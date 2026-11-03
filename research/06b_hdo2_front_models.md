# 06b — Existing 3D models that attach to the HDO2 fan: geometry for a camera mount in place of the fan

Track 06b of the research for `arabskie_gogle`. ZALOZENIA.md governs; where this report and ZALOZENIA.md
disagree, ZALOZENIA.md wins. Status 2026-11-03, working draft: every geometric number below comes from
community STLs or a manual photo, not from a Fat Shark drawing and not from Adam's goggles. **Measure the real
HDO2 before printing anything final (section 6).**

Context: Adam's decision is that the HDO2 fan is removed and the camera mount goes in its place, using the same
screw holes and opening. The goggles will not be sealed to the face, so no fan is needed.

Evidence tags: **[STL]** = my measurement of a downloaded mesh (plane slices + circle fits, scripts in
`papers/models_hdo2_measure/`). **[desc]** = model author's text, verbatim in that model's
`printables_meta.txt`. **[img]** = read off a downloaded image (scale, pixels and uncertainty given).
**[V]** = official manual. **[inf]** = my inference.

## TL;DR

| # | Finding | Value | Confidence | Source |
|---|---|---|---|---|
| 0 | **The HDO2 "front fan" is not on the front face.** It sits on the **top** of the shell, centred left-to-right, with its rear edge against the face-foam frame, between the VOL and CH button panels. Every HDO/HDO2 accessory found mounts there and reaches **forward** over the front edge. | — | high | [V] manual p.5 top view; [img] 262727 img0–4, 1073216 img0, 21866 img1, 1179662 img0–2, 21863 img0–2 |
| 1 | Screw pattern | **4 holes on a 20.0 × 20.0 mm square** | high: 12 independent parts agree within ±0.02 mm | [STL] |
| 2 | Clearance hole in fan covers and plates | **Ø2.0 mm** (5 covers or plates). The cup-style holders 279676 and 1073216 use **Ø1.5 mm** holes. | high (as modelled) | [STL]; 96977 Customizer `mount_hole_d = 2` [desc] |
| 3 | Fan or cover footprint | **25.0 × 25.0 mm square** (all 5 cover replacements); 25 mm fan | high | [STL]; 96977 `fan_side_length = 25` [desc] |
| 4 | Airflow opening | Ø23.0–24.0 mm round, or 25.2 mm square | high (as modelled) | [STL] |
| 5 | Pocket of the holders that clamp **over** the stock cover | 25.0–25.5 mm wide inside, **3 walls, open toward the face**, 5–9 mm tall | high (as modelled) | [STL] 262727, 279676, 370383, 1073216, 21863 |
| 6 | Floor thickness under the stock cover (adds to the screw stack) | 0.7–1.3 mm | high (as modelled) | [STL] |
| 7 | Mating face of every part | **flat (planar)**, no curvature, no locating pins on the underside | high (as modelled) | [STL] |
| 8 | Hinge axis of existing forward mounts | **24.5 / 26.0 / 28.3 mm** ahead of the fan centre, **3.6–4.0 mm** above the seat, pin Ø3.0 | high (as modelled) | [STL] 279676, 370383, 1073216 |
| 9 | Fan centre to the front silhouette of the shell (plan view) | **≈23 mm ± 1.5 mm** (corrected 2026-11-03 by the 06 check; was 24.4: the two front screw heads had been mis-picked) | medium | [img] manual p.5 |
| 10 | ~~The fan seat plane is tilted down toward the front, ≈18–28°~~ **RETRACTED** (06 check): re-picked screw heads give a square pattern, 115.6 × 115.0 px, so no foreshortening is visible. Tilt is unknown and must be measured | — | none | [img] manual p.5, re-measured in `papers/models_hdo2_measure/manual_p5_topview_300dpi_06recheck.png` |
| 11 | Posts on the goggle at the 4 screw positions | fit inside Ø3.5 mm blind holes 2.75 mm deep | low–medium (one model, goggle model not named) | [STL] + [desc] 570569 |
| 12 | Stock screws | **size not found.** "fewer threads holding it down" when a 5 mm plate is stacked under the stock cover; "Longer screws is fine" | screw size: none | [desc] 1179662 |
| 13 | How far the fan or boss stands proud of the shell | **not measurable from any download** | none | — |

