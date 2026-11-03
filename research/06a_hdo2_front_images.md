# 06a — HDO2 fan and front geometry from photos and the manual

Track 06a of `arabskie_gogle`. ZALOZENIA.md governs; where this file disagrees with it, ZALOZENIA.md wins.
Status 2026-11-03: working draft. It rests on photo measurements only. Nobody has measured a real HDO2 yet (see §6).

Evidence tags: **[V]** = text read in a downloaded file. **[V-img]** = seen in a downloaded image. **[M]** = my
pixel measurement on a downloaded image (scale reference, pixel coordinates and uncertainty given).
**[V-comm]** = community source (Printables, forum). **[calc]** = arithmetic on the above. **[inf]** = my
inference, not stated by any source. All files are under `papers/hdo2_front_img/` unless another path is
given. Annotated copies of the three measured images are in `papers/hdo2_front_img/annotated/`.

## TL;DR

**0. The fan is NOT on the front face. It sits on TOP of the goggles.** It is on the top shell, on the
centreline, at the rear (face-side) edge of the top surface. It touches the black faceplate rim and sits
between the VOL and CH button panels. The front face carries only the logo, a parting line and two bay
doors. It has no fan, vent or opening. So "the mount in place of the fan" means a **top-mounted base**, and
the camera has to look forward over the front edge. Confidence **high** [V-img: manual p.5 top view
`manual/img-001.png`; Fat Shark front view `fatshark/fs_hdo2_media4_HDO2_e.jpeg`; Fat Shark 3/4 view
`fatshark/fs_hdo2_media0_HDO2_1024x1024.jpeg`; Oscar Liang close-up
`oscarliang/fatshark-hdo2-fpv-goggles-control-buttons-oled.jpg`]. The task text said "front fan". That
premise is wrong for HDO2.

| # | Quantity | Value | Confidence | Basis |
|---|---|---|---|---|
| 1a | Fan lateral position | on the centreline; cover centre within **±2 mm** of the midpoint between the lenses | high | [M] §2.1, §2.4 |
| 1b | Fan fore-aft position (plan) | cover centre **≈23 mm** behind the front-most point of the front face. Cover front edge ≈10 mm behind it. Cover rear edge touches the faceplate rim | medium (±2 mm) | [M] §2.1 |
| 1c | Fan height | cover base (the top deck the fan stands on) **≈23 ± 4 mm** above the optical axis. Cover top **≈36 ± 4 mm** above the axis and **≈15 mm** above the top edge of the front face *as projected in the front view*. The camera there looks down slightly, so the true difference is about 10–14 mm (06 check) | medium-low | [M] §2.2–2.4 |
| 2a | Fan size | **25 mm class** (25 × 25 mm frame). Cover footprint **25.0–25.2 mm** square in two third-party parts made to fit it; 25.6–26.5 mm from photos | medium-high | [V-comm] STLs, [M] |
| 2b | Screw pattern | **4 screws on a 20 × 20 mm square** (STLs: 20.0 mm; photo: 20.7 ± 0.8 mm). This is the pitch of a standard 25 × 25 mm fan (drawing: "20±0.3") | high (pattern), medium (that the screws go through the fan) | [V-comm], [M], [V] fan datasheet |
| 2c | Screws | 4 small cross-head screws. Head plus recess ≈ **3 mm** across in the photo. The third-party parts use Ø2.0 mm and Ø1.5–1.6 mm holes. Thread **unknown**: measure it | low | [M], [V-comm] |
| 2d | Protrusion | cover stands **≈10–13 mm** above the deck. A raised slotted tab at the cover's rear adds a few mm more | low | [M] §2.2, §2.5 |
| 2e | Grille | **Yes. The black cover IS the grille.** 5 slots face forward, angled ribs run along both sides, the top is closed with a ramped "T" ridge | high | [V-img] |
| 2f | What is under the fan | **Not found.** A third-party replacement plate has a **Ø24.0 mm** through-hole, and a forum calls it "the fan on the faceplate". Air path probably goes to the eye box, not the sealed display chamber. This is an inference | low | [V-comm], [inf] |
| 3a | Front face in plan | almost flat over the central **±35 mm** (set back ≤0.8 mm; arc fit R ≈ 400–560 mm). Wraps sharply beyond ±45 mm (set back 4 mm at ±47 mm, 14 mm at ±64 mm) | medium | [M] §3.1 |
| 3b | Front face height | **≈47 ± 2 mm** (spec 45.5 mm). Horizontal parting line ≈21 mm below the top edge | medium | [M] §3.2 |
| 3c | Front features a mount must avoid | 2 bay doors at the ends (≈18–24 mm wide each). A round antenna-port cover (Ø≈7 mm) on the wearer's left door. Nose notch ≈37 mm wide × 8 mm deep. **No buttons on the front.** | medium | [V-img] [M] §3.2 |
| 3d | Top deck around the fan | free width **≈±18 mm** from the fan centre to the black button panels. VOL/CH buttons start at **≈±21–22 mm**. Two 5-way joysticks stick up further out | medium | [M] §3.3 |
| 4a | Lens centre spacing (as photographed) | **58.9 mm** (58.6 mm in a second copy). Fits the IPD range | medium | [M] §2.3 |
| 4b | **Optical axis vs the fan** | axis is **≈36 ± 4 mm below the cover top** and **≈23 ± 4 mm below the deck** under the fan. That puts the axis at about the front-face parting line and ≈18 mm above the nose-notch apex | medium-low | [M] §2.3–2.4 |
| 4c | Thermal-camera axis if mounted on the fan footprint | ≈23 (deck) + 3 (plate) + ~10 (half of a 19.5 mm camera) ≈ **36 ± 5 mm above the eye axis**, ≈23 mm behind the front face | estimate | [calc] on 4b and track 03 (I1 in `papers/extracts_hdo2.md`) |

