# Monteriggioni Specialità — Core Agriculture

## Scope

This sprint adds the remaining core crops while preserving the existing sesame implementation. It does not add greenhouse, dairy, sauce, orchard, or savegame work.

## Canonical names and sources

| Crop/product | Internal names | Donor/source | Status |
|---|---|---|---|
| Sesame | `sesame`, `SESAME`, `SESAME_OIL` | Existing Phase 1 implementation | Preserved; small oil press recipe remains 40 → 15 |
| Fava/broad bean | `fababean`, `FABABEAN`, `FABA_BEAN_CUT` | BierKasten fava/broad-bean prefab | Grain/direct harvest, forage cut, bulk handling |
| Lavender | `lavender`, `LAVENDER`, `LAVENDER_OIL` | MrLackofSkill Lavender in Rows | Specialist crop, regrowth-capable donor growth, small oil press |
| Mint | `mint`, `MINT`, `MINT_WINDROW`, `DRYMINT_WINDROW`, `MINT_OIL` | Antler22 mint prefab | Mow → windrow → ted → dry windrow; small oil press |
| Chickpea | `chickpea`, `CHICKPEA`, `CHICKPEA_CUT`, `CHICKPEA_FLOUR` | Jinkou multifruit donor, chickpea components only | Grain/direct harvest, forage cut, existing flour mill |
| White grape | `grapeb`, `GRAPEB`, `WHITE_WINE` | Jinkou GRAPEB implementation | Separate white-grape input and white-wine output |
| Red wine | `RED_WINE` | Existing Monteriggioni oil-plant building/architecture | Existing building extended; uses `GRAPE` input |

The donor archives remain outside the mod under `donors/` and are ignored by Git. No pristine archive was modified. Donor readmes/credits were retained in the project inspection material and donor archive layout.

`CHICKPEAS` was normalized to canonical `CHICKPEA`; the donor `GRAPEB` name was retained to keep white grapes distinct from ordinary `GRAPE`.

## Files and assets

Shared definitions were merged, not replaced:

- `working/map/config/maps_fruitTypes.xml`
- `working/map/config/maps_fillTypes.xml`
- `working/map/config/maps_densityMapHeightTypes.xml`
- `working/map/map.xml` (Precision Farming seed-rate registrations)
- `working/map/l10n_*.xml`

Crop foliage and supporting visuals are under `working/map/foliage/`, `working/map/fillPlanes/`, and `working/map/huds/`. Oil and wine pallet assets are under `working/map/objects/pallets/`.

Existing production buildings were extended in place:

- `working/map/placeables/smallOilPress/smallOilPress.xml`
- `working/map/placeables/FS22_GrainMillUS/flourMill.xml`
- `working/map/placeables/oilPlant/oilPlant.xml`

No Lua was added and no generic multifruit framework or donor production building was imported.

## Agriculture configuration

- Fava uses the donor’s custom growth stages, March/April planting window, August/September harvest window, grain-header/direct-cutter categories, and fava cut state.
- Lavender uses the donor’s specialist planting/harvest setup and growth definition; its perennial/regrowth behaviour still needs gameplay verification.
- Mint is registered as a row crop for sowing, mowed to `MINT_WINDROW`, and tedded to `DRYMINT_WINDROW`. Both windrow types are bulk-handled and saleable/storage-compatible.
- Chickpea uses donor growth/harvest data, grain/direct-cutter categories, and `CHICKPEA_CUT` pickup conversion.
- `GRAPEB` is a separate fruit type and fill type, registered for specialist small-planter use and bulk handling. It is not converted to `GRAPE`.
- New loose materials are registered in the existing seven-bit `densityMapHeightTypes` configuration. The expanded `terrainDetailHeight`/`densityMap_height.gdm` was not regenerated or downgraded.
- New field crops are registered for field missions where the donor marked them safe. Lavender, mint, and white grapes are not currently enabled for contracts.
- PF seed-rate registrations were added for fava, lavender, mint, and chickpea. Detailed donor-specific nitrogen targets remain a later balancing pass.

## Processing

| Building | Recipe |
|---|---|
| Existing small Italian oil press | `SESAME` 40 → `SESAME_OIL` 15 (existing), `LAVENDER` 30 → `LAVENDER_OIL` 10, `MINT` 30 → `MINT_OIL` 10 |
| Existing flour mill | `CHICKPEA` 10 → `CHICKPEA_FLOUR` 8 |
| Existing oil-plant building | `GRAPE` 150 + `SUGAR` 20 + `BARREL` 10 → `RED_WINE` 100; `GRAPEB` 150 + `SUGAR` 20 + `BARREL` 10 → `WHITE_WINE` 100 |

The sesame organic-waste byproduct was not introduced. Optional packed fava beans, lavender soap, must intermediates, chickpea bags, and donor winery buildings were deliberately deferred.

## Validation

XML parsing passed for all added foliage XML, shared map configs, and modified production XML. Duplicate fruit, fill, and density-height names were checked. The official GIANTS Test Runner completed normally through Bottles and generated:

- `testrunner-results/TestRunner.log`
- `testrunner-results/testResult_working_FAIL.xml`
- `testrunner-results/testResult_working_FAIL.html`
- `testrunner-results/editorOutput_working.txt`

The final rerun loaded the new crop and pallet I3Ds and passed `I3DCheck`. It still reports FAIL because of:

- donor fava textures using DXT5 where DXT1 would suffice and missing mipmaps;
- inherited `descVersion 109` versus the runner’s current required 111;
- inherited obsolete/source files and duplicate-content findings;
- inherited map/editor issues (two I3D errors; the raw editor report is preserved).

The runner also reports inherited missing references for manure station icons, weed info-layer texture, and two pasta textures. These were not changed in this crop sprint.

## Known limitations / gameplay testing

The official runner validates structure, references, and editor loading; it does not prove a fresh-save gameplay loop. Actual in-game testing remains required for planting equipment visibility, growth/calendar timing, fava/lavender/mint/chickpea harvest behavior, white-grape vineyard tools, silo/tip acceptance, selling, and all three production chains. Prices and PF crop targets need later balancing.

## Provenance

| Material | Use |
|---|---|
| BierKasten fava/broad-bean prefab | Fava foliage, growth, harvest and cut behavior |
| MrLackofSkill Lavender in Rows | Lavender foliage and crop definition |
| Antler22 mint prefab | Mint foliage and donor growth definition |
| Jinkou multifruit donor | Chickpea and GRAPEB foliage/definitions plus selected product/pallet assets |
| Monteriggioni baseline | Shared categories, map density architecture, storage/selling, and existing production buildings |
