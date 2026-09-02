# Placeables and Compost

This pass adds manually placeable food-economy buildings. No entries were added to the map's pre-placed `config/placeables.xml`; no terrain or GDM was changed.

## Placeables

`conservificio/conservificio.xml` provides sauce and preserve recipes. `herbDryer/herbDryer.xml` provides fresh-to-dried herb recipes. `specialitaVegetableGreenhouse`, `specialitaHerbGreenhouse`, and `mushroomGrowHouse` provide compost-backed greenhouse routes. `compostMixer/compostMixer.xml` provides the optional compost source.

All are registered only in `map/config/storeItems.xml`; the player places them manually. Their placement meshes reuse existing local Monteriggioni assets to avoid importing donor frameworks: pasta-factory, small oil press, glass greenhouse, and small manure-plate meshes respectively. This is functional scaffolding; dedicated visual assets can follow.

## Canonical compost

`COMPOST` is the sole Specialità compost fillType. No `COMPOST01` or equivalent existed in the map, so no alias was needed. It is bulk/tippable, mass `0.65`, and is registered in the existing 14/7 density-height configuration.

`MANURE + STRAW -> COMPOST` is the intentionally small compost loop. Compost is used by greenhouse routes only, not dairy, conservificio, or pasta.

## Greenhouses and production split

Specialità vegetable, herb, and mushroom placeables expose `WATER + SEEDS + COMPOST` routes. Existing inherited greenhouse fertilizer/manure routes remain intact. Seasonal greenhouse Lua is deferred; these routes are non-seasonal.

Sauces/preserves are in the standalone conservificio. Pasta retains pasta, gnocchi, tricolore, `PASTAUOVO`, filling/ravioli, and finished meal recipes. Herb drying is standalone. Existing cow/goat/buffalo dairies remain unchanged in place.

FS25_Fresh is not modified; compatibility remains documentation-only in `compat/FS25_Fresh/README.md`. Fresh-save placement, trigger, production-menu, and pallet-spawn testing remains required. Donor packages remain reference/provenance material and were not imported wholesale.