**Precedent already exists [V-comm, V-img].** Printables #1073216 replaces the stock fan cover with a printed
plate on the same 4 screws, with a GoPro-style 3-finger hinge pointing forward. #262727 clamps a frame under
the stock cover with a forward tab. The photos of #215826 show a hinged bracket hanging forward from the fan
area over the top of the front face. All three use the fan footprint as the accessory anchor.

---

## 1. Calibration, and what the spec dimensions mean

- Manual: "Dimensions: 169.2 x 80 x 45.5 mm" [V: `papers/FatShark_HDO2_Manual_RevC.txt` l.411, PDF p.11 (corrected by the 06 check; the page header reads "Fat Shark 11")]. The
  axes are **not labelled**.
- My readings, checked on the photos:
  - **169.2 = width.** It is the only number that fits the long axis.
  - **80 = front-to-back depth including the foam.** Top view, calibrated on width: foam rear y = 395 px to
    front edge y = 1099 px is 704 px × 0.1168 = **82 mm** [M].
  - **45.5 ≈ height of the front face.** Front view, calibrated on width: y 340 → 680 is 340 px × 0.139 =
    **47 mm** [M].
  - Each agrees within ~3–4 %. I use the width as the primary scale everywhere. That the axes are
    width × depth × height is my inference [inf].
- **Uncertainty model:** the product photos have perspective, and parts at different depths have slightly
  different scales. Comparing two independent references in one image gives the error:
  - The 20 mm STL screw pitch measures 20.7 mm on the width scale: 3.5 %.
  - Height 47 mm vs 45.5 mm: 3.3 %.
  - So I quote **±4 %** on lengths within one image, plus edge-picking error (±3–5 px, about ±0.5 mm).
  - Values that combine two images (front plus back) get **±4 mm**.

| Image | File | Size | Scale reference | Scale |
|---|---|---|---|---|
| Top view (manual p.5; the same photo is on fatshark.com as "HDO2 b.jpeg") | `manual/img-001.png`, `fatshark/fs_hdo2_media2_HDO2_b.jpeg` | 2163 × 1451 | shell width x 391…1840 = 1449 px = 169.2 mm (widest rows y 550–650) | 0.1168 mm/px |
| Front view ("HDO2 e.jpeg", fatshark.com) | `fatshark/fs_hdo2_media4_HDO2_e.jpeg` | 2001 × 1175 | body width x 390…1607 = 1217 px = 169.2 mm | 0.1390 mm/px |
| Back view (manual p.5) | `manual/img-008.png` | 2166 × 1593 | white strap lugs x 271…1922 = 1651 px = 169.2 mm | 0.1025 mm/px |
| Back view, second copy ("HDO2 d.jpeg") | `fatshark/fs_hdo2_media5_HDO2_d.jpeg` | 1080 × 637 | x 135…958 ≈ 820 px = 169.2 mm | 0.2063 mm/px |

Silhouettes were found with a threshold (<250 on 8-bit grey, background = 255) in python/PIL. Edges inside
the object were picked on 2–12× zoomed, gridded crops.

