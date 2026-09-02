# FS25 Test Runner baseline

Established 2026-09-02 against commit `initial-state` (`6e24890`) and the
post-sesame validation runs. This is a record only; no failures are fixed by
this file.

## Known baseline failures

- `ModDescCheck`: FAIL. The checked file, `working/modDesc.xml`, is unchanged
  since `initial-state` and passes the installed FS25 `modDesc.xsd` schema.
  The Test Runner does not emit the semantic rule or line that caused the
  failure.
- `ObsoleteFiles`: FAIL. The initial-state tree already contains 79 duplicate
  content groups. The current tree contains 85; six additional groups are the
  reused sesame/sorghum distance textures and should be reviewed separately.
- `EditorCheck`: the completed archived run found 2 errors in 2 I3D files.
  The available Editor output does not identify them. The inspected map assets
  (`working/map/map.i3d` and `working/map/background.i3d`) are unchanged since
  `initial-state`. The current run stalled at 100/102 files and exited 143.

## Other observed diagnostics

The runner reported unresolved references for two manure-station icons,
`map/data/infoLayer_weed.png`, and two pasta textures. These are recorded as
existing diagnostics, not treated as sesame failures.

Raw runs remain under `testrunner-results/`. Use the diagnostic helper for
future comparisons:

```bash
.codex/skills/fs25-test-runner/scripts/diagnose-fs25-test-runner.sh
```