**Bottom line for the camera mount [inf]:** design a plate with a flat underside, 4 × Ø2.0–2.2 mm clearance holes
on a 20 × 20 mm square, sized to the 25 mm footprint (or a cup that clears 25.5 mm). Run an arm forward about
25–30 mm from the fan centre to clear the front edge. The existing designs put their hinge at 24.5–28.3 mm.
Expect to need **longer screws than stock**, and **close the Ø23–24 mm hole**: with the fan gone, an open hole
into the headset lets in dust and probably light. Leave tilt and pocket depth as parameters until Adam has
measured the goggles (section 6). *(06 check: the tilt estimate in row 10 is retracted; the fan-to-front distance is ≈23 mm, not 24.)*

---

## 1. Where the fan is (correcting "front")

- **Manual p.5, top view** (`papers/FatShark_HDO2_Manual_RevC.pdf`): a black square cover with 4 screws and
  vents, centred between the VOL and CH panels, touching the foam frame. The p.6 side views show the same block
  sticking up above the top shell, with an upright tab on the stock cover. The manual does not name the part.
- **Community photos confirm it is the fan, and that HDO and HDO2 share it:**
  - #21866, on an **HDO**: a printed "fan shroud" in exactly this place. The author: "On my HDO I don't need the
    additional spacer designed by Xerpocalypse, the fan spins freely with just my modified part." [desc]
  - #21863: "The small part goes below the faceplate fan of the Fatshark Goggles, you have to remove the shroud
    with the 4 small screws and then place the 'Base' between the fan and shroud." [desc] Photos show an HDO.
  - #1179662 PyroPatch, on an **HDO2**: "utilizes the stock fan cover and screws - just don't tighten too far
    since there's fewer threads holding it down. Longer screws is fine too" [desc]
  - #279676: "I´ve testet the fan-mount on Fatshark Dominator HDO2 goggels and Fatshark Dominator HD3 goggels."
    [desc]
  - #262727 and #1073216 photos show HDO2s with the part under or in place of the stock fan cover.
- The same 25 mm cover and 4-screw pattern also appear on a black Dominator V2/V3 faceplate (96977 photos) and a
  white **HD3** (472353 img1). The fan place is common across the Dominator line. Exception: #182674 (Dominator V2
  vertical fan mount) uses a different pattern (below).
- **Consequence [inf]:** a camera mounted at the fan sits **on top of the shell, about 23 mm behind the front
  silhouette**. To look forward past the goggle front, it needs a forward arm, as every antenna/VRx mount here
  has, or it must sit high enough to see over the front edge.

## 2. Models found and downloaded (all Printables)

Folder `papers/models_hdo2/<id>_<slug>/` holds the files, `printables_meta.txt` and photos. The manifest is
`papers/models_hdo2/README.md`. The two STLs already in `papers/printables_stl/` (262727_fan, 1073216) are
**byte-identical** to the new downloads (md5 fe206ae4…, b159e1f0…).