## 2. The fan

### 2.1 Location in plan (top view `manual/img-001.png`)
The black square cover sits on the top deck. Its rear edge touches the black faceplate rim. On each side
the VOL and CH button panels flank it [V-img; labels "Volume Level", "Channel Selection" on manual p.5,
`manual/page-05.png`].

| Feature | Pixel coords (x, y) | mm (0.1168 mm/px) |
|---|---|---|
| Cover outline | x 990…1219, y 786…1012 | 26.7 × 26.4 |
| Cover centre | (1104.5, 899) | — |
| Shell centreline | x = (391+1840)/2 = 1115.5 | cover centre 11 px = **1.3 mm** off-centre (within error) |
| Screw heads (centres) | (1015, 809), (1192, 809), (1015, 986), (1192, 986) | pitch 177 px = **20.7 mm** both ways |
| Front edge of the shell at the centre | y ≈ 1096–1099 | — |
| Cover front edge → front edge | 1012 → 1097: 85 px | **9.9 mm** |
| Cover centre → front edge | 899 → 1097: 198 px | **23.1 mm** |

Rescaling with the 20.0 mm STL pitch as a local ruler (0.1127 mm/px): cover **25.6 mm**, centre-to-front
22.3 mm. Best estimate: cover footprint **25–26.5 mm square**, centre **22–23 mm** behind the front face.

### 2.2 Size, cover, protrusion
- **Two community parts are built to fit the cover footprint** [V-comm; STLs in `papers/printables_stl/`; my
  slices of the STL]:
  - `1073216_…hdo2.stl`: base plate at z = 0, y from −12.6 to +12.6 mm (**25.2 mm** wide). The 4 holes are
    at x = 1/21, y = ±10, i.e. **20 × 20 mm**. One edge is 12.5 mm from the pattern centre, so the
    footprint is 25 mm. A **Ø24.0 mm** hole sits in the middle. Plate 1.3 mm thick, features up to 5 mm,
    hinge to 7 mm.
  - `262727_fan.stl`: frame 29 × 28 mm, opening 25.2 mm, walls 6 mm, holes Ø2.0 on 20 × 20 (H7 in
    `papers/extracts_hdo2.md`).
- **Fan size [inf, medium-high]:** a 25 × 25 mm axial fan has its holes on **20 ± 0.3 mm**. The SameSky
  CFM-25CF drawing gives "25±0.3", "20±0.3", "7±0.3"
  [V: `fan_ref/SameSky_CFM-25CF_datasheet.pdf` p.4, render `fan_ref/SameSky_CFM-25CF_p4-4.png`]. The HDO2
  pattern (20 × 20), footprint (≈25 mm) and opening (Ø24 in #1073216) all match a 25 mm fan.
- **Not established:** that the 4 cover screws pass through the fan's own holes (they might go into shell
  bosses), and the fan's thickness (25 mm fans come in several).
- **Cover height above the deck [M, low confidence]:**
  - Front view: cover top y = 232, cover base front edge y ≈ 325. That is 93 px × 0.139 = **12.9 mm**.
    *06 check:* this is a projected height. The front view looks down slightly: the cover's top/grille surface
    shows as a 43 px band (y 233–276), and the deck in front of the cover shows as a 15 px band (y 325–340).
    The vertical black skirt is y 276–325 = 49 px = **6.8 mm**. The total depends on the view elevation, which
    is unknown: about 7 mm if the top is flat and the view is ~13° from above, and 11–13 mm if the band is a
    sloped front grille face and the view is nearly level. The side view and the back view (cover top 36 mm
    above the lenses) favour the second reading, so 10–13 mm stands at low confidence. See
    `annotated/front_view_cover_profile_06recheck.png`.
  - Manual side view `manual/img-099.png` (3/4 view, ~150 px across the goggle, so coarse): cover depth
    ≈120 px, height ≈65 px, ratio 0.54 → ~13 mm if the depth is 25 mm. Foreshortening makes this an upper
    bound.
  - Range quoted: **10–13 mm**. The rear tab rises ≈22 px more in the same view (≈4–5 mm at that ratio).
- **Grille [V-img]:** the cover is the grille. It has 5 forward-facing slots (front view x 893…1070, y
  232…325) and angled ribs down both sides (top view). The top is closed, with a recessed ramp shaped like a
  "T" and a raised, slotted tab at the rear (`oscarliang/…control-buttons-oled.jpg`;
  `printables/262727_20220810_074234.jpg`; `manual/img-099.png`). The tab's purpose is not documented.
