# Monteriggioni Specialità — Canonical Inherited Farm Start

> **Status:** Proposed canonical start for first in-game campaign test  
> **Map:** Monteriggioni Specialità  
> **Farm:** Farmland 6 — Traditional Farm  
> **Campaign start:** March 1990  
> **Primary user:** Luna / save-setup agent  
>
> This document is the source of truth for constructing the campaign start save.
> Do not change the map itself to encode campaign state. Make the changes in a dedicated savegame.
> Back up the untouched save before modifying anything.

---

## 0. Goal

Create a playable save that feels like an inherited, already-operating Tuscan family farm rather than a brand-new "start from zero" game.

The farm should:

- own the Farm 6 homestead and a compact block of nearby land;
- have a mixed livestock/cereal/forage operation already in progress;
- have enough old equipment to function, but not every possible machine;
- have useful feed, grain, manure and slurry on hand;
- begin with some work already waiting;
- preserve meaningful reasons to buy or replace equipment;
- start in **March 1990** with historical equipment gating active.

Do **not** silently add modern equipment, extra land, free production buildings, excessive cash or huge inventories.

---

# 1. Campaign Date / Historical Settings

Set:

| Setting | Value |
|---|---|
| Year | **1990** |
| Month | **March** |
| Campaign start period | **Early Spring** |
| Days per month | **3** |
| Vehicle Years / Historical Start | Enabled |
| GPS availability threshold | **1995** |
| Weather profile | Mediterranean where applicable |

If the historical-start mod has a separate start-year setting, set it to **1990**.

Use **three days per month** for the campaign calendar (`plannedDaysPerPeriod = 3`).

If vehicle-year metadata in a mod conflicts with the project's `equipment/catalogue.csv`, use the project catalogue as the campaign override source.

---

# 2. Farm Ownership

The player owns:

- **Farmland 6 — Traditional Farm**
- **Field 6**
- **Field 65**
- **Field 70**
- **Field 75**
- **Field 102**

This is intended to form the compact original family holding around the Farm 6 yard.

Do **not** grant ownership of Field 64, 71, 72, 76, 77 or other surrounding land. Those are natural expansion opportunities.

## Why this block

- **6** is the tiny home paddock beside the yard.
- **65** is immediately west of the farm.
- **70** extends the holding southwest.
- **102** is the main field immediately east of the yard.
- **75** completes the block to the south.

The result should look like one inherited holding rather than five random investments.

---

# 3. Starting Field State — March 1990

The starting state should give the player several different kinds of spring work.

| Field | Intended role | Crop / state at start | Growth / ground state | Fertility / weeds | Immediate purpose |
|---|---|---|---|---|---|
| **6** | Home paddock | `GRASS` / meadow | Established spring grass; **not harvest-ready** | No weeds; normal inherited fertility | Small pasture / emergency forage |
| **65** | Winter cereal | `BARLEY` | Established autumn-sown crop, mid-growth appropriate to early March | One fertilisation pass; no herbicide perfection | Spring cereal care |
| **70** | Winter cereal | `WHEAT` | Established autumn-sown crop, mid-growth appropriate to early March | One fertilisation pass; light weeds acceptable | Spring cereal care |
| **75** | Main hay field | `GRASS` | Established grass, growing toward first spring cut; **not harvest-ready** | No weeds; usable but not optimised | Hay / silage supply |
| **102** | Spring arable field | **No crop** | Cultivated / seedbed-ready | No weeds; not fully fertilised | First major job: sow `FABABEAN` in March |

### Field-state implementation note

Do not guess numeric foliage states.

For each crop, inspect the active fruit/foliage definition and choose the valid state whose semantics match the table above.

For `FABABEAN`, the project foliage definition explicitly permits planting in **EARLY_SPRING (March)** and **MID_SPRING (April)**. Field 102 should therefore be ready to sow on day one rather than pre-planted.

If Precision Farming is active, preserve imperfect inherited soil conditions. Do not make all five fields perfectly limed, fertilised and sampled.

---

# 4. Farm 6 Existing Infrastructure

Farm 6 already has / is intended to use the existing pre-placed infrastructure. Preserve it.

Relevant Farm 6 assets include:

