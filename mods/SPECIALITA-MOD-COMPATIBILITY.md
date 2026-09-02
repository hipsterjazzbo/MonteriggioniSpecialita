# Monteriggioni Specialità — Gameplay Mod Compatibility

Checked: 2026-09-02

This tracks **map/project-side work needed for the planned campaign mod stack**.

- **MAP** — edit Monteriggioni Specialità itself.
- **PROJECT CONFIG** — keep an update-safe compatibility preset in the repo, but do not bake another mod's internals into the map.
- **SAVE SETUP** — campaign/savegame setup only.
- **TEST ONLY** — should work without edits, but needs an in-game compatibility test.
- **NONE** — no map-side work expected.

## Precondition

Finish the current core foliage registration fix first. The Specialità fruit definitions can appear in the calendar while still being unusable on fields if their foliage XMLs are not registered in `working/map/map.i3d`.

Do not diagnose gameplay-mod compatibility until `SESAME`, `FABABEAN`, `LAVENDER`, `MINT`, `CHICKPEA` and `GRAPEB` can actually be painted/grown in a fresh save.

---

## Required / high-value compatibility work

| Mod/system | Class | Work |
|---|---|---|
| Precision Farming | **MAP** | Complete PF definitions for the new crops. |
| British Fill Units + Wood And Weight Info | **MAP** | Audit `massPerLiter` and liquid/solid semantics for every custom fill type/product. |
| Fresh / Perishable Products | **PROJECT CONFIG** | Maintain an external `customDefaults.xml` preset for Specialità crops/products and verify cold-storage classes. |
| Historical Start + Enhanced Loan System | **SAVE SETUP** | Build the canonical March 1990 campaign start without hard-coding campaign state into the map. |
| Manure For All Husbandries | **SAVE SETUP** | Ensure starting animal yards have practical loose-straw access and nearby manure heaps. |

### 1. Precision Farming

Current map file: `working/map/map.xml`

The map already has explicit Precision Farming integration. At the current core-agriculture state:

- `cropSensor` includes the inherited custom crops plus **SESAME**, but not the other new Specialità crops.
- `npcTramlines` likewise includes **SESAME** but not the rest.
- `fruitRequirements` contains a full **SESAME** definition and inherited custom-crop definitions, but fava/chickpea/lavender/mint still need proper nitrogen/yield targets.
- The core-agriculture sprint added seed-rate entries for the new field crops; these need a gameplay sanity pass rather than blind replacement.

#### Planned PF pass

| Fruit | PF intent |
|---|---|
| `SESAME` | Already substantially configured; balance later. |
| `FABABEAN` | Add crop sensor + nitrogen/yield requirements. Treat as a legume in balance decisions. |
| `CHICKPEA` | Add crop sensor + nitrogen/yield requirements. Treat as a legume. |
| `MINT` | Add crop sensor + suitable requirements if PF behaves sensibly for the mown herb crop. |
| `LAVENDER` | Add suitable PF requirements if field fertilisation is meaningful for its perennial/regrowth loop. |
| `GRAPEB` | **Do not force into the arable PF model.** First compare against base `GRAPE`/vineyard behaviour. |

Also decide whether `FABABEAN`, `CHICKPEA`, `MINT` and `LAVENDER` belong in `npcTramlines`. Follow how each crop is actually worked, not “all new crops = tramlines”.

Optional later improvement: replace the inherited generic EU PF soil map with a Tuscany-specific soil map. That is a realism enhancement, not required compatibility.

Source: https://www.farming-simulator.com/mod.php?filter=console&mod_id=318936&title=fs2025

### 2. British Fill Units + Wood And Weight Info

Both systems expose mistakes in fill-type density that normal litre-based FS UI tends to hide.

Audit every Specialità custom fill type in `working/map/config/maps_fillTypes.xml` for:

- plausible `massPerLiter`;
- correct liquid vs solid behaviour;
- no placeholder density copied from an unrelated donor product;
- sensible density for intermediate materials that appear in trailers, tanks, pallets or storage.

Priority audit groups:

- `SESAME`, `FABABEAN`, `FABA_BEAN_CUT`, `CHICKPEA`, `CHICKPEA_CUT`;
- `MINT`, `MINT_WINDROW`, `DRYMINT_WINDROW`, `LAVENDER`;
- `GRAPEB`;
- `SESAME_OIL`, `MINT_OIL`, `LAVENDER_OIL`, `RED_WINE`, `WHITE_WINE`;
- future greenhouse vegetables/herbs;
- cow/goat/buffalo dairy products;
- conservificio sauces/preserves;
- pasta products and fillings.

This is real map-data work: British Fill Units converts displays/prices using material mass, and Wood And Weight Info calculates fill-unit cargo mass.

Sources:
- https://www.kingmods.net/en/fs25/mods/78478/british-fill-units
- https://www.kingmods.net/en/fs25/mods/79966/wood-and-weight-info