- **Screws [M + V-comm, low]:** 4 cross-head screws.
  - Head plus its dark recess: 26 px across at (1002…1028, y 809) → **≈3.0 mm** (0.1168) / 2.9 mm (local
    scale).
  - Hole sizes in the community parts: Ø2.0 mm (262727) and Ø1.5–1.6 mm (1073216).
  - So the thread is about 1.6–2 mm (machine or self-tapping). Clearly not M2.5 or M3. **Unscrew one and
    measure it (Q-F1).**
  - *06 check:* the generic 25 × 25 × 7 mm fan drawing used above specifies frame holes "3−ø3.0±0.2" and an
    "M2.5" machine screw [V: `fan_ref/SameSky_CFM-25CF_p4-4.png`]. If the HDO2 fan is a generic 25 mm frame, a
    ≤Ø2 cover screw passes loosely through its Ø3 holes. Alternatively, the fan sits over Ø3 posts on the shell,
    like the "posts … on the faceplate fan mount" of Printables #570569 (06b §3.1). This is an inference;
    Q-F2 settles it.

### 2.3 Optical centres (back views)
`manual/img-008.png`, 0.1025 mm/px:

| Feature | Pixel coords | mm |
|---|---|---|
| Left lens centre (lens circle x 750…940, y 825…1015) | (845, 920) | — |
| Right lens centre (x 1325…1515) | (1420, 920) | — |
| Lens spacing | 575 px | **58.9 mm** |
| Midpoint between the lenses | x = 1132.5 | — |
| Fan cover seen from behind (x 1002…1225, top y ≈ 562) | centre x = 1113.5 | **1.9 mm** from the lens midpoint |
| Cover top → lens centre | 920 − 562 = 358 px | **36.7 mm** |

Second copy, `fatshark/fs_hdo2_media5_HDO2_d.jpeg` (0.2063 mm/px):
- Lenses (420, 292) and (704, 292): 284 px = **58.6 mm** apart.
- Cover top y ≈ 124: 168 px = **34.7 mm** above the lens centres.
- Cover centre x 555 vs lens midpoint 562: 1.4 mm off.

These two images are probably the same shoot, so they are not fully independent. The mean is **35.7 mm**.
Error: ±2 mm between the copies, plus camera elevation, which I cannot recover. Quoted as **±4 mm**.

The 58.6–58.9 mm spacing sits inside the reviewer-measured IPD range of about 59–69 mm
[V: `papers/ctrl_hdo2_oscarliang.txt` l.87: "I found the minimum IPD to be around 59mm"]. That supports the
back-view scale. It also means the lenses were near minimum IPD in this photo. The **lens centres move
laterally with IPD**, and the fan does not.

### 2.4 Optical axis in the front view (combining the two views)
The cover top in the front view is y = 232, at 0.139 mm/px (or 0.1338 mm/px if calibrated on height):
- Optical axis: 232 + 35.7/0.139 = **y ≈ 489**, or y ≈ 499 on the height scale. The front-face parting line
  is at y ≈ 488. **The axis sits at the parting line, ±4 mm** [M/calc].
- Cover base (deck) y ≈ 325 → **≈23 mm** above the axis (22.8 / 23.6).
- Front-face top edge y ≈ 340 → **≈21 mm** above the axis.
- Nose-notch apex y ≈ 623 → **≈18 mm** below the axis.

The fan-cover centre and the nose-notch apex line up at x = 979 and x = 975. That symmetry axis is ≈20 px
left of the silhouette centre (x 998.5). The silhouette is skewed by the different bay doors and the
perspective. Laterally I trust the feature axis.

### 2.5 What is under the fan: not established
- "the original HDO2 VIN Board powers/controls the fan on the faceplate … the older FSV3407 VIN Board …
  doesn't have socket for the fan plug" [V-comm: `forums/intofpv_thread_25283.txt` l.36]. So the fan has a
  **plug** on the VIN board and is described as **on the faceplate**.
- "Faceplate is smaller, and the fan is now powered directly from the barrel connector … the maximum speed
  is proportional to the battery voltage" [V: `papers/ctrl_hdo2_oscarliang.txt` l.103]. The manual says the
  same about speed (A4).
- The #1073216 plate made to replace the cover keeps a **Ø24.0 mm** through-hole.
- **Inference [inf]:** the fan sits in an opening of roughly Ø24 mm that leads to the space between the face
  and the lenses (the eye box), not into the sealed display/optics chamber. I could **not** retrieve a
  teardown that shows this (§MISSING).