- steel-frame cow shed;
- sheep/goat barn;
- chicken shed;
- farm garage;
- large farm silo;
- farm dairy;
- farmhouse;
- medium glass greenhouse(s);
- small manure plate / manure storage;
- Farm 6 decoration.

Do not replace these with newer equivalents during setup.

The large Farm 6 silo has a **300,000 L** total capacity.

The cow shed supports:

- cows and water buffalo;
- liquid manure;
- cow milk;
- buffalo milk;
- straw;
- manure;
- automatic water;
- 60,000 L food capacity;
- 100,000 L liquid-manure capacity;
- up to 70 animals.

The sheep/goat barn supports:

- goats/sheep;
- hay/grass food;
- straw;
- manure;
- goat milk / wool pallet output;
- automatic water;
- 13,500 L food capacity;
- up to 40 animals.

---

# 5. Starting Livestock

Use a mixed herd, but leave room for expansion.

## Cow shed

| Animal | Count | Notes |
|---|---:|---|
| Dairy cows | **12** | Adult / productive |
| Water buffalo | **6** | Adult / productive |

Total cow-shed population: **18 / 70 maximum**.

Avoid creating an artificially uniform herd if Realistic Livestock RM stores individual age/sex/genetic state. Prefer a plausible spread of adult ages, with most animals productive and a few younger animals.

## Goat barn

| Animal | Count | Notes |
|---|---:|---|
| Goats | **20** | Mostly adult / productive |

Total: **20 / 40 maximum**.

## Chicken shed

Leave **empty for the first test save**.

The building remains part of the inherited farm, but chickens can be added later if they improve the campaign rather than simply adding another icon to service.

---

# 6. Starting Husbandry Resources

## Cow shed

| Resource | Start amount |
|---|---:|
| Food / forage/TMR-equivalent accepted by husbandry | **24,000 L** |
| Straw in husbandry | **8,000 L** |
| Liquid manure / slurry | **22,000 L** |
| Manure | **14,000 L** |
| Cow milk | **2,000 L** |
| Buffalo milk | **1,000 L** |

Water is automatic.

If the manure system requires a separate nearby manure heap rather than direct internal storage, place/associate the existing Farm 6 manure storage correctly and put the **14,000 L** there.

Farm 6 has two separate manure heaps: the larger heap beside the cow barn is for cows, and the smaller heap beside the goat shed is for goats. They are separate engine-managed heaps; do not combine their contents or put either herd's manure into the cow shed's zero-capacity internal `MANURE` slot.

## Goat barn

| Resource | Start amount |
|---|---:|
| Hay / accepted goat feed | **6,000 L** |
| Straw | **3,000 L** |

Water is automatic.

Do not start with spawned goat-milk pallets unless the game naturally creates them from the herd after the save begins.

---

# 7. Bulk Stock on Hand

Put these materials in the Farm 6 silo where supported:

| Material | Quantity |
|---|---:|
| Wheat | **12,000 L** |
| Barley | **8,000 L** |
| Maize / corn | **6,000 L** |

These are leftovers from the previous harvest, not a free warehouse of everything the farm might someday need.

Do not pre-stock Specialità cash crops such as sesame, fava, chickpea, lavender or mint. The player should produce those.

---

# 8. Bale Stock

Physically place bales in a sensible covered Farm 6 storage area if possible.

| Material | Count | Form |
|---|---:|---|
| Hay | **10** | Round bales |
| Straw | **8** | Round bales |
| Silage | **6** | Wrapped round bales |

Use a bale size that is genuinely compatible with the starting **Welger RP150** rather than arbitrarily choosing the largest modern bale.

If the RP150 mod exposes multiple historically plausible sizes, prefer its normal/default round-bale size.

Do not substitute square bales.

## 8.1 Canonical Farm 6 storage layout

After the preliminary placement test, the save's current component-1 transforms are recorded here. Preserve these positions when reconstructing the start; the rotations are included so equipment does not get respawned in the original scattered staging area.