| ID | Title (author) | Type | Goggle in photos or text |
|---|---|---|---|
| 262727 | Triple feed 150mm antenna support for Fatshark HDO 2 (ericogr) | 3-wall cup under the stock cover, plus a 2-prong forward tab | HDO2 |
| 1073216 | Supporto Vrx Walksnail per Fatschark hdo2 (FlowerFpv) | 3-wall cup, Ø24 hole, 3-finger hinge forward | HDO2 |
| 279676 | Fan-mount for Fatshark Sharkbyte Receiver (crazy.biker_84), **OpenSCAD source included** | 3-wall cup, Ø23 hole, 3-finger hinge | HDO2, HD3 [desc] |
| 370383 | Fatshark Walksnail VRX Holder (Chris Horton) | remix of 279676, hinge moved 1.5 mm further forward | Attitude V6 [desc] |
| 21863 | Long-range Antennas Removable Mount for Fatshark (Valentin B) | "Base" cup between fan and shroud, plus TPU clip | HDO |
| 1179662 | PyroPatch - Improved Fatshark Goggle Mount (Micah) | only the **sleeve** is in the files; the fan-mount piece is **not** | HDO2 |
| 21866 | TBS Logo Fatshark Fan Shroud (Valentin B) | replacement cover | HDO |
| 472353 | Fatshark Fan Cover - TZS (tozes) | replacement cover | HD3, white Dominator |
| 1028925 | FatShark Fan Guard - theFPVgeek edition (3 versions) | replacement cover | none named (img0–1 are renders) |
| 96977 | 25mm Fan Guard for Fatshark Faceplate (ps915), Thingiverse Customizer 128718 | flat grille | black Dominator, V2/V3-style faceplate (model not named) |
| 570569 | Fat Shark Rediculous 40mm fan mod! (MDrifterX3) | 25→40 mm adapter + 40 mm cover | white Dominator (model not named) |
| 182674 | Fan mount for Fatshark Dominator V2 (oXiVanisher) | vertical fan holder | Dominator V2 (**different pattern**) |
| 215826 | HDO2 adapter for HDZERO VRx (MrMPod) | small adapter between the HDZero VRx and a Shield antenna. In its photos the VRx hangs from a black hinged bracket on top of the stock fan cover; that bracket is not among the files | HDO2 |
| 569776 | Walksnail Avatar Fatshark Dominator 4 Antenna Faceplate Mod | Walksnail goggle faceplate; "Mount the fan using the two original screws" [desc] | Walksnail Avatar (**different goggle**) |

## 3. Measured geometry (all [STL], mm)

Method: each mesh is placed with its largest downward-facing flat face at z = 0 (the mating face). I sliced
horizontal planes every 0.1 mm, chained the loops and circle-fitted them (Kasa least squares; residual
< 0.005 mm on every hole quoted). Inner pockets were ray-cast from the hole-pattern centre. Hinges were sliced
perpendicular to the pin. `admesh` reports every STL as one closed part with 0 disconnected facets, except
569776 Antenna-Mod (3 facets). Cross-check: the 279676 OpenSCAD source states the same numbers I measured from
its STL (holes `r=0.75` at ±10, centre hole `r=11.5`, floor 0.7 mm, pocket = hull of r = 2.5 at ±10 → 25 mm,
hinge axis at y = 24.5, z = 4, pin `r=1.5`, slots 3.1 mm).

### 3.1 Hole pattern and footprint

| Part | Hole centres (spacing) | Hole Ø | Footprint / opening | Plate under screw heads |
|---|---|---|---|---|
| 262727 fan.stl | (±10, ±10) → 20.00 × 20.00 | 2.00 (1.99 at z=0.3) | inner square 25.2 × 25.1, outer 29.0 | 1.0 |
| 1073216 | x 1.0/21.0, y ±10.0 → 20.00 × 20.00 | 1.50 | round Ø24.00 | 1.3 |
| 279676 | (±10, ±10) → 20.00 | 1.50 | round Ø23.00 | 0.7 |
| 370383 | (±10, ±10) → 20.00 | 1.50 (as 279676) | Ø23.00 | 0.7 |
| 21863 base | 111.82/131.82, 58.73/78.73 → 20.00 | 2.0, with a 0.5 mm chamfer to 2.9 at the underside | Ø23.0 (23.9 at the chamfer) | 1.0 |
| 21866 cover | 20.00 | 2.00 | flange 25.0 × 25.0 | flange 1.0 |
| 472353 cover (re-oriented: its flange is tilted 8.1° in the file) | 20.00 | 2.00 | flange 25.0 × 25.0, opening 24.3 | ≈1.2 |
| 1028925 covers v1/v2/v3 | 20.00 | 2.00 | flange 25.0 × 25.0, opening 24.3 | ≈1.2 |
| 96977 grille | 20.00 | 2.00 | 25.0 × 25.0 × 2.0, opening Ø23.0 | 2.0 |
| 570569 adapter, goggle side | 19.98–20.00 | **Ø3.5 blind, 2.75 deep** (+0.45 mouth chamfer); no through hole | 25.15 outer, Ø23.0 | — |
| 182674 (Dom V2) | **24.00 × 24.00** | 3.0 | 41.5 × 38 | — |