- **Consequence for the mount plate [inf]:** close the opening. Do not copy the Ø24 hole. An open hole in
  the top of the eye box admits light and dust. Unplug the fan at the VIN board, or just leave it
  disconnected under the plate.

## 3. Front face and top deck

### 3.1 Front-face curvature in plan
Top view, lowest object pixel per column = front edge, centre x = 1115.5 [M]:

| Lateral offset from centre (mm) | 0 | ±11.7 | ±23.4 | ±29.2 | ±35.0 | ±40.9 | ±46.7 | ±52.5 | ±58.4 | ±64.2 | ±70.1 | ±75.9 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Setback from the front-most point (mm) | 0.0–0.4 | 0.2–0.6 | 0.1–0.7 | 0.0–0.8 | 0.5–1.2 | 1.5–2.2 | 3.3–4.0 | 5.7–6.3 | 8.9–9.7 | 13–14 | 19–20 | 27–28 |

- Circle fits: R ≈ **400 mm** for |x| ≤ 23 mm (rms 0.2 mm) and R ≈ **560 mm** for |x| ≤ 41 mm (rms 0.3 mm).
  So the front is nearly flat across about 70 mm and wraps around the corners.
- Caveat: this is the outline seen from above. Where the upper and lower halves of the front bulge
  differently, the bulge that sticks out further sets it.
- Vertically, the front face has a rounded top edge: a highlight band at y 345–375 in the front view. No
  number is given.

### 3.2 Front face, front view `fatshark/fs_hdo2_media4_HDO2_e.jpeg`
Scale 0.139 mm/px. "Wearer's left" = image right, checked against the manual side views (p.6: Antenna Port
and VRx Modular Bay on one side, Power Port, AV and Expansion Bay on the other) and the top view (CH and
Display on image right).

| Feature | Pixels | mm |
|---|---|---|
| Front-face top edge | y ≈ 338–341 (column transitions at x = 600…1400) | — |
| White body lower edge (centre-side columns) | y ≈ 679–685 | face height ≈ **47 mm** (±2) |
| Horizontal parting line | y ≈ 487–490, x ≈ 528…1430 | 20.6 mm below the top edge, ≈ optical-axis height |
| "FAT SHARK" logo | x 785…1158, y 410…478 | 52 × 9.5 mm (cosmetic, can be covered) |
| Wearer's right end door (Expansion Bay; power port and AV jack are on the side) | x 395…528, y 365…622 | 18.5 × 35.7 mm |
| Wearer's left end door (VRx Modular Bay) | x 1430…1605, y 365…622 | 24 × 35.7 mm |
| Round antenna-port cover on that door | centre (1472, 440), Ø ≈ 50 px | **Ø ≈ 7 mm**, ≈10 mm below the top edge |
| Nose notch | apex (975, 623); edges at y = 680: x ≈ 843 / 1110 | **≈37 mm wide × 8 mm deep** |
| Clear flat panel between the doors, above the notch | x 528…1430, y 340…623 | **≈125 × 39 mm** |
| Joystick knobs seen above the top edge | x ≈ 690 and 1275, y ≈ 322–340 | stand ≈2.5 mm proud, ≈40 mm either side of centre |

No button, port or vent is on the front face [V-img]. The ports are on the side faces (manual p.6). The
controls are on the top and the underside (manual p.5).

### 3.3 Top deck around the fan (`manual/img-001.png`, 0.1168 mm/px)