### 3. Fresh / Perishable Products

Fresh explicitly supports custom map/mod crops through an external, update-safe file:

`modSettings/FS25_Fresh/customDefaults.xml`

Do **not** patch Fresh itself.

Create a repo-maintained example/preset later, e.g.:

`compat/FS25_Fresh/customDefaults.xml.example`

Then copy it to the game profile when setting up the campaign.

At minimum classify Specialità products into sensible groups:

- **short-lived fresh produce:** fresh herbs, spinach/leafy greens, mushrooms, ripe grapes, many greenhouse vegetables;
- **moderate storage:** fava/chickpea where appropriate, garlic/onions, some fruit;
- **dairy:** cow/goat/buffalo milk, cream, ricotta, caprino, mozzarella;
- **preserved/long-lived:** dried herbs, oils, wine, canned products, passata/sauces according to recipe;
- **finished meals:** pasta meals and filled pasta should generally remain perishable.

For each cold-storage placeable, verify Fresh's auto-classification in-game. If Cold Room Storage, Cold Pallet Storage or Refrigerated Warehouse does not become `Cooled`/`Frozen` as intended, override that storage in Fresh settings rather than modifying the placeable unless the mod documents a map-author hook.

Sources:
- https://www.kingmods.net/en/fs25/mods/74264/fresh-perishable-products
- https://github.com/rittermod/FS25_Fresh

### 4. Campaign state: Historical Start + loans

No map edit is required.

Canonical save setup:

- start year **1990**;
- start month **March**;
- GPS threshold **1995**;
- Vehicle Years overrides for equipment whose database year is missing/wrong;
- inherited campaign debt represented through Enhanced Loan System/save state rather than hard-coded map economy.

Historical Start also alters contract equipment by year. Because Specialità enables contracts for some custom crops, verify that no 1990 contract is generated when the required crop machinery has no period-available vehicle. If that happens, either:
1. provide a period-correct equipment option/year override, or
2. disable field missions for that crop.

Sources:
- https://www.kingmods.net/en/fs25/mods/62107/vehicle-years
- https://www.kingmods.net/en/fs25/mods/78270/vehicle-years-system-historical-start
- https://www.farming-simulator.com/mod.php?mod_id=369793
- https://www.farming-simulator.com/mod.php?mod_id=314906&title=fs2025

### 5. Manure For All Husbandries

The mod explicitly augments husbandries at load and says **no map edit is required**.

Campaign setup still needs:
- a manure heap within range of each husbandry expected to produce manure;
- practical loose-straw delivery at the food/straw point;
- a quick test of Farm 6 goat/cow/buffalo areas.

Prefer doing this in the campaign/start-save layer so the map remains usable without the mod.

Source: https://www.kingmods.net/en/fs25/mods/79828/manure-for-all-husbandries

---

## Compatibility tests before declaring the stack green

### Crop Rotation — TEST / possibly PROJECT CONFIG

The current public description says the mod supports map crop changes better than its first release, including fixes for maps with removed standard fruits, but it does not document a stable map-author extension format.

Test whether it tracks each Specialità crop correctly after the foliage fix.

Desired semantics:

- `FABABEAN` — legume; strong rotation value.
- `CHICKPEA` — legume.
- `SESAME` — oilseed.
- `MINT` — specialist/perennial-ish herb.
- `LAVENDER` — perennial specialist crop; probably excluded from normal annual rotation or treated specially.
- `GRAPEB` — permanent vineyard crop; exclude from annual arable rotation.

If the mod cannot express these cleanly, prefer upstream-supported config/feature work over embedding a private copy of Crop Rotation into the map.

Source: https://www.kingmods.net/en/fs25/mods/74660/crop-rotation

### Moisture System — TEST

Use the built-in **Mediterranean** weather profile first.

The mod has crop-specific moisture/quality ranges, but its public docs do not expose a map-side custom-crop profile format. After the new crops are genuinely usable, check Shift+M:

- `SESAME`
- `FABABEAN`
- `CHICKPEA`
- whether `MINT`/`LAVENDER` biomass is sensibly handled or ignored
- whether `GRAPEB` should remain outside the moisture system

If a crop is unsupported, record it and pursue the mod's supported crop-suggestion/profile route. Do not hard-fork Moisture System data into Monteriggioni.

The current Moisture System also integrates with Realistic Harvesting, so test those two together.

Sources:
- https://www.kingmods.net/en/fs25/mods/75883/moisture-system
- https://github.com/Ozz-Modding/FS25_MoistureSystem

### Realistic Harvesting — TEST

No map edit expected.

Current releases:
- use name-based crop lookup;
- include an explicit **chickpea** calibration preset;
- have fallback handling for non-standard/modded forage crops;
- integrate with Moisture System.