- **20 × 20 mm on a 25 mm square is consistent across HDO, HDO2 and HD3 parts.** 182674 (24 × 24, Ø3.0) belongs
  to the Dominator V2 vertical fan holder, a Predator-goggle remix ("Sources: vertical mount for fan to use with
  Fat shark Predator goggles", thing:1163521). It is **not** HDO2 evidence.
- **Hole diameter.** Five parts use Ø2.0 clearance. 279676/370383 and 1073216 use Ø1.5, which a stock screw can
  only pass by cutting its own thread. [inf] The stock screw's thread is therefore probably larger than 1.5 mm
  and no larger than about 2.0 mm (M1.7–M2 self-tapping is plausible). **Not confirmed. Measure it.**
- **Posts [inf, low–medium].** 570569 says "the adapter slides over the posts that are on the faceplate fan mount
  nice and snug!" [desc]. Its goggle-side face has four Ø3.5 × 2.75 mm blind holes on the 20 × 20 pattern and
  **no screw holes** [STL]. So that (unnamed white Dominator) goggle has four bosses ≤ Ø3.5 mm standing up to
  ≈2.75 mm above the surface the adapter seats on. The photos do not show whether those posts belong to the shell
  or to the fan frame. The other parts give no clue: all have flat undersides with plain holes.

### 3.2 Cups that go between the shell and the stock cover

| Part | Inside pocket | Open side | Wall top above the mating face | Notes |
|---|---|---|---|---|
| 262727 | 25.2 wide | rear (+y, toward the face) | 6.0 | 2-prong tab forward: prongs 5.0 wide, 4.0 gap, tab tip 29.4 ahead of the fan centre. Rear wall outside face 68° from horizontal; top face 4.4° |
| 279676 | 25.0 (r 2.5 corners) | rear | 5.5 | hinge to 8.0 |
| 370383 | 25.0 | rear | 5.5 | hinge to 8.0 |
| 1073216 | 25.0 wide; front wall 13.0 from the hole centre (0.5 mm extra clearance forward) | rear | 5.0 | fingers to 7.0 |
| 21863 base | 25.5 wide (12.75 each side) | rear | 9.0 | sliding-clip interface |

[inf] The stock cover fits inside a 25.0–25.5 mm, 3-sided pocket. Its screws pass through the cup floor, so the
cover **rises by the floor thickness (0.7–1.3 mm)**. That is why PyroPatch warns about fewer threads. All five
cups are **open on the face side**, which suggests something on that side (the foam frame, or the black
surround at the foam, visible in 21866 img1) leaves no room for a wall.

### 3.3 Forward hinges (the closest analogues to a camera arm)

| Part | Pin hole | Axis ahead of the fan centre | Axis height above the seat | Fingers |
|---|---|---|---|---|
| 279676 | Ø3.00 | 24.5 | 4.0 | 3 fingers across 17.0, slots 3.1 (from SCAD) |
| 370383 | Ø3.00 | 26.0 | 4.0 | same as 279676; the author says the VRX "didn't quite sit flush … so I added a couple of millimetres" [desc] |
| 1073216 | Ø2.99 | 28.3 | 3.6 | 3 fingers 3.5 / 3.0 / 3.5, gaps 3.0 |
| PyroPatch 1179662 | "M2x25mm bolt and nut" [desc] | fan-mount part not in the files | — | — |

[inf] Three makers each put the pivot between **24.5 and 28.3 mm** ahead of the fan centre. With the front
silhouette at about 23 mm (section 4), that places the pivot just at, or a few mm beyond, the front edge in
plan. None of the hinges is the GoPro standard (Ø5 / M5). All use a Ø3 pin, or M2 in PyroPatch.

### 3.4 Covers (height budget)

Heights above the seat: 21866 8.0, 472353 5.5, 1028925 6.0 / 6.0 / 6.5, 96977 2.0. 472353 and 1028925 share the
same base geometry (identical face areas 381.0 / 139.6 / 294.1 / 90.8 mm², domes tilted 8.1°). 21866 needs no
spacer on an HDO: the fan "spins freely" [desc]. [inf] The fan blades therefore sit below the flange plane, so a
flat plate on the seat will not touch a fan, if one were left in.

### 3.5 Mating-face curvature and locating features

Every part's underside is a **single plane** (the dominant −z face; no curved or tilted downward faces on the
mating side). There are **no** locating pins, ribs or keys on the underside of any HDO/HDO2 part. Location comes
from the 4 screws, plus, on the cups, the walls hugging the stock cover. The tilted faces found (68°/4.4° on
262727, 14.1° on 279676, 8.1° domes, 22° on 1073216) are all on top or outside surfaces.

