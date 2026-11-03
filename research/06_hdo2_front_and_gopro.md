# 06 — HDO2 fan seat, front face and GoPro joint: reconciled design parameters for the CAD

Track 06 (reconciliation of 06a, 06b and 06c). ZALOZENIA.md governs. **Where this file disagrees with a source
in `papers/`, the source governs.** The corrections found in this check have also been written into 06a, 06b
and 06c (see Verification).
Status 2026-11-03: **working draft.** Every HDO2 number here comes from product photos, the manual or community
models. Nobody has measured Adam's goggles yet. §3 lists the measurements that replace the low-confidence rows.

Tags: [STL] mesh measurement (by 06b/06c, and by me where marked "re-checked"); [img] pixel measurement with
the scale reference given; [V] manual or datasheet text; [V-comm] community text; [calc]; [inf] inference.

## 0. Headline: the HDO2 fan is on the TOP, not on the front face

Adam's decision (ZALOZENIA log, 2026-11-03): the fan is removed and the camera mount goes in its place. All the
evidence puts that place **on the top shell**:
- it is centred left to right;
- its rear edge sits against the black faceplate rim;
- it sits between the VOL and CH button panels;
- its centre is about 23 mm behind the front face.

The front face carries only the logo, a parting line and two bay doors. Evidence I viewed myself:
- `papers/hdo2_front_img/manual/img-001.png` (manual p.5, top view);
- `fatshark/fs_hdo2_media4_HDO2_e.jpeg` (front view: the cover sticks up above the top edge);
- `manual/img-099.png` (side views);
- `oscarliang/fatshark-hdo2-fpv-goggles-control-buttons-oled.jpg` (close-up).

06a and 06b reached this independently. Confidence: high.