| Feature | Pixels | mm from the fan-cover centre (x 1104.5) |
|---|---|---|
| Inner edge of the VOL panel (wearer's right) | x ≈ 949 | **18.2** |
| Inner edge of the CH panel (wearer's left) | x ≈ 1269 | **19.2** |
| VOL ▲ / ▼ button centres | (888, 862), (888, 960); Ø ≈ 60 px = 7 mm | 25.2 → inner edge ≈ **21.7** |
| CH ▲ / ▼ button centres | (1329, 869), (1326, 965); Ø ≈ 7 mm | 26.1 → inner edge ≈ **22.6** |
| DVR 5-way, HT (wearer's right); Display 5-way (wearer's left) | further out (manual p.5) | > 40 |

A base wider than about **36 mm** (±18 mm) starts to cover the button panels. Wider than about **43 mm**, it
covers the VOL/CH buttons. A mount can overhang above them if it leaves finger room [calc].

## 4. Consequences for the camera mount (for the design track; not a design)

1. The fan footprint is a **top** anchor: 4 screws on 20 × 20 mm, ≈25 mm square, centred, about 23 mm
   behind the front face. A camera on it looks over the front edge. With a ~36 mm camera-to-eye vertical
   offset (TL;DR 4c), check the vertical parallax against track 01 (`research/01_camera_placement_parallax_latency.md`).
2. To bring the camera down toward eye height, the bracket has to reach **forward and down over the front
   face**. That is what the #215826 photos show (`printables/215826_large_display_20220521_190438_215826.jpg`).
   The front panel offers ≈125 × 39 mm of almost flat surface (R ≥ 400 mm in plan) to rest a pad on, with no
   controls to block. The parting line runs at about optical-axis height.
3. Keep the base within ±18 mm laterally to leave the VOL/CH buttons and both joysticks usable.
4. The mount plate should seal the fan opening, and the fan plug should be disconnected [inf, §2.5].

## 5. Questions for Adam to answer on the real goggles (they replace the low-confidence rows)
- **Q-F1** Unscrew one fan-cover screw: thread (M1.6? M2? self-tapping?), length, head Ø.
- **Q-F2** Lift the cover: fan frame size and thickness, connector type, and whether the screws pass through
  the fan.
- **Q-F3** With the fan out: size and shape of the opening, and where it leads (eye box, or the inside of the
  shell).
- **Q-F4** Height of the deck under the fan above the lens centres. Calliper from the deck to the lens
  centre, with the goggle face-down. Replaces the ±4 mm value.
- **Q-F5** Cover height above the deck and height of the rear tab.

## Retrieved (all in `papers/hdo2_front_img/`)
- `manual/`: images extracted from `papers/FatShark_HDO2_Manual_RevC.pdf` (img-001 top view, img-007 bottom,
  img-008 back, img-099 side views, img-101 bay interior) and page renders page-01…06 (150 dpi).
- `fatshark/`: `fs_hdo2.html` (https://www.fatshark.com/product-page/hdo2, Wix page, 2026-11-03) and the 6
  full-resolution gallery images `fs_hdo2_media0…5` (titles in `media_list.txt`; "HDO2 e" = front view,
  "b" = top, "c" = bottom, "d" = back). Also `fs_black_fan_faceplate.html` (Attitude V3 faceplate, context only).
- `oscarliang/`: 10 full-size photos from https://oscarliang.com/fatshark-hdo2-fpv-goggles/ (the page text was
  already in `papers/ctrl_hdo2_oscarliang.txt`).
- `printables/`: photo galleries and API JSON for #262727, #1073216 and #215826 (via api.printables.com).
- `forums/`: IntoFPV printable threads 25283 (HDO2 VIN board and fan plug, used), 9760 (HDO2, manual quote
  only), 11158 and 25541 (HDO v1 / HD3, **not HDO2**, not used for claims), 17022 (DJI, not used), 22535 (HD3,
  not used).
- `fan_ref/`: SameSky CFM-25CF datasheet (25 × 25 mm fan drawing) and its product page.
- `annotated/`: my measurement overlays (top, front, back).

## MISSING (searched for and not obtained; no claims rest on them)
- **GetFPV HDO2 disassembly / dust-removal guide** (Lawrence Ro), https://www.getfpv.com/learn/fpv-diy-repairs-and-mods/fatshark-dust-removal/
  (WP post 6492). This is the most likely source for what lies under the fan and for the faceplate/shell
  split. Cloudflare returns 403 to curl and WebFetch. web.archive.org blocks both. **Adam: please open it in
  a browser and save the page with images into `papers/hdo2_front_img/`.**
- GetFPV HDO2 review (https://www.getfpv.com/learn/fpv-product-reviews-and-comparisons/fat-shark-hdo2-fpv-goggles/): same block.
- The RC Groups post by "Greg" on the HDO2 fan plug (linked from IntoFPV 25283): not followed.
- Any HDO2 teardown video (YouTube) or reddit/rcgroups post showing the fan removed: none found by search.
- Retailer galleries (getfpv, team-blacksheep, racedayquads, nextfpv, fpv24 images): not downloaded. The Fat
  Shark gallery covered the same views at higher resolution.
- Fat Shark CAD/drawing of the HDO2 shell: none found (same as track 04).
- No source found for: the fan model, its thickness or airflow direction, the screw thread, the size of the
  opening under the fan, or whether the fan belongs to the removable faceplate or the main shell.