## 4. Image measurements (manual p.5 top view)

Source: `papers/FatShark_HDO2_Manual_RevC.pdf` p.5, rendered at 300 dpi; annotated crop at
`papers/models_hdo2_measure/manual_p5_topview_300dpi_annotated.png` (page pixel coordinates).

- **Scale reference:** shell width 169.2 mm [V p.11] = left edge x = 386 to right edge x = 1329 at row y = 560
  → 943 px → **5.573 px/mm**. Check: the rear edge (y = 375–383) to the front silhouette (y = 820) is 437–445 px
  = 78.4–79.8 mm, against the 80 mm spec [V p.11]. The view is close to orthographic, so the scale holds to about 2%.
- **Screw heads.** *Corrected 2026-11-03 by the reconciliation check (`06_hdo2_front_and_gopro.md`, Verification).*
  The original picks were TL (791, 633), TR (903, 633), BL (791, 735), BR (903, 735). The two front (lower)
  heads were mis-picked about 13 px too high. Re-picked on a 4× crop of the same 300 dpi render, ±1.5 px:
  TL (793.8, 632.5), TR (909.5, 633.3), BL (793.0, 748.0), BR (909.0, 747.5).
  - Left-to-right pitch 115.6 px = **20.8 mm**. Front-to-back pitch 115.0 px = **20.7 mm**. The pattern is
    square to within ±2 % (ratio 0.995 ± 0.025). The extracted image `papers/hdo2_front_img/manual/img-001.png`
    gives the same result: 176.7 × 177.7 px (06a).
  - **There is no foreshortening, so the photo gives no evidence of tilt.** The earlier "≈24° (18–28°) tilted
    down toward the front" came only from the mis-picked heads and is **retracted**. The photo only bounds the
    tilt of the cover top relative to the camera's line of sight, to about ≤14°, and that line of sight is
    itself unknown. **Seat tilt: unknown. Measure it.**
  - The 1073216 author's remark ("più parallela alla parte anteriore dei googles") is still a hint that the seat
    is not exactly square to the front face. It gives no magnitude.
- **Fan (pattern) centre** (851.6, 690.3) to the front silhouette (y = 819 at x = 850–865): 128.7 px =
  **23.1 mm ± 1.5 mm** in plan, using 5.56–5.57 px/mm. 06a gets 23.1 mm independently from `img-001.png`. The
  centre is 1.2 mm left of the shell mid-line (858), inside the uncertainty, so: centred.
- **Not measurable here:** the height of the fan/cover above the shell, the depth of the recess around it, and the
  surface curvature around the seat.
- **Stock screw head (attempt, low confidence):** in 21866 img1 (HDO), using the 20 mm screw pitch as scale
  (21–24 px/mm along the visible edges, oblique view), the heads measure about 45–50 px, i.e. **≈2–2.5 mm**. This
  sits awkwardly with the Ø2.0 clearance holes, so the perspective error is large. **Do not use it. Measure the
  screw.**

## 5. Implications for Adam's camera mount [inf]

1. **Interface to copy:** flat underside, 4 × Ø2.0–2.2 clearance on 20 × 20, 25 mm square (or a cup open to the
   face side, 25.5 inside). Keep the Ø23–24 opening **closed** (no fan; it stops dust and light ingress).
2. **Forward reach:** to put the camera ahead of the goggles, the arm needs ≥ 25 mm from the fan centre, as all
   three hinged mounts (24.5–28.3 mm) do. Make the reach and the seat tilt **parameters**, and print a 2-hole test
   coupon first.
