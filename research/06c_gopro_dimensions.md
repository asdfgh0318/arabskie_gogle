# 06c — GoPro mount dimensions: what independent sources say, how far they disagree, and what to print

Context: the HDO2 fan is being removed and the camera mount goes in its place. (06 check: the fan is on the **top** of the shell, not on the front face. See 06a/06b and `06_hdo2_front_and_gopro.md`.) The cage carries a
2-prong (male) GoPro joint. It must fit Adam's real GoPro buckle on a VHB base and the printed 3-prong
adapter (`cad/camera_mount.scad`). *Corrected by the 06 check:* the file does **not** use the ridercz 3.5 slot. Line 53 reads
`gp_leg = 3.0;  gp_slit = 3.3;  gp_od = 15;  gp_hole = 5.5;`, so finger 3.0, slit **3.3** for both the male slot and the female gaps, Ø15, hole 5.5.

**Tags.** [V-comm] = a number written in a community source I downloaded and read (quote in
`papers/extracts_gopro_dims.md`, G-number). [M] = I measured it on a downloaded STL/3MF by ray casting.
Raw output is in `papers/gopro_dims/measurements_raw.txt`, with log line numbers given as "raw l.N".
Planar faces are exact to ±0.01 mm. Holes and round bosses are polygons, so they read about 0.05 mm small.
[img] = a handwritten caliper value read from a photo. The digits are written on the sketch, so no pixel
scaling was needed; the reading uncertainty is noted where it applies. [calc] = my arithmetic. [A] = my
engineering judgment, with no source.
**No GoPro-published drawing or dimension was found.** GoPro's patents describe the joint only in words.
Every number below comes from the community: reverse-engineered models, parametric libraries and one
caliper sketch.

---

## TL;DR

