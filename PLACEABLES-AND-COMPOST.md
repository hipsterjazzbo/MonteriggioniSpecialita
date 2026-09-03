# Placeables and Compost

This pass adds manually placeable food-economy buildings. No entries were added to the map's pre-placed `config/placeables.xml`; no terrain or GDM was changed.

## Placeables

`conservificio/conservificio.xml` provides sauce and preserve recipes. `herbDryer/herbDryer.xml` provides fresh-to-dried herb recipes. `specialitaVegetableGreenhouse`, `specialitaHerbGreenhouse`, and `mushroomGrowHouse` provide compost-backed greenhouse routes. Compost production is supplied by the external Compost Production Pack.

All are registered only in `map/config/storeItems.xml`; the player places them manually. Their placement meshes reuse existing local Monteriggioni assets to avoid importing donor frameworks: pasta-factory, glass greenhouse, and small manure-plate meshes. The Conservificio now uses the pasta-factory building model while retaining its own production XML and recipes.

## Canonical compost — Compost Production Pack

The Compost Production Pack by **[Weekend Farmers]**, ModHub ID **319065**,
version **1.3.0.0**, filename `FS25_compostProduction.zip`, is now the sole
owner of compost registration and production. Its canonical fill types are
`COMPOST`, `COMPOSTRAW`, `COMPOST_BOXED`, and `QUALITYCOMPOST`; Specialità
continues to consume the pack's `COMPOST` type. The pack owns the compost
physics, density-height registration, spreading support, sales and Precision
Farming integration.

The map follows `compost_installation_guide.pdf`: `map.xml` declares the
`COMPOST` fertiliser spray type and PF application/usage rates, and
`modDesc.xml` declares `FS25_compostProduction` as a dependency. The local
`COMPOST` fillType, density-height entry, local HUD asset, and
`MANURE + STRAW -> COMPOST` mixer were removed. No second compost owner remains.

The external pack's intended workflow is fermented material in its composting
silos/halls, then bulk `COMPOST` or packaged products. The pack accepts manure,
straw, grass, hay, chaff, silage and other documented organic materials. The
local `compostMixer` store item and file are gone; no map compost production is
pre-placed.

## Greenhouses and production split

Specialità vegetable, herb, and mushroom placeables expose `WATER + SEEDS + COMPOST` routes. Existing inherited greenhouse fertilizer/manure routes remain intact. Seasonal greenhouse Lua is deferred; these routes are non-seasonal.

Sauces/preserves are in the standalone conservificio. Pasta retains pasta, gnocchi, tricolore, `PASTAUOVO`, filling/ravioli, and finished meal recipes. Herb drying is standalone. Existing cow/goat/buffalo dairies remain unchanged in place.

FS25_Fresh is not modified; its external overlay remains in
`compat/FS25_Fresh/customDefaults.xml.example`. Fresh-save placement, trigger,
production-menu, compost spreading, PF, and pallet-spawn testing remains
required. Donor packages remain reference/provenance material and were not
imported wholesale.

## Low-input campaign settings

The campaign is traditional low-input farming, not certified organic. Crop
rotation, manure, slurry and compost are preferred; mineral fertiliser remains
available when necessary; herbicide starts at zero. The external Reduced
Organic Fertilizer Usage mod by **moji**, ModHub ID **367543**, version
**1.1.0.0**, is installed with manure, liquid-manure and digestate multipliers
set to **0.55** in `modSettings/FS25_ReducedOrganicFertilizerUsage.xml`.

The repo source preset is `compat/ReducedOrganicFertilizerUsage.xml.example`.

## Validation status — 2026-09-03

The official GIANTS Test Runner completed against the updated working tree.
`MapCheck`, `PlaceableCheck`, `I3DCheck`, `ShaderCheckEditor` and structural
reference checks passed. The result remains FAIL because of the documented
baseline DXT/MipMap, ModDesc, ObsoleteFiles and two unidentified EditorCheck
errors; no new compost-specific failure was reported. Raw output and reports
remain in `testrunner-results/`.

A fresh interactive save test of the Compost Pack's fermentation, compost
spreading, Precision Farming response, and greenhouse consumption remains
pending. The canonical save was not rebuilt or given a starting compost stock
in this pass.
