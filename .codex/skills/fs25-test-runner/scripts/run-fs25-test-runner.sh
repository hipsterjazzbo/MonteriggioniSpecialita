#!/usr/bin/env bash
set -u

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
results_dir="$project_dir/testrunner-results"
log_file="$results_dir/TestRunner.log"
launcher_log="$results_dir/TestRunner-launcher.log"
runner="$project_dir/tools/TestRunner_public.exe"
bottle="${FS25_BOTTLE_NAME:-GIANTS Modding}"

mkdir -p "$results_dir"
if [[ -f "$log_file" ]]; then
    mv "$log_file" "$results_dir/TestRunner.log.$(date +%Y%m%d-%H%M%S)-$$.previous"
fi
test -f "$runner" || { echo "Missing runner: $runner" >&2; exit 2; }

test_command='C:/Tools/TestRunner/TestRunner_public.exe "Z:/home/hazel/Projects/MonteriggioniSpecialita/working" -g "Z:/home/hazel/.local/share/Steam/steamapps/common/Farming Simulator 25" -e "C:/Program Files/GIANTS Software/GIANTS_Editor_10.0.13/editor.exe" --outputPath "Z:/home/hazel/Projects/MonteriggioniSpecialita/testrunner-results" --logPath "Z:/home/hazel/Projects/MonteriggioniSpecialita/testrunner-results" --verbose'
flatpak_cmd=(flatpak run --command=bottles-cli com.usebottles.bottles shell -b "$bottle" -i "$test_command")

"${flatpak_cmd[@]}" >"$launcher_log" 2>&1 &
launcher_pid=$!
echo "Started Test Runner through Bottles bottle '$bottle' (launcher PID $launcher_pid)."

last_lines=0
while kill -0 "$launcher_pid" 2>/dev/null || pgrep -f '[T]estRunner_public.exe' >/dev/null; do
    if [[ -f "$log_file" ]]; then
        current_lines=$(wc -l < "$log_file")
        if (( current_lines < last_lines )); then
            last_lines=0
        fi
        if (( current_lines > last_lines )); then
            sed -n "$((last_lines + 1)),${current_lines}p" "$log_file" \
                | sed '/use_lsteamclient lsteamclient disabled/d' \
                | tail -n 20
            last_lines=$current_lines
        fi
    else
        echo "Waiting for TestRunner.log..."
    fi
    sleep 2
done
wait "$launcher_pid"; launcher_rc=$?

if [[ ! -f "$log_file" ]]; then
    echo "FAIL: TestRunner.log was not created; Bottles launcher exit=$launcher_rc"
    tail -n 40 "$launcher_log"
    exit 1
fi

failed_modules=$(grep -E 'module .* result: FAIL' "$log_file" || true)
error_lines=$(grep -E ' ERROR |ERROR -|found [0-9]+ errors|Traceback|Exception' "$log_file" | tail -n 30 || true)
warning_lines=$(grep -E ' WARNING |WARNING -' "$log_file" | tail -n 30 || true)
file_lines=$(grep -E 'found [0-9]+ errors in|failed|Failed' "$log_file" | tail -n 40 || true)
if [[ "$launcher_rc" -ne 0 || -n "$failed_modules" ]]; then state=FAIL; else state=PASS; fi

echo "Overall: $state (Bottles launcher exit=$launcher_rc)"
echo "Log: $log_file"
echo "Reports: $results_dir"
echo "Failed modules/checks:"; printf '%s\n' "${failed_modules:-none}"
echo "Errors:"; printf '%s\n' "${error_lines:-none}"
echo "Warnings:"; printf '%s\n' "${warning_lines:-none}"
echo "Implicated files/relevant checks:"; printf '%s\n' "${file_lines:-none}"
echo "Raw Bottles output: $launcher_log"
if [[ "$launcher_rc" -ne 0 ]]; then
    echo "Launcher exit failure: $launcher_rc"
    echo "Launcher output tail:"
    tail -n 40 "$launcher_log"
fi
[[ "$state" == PASS ]]