3. **Screws:** the stock screws are short (PyroPatch warning). Any plate under or instead of the cover needs
   longer screws of the same thread. Buy them after measuring the stock screw (thread Ø, length, head).
4. **Break-away:** the existing arms are Ø3 / M2 pins on a 0.7–1.3 mm floor held by 4 small self-tappers. That is
   naturally weak, which suits the frangibility idea in report 04. The mount will fail at the screws pulling out
   of the shell bosses, which damages the goggles. A designed weak link in the arm, above the plate, is better.
5. **Fan electrics:** the manual ties the fan to the power button (short press = fan speed / on-off) [V p.6–7].
   What to do with the unplugged fan lead was not found in any source.

## 6. Measure on the real HDO2 before final CAD (in order)

1. Stock screw: thread Ø, pitch or type (machine vs self-tapping), length, head Ø and height. Count 4.
2. With the cover off: whether the screws go into shell bosses or through the fan frame; boss Ø and height above
   the seat (compare with the 570569 posts ≤ Ø3.5 × 2.75).
3. Fan: outer size (expect 25), thickness, connector type.
4. Seat plane: its tilt to the front face (a phone inclinometer on a flat card), and the distance from the fan
   centre to the front edge (expect ≈23).
5. Space on the face side of the seat (why every cup is open there).
6. Test fit: print `papers/models_hdo2/262727…/fan.stl` or `96977` (1–2 min prints) to confirm the 20 × 20 / Ø2
   pattern before designing.

---

## Retrieved

- Printables (API metadata + files + photos) into `papers/models_hdo2/`: 262727, 1073216, 279676 (+ .scad),
  370383, 21863, 1179662 (3mf + STEP + IGES, sleeve only), 21866, 472353, 1028925 (3 STLs), 96977 (+ SOURCES.txt),
  570569, 182674 (+ SOURCES.txt), 215826, 569776 (+ STEP). Manifest with md5: `papers/models_hdo2/README.md`.
- Derived (mine): STEP→STL conversions (FreeCAD) `papers/models_hdo2_measure/1179662_sleeve.stl`,
  `569776_antenna_mod.stl`; renders `render_sheet0/1.png`; annotated manual crop; measurement scripts
  (`meshlib.py`, `scan.py`, `rays.py`, `prof.py`, `slices.py`, `overview.py`, `pmeta.py`, `pdl.py`,
  `step2stl_fc.py`).
- Already in the project and re-used: `papers/FatShark_HDO2_Manual_RevC.pdf` (p.5, p.6, p.11).

## MISSING (could not retrieve; ask Adam to fetch in a browser or drop the files in)

- **Thingiverse**: thing:128718 (fan guard Customizer, source of 96977), thing:1109091 (Dominator V2 fan mount,
  base of 182674), thing:1163521 (Predator vertical fan mount), Xerpocalypse's original fan shroud (base of 21866;
  thing ID unknown), thing:1242876 (an HDO2 search hit, content unknown). All `thingiverse.com` pages and
  `/zip` downloads returned **HTTP 403 (Cloudflare)**.
- **Cults3D**: cults3d.com/:349552 (Dominator V2 fan mount, 41.5 × 38 × 10.4 mm per the search snippet only),
  /:482718 (HD/V2 "FatShark_FacePlate_Fan_Cover.stl 25.0 × 25.0 × 3.0 mm" per the snippet only), /:1082638
  (unknown). **HTTP 403**. Snippet sizes are not used as evidence above.
- **MakerWorld** search API and **Thangs** (thangs.com/m/727143, /m/803564): **HTTP 403**. MakerWorld 413931
  ("Fatshark Strap Mount", Dominator 3 per the snippet) was not fetched.
- **GrabCAD, MyMiniFactory**: blocked (MyMiniFactory 403); GrabCAD not attempted. **No Fat Shark CAD or drawing
  of the HDO2 shell was found anywhere.**
- **PyroPatch 1179662 fan-mount part**: the description talks about a "Fan mount", but the Printables files
  contain only the sleeve (3mf bbox = STEP bbox = 87 × 43 × 5 mm).
- Not found in any source: stock screw size, fan size and thickness from Fat Shark, boss height, seat tilt,
  and how far the fan stands proud of the shell.