| Equipment | Position | Rotation |
|---|---|---|
| Fiatagri 110-90 DT | `-588.663 37.549 55.954` | `176.86 8.21 -179.15` |
| Fiat 480 | `-595.708 37.097 63.621` | `178.62 82.64 -179.70` |
| New Holland TX32 | `-578.115 38.539 28.407` | `-0.37 87.43 -0.94` |
| TX32 grain header | `-573.411 39.527 28.803` | `-16.60 87.43 -0.92` |
| Deutz-Fahr KM24 | `168.745 28.079 -127.547` | `-0.02 -0.05 0.04` |
| SIP Favorit 220 | `-599.591 37.037 64.133` | `16.77 89.42 18.00` |
| Welger RP150 | `-600.633 36.992 69.047` | `-1.30 85.85 0.27` |
| Pöttinger Pionier LW14 | `-598.823 37.149 74.303` | `-176.97 83.13 -178.78` |
| RAUCH ZSA580 | `-581.634 38.740 38.390` | `-27.77 9.89 -71.86` |
| Hassia DU100 | `-578.941 38.473 35.018` | `171.34 89.28 -177.86` |
| Lemken Achat | `-575.452 38.428 35.075` | `-176.36 89.67 -176.35` |
| Krone Emsland | `-577.295 39.971 41.844` | `-177.20 87.12 -177.27` |
| Joskin Tanker 3500 | `-550.839 38.737 68.548` | `-178.57 -3.05 180.00` |

The three bale stocks are stored inside `placeable_smallRusticBaleShed` at `-558.951 38.698 68.075`, rotation `0 0 0`, rather than spawned as loose world objects. Its serialized contents are 10 hay bales, 8 straw bales and 6 wrapped silage bales. Keep them in that object-storage inventory on future save construction.

The canonical equipment metadata is: Fiatagri 110-90 (age 4, 3,840 h, 17% damage), Fiat 480 (age 17, 8,960 h, 29%), TX32 and header (age 0, 42 h / 0 h, 2% / 0%), KM24 (age 8, 1,150 h, 24%), SIP Favorit 220 (age 18, 1,780 h, 32%), Welger RP150 (age 12, 2,420 h, 28%), Pionier LW14 (age 27, 3,260 h, 39%), RAUCH ZSA580 (age 1, 760 h, 22%), Hassia DU100 (age 6, 1,360 h, 19%), Lemken Achat (age 0, 35 h, 3%), Krone Emsland (age 27, 4,100 h, 36%) and Joskin Tanker 3500 (age 6, 2,050 h, 31%). These values are the intended March 1990 start metadata; preserve the current saved transforms above when reconstructing the save.

The live save uses the existing separate heaps: `placeable4259b534ddb7df4ae18d7dd025ce87eb` beside the cow barn currently has engine heap state `manureToDrop="7"`, and `placeable_smallManurePlate` at `-594.604 37.819 52.874` beside the goat shed currently has `manureToDrop="4"`. These are FS25 heap-state counters rather than litre values; do not put manure into the husbandry storage node, whose configured `MANURE` capacity is zero.

---

# 9. Starting Equipment

Use the project's historical equipment catalogue as the source for allowed machines and year overrides.

The fleet should have deliberately uneven wear. Do not apply one global degradation percentage.

## Tractors

| Machine | Role | Hours | Repair / mechanical | Paint | Fuel |
|---|---|---:|---:|---:|---:|
| **Fiatagri 110-90 DT** | Main tractor | **3,840 h** | **83%** | **58%** | **70%** |
| **Fiat 480** | Yard / light tractor | **8,960 h** | **71%** | **31%** | **55%** |

Interpretation: the 480 is the old family survivor; the 110-90 is the newer main machine that has already worked hard.

## Combine

| Machine | Role | Hours | Repair | Paint | Fuel |
|---|---|---:|---:|---:|---:|
| **New Holland TX32** | Grain combine | **42 h** | **98%** | **96%** | **80%** |

Include its period-correct grain header.

The TX32 is intentionally the odd machine out: essentially new in March 1990.

This gives the inherited farm a useful campaign hook: the previous owner had very recently bought the combine, so the player inherits both a valuable machine **and the financial consequences of buying it**.

Do not artificially age it to match the rest of the fleet.

## Grass / forage

