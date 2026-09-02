# Phase 1 — Sesame

## Changed

- Registered `SESAME` in `map/config/maps_fruitTypes.xml`, including grain header, maize cutter, direct cutter, planter, forage conversion, and crop categories.
- Registered `SESAME` and `SESAME_OIL` in `map/config/maps_fillTypes.xml`, including bulk/product/selling categories and local HUD/fill assets.
- Registered `SESAME` in `map/config/maps_densityMapHeightTypes.xml` without changing the expanded `densityMap_height.gdm`.
- Added sesame Precision Farming requirements, seed rates, crop sensor, and tramlines to `map/map.xml`.
- Added sesame harvesting effects and chopper support.
- Added English, Italian, French, and German sesame names.
- Extended the existing `map/placeables/smallOilPress/smallOilPress.xml` with `SESAME` → `SESAME_OIL`: 40 input, 15 output, 10 cycles/hour, no organic-waste byproduct.
- Added local sesame provenance at `map/SESAME-PROVENANCE.txt`.

## Assets copied

- `map/foliage/sesame/` — sesame foliage I3D, shapes, textures, and donor foliage definition.
- `map/foliage/sesame/distance/` — reused Monteriggioni sorghum distance maps for the donor foliage states, kept under the sesame path.
- `map/fillPlanes/sesame_*.dds` and `map/huds/hud_fill_sesame.dds`.
- `map/effects/cutter/sesameEffects.xml`.
- `map/huds/hud_fill_sesameOil.dds` and `map/objects/pallets/oil/sesameOilPallet.*` plus its diffuse texture.

## Donors and internal names

- Crop donor: `donors/sesame(prefab).zip`, Jinkou89.
- Oil pallet/icon reference: `donors/FS25_MultifruitPack_PREFAB.zip`, Jinkou89; no generic oil factory or multifruit framework imported.
- Internal names: `SESAME`, `SESAME_OIL`, foliage fruit type `sesame`, production id `sesame_oil`.

## Compromises / not yet tested

- Organic waste was omitted because it is not already part of Monteriggioni’s clean Phase 1 economy; the recipe is deliberately easy to extend later.
- The donor’s missing `.png`/`.dds` references were corrected. Its missing local distance maps were supplied from the map’s existing sorghum distance maps.
- Fresh-save, in-game planting, growth, combine/direct-cut harvest, forage harvest, tipping, storage, sale, and pallet spawning still need an FS25 launch test. XML/reference checks are recorded below.

## Phase 2 follow-ups (not implemented)

- Add organic waste only when its economy is designed.
- Review sesame-specific distance textures and balance after in-game inspection.
- Add other crops/products only as separate, scoped integrations.