**Consequence for `cad/camera_mount.scad` (not edited; outside this task's scope).** `adapter_fan` and
`hdo2_ghost` model the fan as a **vertical** 25 × 25 face **on the front** of the goggles:
- l.6: "ramka nasuwana na wentylator 25x25 z przodu HDO2";
- l.13: "x=0 = przednia płaszczyzna wentylatora";
- l.211: "wentylator na środku przodu".

That geometry is wrong. The adapter needs:
- a **horizontal seat plate** on the top shell;
- an arm reaching **forward past the front edge**, which is ≈10 mm ahead of the cover's front edge and ≈23 mm
  ahead of the fan centre;
- then a drop **down in front of the front face**, so the thermal camera can reach the 0…+35 mm eye-height
  window of ZALOZENIA item 1 (see C6).

## 1. Design parameters

Coordinates: "fan centre" means the centre of the 4-screw pattern. "Axis" means the optical axis through the
eyepiece lens centres.

### A. Interface on the goggles (replaces the fan)

| # | Parameter | Value for CAD | Uncertainty | Source | Conf. |
|---|---|---|---|---|---|
| A1 | Screw pattern | **4 holes on a 20.00 × 20.00 mm square**, centred on the fan | ±0.05 as modelled; the photos give 20.7–20.8 (+3–4 % perspective) | [STL] re-checked by me: `models_hdo2/262727…/fan.stl`, `21866…`, `96977…` holes at (±10, ±10); `1073216…` at x 1/21, y ±10. 279676 SCAD `translate([±10,±10])`. [img] `manual/img-001.png` 176.7 × 177.7 px at 0.1168 mm/px; manual p.5 300 dpi render 115.6 × 115.0 px at 5.56 px/mm | high |
| A2 | Stock screw | thread **unknown**, between Ø1.5 and Ø2.0 (≈M2 or a 1.7–2 mm self-tapper); head ≈3 mm; stock length "short" | head ±0.5 mm | Ø2.0 clearance in 262727, 21866, 96977, 472353, 1028925; Ø1.50 in 1073216 and 279676 (screw cuts its own thread) [STL]; head [img] 06a §2.2; "fewer threads holding it down … Longer screws is fine" [V-comm `models_hdo2/1179662…/printables_meta.txt` l.7] | low |
| A3 | Plate clearance holes | **Ø2.3** (= `m2_d` in the CAD); keep it a parameter until A2 is measured | — | [inf] from A2 | — |
| A4 | Seat footprint (cover or fan) | **25.0 × 25.0 mm**; community plate undersides 25.2–25.4 | ±0.2 | [STL] covers 21866, 96977 (bbox 25.0 × 25.0 × 2.0), 472353, 1028925; 262727 inner 25.2 × 25.1; 1073216 base 25.4 wide at z = 0.3 (re-checked) | high (as modelled) |
| A5 | Space around the seat | lateral **±18 mm** from the fan centre before the button panels (VOL panel edge 18.2, CH 19.2); VOL/CH buttons from ±21.7 / 22.6; joysticks ≈±40. **Rearward: none**, because the cover's rear edge touches the faceplate rim (every cup is open at the rear). Forward: 9.9 mm of deck to the front edge | ±4 % | [img] 06a §3.3, §2.1 (`img-001.png`); [STL] 06b §3.2 | medium |
| A6 | Opening under the fan | **Ø23–24 mm**. What lies under it is **unknown**. **Close it** with a solid plate, light-tight | as modelled | [STL] 1073216 Ø23.99 (re-checked), 279676 SCAD `r=11.5`; covers 24.3. Forum: "the fan on the faceplate" [V-comm `hdo2_front_img/forums/intofpv_thread_25283.txt` l.36] | value high; "what's under" none |
| A7 | Bosses or posts at the screws | possibly posts **≤Ø3.5 × ≤2.75 mm**. Give the plate underside relief pockets (e.g. Ø4 × 3 mm) as a **parameter**, off by default | — | [STL+V-comm] 570569 (unnamed white Dominator): "slides over the posts that are on the faceplate fan mount" (`printables_meta.txt` l.8). The generic 25 mm fan frame has "3−ø3.0±0.2" holes [V `hdo2_front_img/fan_ref/SameSky_CFM-25CF_p4-4.png`] | low |
| A8 | Seat plane | flat. **Tilt unknown**: the 06b estimate of 18–28° is **retracted** (Verification V2). No HDO2 part has locating pins | — | [STL] all undersides planar (06b §3.5) | flat: high (as modelled); tilt: none |
| A9 | Fan centre position, lateral | on the centreline: 1.2–1.3 mm off in the top views, 1.4–1.9 mm off the lens midpoint in the back views | ±2 mm | [img] `img-001.png`, p.5 render, `manual/img-008.png`, `fatshark/fs_hdo2_media5_HDO2_d.jpeg` | high |
| A10 | Fan centre position, fore-aft | **23.1 mm** behind the front-most point of the front face, in plan | ±1.5 mm | [img] `img-001.png` 198 px × 0.1168 (06a). p.5 render 128.7 px / 5.56 px/mm (re-checked; 06b's 24.4 corrected) | medium |
| A11 | Stock cover height above the deck | **10–13 mm** (the plate replaces it; this is only a height reference). Its vertical black skirt alone is 6.8 mm | +0/−3 | [img] front view: rear-top edge y = 233, skirt y 276–325, deck strip y 325–340, at 0.139 mm/px (`annotated/front_view_cover_profile_06recheck.png`). The view elevation is unknown (06a §2.2 note) | low |
| A12 | Precedent forward hinges | axis **24.5 / 26.0 / 28.3 mm** ahead of the fan centre and 3.6–4.0 mm above the seat; Ø3 pin (none is GoPro M5) | as modelled | [STL] 279676 (SCAD `translate([-8.5,24.5,4])`), 370383, 1073216 (06b §3.3) | high (as modelled) |

### B. Front face

| # | Parameter | Value | Uncertainty | Source | Conf. |
|---|---|---|---|---|---|
| B1 | Clear flat front panel | **≈125 × 39 mm**, between the bay doors and above the nose notch | ±4 % | [img] front view x 528…1430, y 340…623 at 0.139 mm/px (06a §3.2) | medium |
| B2 | Flatness in plan | setback from the front-most point: ≤0.7 mm within ±35 mm, 2.9–3.6 mm at ±46.7 mm, 12.6–13.4 mm at ±64 mm (re-checked). Arc fit R ≈ 400–560 mm in the central ±23…41 mm | ±0.5 mm | [img] `img-001.png`, lowest object pixel per column (06a §3.1) | medium |
| B3 | Front face height | ≈47 ± 2 mm in the photo; spec 45.5 (the manual does not label the axes) | — | [img] 06a §1; [V] `papers/FatShark_HDO2_Manual_RevC.txt` l.411, PDF p.11 | medium |
| B4 | Parting line | ≈20.6 mm below the front-face top edge, running x 528…1430 | ±1 mm | [img] front view y 487–490 | medium |
| B5 | Keep clear, front | bay doors at both ends: wearer's right 18.5 × 35.7 mm, wearer's left 24 × 35.7 mm. Antenna-port cover Ø≈7 mm on the left door, ≈10 mm below the top edge. Nose notch ≈37 wide × 8 deep. Rounded top edge (no radius known). No buttons or vents on the front | ±4 % | [img] 06a §3.2 | medium |
| B6 | Keep clear, top and sides | VOL/CH buttons from ±21.7 / 22.6 mm; HT and the DVR/Display 5-way joysticks further out (knobs ≈2.5 mm proud). Power and AV ports on the sides (manual p.6). Power/fan button and receiver switch underneath (manual p.5) | — | [img] 06a §3.3; [V] manual p.5–6 | medium |

### C. Eyepiece axis relative to the fan seat

| # | Parameter | Value | Uncertainty | Source | Conf. |
|---|---|---|---|---|---|
| C1 | Lens centre spacing as photographed | 58.6–58.9 mm (≈ minimum IPD). The lenses move with IPD; the fan does not | ±4 % | [img] `manual/img-008.png` 575 px × 0.1025; `media5` 284 px × 0.2063. "minimum IPD to be around 59mm … maximum is around 69mm" [V `papers/ctrl_hdo2_oscarliang.txt` l.87] | medium |
| C2 | Cover top above the lens centres | **35.7 mm** (34.7 and 36.7 in two copies of one shoot) | ±4 mm | [img] back views: cover top y ≈ 562 (re-checked; the cover's top surface spans y 563–580, so that camera looks down ≈4°) | medium-low |
| C3 | **Seat (deck) above the lens axis** | **≈23 mm, range 19–29** | +6 / −4 mm | 06a gives 23 ± 4 (C2 minus a 13 mm cover, and the front-view chain "axis at the parting line"). With the cover at 7–13 mm (A11), C2 alone gives 23–29 [calc]. The main open number | **low; measure (M5)** |
| C4 | Lateral offset, fan centre to lens midline | ≤2 mm | — | A9 | high |
| C5 | Fore-aft position of the lenses or eyes relative to the fan centre | **not found** | — | no source | none |
| C6 | Thermal axis if the camera sits directly on the seat | seat + 3 mm plate + 9.75 mm (half of the 19.5 mm body) ≈ **36 mm above the eye axis (≈32–42)**, against ZALOZENIA's 0…+35 window. **So the arm must drop the camera in front of the front face** | — | [calc] C3; camera 19.5 mm (`cad/camera_mount.scad` l.25 `th_w = 19.5`, from track 03) | estimate |

### D. GoPro joint (cage = male 2-prong; adapter = female 3-prong)

| # | Parameter | Print value (PETG, MK4) | Real-part estimate (spread) | Source | Conf. | Current CAD (l.53–54) |
|---|---|---|---|---|---|---|
| D1 | Male finger | **3.0**; coupon at 2.8 / 2.9 / 3.0 | real gaps 3.0–3.175, median 3.14 | [M] `papers/gopro_dims/measurements_raw.txt` l.8–57 (intervals re-derived) | medium | `gp_leg = 3.0` ✓ |
| D2 | Male slot | **3.5** | real middle finger 3.0–3.3, median 3.18 | same; ridercz `__gopro_slit_width = 3.5` [`papers/gopro_ridercz_GoPro.scad.txt` l.11] | medium | `gp_slit = 3.3`: **only 0–0.3 mm clearance, flag** |
| D3 | Female gap | **3.4–3.5** | takes real male fingers of 2.85–3.02 | 06c §2.2, §6 | medium | 3.3 (same `gp_slit`): tight |
| D4 | Female middle finger | 3.0 | real male slots 3.12–3.3 | 06c §2.2 | low–medium | 3.0 ✓ |
| D5 | Finger-end boss | **Ø15** | 11 of 12 values in 14.55–15.0 | 06c §2.1 (count re-checked) | high | 15 ✓ |
| D6 | Hole | **Ø5.4–5.5** for M5 | moulded real holes 4.97–5.09 | raw l.10, 19, 29, 39 (re-derived) | high | 5.5 ✓ |
| D7 | Hole axis to the nearest base face | ≥ 9 mm (design choice, not a standard) | 9.0–19.5 across designs | 06c §2.1 | — | — |
| D8 | Screw and nut | M5 × 50 in a printed knob, ≈18 mm of thread out; M5 hex nut pocket 8.1–8.2 AF | — | ridercz l.14; j-h-a README | high (M5) | `gp_nut_af = 8.2` ✓ |
| D9 | Quick-release buckle and base (only if a GoPro base is used) | buckle rail 27.8–28.0 × 4.05–4.34; base 28.0–28.6 between rails (caliper 1.106 in = 28.09), roof opening 22.0–22.6, overhang 3.0. Slot height 4.19 vs 4.9–5.0 **unresolved** | — | 06c §4–5; freeza36 sketch `instructables_freeza36_sketches/FOO4TUWHD2RTZE2.jpg` (viewed) | medium-high | — |

## 2. Verification (what I re-checked, and what was wrong)

**Errors found and fixed in place:**
- **V1. 06b, fan centre to front edge: 24.4 changed to 23.1 mm.** 06b put the front screw heads at y = 735 in
  the p.5 300 dpi render. I re-picked them on a 4× crop at y = 748.0 / 747.5, so the pattern centre moves to
  (851.6, 690.3). The distance to the front silhouette (y = 819) is then 128.7 px / 5.56 = 23.1 mm. That agrees
  with 06a's 23.1 mm from `img-001.png`. Fixed in 06b TL;DR rows 9, §1, §3.3, §4 and §6. Annotated:
  `papers/models_hdo2_measure/manual_p5_topview_300dpi_06recheck.png`.
- **V2. 06b, seat tilt 18–28° retracted.** The tilt came only from the mis-picked heads (102 px front to back
  against 112 px side to side). Re-picked, the pattern is 115.6 × 115.0 px. `img-001.png` agrees at
  176.7 × 177.7 px, and 06a already had 177 px both ways. There is no foreshortening, so the photo gives no
  tilt. It only bounds the tilt to ≲14° relative to an unknown camera direction. Fixed in 06b row 10 and §4.
- **V3. 06a, manual page.** The dimensions line is on PDF **p.11** (page header "Fat Shark 11"), not p.12.
  Fixed.
- **V4. 06a, cover height and "cover top ≈15 mm above the front-face top edge".** These are projected values.
  - The front view looks down slightly. The cover's top/grille surface shows as a 43 px band (y 233–276) and
    the deck in front of it as a 15 px band (y 325–340). Only the 49 px skirt (6.8 mm) is clearly vertical.
  - Read as a flat top seen from ≈13° above, the cover is ≈7 mm tall. Read as a sloped front grille seen from
    nearly level, it is 11–13 mm. The side view and the back-view C2 favour the second reading.
  - So I keep 10–13 mm at low confidence and widen the seat-to-axis value to 23 (+6/−4) mm (C3).
  - Notes added to 06a TL;DR row 1c and §2.2.
- **V5. 06a, screw note.** The generic 25 mm fan drawing that 06a cites for the 20 ± 0.3 pitch also specifies
  Ø3.0 frame holes and an M2.5 screw, which 06a had not mentioned. A ≤Ø2 HDO2 screw therefore does not use the
  fan holes as a thread. It either passes loosely through them or the fan sits over posts (A7). Added to 06a
  §2.2.
- **V6. 06c, current CAD values misquoted.** 06c said `camera_mount.scad` uses the ridercz 3.0 / **3.5**. The
  file (l.53) has `gp_slit = 3.3`, which applies to both the male slot and the female gaps. Corrected in 06c's
  context and bottom line, with the consequence (D2/D3).

**Checked and confirmed (no change needed):**
- **STL holes, re-sliced with my own slicer and circle fit.**
  - 262727 `fan.stl`: 4 × Ø1.99 at (±10, ±10); inner 25.2 × 25.1.
  - 1073216: 4 × Ø1.50 at x 1/21, y ±10; Ø23.99 centre hole.
  - 21866: 4 × Ø2.00 on 20.00; flange 25.0 × 25.0.
  - 96977: 4 × Ø1.99 at (±10, ±10); bbox 25.0 × 25.0 × 2.0.
  - The 279676 SCAD matches 06b (holes r = 0.75 at ±10, centre r = 11.5, floor 0.7, hinge at y = 24.5, z = 4).
- **06a front-face plan profile.** My re-check gives setback ≤0.7 mm within ±35 mm, 2.9–3.6 mm at ±46.7 mm and
  12.6–13.4 mm at ±64 mm. 06a reported 3.3–4.0 and 13–14; the difference is within edge-pick error.
- **Back view.** The cover top is at y ≈ 562 and the lens centres at y = 920. Both confirmed on a 3× crop.
- **06c finger, gap, hole and buckle values.** All re-derived from the interval lists in
  `measurements_raw.txt`:
  - gaps: 153569 3.10; 579629 3.175; 95616 V9 3.15; 934640 3.0; 65294 3.14; 1264483 3.15 / 3.65.
  - medians recomputed: middle finger 3.18, gap 3.14.
  - 11 of 12 boss values fall in 14.55–15.0.
  - I ray-cast 153569 myself. Middle and outer fingers are 3.251; the outer one widens to 5.944 at the nut
    boss, and the raw l.8 value of 1.219 is the ray passing through the nut pocket. 06c's "3.25 (nut boss to
    5.94)" is correct.
- **freeza36 sketch (viewed).** It reads .1185 / .869 / 1.106 / .165 / .155 / .3185, and
  2 × 0.1185 + 0.869 = 1.106 checks out. One inconsistency: ".41755" from the ridge to the wall should be
  (1.106 − 0.155)/2 = 0.4755. It looks like a slip on the sketch and affects only the ridge position, which no
  design value uses.
- **Quotes checked verbatim at the cited lines:**
  - `ctrl_hdo2_oscarliang.txt` l.87 (IPD 59–69) and l.103 (fan powered from the barrel connector);
  - `intofpv_thread_25283.txt` l.36;
  - the 1179662, 570569, 21866 and 1073216 descriptions;
  - the SameSky drawing ("25±0.3", "20±0.3", "7±0.3", "3−ø3.0±0.2", "M2.5").

**Contradictions between 06a and 06b, resolved:**

| Item | 06a | 06b | Resolution |
|---|---|---|---|
| Fan centre to front edge | 23.1 | 24.4 ± 2 | **23.1 ± 1.5** (06b pick error, V1) |
| Pattern foreshortening / seat tilt | 177 × 177 px, square | 18–28° tilt | **square; tilt unknown** (V2) |
| Hole Ø in 1073216 | 1.5–1.6 | 1.50 | 1.50 (re-sliced) |
| 1073216 width | plate 25.2 | pocket 25.0 inside | different features: underside 25.4 at z = 0.3, pocket 25.0. No conflict |
| Cover protrusion | 10–13 mm | "not measurable" | 10–13 mm, low (V4) |
| Lateral offset | 1.3 mm | 1.9 mm | 1.2–1.3 mm (re-picked); centred either way |

06c does not overlap with 06a or 06b except for the CAD values (V6).

## 3. Still to be measured by Adam on the real goggles and parts (in priority order)

- **M1. Stock fan-cover screw:** thread diameter and pitch (or self-tapping), length, head diameter and head
  height. Decides A2/A3 and the plate's counterbore.
- **M2. With the cover off:**
  - fan size and thickness (a generic part would be 25 × 25 × 7);
  - connector type;
  - whether the screws go through the fan into shell posts or bosses;
  - post diameter and height above the seat;
  - depth of the fan pocket. Decides A7 and the plate underside.
- **M3. Opening under the fan:** size and shape, and where it leads. Shine a torch into it and look into the
  eyecups. Decides how light-tight the plate must be (A6).
- **M4. Seat plane:**
  - flatness;
  - tilt relative to the front face and to the lens axis (phone inclinometer on a card laid on the seat, then
    on the front face);
  - free space to the faceplate rim behind it and to the button panels (A5, A8).
- **M5. The key number: seat height above the lens centres (C3).** Stand the goggles on a table, front face
  down or with the lens axis horizontal. Measure the lens centre and the seat (top of the posts) from the same
  reference with calipers or a height gauge. The current estimate is 23 mm, range 19–29.
- **M6. Front and top geometry:**
  - fan centre to the front face (expect 23.1);
  - front-face height (45.5 or 47?);
  - straightedge check of the front panel's flatness, horizontally and vertically;
  - radius of the top front edge.
- **M7. IPD setting:** at Adam's IPD, the lens centre spacing (checks C1 and A9).
- **M8. GoPro:**
  - on Adam's real buckle: middle finger, both gaps at the tip and at the root, boss diameter, hole;
  - print coupons: male finger 2.8 / 2.9 / 3.0 and slot 3.3 / 3.4 / 3.5. Record which fit by hand (D1–D3).
- **M9.** Only if a GoPro adhesive base is used: rail width, roof opening, slot height (feeler or drill
  shank), pad thickness, and the curved-base sag.
- **M10.** Unplug the fan and confirm the goggles boot and run normally. No source says whether the firmware
  minds.

## 4. Not found (no claim rests on these; ask Adam to fetch them in a browser if wanted)

- **GetFPV "Fatshark dust removal" (HDO2 disassembly)**
  https://www.getfpv.com/learn/fpv-diy-repairs-and-mods/fatshark-dust-removal/. Cloudflare 403 to curl,
  WebFetch and the archive (06a). It is the most likely source for M2/M3.
- Thingiverse 128718, 1109091, 1163521, 1242876 and the Xerpocalypse fan shroud; Cults3D 349552, 482718,
  1082638; Thangs and MakerWorld. All returned 403 (06b).
- Any Fat Shark drawing or CAD of the HDO2 shell; the fan model, thickness, airflow direction and screw thread.
- The genuine GoPro drawing and thumbscrew dimensions; GoPro design patents D829809, D880571 and D908780 (06c).

Files written in this pass: this report; `papers/models_hdo2_measure/manual_p5_topview_300dpi_06recheck.png`;
`papers/hdo2_front_img/annotated/front_view_cover_profile_06recheck.png`; in-place correction notes in
06a, 06b and 06c.
