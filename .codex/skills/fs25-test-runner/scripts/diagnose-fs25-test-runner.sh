#!/usr/bin/env python3
"""Read-only diagnostics for an FS25 Test Runner result."""

from collections import defaultdict
from hashlib import sha256
from pathlib import Path
import re
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[4]
WORKING = ROOT / "working"
RESULTS = ROOT / "testrunner-results"
LOG = RESULTS / "TestRunner.log"
EDITOR = RESULTS / "editorOutput_working.txt"
SCHEMA = Path.home() / ".local/share/Steam/steamapps/common/Farming Simulator 25/shared/xml/schema/modDesc.xsd"


def section(title):
    print(f"\n--- {title} ---")


def moddesc_check():
    section("modDesc XML/schema")
    moddesc = WORKING / "modDesc.xml"
    if not moddesc.exists():
        print(f"Missing: {moddesc}")
        return
    result = subprocess.run(
        ["xmllint", "--noout", "--schema", str(SCHEMA), str(moddesc)],
        text=True,
        capture_output=True,
    )
    print("PASS" if result.returncode == 0 else "FAIL")
    if result.stdout.strip():
        print(result.stdout.strip())
    if result.stderr.strip():
        print(result.stderr.strip())


def duplicate_check():
    section("duplicate files")
    groups = defaultdict(list)
    for path in WORKING.rglob("*"):
        if path.is_file():
            digest = sha256(path.read_bytes()).hexdigest()
            groups[digest].append(path.relative_to(ROOT))
    duplicates = [files for files in groups.values() if len(files) > 1]
    print(f"{len(duplicates)} duplicate-content groups")
    for files in sorted(duplicates, key=lambda item: str(item[0])):
        print(f"\n{len(files)} files:")
        for path in files:
            print(f"  {path}")


def runner_log_check():
    section("Test Runner unresolved references")
    if not LOG.exists():
        print(f"Missing: {LOG}")
        return
    lines = LOG.read_text(errors="replace").splitlines()
    editor_progress = [line for line in lines if "i3d-files loaded" in line]
    editor_result = [line for line in lines if "module EditorCheck result:" in line]
    print("Latest EditorCheck progress:")
    print(f"  {editor_progress[-1]}" if editor_progress else "  none")
    print("Latest EditorCheck result:")
    print(f"  {editor_result[-1]}" if editor_result else "  no result recorded")
    for index, line in enumerate(lines):
        if "Unable to resolve path" in line:
            print(line)
            for detail in lines[index + 1 : index + 4]:
                print(detail)


def editor_check():
    section("EditorCheck markers")
    if not EDITOR.exists():
        print(f"Missing: {EDITOR}")
        return
    text = EDITOR.read_text(errors="replace")
    if EDITOR.stat().st_mtime < LOG.stat().st_mtime:
        print("NOTE: editorOutput_working.txt predates the current TestRunner.log; markers are from an earlier run.")
    files = re.findall(r"NEW_FILE\[\[(.*?)\]\]", text)
    finished = text.count("FINISHED_FILE")
    print(f"files opened: {len(files)}; FINISHED_FILE markers: {finished}")
    if len(files) > finished:
        print("Files opened without a matching FINISHED_FILE marker:")
        for path in files[finished:]:
            print(f"  {path}")
    explicit = [line for line in text.splitlines() if re.search(r"\b(error|exception)\b", line, re.I)]
    print("Explicit Editor error/exception lines:")
    print("\n".join(f"  {line}" for line in explicit) or "  none")


def main():
    if not WORKING.is_dir():
        print(f"Missing working tree: {WORKING}", file=sys.stderr)
        return 2
    moddesc_check()
    duplicate_check()
    runner_log_check()
    editor_check()
    return 0


raise SystemExit(main())