| Feature | Spread across sources | Best estimate of the real part | Confidence | Print value, PETG on MK4 [A] |
|---|---|---|---|---|
| 3-prong **middle finger** | 3.0–3.3 (designed/reverse-engineered); 3.6 in j-h-a (made to clamp) | **≈3.2** (median 3.18 of 7) | medium | 3.0 (printed female) |
| 3-prong **gap** (slot for the male finger) | 3.0–3.175 (reverse-engineered); 2.95–3.5 in libraries | **≈3.14** (median of 7) | medium | 3.4–3.5 (printed female) |
| 3-prong outer fingers | 2.4–3.5, one side carries the nut boss | not critical | — | 3.0 |
| 2-prong (male) **finger** | 2.85–3.02 | **≈3.0** (only one source claims a measurement: 3.02) | low–medium | **3.0** (test coupon 2.8 / 2.9 / 3.0) |
| 2-prong **slot** (takes the middle finger) | 3.12–3.6 | ≈3.1–3.3 | low–medium | **3.5** |
| Finger end (boss) **Ø** | 14.55–15.0 (one outlier at 16.0) | **Ø15** | high | 15.0 |
| **Hole** | 4.97–5.09 claimed or measured; 5.2–5.5 in print libraries | M5 clearance, ≈Ø5.1 moulded | high | **5.4–5.5** |
| Width over 3 fingers | 14.6–16.0 | ≈15.3–16 | medium | follows from the above |
| Hole axis to base face | 9.0–19.5, set by each design | depends on the design | — | ≥ R + 1.5 = 9 mm [calc] |
| Thumbscrew | M5; 18–18.5 mm of thread sticks out; built on an M5×50 bolt | M5 | high (M5); medium (18 mm) | M5×50 + hex/square nut |
| QR buckle rail (flange) width × thickness | 27.82–28.0 × 4.05–4.34 | **≈27.9 × 4.1–4.3** | medium–high | — |
| QR buckle overall (with latch arms) | 44.9–48.5 × 31.1–32.6 | ≈46 × 32.5 | medium | — |
| Socket (adhesive base): width between rails | 28.0–28.6 (one model 30.0) | **≈28.1** (caliper: 1.106 in) | medium–high | — |
| Socket: roof opening / overhang | 22.0–22.6 / 3.0 (one model 4.0) | **≈22.0 / 3.0** | high | — |
| Socket: slot height under roof | 4.19 (caliper) vs 4.9–5.0 (models) | 4.2–5.0, **unresolved** | low | — |
| Socket: centre ridge | 3.0–3.94 wide × 1.5–2.0 high, 34 long | ≈3–4 × 1.5–2 × 34 | medium | — |
| Socket footprint × height | 36–40 × 46–50, 10.3–14.4 high | ≈40 × 50 × 12 | low (no real part measured) | — |
| Curved base radius | no GoPro value; community 57 and ≈120–135 (each fitted to one person's helmet) | **unknown** | none | measure Adam's base |
| Adhesive thickness | no source | **unknown** | none | measure |

**Bottom line for the cage.** The ridercz values (male fingers 3.0, slot 3.5, Ø15, M5 + 0.5) fall inside the
spread and leave clearance against the reverse-engineered real part. *06 check:* `camera_mount.scad` uses
`gp_slit = 3.3`, not 3.5. A 3.3 male slot over a real middle finger of 3.0–3.3 leaves 0–0.3 mm, so that is a
second tight number, alongside the male finger below. A 3.3 printed female gap also sits below the 3.4–3.5
recommended in §6. Either include the slit in the coupon (3.3 / 3.4 / 3.5) or set it to 3.5. The male
finger is the only number with little margin. Real gaps measure about 3.10–3.18 mm, so a 3.0 mm printed finger
has about 0.1–0.2 mm of clearance, which is tight for FDM. **Print a coupon at 2.8 / 2.9 / 3.0 and test it in
Adam's real buckle before printing the cage** (Q8 in `04`).

---

## 1. Sources and how independent they are

| ID | Source | Kind | What I used |
|---|---|---|---|
| G3 | ridercz/GoProScad v1.2.2 (already in the repo) | OpenSCAD library | the stated "standard" values |
| G1 | j-h-a/go-pro-mounts (Jay Abbott, 2014) | OpenSCAD; quick-release clip fitted to "an official quick-release clip" | finger stack, QR socket, thumbscrew |
| G2 | MoonCactus/gopro_customizable_mounts (= Thingiverse 62800, 2013) | OpenSCAD (most-used customizer) | fingers, holes, nut |
| G4 | julietta, Thingiverse 3088912 (via mbugert/openscad-projects) | OpenSCAD | fingers, Ø15, hole |
| G5 | Printables #93976 BeppeITA | "I found the real sizes" + Fusion file + STL | stated values + [M] STL |
| G6 | Printables #153569 | "Reversed engineered the GoPro Buckle" STL | [M] |
| G12 | Printables #579629 | QR buckle with flexible locking tab, STL/STEP | [M] (dimensions in round inches: 3.175 = 1/8 in, 12.7 = 0.5 in) |
| G13 | Printables #95616 (V7, V9), #189423 | buckle; 3-prong on drone plate | [M]. **Same finger coordinates (±1.65, ±4.8) in both, so probably one common origin. I count them as one source.** |
| G13 | Printables #934640 "Gopro Mount Clip Original" | buckle STL | [M] |
| G7 | Printables #65294 "verified ... using a GoPro Hero 4 case" | 3-prong base STL | [M] |
| G8/G13/G10 | Printables #1642521 "ORIGINAL dimensions", #1394238, #1031776 (curved) | QR sockets | [M]. **Same rail/roof/ridge geometry (rail ≈25, roof 20.5–21, ridge 3.0 wide; 1.5 × 34 where measured), so I count them as one family**, although the inner width differs (30.0 vs 28.0). |
| G9 | Printables #1063720 (CC0) | buckle tongue "snug and sturdy fit" | [M] |
| G11 | Printables #1264483 (copy of tmorris9 #96691 with a curved base) | curved 3-prong base | [M] |
| G17 | Instructables "3D Printed GoPro Mount", freeza36 2013 | **dial-caliper sketches of a real GoPro mount** (inches) | [img] socket section |
| G18 | GoPro patents US9423673B2, US10642133B2 | patent text | wording only, no dimensions |
| — | dnnsmnstrr/connector-foundry | vendors GoProScad, says so in l.3-4 | **not independent**, not counted |

Excluded as non-standard or unusable: LeonardChrist board mount (4 mm fins, Ø10 ends); justcoding adapter
(generic defaults); lucasgelfond plate (incomplete code); Brian Dorey PDF (handlebar clamp only); Printables
#30388 (orientation unclear). The HDO2 community parts `262727_fan.stl` / `262727_connector.stl` are **not**
GoPro joints (5 mm prongs, 4 mm slot, Ø3 hole) [M]. Details are in the extracts, "Not GoPro geometry".

---

## 2. Fingers: 3-prong (female, the "buckle" side) and 2-prong (male, the camera side)

### 2.1 3-prong, per source (mm)

| Source | Outer finger | Middle finger | Gap | Boss Ø | Hole Ø | Over 3 fingers | Hole axis to base | Origin |
|---|---|---|---|---|---|---|---|---|
| ridercz G3 | 3.0 | 3.0 | 3.5 "incl. tolerance" | 15 | 5 + 0.5 | 16.0 [calc] | 12.5 default (17 − 7.5 + 3) [calc, l.28] | library |
| j-h-a G1 | 3.0 | **3.6** | 3.0 (spacer = male plate) | 14.9 | 5.3 | 15.6 [calc] | — | library, fitted to an official part |
| MoonCactus G2 | 2.75 | 3.2 | **2.95** | 14.6 [calc l.107] | 5.5 | 14.6 | 7.8 to plate face [calc] | library ("keep it tight") |
| julietta G4 | 8 (nut side) / 3.0 | 3.0 | 3.5 | 15 | 6.0 | — | — | library |
| BeppeITA G5, stated | 3.02 | 3.02 | 3.12 | 14.88 (labelled "radius", really Ø) | 5.09 | 15.30 [calc] | — | "real sizes" |
| BeppeITA G5, STL as exported [M raw l.2-4] | 2.82 | 2.82 | 3.62 | 14.68 | 4.89 | 15.70 | 11.07 to plate | STL has the tolerance baked in |
| #153569 [M raw l.8-10] | 3.25 (nut boss to 5.94) | 3.25 | 3.10 | 14.55 | 5.07 | 15.95 | 13.40 to buckle bottom | reverse-engineered |
| #579629 [M raw l.17-19] | 2.60 | 3.175 | 3.175 | 14.73 | 5.46 | 14.73 | 15.24 to buckle bottom | inch design |
| #95616 V9 / V7 [M raw l.27-32] | nut side 2.8 (5.5 across the nut boss); other side 3.3 (V9) / 3.8 (V7) | 3.3 | 3.15 | 15.0 | 4.99 | 15.7 | 13.2 to buckle bottom | — |
| #189423 [M raw l.50-52] | 2.5 | 3.3 | 3.15 | 15.0 | 5.49 | 14.6 | 9.0 to plate top | same origin as #95616 |
| #934640 [M raw l.38-39] | 3.5 | 3.0 | 3.0 | 14.99 | 4.97 | 16.0 | 19.54 to buckle bottom | — |
| #65294 [M raw l.54-55] | 7.27 / 2.27 (recessed) | 3.18 | 3.14 | **16.0** | 5.48 | — | 9.0 to base | "verified with Hero 4 case" |
| #1264483 [M raw l.57] | 7.1 / 2.4 | 3.0 | 3.15 / 3.65 (asymmetric) | — | — | — | — | copy of tmorris9 |

**Spread.**
- **Middle finger.** The sources that claim a real part or were checked against one (G5, #153569, #579629,
  #95616/189423, #934640, #65294; 6 groups, 7 values) give 3.0–3.3, median 3.18 [calc]. The libraries use
  3.0–3.2, and j-h-a uses 3.6 on purpose (its middle plate clamps).
- **Gap.** The same groups give 3.0–3.175, median 3.14 [calc]. MoonCactus is the tightest library at 2.95.
  ridercz and julietta put 3.5 *including tolerance*. BeppeITA's printed STL widens 3.12 to 3.52–3.62. He
  writes: "some compatible mounts have tighter gaps (at the bottom), so you have just to increase the tolerance
  of 0.1" (G5 l.22).
- **Boss Ø.** 14.55–15.0, with #65294 at 16.0 as the outlier. Ø15 is the common value.
- **Hole.** Values that claim to reproduce the real part are 4.97–5.09. Print libraries open it to 5.2–5.5
  for an M5.
- **Hole axis to base.** This is a design choice, not a standard. Each buckle sets it differently
  (13.2–19.5 mm). The only hard limit is that the partner's Ø15 boss must clear the base when it pivots:
  ≥ 7.5 mm + clearance [calc].

### 2.2 2-prong (male), per source

| Source | Finger | Slot | Boss Ø | Hole Ø |
|---|---|---|---|---|
| ridercz G3 | 3.0 | 3.5 | 15 | 5.5 |
| j-h-a G1 | 3.0 | 3.6 | 14.9 | 5.3 |
| MoonCactus G2 | 2.85 | 3.3 [calc: 1.65 to 4.5 ×2] | 14.6 | 5.2 |
| julietta G4 | 3.0 | 3.5 | 15 | 6.0 |
| BeppeITA G5, stated / STL [M raw l.5-6] | 3.02 / 2.82 | 3.12 / 3.52 | 14.88 / 14.88 | 5.09 / 5.29 |

Only BeppeITA claims a measured real male part (3.02 / 3.12). Mating rule, which all libraries obey [calc]:
male finger < female gap, and male slot > female middle. MoonCactus runs 0.1 mm of total clearance
(2.85 in 2.95, 3.3 over 3.2). ridercz runs 0.5 mm (3.0 in 3.5). When tightened, the thumbscrew pulls the
outer female fingers in and takes up the clearance. j-h-a's build notes rely on that ("They will flex slightly
and grip together when the thumb-screw is tightened", `jha_README.md.txt` l.69).

---

## 3. Thumbscrew and nut

- Thread length out of the handle: **18 mm** (ridercz `__gopro_screw_extension_length = 18`, G3) and
  **≈18.5 mm** (j-h-a README l.40; the code gives 50 − 35.6 + 3.6 = 18.0 [calc from l.16–32]). That covers a
  14.6–16.0 mm 3-finger stack plus the nut [calc].
- Bolt used inside printed handles: **M5×50** (ridercz README l.57 "Usually, M5x50 screws are ideal"; j-h-a
  README l.31). Other printed knobs use M5×20 (#59568) or M5×30–60 (#277814).
- Head and handle recess: Ø9.5 × 3.5 (ridercz l.14-15); 8.6 across the head flats (#897509); "Max. screw head
  diameter: 10–10.5 mm" for clearance (#65294 l.13). The j-h-a handle is Ø19.8 × 10.6.
- Nut. Square M5 "preferrably" (ridercz, pocket `d = 11.5, $fn = 4` = 8.13 mm side [calc]). Hex pockets:
  j-h-a 10 mm across corners = 8.66 across flats [calc]; MoonCactus 9.2 across corners = 7.97 across flats,
  depth 2, "keep it tight" [calc]; BeppeITA "hexagon: 9.5mm face2face" (larger, unexplained). #153569 uses an
  M5 acorn nut. #579629 makes the nut "a secure press fit".
- **I found no measurement of the genuine GoPro thumbscrew** (thread length, head, knob). See MISSING.

---

## 4. Quick-release buckle (the tongue that slides into the adhesive base)

All [M], from the tongue cross-section at mid-length. "Flange" = the side rails that go under the socket roof.

| Model | Flange width | Flange thickness | Body above flange | Ridge groove w × depth | Flange length | Overall incl. latch arms |
|---|---|---|---|---|---|---|
| #153569 (raw l.11-15) | 27.94 | 4.34 | 21.34 | 3.99 × 2.16 | 20.85 | 44.9 × 31.1 |
| #579629 (raw l.20-25) | 27.94 | 4.12 | 22.50 | 4.28 × 2.41 | 21.97 | 48.5 × 32.5 |
| #95616 V9 (raw l.33-36) | 27.82 | 4.07 | 22.0 | 4.30 × 2.60 | — | 46.0 × 32.6 |
| #934640 (raw l.40-43) | 27.82 | 4.05 | 21.8 | 4.10 × 2.50 | — | 46.3 × 32.6 |
| #1063720 (raw l.45-48) | 28.0 | 4.30 | 22.2 | 4.20 × 2.20 | — | 46.0 × 32.4 |

Spread: flange width 27.82–28.0, thickness 4.05–4.34, body 21.3–22.5, groove 4.0–4.3 × 2.2–2.6. These fit
the socket figures in §5 (28.0–28.6 between rails, 22.0–22.6 roof opening, 4.2–5.0 slot) only with very
small clearances. #1063720 at 28.0 in a 28.0 socket is zero clearance ("snug"). GoPro's patent describes the
latch qualitatively ("two prongs 180 a and 180 b that can be flexibly compressed inward when squeezed", with
securing arms 190a/b, G18) and gives no numbers.

---

## 5. Adhesive base (the socket the buckle slides into)

| Source | Width between rails | Roof opening | Overhang | Slot height | Roof thickness | Ridge w × h × length | Rail / roof length | Base thickness | Footprint × total height |
|---|---|---|---|---|---|---|---|---|---|
| **freeza36 caliper G17 [img]** | **1.106 in = 28.09** | **0.869 in = 22.07** | **0.1185 in = 3.01** | **0.165 in = 4.19** | 0.10 in = 2.54 | 0.155 in = 3.94 × 0.070/0.076 in = 1.78/1.93 × (1.343 in = 34.1?) | 1.003 in = 25.5? | 0.30 in = 7.62 | 1.506 in = 38.25 wide; 0.565 in = 14.35 high |
| j-h-a G1 | 28.6 | 22.6 [calc] | 3.0 | 4.9 | 2.4 [calc 7.3 − 4.9] | 3.5 × 2.0 × 34 | 25.6 | 3 | 37.5 × 49.5; 10.3 [calc] |
| #1642521 "ORIGINAL dimensions" [M raw l.59-68] | **30.0** | 22.0 | **4.0** | 5.0 | 2.0 | 3.0 × 1.5 × 34 | 24.95 / 20.5 | 5.0 | 40.0 × 50.0 × 12.0 |
| #1394238 [M raw l.69-75] | 28.0 | 22.0 | 3.0 | 5.0 | 2.0 | 3.0 × 1.5 × 34 | 25.0 / 21.0 | 5.0 | 40 × 50 × 12 |
| #1031776 curved [M raw l.76-82] | 28.0 | 22.0 | 3.0 | 5.0 | 2.0 | 3.0 wide | 24.2 / 20.5 | 2.3–3.0 (curved) | 40 × 50 × 11.4 |
| lucasgelfond (incomplete) | — | — | — | — | — | 4.5 × 1.75 × 34 | 25.75 | 3 | 36 × 46 |

Notes on the caliper sketch [img]:
- The author says he widened only outer, thin areas by 0.1 in and "did not change any of the internal
  distances" (G17 txt l.9). The internal numbers (28.09 / 22.07 / 3.01 / 4.19) are therefore his real-part
  readings.
- The outer numbers (0.2 in walls, 1.506 in width, 0.30 in base) may already include his +0.1 in
  modification. I do not treat them as the real footprint.
- Reading uncertainty: ridge height is ".070" on the graph-paper sketches and ".076" on the final one.
  "1.003" and "1.343" are drawn on a top view without a clear reference; 1.343 in = 34.1 mm matches the
  34 mm ridge length of j-h-a and #1642521.

**Spread and verdict.**
- Width between rails is 28.0–28.6 in four sources. #1642521, labelled "ORIGINAL dimensions", is the outlier
  at 30.0 with a 4.0 mm overhang.
- Roof opening 22.0–22.6 is consistent.
- Slot height is the weakest number: caliper 4.19 against 4.9–5.0 in the models. Buckle flanges are
  4.05–4.34 (§4), so 4.19 is barely possible for a real part and the models leave about 0.7 mm. A
  depth-gauge reading of an undercut slot is hard to take with a dial caliper, so I trust neither.
- **Curved base radius: no GoPro value exists in what I found.** #1031776 fitted its underside to the
  author's Smith Scout helmet: circle fit R = 133–135 mm (max residual 0.19 mm), but the sag of 2.23 mm over
  ±23 mm gives R ≈ 118 mm [calc]. Call it ≈120–135 mm, low confidence. #1264483 is cylindrical with R =
  56.9 mm (residual 0.065 mm) [M, raw l.83-86].
- Do not confuse these with j-h-a's `baseOuterCurveRadius = 58`. That is the radius of the base *outline in
  plan view*, not of the underside.
- **Adhesive pad thickness and type: no source.** GoPro's pages name neither 3M nor VHB (`04` §4, F1/F2). A
  search snippet claimed "3M VHB 4991", but I could not open the page that said so. **No claim.**
- One third-party data point: a Rollei adhesive mount is listed at "Height 12 mm Width 45 mm Depth 53 mm"
  (G19, Icecat). It is not GoPro, and the page doesn't say whether that is the part or the package.

---

## 6. Recommended print values: PETG, Prusa MK4 [A unless tagged]

The goal is a printed **male 2-prong on the cage** that fits **Adam's real GoPro buckle** and the
**printed 3-prong adapter**.

| Part | Value | Why |
|---|---|---|
| Male finger thickness | **3.0**, but print a coupon at 2.8 / 2.9 / 3.0 first | Real gap ≈3.10–3.18 [§2.1], so 3.0 leaves 0.1–0.2. BeppeITA prints 2.82 against his 3.12 (G5 STL). Too tight means it won't go in; too loose is fixed by the screw clamp. |
| Male slot | **3.5** | Real middle finger 3.0–3.3, so 0.2–0.5 clearance; same as ridercz and julietta |
| Female gap (printed adapter) | **3.4–3.5** | Takes the printed 3.0 male and real GoPro males (2.85–3.02) |
| Female middle finger | **3.0** | Fits real male slots of 3.12–3.3 and the printed 3.5 slot |
| Female outer fingers | 3.0 + nut boss on one side | non-critical; MoonCactus 2.75, ridercz 3.0 |
| Boss | **Ø15.0** | 11 of 12 values in §2 fall within 14.55–15.0 (the outlier is 16.0) |
| Hole | **Ø5.4–5.5** | j-h-a 5.3/5.4, MoonCactus 5.5, ridercz 5.0 + 0.5. Measured real holes are ≈5.0–5.1 but are moulded. |
| Hole axis to nearest base face | **≥ 9 mm** | Ø15 boss of the partner + 1.5 mm pivot clearance [calc] |
| Nut | M5 square pocket 8.2 × 3.0–3.5 deep (ridercz layout), or M5 hex 8.1–8.2 across flats | MoonCactus 7.97 (press) and j-h-a 8.66 bracket it [calc] |
| Screw | M5×50 in a printed knob, about 18 mm out; or a GoPro thumbscrew | §3 |

Printing notes [A, from the sources' own advice plus my practice]:
- Use **PETG, 100 % infill or ≥ 4 perimeters** in the fingers. MoonCactus: "Better use PETG instead of PLA
  for heat resistance" and "100% fill (probably safer...)"; #153569: "I'd recommend printing out of PETG at
  0.2mm quality".
- **Orientation decides which tolerance matters.**
  - Legs pointing up, hole axis horizontal (ridercz and BeppeITA layout): finger thickness comes from the XY
    perimeters, and no supports are needed.
  - Fingers lying flat, hole axis vertical (as `04` suggests): thickness comes from the layer count. Choose a
    layer height that divides it exactly (3.0 = 15 × 0.20 or 20 × 0.15). The gaps then need bridging or
    supports.
  - Either way, the coupon must use the same orientation and settings as the real part.
- After printing, measure the coupon's fingers with calipers and adjust **the CAD value, not slicer XY
  compensation**. This keeps the cage and adapter consistent.
- Breakaway (`ZALOZENIA` item 10, `04` §1): the single M5 pivot is the intended weak point. Don't add a
  second screw or glue the joint.

---

## 7. What to measure on the real parts (closes the gaps above)

1. On one real GoPro buckle, with calipers: middle finger, the two gaps (at the tip **and** at the root,
   since G5 says gaps narrow at the bottom), boss Ø, hole Ø, and hole axis to the buckle underside.
2. On a real adhesive base: width between rails, roof opening, slot height (use a 4.0 / 4.5 / 5.0 mm feeler
   or drill shank, not the caliper depth rod), ridge, footprint, total height and pad thickness. On the curved
   base, also the sag over the 50 mm length, so R = L²/(8·sag) [calc formula].
3. The GoPro thumbscrew: thread length and knob Ø.
4. Print the 2.8 / 2.9 / 3.0 male-finger coupon and record which one slides into the real buckle by hand.

---

## Retrieved (all in `papers/gopro_dims/`, quotes in `papers/extracts_gopro_dims.md`)

- GitHub OpenSCAD:
  - j-h-a/go-pro-mounts: all `.scad` + README (`jha_*`)
  - MoonCactus/gopro_customizable_mounts: `.scad` + README
  - mbugert/openscad-projects: julietta `GoPro_Mount.scad` + README
  - dnnsmnstrr/connector-foundry: gopro `_body`/`female`/`male` (derived from GoProScad)
  - LeonardChrist, justcoding-dev, lucasgelfond `.scad` (excluded or partial)
- Printables metadata (`printables_<id>.txt`) via the Printables GraphQL API, and model files:
  - #93976: STL ×2, `.f3d`, `gopro-size.txt`
  - #153569: STL
  - #579629: STL ×2, STEP, SLDPRT
  - #95616: STL ×2
  - #934640: STL
  - #1063720: STL, STP
  - #189423: STL ×2, 3MF ×2, `.f3d`
  - #65294: STL, STEP, OBJ, F3D
  - #1642521: 3MF
  - #1394238: STL, STEP
  - #1031776: STL
  - #1264483: STL
  - metadata only: #1239290, #511410, #897509, #448816, #59568, #139308, #99429, #30388 (+ STL), #277814
- Instructables freeza36 "3D Printed GoPro Mount": JSON + text + 6 sketch photos (`instructables_freeza36_sketches/`).
- GoPro patents US9423673B2 and US10642133B2 (Google Patents HTML + text).
- Brian Dorey `gopro-mounts.pdf` (handlebar clamp, not used).
- Multitronic page for the Rollei adhesive mount (Icecat dimensions).
- My tools and outputs: `_measure_tools/{mesh,run_all,render,curvefit}.py`, `measurements_raw.txt`.

## MISSING / could not retrieve

- **Any GoPro-published dimension or drawing** of the 3-prong/2-prong joint, buckle, flat or curved adhesive
  base, or thumbscrew. The GoPro patents checked (US9423673B2, US10642133B2) contain no dimensions. Design
  patents D829809, D880571 and D908780 (justia.com) were **not downloaded**. Being design patents, they
  would have drawings without dimensions.
- **Adhesive pad thickness and type.** A search snippet attributed "3M VHB 4991" to the GoPro set, but I
  could not open that page, so I make no claim. GoPro's own pages (`04`, F1/F2) name neither 3M nor VHB.
- **Curved adhesive base radius** for the genuine GoPro part. Only two community values exist, each fitted
  to one person's helmet.
- **Genuine GoPro thumbscrew** dimensions (thread length, knob).
- **Qidi3D blog "Printing Custom GoPro Mounts for Cyclists"** (qidi3d.com/blogs/print-lab/gopro-mounts-cyclists).
  Every attempt returned HTTP 429 or "local_rate_limited", so its numbers (seen only in search snippets:
  prong ≈3.0, gap 3.1–3.5, hole 5.0) are **not used**.
- **Cults3D #4873825** (snippet: "3.00 mm prong, 3.45 mm gap, 3.2 mm OEM nominal"). Cloudflare 403. Not used.
- **Thingiverse pages** (62800, 3088912) render only with JavaScript. I used their GitHub copies (MoonCactus
  repo; julietta via mbugert) instead.
- **Printables #320972** "Basic GoPro Mount - OpenSCAD": found in search, not downloaded.
- **Instructables freeza36 numbers** exist only as handwritten photos (inches). The outer dimensions may be
  post-modification, as noted in §5.
