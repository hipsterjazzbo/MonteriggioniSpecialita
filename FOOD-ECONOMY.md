# Monteriggioni Specialità — Food Economy

## Scope

This sprint extends the existing greenhouse, dairy, oil, and pasta production points with a small food economy. Core agriculture and the 14/7 terrain-detail height setup are unchanged. No GDM was regenerated.

## Sources and canonical names

| Area | Source/use |
|---|---|
| Existing vegetables, mushrooms, greenhouses and dairy | Monteriggioni baseline |
| Selected greenhouse and herb definitions | Tamara greenhouse/hydroponic donor inspection material |
| Sauces and preserved-food naming/ratios | Jinkou Multifruit and Sauce And Mushrooms donor inspection material |
| Recipes/buildings | Existing Monteriggioni production XMLs |

Existing equivalent names were reused: `GREENBEAN`, `PEA`, `SPINACH`, `ENOKI`, and `OYSTER`. New greenhouse outputs are `PEPPER`, `EGGPLANT`, `ASPARAGUS_WHITE`, `ASPARAGUS_GREEN`, `BASIL`, `PARSLEY`, `ROSEMARY`, `SAGE`, `CHIVES`, `THYME`, and `LEMONBALM`.

## Greenhouses

Both existing medium greenhouse variants now also expose compost-backed specialty recipes using `WATER + SEEDS + COMPOST`; inherited fertilizer/manure paths remain intact. Seasonal greenhouse Lua was not imported; outputs remain non-seasonal.

## Dairy

`MILK`, `GOATMILK`, and `BUFFALOMILK` remain separate. Both existing dairy production XMLs now provide:

- cow `CREAM`, `RICOTTA`
- goat `GOAT_CREAM`, `CAPRINO`, `GOAT_RICOTTA`
- buffalo `BUFFALO_RICOTTA`, while existing `BUFFALOMOZZARELLA` is preserved

Animal collection remains the existing map architecture; no animal Lua was added.

## Conservificio and herbs

The standalone Conservificio Monteriggioni produces `PASSATA`, `SUGO_AL_POMODORO`, `ARRABBIATA`, `MARINARA`, `SUGO_AI_FUNGHI`, `PESTO`, `PESTO_ROSSO`, `PRESERVED_PEPPERS`, `GARLIC_IN_OIL`, and `MUSHROOMS_IN_OIL`. The standalone Farm Herb Dryer produces dried herbs without changing the existing `MINT_WINDROW -> DRYMINT_WINDROW` field mechanic. See `PLACEABLES-AND-COMPOST.md`.

## Pasta meals

Existing flour/pasta recipes are preserved. Added chains are `RICOTTA + SPINACH -> RICOTTA_SPINACH_FILLING`, filling plus pasta -> `RAVIOLI`, plus five small finished meal recipes: `PASTA_AL_POMODORO`, `PASTA_ARRABBIATA`, `PASTA_AI_FUNGHI`, `PASTA_AL_PESTO`, and `GNOCCHI_AL_POMODORO`.

## Fresh compatibility

`compat/FS25_Fresh/README.md` is documentation scaffolding only. It intentionally does not claim to be loadable: the exact external FS25_Fresh schema was not available in the map and FS25_Fresh itself was not modified.

## Validation and limitations

XML parsing, duplicate-name checks, and reference checks are required after this sprint. The official Test Runner result and any baseline comparison are recorded here after execution. Actual gameplay testing remains required for fresh-save production visibility, pallet spawning, greenhouse production display, dairy collection, and recipe throughput. Product icons currently reuse an existing map icon where no dedicated local asset was imported; this is a visual follow-up, not a recipe dependency.