| Machine | Role | Hours | Repair | Paint |
|---|---|---:|---:|---:|
| **Deutz-Fahr KM24** | Mower | 1,150 h | 76% | 43% |
| **SIP Favorit 220** | Tedder / rake | 1,780 h | 68% | 34% |
| **Welger RP150** | Round baler | 2,420 h | 72% | 46% |
| **Pöttinger Pionier LW14** | Forage wagon | 3,260 h | 61% | 25% |

## Tillage / sowing / fertilising

| Machine | Role | Hours | Repair | Paint |
|---|---|---:|---:|---:|
| **Hassia DU 100** | Grain drill | 1,360 h | 81% | 55% |
| **Lemken Achat** | Cultivator / secondary tillage | 35 h | 97% | 94% |
| **RAUCH ZSA580** | Fertiliser / lime spreader | 760 h | 78% | 49% |

The Lemken Achat is another recent purchase. If historical gating proves that the specific in-game configuration cannot reasonably exist by March 1990, omit it rather than inventing an earlier year.

## Transport / slurry

| Machine | Role | Hours | Repair | Paint |
|---|---|---:|---:|---:|
| **Krone Emsland** | Grain / general / bale trailer | 4,100 h | 64% | 22% |
| **Joskin Tanker 3500** | Slurry tanker | 2,050 h | 69% | 41% |

## Deliberate starting gaps

Do **not** automatically provide every operation.

In particular, do not add a manure spreader solely because manure exists. Accumulating manure can create a sensible early equipment decision.

Do not add a dedicated maize forage harvester unless testing shows the starting livestock loop is unworkable without one.

---

# 10. Vehicle-Year Overrides

Where Historical Start / Vehicle Years needs manual overrides:

- use `equipment/catalogue.csv`;
- do not use the mod's release year;
- do not backdate unresolved machinery just to make it available.

Known campaign anchors include:

- Fiatagri 110-90 DT — **1986**
- Fiat 480 — **1973**
- New Holland TX32 — **1990**
- Welger RP150 — **1978**
- Pöttinger Pionier LW14 — **1963**
- Hassia DU 100 — **1984**
- RAUCH ZSA580 — **1989**
- Lemken Achat — **1990**

For machines whose catalogue year is explicitly a proxy or unresolved, preserve that status.

---

# 11. Consumables

Start with modest working quantities only.

| Consumable | Quantity |
|---|---:|
| Diesel in farm storage, if Farm 6 has usable fuel storage | **2,000 L** |
| Seeds | **1,500 L** |
| Solid fertiliser | **1,000 L** |
| Lime | **2,000 L** |
| Herbicide | **0 L** |
| Liquid fertiliser | **0 L** |

The zero herbicide/liquid-fertiliser start is intentional: the inherited farm should not begin as a perfectly stocked modern input warehouse.

If Farm 6 has no appropriate owned bulk storage for one of these materials, do not invent a tank. Use a small number of appropriate pallets/big-bags instead.

---

# 12. Greenhouses / Productions

Farm 6's inherited production infrastructure should remain present, but do not grant free production inventory.

At start:

- farm dairy: present, inactive unless the player turns on a recipe;
- glass greenhouses: present, **empty / inactive**;
- no free compost;
- no free Specialità finished products;
- no free sauce, pasta, oils or wine.

Milk already in the cow shed may be used by the player immediately if the dairy accepts it.

---

# 13. Precision Farming / Agronomy

If Precision Farming is enabled:

- do not make the whole holding perfect;
- use plausible inherited soil variation;
- avoid maximum nitrogen and perfect pH on every field;
- Field 102 should be ready for a real spring decision before fava sowing;
- do not force `GRAPEB` into the normal arable PF model.

Fava is a legume and should ultimately be balanced accordingly, but do not invent final nitrogen targets if the project's PF pass has not established them yet.

---

# 14. Save-Setup Procedure for Luna