Test:
- sesame combine load;
- fava combine load;
- chickpea preset;
- mint/lavender only where a supported harvester path actually invokes the mod;
- windrow/pickup behaviour for fava/chickpea cut states.

If a crop needs tuning, use Realistic Harvesting's profile/settings mechanisms rather than changing map yield solely to satisfy one script mod.

Sources:
- https://www.kingmods.net/en/fs25/mods/73932/realistic-harvesting
- https://github.com/exekx/FS25_RealisticHarvesting

### CoursePlay — TEST

Courseplay advertises vineyards, specialty crops, bale work and standard field automation.

After the foliage-system bug is fixed, test:
- sow/harvest course generation for sesame/fava/chickpea;
- mowing, tedding and pickup for mint;
- lavender harvesting;
- `GRAPEB` vineyard rows;
- existing red grapes/olives as regression.

Only change Specialità fruit/tool categories if Courseplay reveals a real category omission that also makes sense for ordinary gameplay.

Source: https://www.farming-simulator.com/mod.php?mod_id=331515

### RLRM + Animal Herding Lite + Pasture Grazing System — TEST / SAVE SETUP

RLRM states that standard animals work on virtually any map without a bridge. A map bridge is only needed for custom animal types/breeds.

Pasture Grazing System v0.7.1.0 is beta/single-player, requires RLRM and Animal Herding Lite, and its newer schedule code is described as animal-neutral.

For Specialità:
- keep cows/goats/water buffalo as standard animal types where possible;
- use the ConGan-maintained Animal Herding Lite fork when pairing with Pasture Grazing System;
- test goat and buffalo movement before calling PGS mandatory;
- choose sensible Farm 6 pasture areas and record safe walk paths;
- check steep slopes, walls, gates and road crossings;
- enable/test PGS's optional Precision Farming soil/pH layer.

No map XML edit should be made merely to satisfy these mods unless testing finds a concrete husbandry/nav problem.

Sources:
- https://www.kingmods.net/en/fs25/mods/74109/realistic-livestock-rm
- https://github.com/ConGan98/FS25_AnimalHerdingLite/releases
- https://github.com/ConGan98/FS25_PastureGrazingSystem/releases

### DynamicDrive Pro — TEST

No expected map edit. Test representative surfaces:
- normal field;
- asphalt;
- standard gravel;
- custom `rocktrail`;
- `gravel_stone`;
- `moss_pebbles`;
- other custom ground mappings.

Only touch map surface definitions if the custom mappings demonstrably produce nonsense traction.

Source: https://www.kingmods.net/en/fs25/mods/75940/dynamicdrive-pro

### Realistic Fuel Costs — TEST

No expected map edit. Confirm that any built-in/custom Monteriggioni fuel purchase points use standard fuel-station behaviour and are charged by the mod.

Source: https://www.kingmods.net/en/fs25/mods/77178/realistic-fuel-costs

### Cold-storage placeables — TEST / PROJECT CONFIG

No map integration is required; they can remain optional placeables unlocked by campaign finances.

Use Fresh to verify their actual storage class:
- Cold Room Storage — early serious upgrade.
- Cold Pallet Storage — possible cheap/small option.
- Refrigerated Warehouse — late large upgrade.

Sources:
- https://www.farming-simulator.com/mod.php?mod_id=328853&title=fs2025
- https://www.farming-simulator.com/mod.php?mod_id=354861&title=fs2025
- https://www.farming-simulator.com/mod.php?mod_id=354348&title=fs2025

---

## No expected map changes

These should remain external gameplay systems unless testing proves otherwise:

- Vehicle Years
- Vehicle Years System: Historical Start
- Disable GPS (By Year)
- Advanced Damage System
- Real Fuel Consumption
- Enhanced Loan System
- Hire Purchasing
- Dynamic Field Prices
- RealismAddon: Balers
- Realistic Cab View
- Easy Development Controls

For Advanced Damage System, the only map-specific check worth doing is whether any workshop/service triggers we intend to use behave normally.

---

## Suggested compatibility work order

1. Fix and gameplay-test the Specialità foliage registrations.
2. **Precision Farming completion pass** for fava/chickpea/mint/lavender.
3. **Custom fill-type density audit** for British Fill Units / weight calculations.
4. Install the core gameplay stack and run one fresh-save compatibility session.
5. Record Crop Rotation, Moisture, Realistic Harvesting and Courseplay behaviour for every new crop.
6. Create the **Fresh custom defaults preset** once the food-economy fill-type list stabilises.
7. Test the animal stack on Farm 6 and decide whether Pasture Grazing System graduates from TEST to CORE.
8. Build the canonical March 1990 start save only after the stack is stable.

## Rule

**Do not modify the map to compensate for undocumented internals of a script mod.**

Map changes should represent correct crop, fill-type, PF, husbandry or terrain data that remains sensible without the mod. Mod-specific behaviour belongs in documented extension/config files or in savegame settings.
