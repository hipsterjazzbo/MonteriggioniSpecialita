---
name: fs25-test-runner
description: Run the official GIANTS FS25 Test Runner against this project's working map through Bottles and report completed validation results.
---

# FS25 Test Runner

Run the project-local helper:

```bash
.codex/skills/fs25-test-runner/scripts/run-fs25-test-runner.sh
```

It validates `working/` only and must not edit map files or apply fixes.

The helper creates `testrunner-results/`, archives any existing `TestRunner.log`, launches `tools/TestRunner_public.exe` through the installed Bottles bottle using Soda 11.0-7, and watches the new log until the launcher and Test Runner have exited. GIANTS Editor windows are expected and are not a failure.

For read-only follow-up diagnostics, run:

```bash
.codex/skills/fs25-test-runner/scripts/diagnose-fs25-test-runner.sh
```

This validates `modDesc.xml` against the installed game schema, lists duplicate-content groups, extracts unresolved references, and correlates EditorCheck file markers. It does not modify `working/` or the result artifacts.

Report overall PASS/FAIL, failed modules/checks, errors, warnings, implicated files, and generated report paths. Omit repetitive `use_lsteamclient lsteamclient disabled` lines from the summary only; preserve raw launcher output and Test Runner logs.