1. Locate the intended fresh Monteriggioni Specialità test save.
2. Make a complete backup before editing.
3. Verify the active map/mod version matches the current repo.
4. Set campaign year/month to **March 1990** and days per month to **3**.
5. Configure Historical Start / Vehicle Years settings.
6. Make Farmland 6 the player's farm property.
7. Grant ownership of Fields **6, 65, 70, 75, 102** only.
8. Apply the requested field crop/ground states.
9. Verify Field 102 is genuinely sowable with `FABABEAN` in March.
10. Populate cow/buffalo and goat husbandries.
11. Set husbandry feed/straw/manure/slurry/milk values.
12. Put the specified grain into the Farm 6 silo.
13. Create/place the bale inventory.
14. Create/assign the starting machinery.
15. Apply exact operating hours, repair, paint and fuel values.
16. Apply Vehicle Years overrides where required.
17. Leave deliberately missing operations missing.
18. Configure consumables only where the farm has a plausible storage method.
19. Leave greenhouses and production chains empty/inactive.
20. Save.
21. Start the game and load the save.
22. Check `log.txt` for errors.
23. Verify every item below in-game.
24. If any requested state cannot be represented safely, stop and document the blocker rather than silently approximating it.

---

# 15. Acceptance Checklist

## Campaign

- [ ] Date is March 1990 with three days per month.
- [ ] Historical vehicle gating starts in 1990.
- [ ] GPS remains unavailable until 1995.

## Ownership

- [ ] Farm 6 is owned.
- [ ] Field 6 owned.
- [ ] Field 65 owned.
- [ ] Field 70 owned.
- [ ] Field 75 owned.
- [ ] Field 102 owned.
- [ ] No unintended surrounding fields are owned.

## Fields

- [ ] Field 6 is established grass/pasture.
- [ ] Field 65 is established barley.
- [ ] Field 70 is established wheat.
- [ ] Field 75 is established grass/hay ground.
- [ ] Field 102 is cultivated and ready for March fava sowing.
- [ ] No field is accidentally harvest-ready on day one unless explicitly specified.
- [ ] Precision Farming state is plausible rather than perfect.

## Livestock

- [ ] 12 productive dairy cows.
- [ ] 6 productive water buffalo.
- [ ] 20 goats.
- [ ] Chicken shed empty.
- [ ] Cow/buffalo feed and straw correct.
- [ ] Goat feed and straw correct.
- [ ] 22,000 L slurry available.
- [ ] 14,000 L manure available.
- [ ] Cow and buffalo milk starting stock correct.

## Stored material

- [ ] 12,000 L wheat.
- [ ] 8,000 L barley.
- [ ] 6,000 L maize.
- [ ] 10 hay round bales.
- [ ] 8 straw round bales.
- [ ] 6 wrapped silage round bales.

## Machinery

- [ ] Fiatagri 110-90 DT.
- [ ] Fiat 480.
- [ ] New Holland TX32 + grain header.
- [ ] Deutz-Fahr KM24.
- [ ] SIP Favorit 220.
- [ ] Welger RP150.
- [ ] Pöttinger Pionier LW14.
- [ ] Hassia DU 100.
- [ ] Lemken Achat, if March-1990 availability remains defensible.
- [ ] RAUCH ZSA580.
- [ ] Krone Emsland.
- [ ] Joskin Tanker 3500.
- [ ] Hours/repair/paint values match this document.

## Infrastructure

- [ ] Existing Farm 6 cow shed works.
- [ ] Slurry loading trigger works.
- [ ] Existing manure storage is connected/usable.
- [ ] Sheep/goat barn works.
- [ ] Farm silo works.
- [ ] Farm dairy works.
- [ ] Greenhouses remain present but start empty.
- [ ] Save loads without new errors.

---

# 16. First In-Game Jobs the Start Should Naturally Produce

A successful setup should make the opening week feel roughly like:

1. Walk the inherited farm and inspect the machinery.
2. Feed/check cows, buffalo and goats.
3. Decide whether to spread existing slurry before spring sowing.
4. Prepare/sow **Field 102 with fava**.
5. Check weeds/nutrition on the winter barley and wheat.
6. Keep an eye on the grass fields for the first forage cut.
7. Deal with the awkward reality that the farm owns a nearly-new TX32 while much of the rest of the fleet looks like it has known several popes.

That tension is intentional.

---

# 17. Test Notes

## Problems

- 

## Save-editing blockers

- 

## Balance changes

- 

## Equipment substitutions

- 

## Canonical changes after testing

- 
