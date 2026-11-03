# 07b — Where the control pod can go on the HDO2 (WORKING DRAFT)

Track 07b of `arabskie_gogle`. **ZALOZENIA.md governs; where this file disagrees with `research/06` (the HDO2
geometry table) or with a source in `papers/`, those govern.** Verbatim quotes for every [V] / [V-comm] tag are
in `papers/extracts_pod_placement.md` (IDs P, S, F, E, O, X). Status 2026-11-03: **working draft.** Nothing here
has been measured on Adam's goggles; it rests on product photos, the manual, one receiver-module manual, one
forum measurement and the v0.3 camera-mount CAD. §6 lists what Adam must measure before the pod is drawn.
**An adversarial verification pass on 2026-11-03 corrected several numbers in place; see "Verification" at the
end.** The largest correction is the side-view scale, which was 11 % too small.

Tags: **[V]** read at source (manufacturer); **[V-comm]** community source read at source; **[img]** my pixel
measurement (image, pixel coordinates and scale given); **[cad]** measured in OpenSCAD on `cad/camera_mount.scad`
v0.3; **[calc]**; **[A]** assumption; **[design]** my recommendation, not a sourced claim.

Sides are named from the **wearer's** point of view. In the CAD, +y = wearer's left.

## TL;DR

1. **Recommended location: the wearer's-left VRx Modular Bay (candidate b).** With the receiver module removed,
   the pod becomes a printed **"module casing" that replaces the bay door**. Electronics sit inside the empty
   bay; the encoder and the two tactiles sit on the outer face, at the temple.
   - **Precedent:** a commercial receiver module with a **5-way button on its outer face** is documented as fitting
     the HDO2 in exactly this way. The SpeedyBee module is "51x34x17.8 (mm)" with a "Compatible Casing with
     FatShark Dominator Series Goggles", and its manual's install example is the HDO2 [V: S1–S4]. (It proves the
     envelope and the retention; it says nothing about blind, gloved use of that button. See Verification V9.)
   - **No new holes and no adhesive.** The bay's own socket and the door seat hold the pod.
2. **Envelope for the recommended pod [design on V/V-comm/img]:**
   - **51 mm** fore-aft along the side × **34 mm** high on the shell;
   - **≤11 mm** inside the bay (bay ≈44 × 32 mm, "deepest part is 13mm", measured on an HDO v1 [V-comm: F1]);
   - **≤12 mm** of body standing proud of the side surface, plus a knob of **≤12 mm**.
   - Total lateral depth ≤ **~35 mm** from the bay floor (§4).
3. **FOV: no candidate enters the camera fields of view.** OpenSCAD intersections of the thermal (50 × 37.2°)
   and Infra worst-case (96 × 72°) pyramids at tilt 0/10/20° gave **zero volume for all 8 candidate boxes**.
   That held in 288 runs, including a conservative apex at the camera body front [cad, §3]. **But this result is
   geometrically guaranteed, not a stress test:** every candidate box lies behind the nearest FOV apex (x ≤ 58.1
   vs apex x ≥ 58.07), and no FOV ray points backwards, because the half-angle plus tilt stays < 90° (Verification
   V5). The method was checked with a positive control. A front-face pod beside the cage first enters the Infra FOV
   at **≈54 mm proud of the front face** (tilt 20°; re-bisected, V5). It is clean at 52 mm; keep it ≤45 mm.
4. **The real discriminator is the camera knock, not the FOV.**
   - Yaw between the cameras and the goggles is set only by friction of the 4 fan screws in Ø2.3 clearance holes.
   - The play available there is **±0.6° (Ø2.0 screw) to ±1.6° (Ø1.5 screw)** from centred screws, i.e. up to
     1.2–3.2° end to end [calc]. That exceeds the **0.5°** budget in ZALOZENIA 1c.2.
   - So **anything the gloved hand presses must be far from the cage and the hinge.**
   - The top deck is 0–6 mm from the hinge, and the front face beside the cage is 3–15 mm from it. The left bay
     door's front edge is ≈47 mm lateral from the cage side (and ≈11 mm behind the front face); its flat side
     part is ≈72 mm lateral from it, on a different face (V4).
5. **Rejected or kept as fallbacks** (dimensions as corrected in Verification):
   - **Top deck (d): rejected.** It leaves a 5.7–6.4 mm gap beside the adapter and an 11–12.7 mm strip in front of
     the button panels, and it sits next to the hinge.
   - **Strap (e): rejected.** The strap is elastic, so the pod moves when pressed.
   - **Front face beside the cage (a): fallback only.** It is flat over just 17 mm (lateral 28–45 mm), the hand
     works right beside the cage, and the leads are long.
   - **Right side above the ports (c-R): second choice.** Its leads to the power and AV ports are the shortest
     (<50 mm), but the area is cut by the ports, and the Expansion Bay door has to stay removable.
   - **Helmet side: fallback** if Adam drops the "buttons on the goggles" decision.
6. **The decisive measurements are:**
   - (P1) the VRx bay with the door off: opening, depth, latch features;
   - (P2) the bay socket pinout, metered;
   - (P5) clearance between the goggle side and the helmet rim when worn;
   - (P8) the fan-screw diameter.

## 0. Inputs and frame

- **CAD frame** (`cad/camera_mount.scad` v0.3):
  - origin = fan-screw pattern centre on the top deck; x forward, y = wearer's left, z up;
  - front face at x = 23.1 mm (`front_x`); eye axis at z = −23 (`seat_above_eye`, range 19–29, research/06 C3).
- **Camera position from the ECHO / transform** [cad]:

  | tilt | thermal lens tip (x, z) | camera body front (x, z) | cage rear-bottom (x, z) |
  |---|---|---|---|
  | 0° | 70.8, −10.6 | 63.5, −10.6 | 47.1, −22.6 |
  | 20° | 64.9, −22.7 | 58.1, −20.2 | 38.6, −25.8 |

  - Hinge axis at x 33.6, z 0.
  - The cage is ±12.95 mm wide. The adapter's nut boss reaches y = +12.8. The M5 head (ISO 4762, on the −y =
    wearer's-right side) reaches about y = −13.8 (7.8 finger + 1 washer + 5 head [A, standard sizes not retrieved]).
  - So **the camera body front stands 35–40 mm ahead of the front face**, and the cage starts 15–24 mm ahead of it.
- **HDO2 geometry (research/06, re-used with its tags):**
  - front panel ≈125 × 39 mm between the bay doors; setback ≤0.7 mm within ±35 mm, 2.9–3.6 mm at ±46.7 mm,
    12.6–13.4 mm at ±64 mm (06 B2, which governs over 06a's slightly larger figures);
  - nose notch ≈37 × 8 mm;
  - front portions of the bay doors: 18.5 mm (right) and 24 mm (left) wide, 35.7 mm tall; antenna-port cover
    Ø≈7 mm on the left door (06 B5). **Discrepancy flagged for 06:** in the same front view the cover is 69 px
    ≈ **9.6 mm tall**. Only its width (53 px ≈ 7.4 mm) gives "≈7", and the width is foreshortened by the corner
    (V2);
  - because the doors differ in width, the panel between them is off-centre. Measured from the silhouette centre,
    the door edges lie at lateral **≈65–66 mm (right)** and **≈60–61 mm (left)**, not ±62.7 (V3);
  - deck free ±18 mm; VOL/CH buttons from ±21.7/22.6 mm; DVR/Display joysticks at ≈±40 mm (B1–B6, A5).
- **Controls I must not cover** [V: P1, P4]:
  - **Display 5-way** (top, wearer's left, ≈40 mm out). Needed for the image menu: "contrast, brightness,
    sharpness, saturation, and power".
  - **Power/Fan button and Receiver on/off** (underside).
  - Ports [V: P2, P6]: "Power Port (7-13V)", "AV Input/Output" and "Expansion Bay" on one side; "Antenna Port"
    and "VRx Modular Bay" on the other.

## 1. New geometry measured for this track

### 1.1 Corner and side wall in plan (top view `hdo2_front_img/manual/img-001.png`, 0.1168 mm/px, as in 06a)
Method: the silhouette half-width per row, with a threshold <250 [img].

| Behind the front (mm) | 77–52 | 48.7 | 41.7 | 34.7 | 27.7 | 20.7 | 13.7 | 6.7 | 3.2 |
|---|---|---|---|---|---|---|---|---|---|
| Half-width (mm), R / L | 84.3–84.6 | 84.2/84.3 | 82.5/82.8 | 79.8/80.2 | 76.2/76.7 | 71.2/72.0 | 64.3/65.3 | 53.8/54.8 | 45.0/47.1 |

- **The side wall is straight (within 0.4 mm) from ≈52 to 77 mm behind the front face, a run of about 25 mm.**
- **The front corner is close to a vertical cylinder.** A circle fit gives **R ≈ 58 mm**, centred 27 mm from the
  centreline and 58 mm behind the front face, with residuals ≤0.13 mm [img + calc].
- The arc runs from lateral 45 mm to the side wall: **≈72 mm of curved surface** per side [calc].

### 1.2 Side wall in elevation (front view `fatshark/fs_hdo2_media4_HDO2_e.jpeg`, 0.139 mm/px)
- The outermost silhouette is vertical within 0.3 mm (width 168.9–169.2 mm) from **7 to 32 mm below the
  front-face top edge**, so **≈25 mm of straight height** [img]. It narrows to 168.2 mm at 34 mm and 164.9 mm
  at 38 mm.
- The top shoulder rounds off over ≈7 mm and the bottom over ≈13 mm. The bottom rounding is larger because the
  body narrows to 132 mm at the base.

### 1.3 Bay doors and ports (side views `manual/img-099.png`, 1335 × 490)
- **Scale (corrected in verification, V1):** the door outline is tilted ≈4–6° in these views. "205 px" was the
  bounding-box height (top-front corner to bottom-rear corner), not the door height. Measured perpendicular to
  the door's top and bottom edges, the door is **≈180–185 px** tall. Taking it as 35.7 mm gives
  **≈0.196 mm/px** (0.193–0.200), not 0.174. An independent check agrees: the antenna-port cover is 49 px tall
  here and 69 px × 0.139 = 9.6 mm tall in the front view, which gives 0.196 mm/px. These are 3/4 views, so
  fore-aft lengths are projected: **±8 mm** [img].

| Feature | Pixels (orig.) | mm (at 0.196 mm/px) |
|---|---|---|
| Wearer's-right door (Expansion Bay) | edges x ≈302 (rear) – 568 (front); bbox y 232–437 | ≈52 projected × 35.7 |
| Power port (square) | x 253–307, y 355–415 | ≈11 × 12; just behind the door's rear edge, lower half |
| AV jack (round boss Ø≈10.4, 53 px) | centre (351, 400) | inside the door outline at its lower **rear** corner; centre ≈9.6 mm ahead of the door's rear edge |
| Free band on the right door above the AV boss | door top ≈ y 256 → boss top ≈ y 373 (at x 351) | **≈23 mm tall** along the door; full 35.7 mm only ahead of x ≈ 380 (≈37 mm long) |
| Wearer's-left door (VRx Modular Bay) | edges x ≈803 (front) – 1076 (rear); bbox y 227–432 | ≈53.5 projected × 35.7 |
| Antenna-port cover | x 810–848, y 262–311 | ≈9.6 tall (front view); at the **front** end of the door, upper half |
| Left door rear edge → strap lug | x 1076 → 1168 | **≈18 mm** of plain shell |

- **Door arc length [calc on 1.1, corrected V3]:** in the front view the door edges lie at lateral ≈60.5 mm (left)
  and ≈65.5 mm (right) from the silhouette centre. On the R 58 corner that puts the left edge ≈11 mm behind the
  front face, with a **≈55 mm** arc from there to the side wall. The right edge is ≈15 mm behind the front face,
  with a ≈48 mm arc. Each door also runs some unknown distance along the straight wall, so the **left door is
  ≳55 mm long** and the right one ≳48 mm. The side-view projections (≈53.5 and ≈52 mm, ±8) agree within their
  error.
- That is consistent with the forum bay width ("approximately 44mm width x 32mm height" [V-comm: F1]) and with
  the 51 mm module casing [V: S1].
- **So each "end door" seen in the front view is the front part of one large door that wraps the corner and
  covers most of the side.** The right door also carries the AV jack opening at its rear-lower corner.

### 1.4 Top deck in front of the button panels (img-001)
- For lateral 20–50 mm on both sides, the white strip between the dark button panel and the front silhouette is
  **11.1–12.7 mm** deep in plan (re-measured in verification). That depth includes the rounded front edge [img].
- The gap between the adapter and the panel edges is **5.7 mm** on the wearer's right (plate −12.5 to VOL panel
  −18.2) and **6.4 mm** on the left (nut boss +12.8 to CH panel +19.2) [cad + img].

## 2. Candidate by candidate

Reach and knock assessments are [design] unless tagged. "Knock path" means what the hand can hit on the way in
and on the press.

### Parameter table

| | (a) front face, beside the cage (R or L) | (b) **VRx Modular Bay, wearer's left** | (c-R) side, Expansion Bay, wearer's right | (d) top deck beside the adapter | (e) strap / helmet |
|---|---|---|---|---|---|
| Free area | flat part: lateral 28–45 mm × ≈38 mm tall (z −6…−44) → **17 × 38**. With a contoured base out to the door edge: **≈37 × 38** (right, to ≈65.5) or **≈32 × 38** (left, to ≈60.5) | door ≳55 (arc) × 35.7 [calc on img]; module envelope **51 × 34** [V: S1]; bay ≈**44 × 32 × ≤13** deep [V-comm: F1, HDO v1] | above the AV boss: **≈52 × 23**. Ahead of the AV jack: **≈37 × 36** [img, corrected V1] | beside the adapter: **5.7–6.4 mm** wide. Strip in front of the panels: **11–12.7 × ~30** (curved) | strap: none rigid. Helmet: large, not measured |
| Curvature | plan: R≈400–560 across the central ±41 mm (≤0.7 mm setback to ±35), then the R 58 corner. Vertical: flat between rounded edges | corner R≈58 in plan, then straight; vertical straight ≈25 mm. The door is the shell, so **a door-replacement casing needs no fit to a curve** | straight side wall (25 mm) + corner R 58 | domed deck, rounded front edge | — |
| Nearest features | cage side: **15 mm** (at lateral 28) or **3 mm** (at 16); M5 head 14 mm; nose notch ≥9 mm below/inboard; door edge at ≈65.5 (R) / ≈60.5 (L); antenna cover (left) centred at lateral ≈65.5 (projected), its top ≈9 mm below the top edge | strap lug ≈18 mm behind the door; RX on/off switch, earphone jack and mini-HDMI on the underside on this side (manual p.5) [V: P1 + img]; Display 5-way on top (other surface); antenna cover is part of the door (gone with a printed casing) | AV jack and power port at the rear-lower door corner; the door must stay removable (Legacy/Button jumper behind it [V: P3]) | adapter 5.7–6.4 mm; CH or VOL buttons covered; Display/DVR joysticks at ±40 | — |
| Blind reach (gloved) | hand comes in front of the face, beside the camera; easy to find by sliding off the cage, which is exactly the problem | temple: slide the hand forward along the strap; it lands on the pod. Natural "touch the headset" gesture | same as (b), mirrored; ports and plugs are under the fingers | finger lands on the hinge or the buttons | helmet side: easy; strap: pod slides away |
| Camera-knock risk | **high near the cage, moderate at ≥28 mm**: a glove ≈20–25 mm wide [A] passing a 15 mm gap. Switch operating forces: B3S ≤1.57 / ≤2.26 N (max values); EC11 push 6 (+2.5/−2) N, so 4–8.5 N [V: O1, E1]. A gloved press usually overshoots these; the real load is set by the hand [A] | **negligible**: door front edge ≈47 mm lateral from the cage side, ≈11 mm behind the front face; the side part ≈72 mm away, on a different face | negligible, as (b) | **high**: hinge and adapter 0–6 mm away; the press loads the goggles onto the nose | none (decoupled) |
| FOV entry (OpenSCAD, §3) | none up to 52 mm proud of the front face; Infra hit from ≈54 mm (tilt 20°) | none (trivially: behind the cameras) | none (trivially) | none (trivially) | none |
| Leads to power/AV | ≈85–100 mm around the corner (right) [calc] | ≈250 mm across the front, **or** split the trunk (§4.4) | **<50 mm** | ≈60–80 mm | trunk (exists anyway) |
| Mounting | adhesive or a clamp on a curved, glossy shell [A]; no existing features | **existing bay socket + door seat** (as a receiver module) | adhesive on the door, or a printed replacement Expansion door with port cut-outs | must share the fan seat or stick to the domed deck | GoPro VHB on the helmet |
| Verdict | fallback | **recommended** | 2nd choice | reject | reject strap; helmet = fallback if the decision changes |

### (a) Front face beside the camera cage
- **Space.** Usable lateral range is from the cage keep-out to the door edge at ≈65.5 mm (right) or ≈60.5 mm
  (left) (V3). The face is flat only to ≈±45 mm (setback ≤3.6 mm). Beyond that the R 58 corner curls back
  11–15 mm by the door. Vertically, take z −6…−44: the top edge is rounded over ≈4 mm, and the bottom is clear of
  the notch beyond lateral 19 mm. Result: **17 × 38 mm flat**, or **≈37 × 38 mm (right) / ≈32 × 38 mm (left)** on
  a contoured base [img, research/06 B1–B5].
- **Knock.** The cage is ±12.95 wide and the M5 head reaches −13.8 [cad]. A finger gap of ≥15 mm (pod from
  lateral 28) leaves only 17 mm of flat face. A gloved hand that misses the pod slides inward onto the cage, which
  stands 15–24 mm proud of the face right there [cad].
  - **Why that matters:** the camera's yaw is held only by the friction of 4 screws in Ø2.3 holes
    (`m2_d`; screw Ø1.5–2.0, research/06 A2). The rotation they allow is θ = c / r, with r = 14.14 mm (half the
    diagonal of the 20 × 20 mm pattern):

    | Screw Ø | Radial clearance c | Possible yaw |
    |---|---|---|
    | 2.0 mm | 0.15 mm | **0.61°** |
    | 1.7 mm | 0.30 mm | 1.22° |
    | 1.5 mm | 0.40 mm | **1.62°** |

    These are one-sided values from centred screws. The end-to-end range is twice as large (1.2–3.2°). All of them
    exceed the ≤0.5° budget (ZALOZENIA 1c.2) [calc]. **The README's step 5 uses exactly this play to set
    convergence, so a knock undoes the alignment.** Whether a given knock actually overcomes the clamp friction
    is not known [A].
- **Press direction.** A press on the front face pushes the goggles back into the face, which is a good reaction
  path. It also puts the forearm in front of the cameras, and the hand appears in the image while operating
  [design].
- **Leads.** The right side reaches the ports around the corner, ≈85–100 mm [calc]. The left side reaches them
  across the face.
- **Verdict: fallback.** If it is used, put the pod at lateral **≥28 mm** and add a printed **rib (fence) between
  the pod and the cage**. Keep the pod's front within **45 mm** of the face (§3).

### (b) Wearer's-left VRx Modular Bay (RX module removed)
- **The door is the space.** The bay door covers the front corner and most of the left side (§1.3). With the
  module out, the bay behind it is empty: "approximately 44mm width x 32mm height … the deepest part is 13mm",
  measured on an HDO v1 [V-comm: F1]. The HDO2 shell differs, so this needs confirming (P1).
- **A pod in the module form factor has been done commercially.** The SpeedyBee receiver is "51x34x17.8 (mm)". It
  lists "HDO2" as supported, ships a "Compatible Casing with FatShark Dominator Series Goggles", carries a "5-Way
  Button" on its outer face, and installs by "remove the receiver compartment panel" then "Align the receiver's
  pins with the female socket inside the goggles receiver compartment. Press down slowly and firmly until you
  feel it securely lock into place" [V: S1–S4]. That gives us:
  - a **proven outer envelope** on the HDO2: 51 × 34 mm, 17.8 mm thickness. The SMA jacks (≈7 mm) and the
    5-way stick (≈2.5 mm) stand beyond the 17.8 mm line in the manual's drawing [img, scaled from the 17.8 mm
    dimension]. The drawing also shows a curved inner casing that follows the goggle corner;
  - a **proven retention method** (the socket and the casing seat);
  - a **precedent for a control on the bay face** (the 5-way). **Downgraded in verification (V9):** the manual
    does not show that the button is used blind or with gloves, so this is not an ergonomic proof.
- **Thickness.** A module 16.5 mm deep "isn't flush but sticks out a bit" in a 13 mm bay, and "The cover hides
  any of that" [V-comm: F1]. So the stock door already clears ≥3.5 mm of module above the bay rim. Against the
  13 mm deepest point, a 17.8 mm module stands **roughly 5 mm** beyond the bay rim [calc]. That is rough: the
  bay depth "varies" and the HDO2 bay is unmeasured. Budget for our pod in §4.
- **Electrical bonus (hypothesis, verify first).**
  - The socket powers a 450 mA module: "Working Current 450mA@5V"; it "will power on automatically when the
    goggles are turned on" [V: S1, S4].
  - A community schematic gives the pinout "1 = 5V … 3 = GND … 6 = VIDEO" (research/04 §1.3, G1). It is **not
    confirmed for HDO2.**
  - If it holds, the pod could take 5 V from the goggles (no Pololu buck) and even inject the camera CVBS into the
    bay (no AV cable).
  - The "RX power switch" independently controls the module's power. A module and AV video together cause an
    "image conflict" unless the RX is off [V: P5]. That interaction has to be bench-tested before relying on
    the socket electrically (P2).
  - **Mechanically the socket can be used regardless**, with an isolated header for retention only [design].
- **Knock.** The pod is ≈47 mm lateral from the cage side at the door's front edge (≈72 mm on the flat side
  part), mostly on the side face. The hand never comes near the camera.
  A sideways press of up to 8.5 N (EC11 push, 6 +2.5/−2 N [V: E1]) is reacted by the strap and the face pad. The
  goggles may shift, but **the cameras and the displays move together, so camera-to-goggle yaw is unaffected**
  [design]. Encourage a **pinch grip**: thumb under the goggle's lower edge, finger on the control. The 34 mm
  height allows this [design].
  - **Caveat added in verification (V10):** on this side of the underside sit the "Receiver on/off" switch, the
    earphone jack and the mini-HDMI port [V: P1; side from the manual p.5 bottom view, where image-right =
    wearer's left]. A thumb there could flip the RX switch. If the pod ever takes 5 V from the bay, that switch
    probably cuts the pod's power ("The RX module power is independently controlled via this switch" [V: P5];
    that it gates the socket's 5 V is [A]). Put a thumb rest on the pod itself, or check P2 first.
- **Reach.** The strap lug is ≈18 mm behind the door [img, corrected V1]. Sliding the hand forward along the strap lands on the
  pod's rear edge, which is a reliable blind landmark [design]. The pod's rear end must stay ≥2 mm ahead of the
  lug so the strap is untouched [design].
- **Leads.** The power and AV ports are on the other side, so either:
  - split the trunk on the helmet: **power + video branch down the right strap** to the barrel and AV plugs;
    **control branch** (VBAT for the divider/buck, GND, GPIO2, UART-TX) **down the left strap** to the pod; or
  - use the bay socket for 5 V and video if P2 confirms it.

  Both avoid a cable across the front [design].
- **Verdict: recommended.**

### (c) Side face at the temple
- **Wearer's left** is (b).
- **Wearer's right** is the Expansion Bay door, with the power port and AV jack at its rear-lower corner (§1.3).
  - Free area: ≈52 × 23 mm above the AV boss, or ≈37 × 36 mm ahead of the AV jack [img, corrected V1].
  - A right-angle AV plug and barrel plug stand out from the side. The pod must leave them free; the plugs could
    even be built into the pod as a "dock" [design].
  - The door hides the power-mode jumper [V: P3]. Legacy Mode, the shipped state, is what this build wants, so the
    door is rarely opened. A pod glued to the door is acceptable. A printed replacement door with port cut-outs
    needs the latch geometry (P3).
  - The bay behind it is **not** empty: the VIN board, jacks, micro-USB and wires are visible in
    `hdo2_front_img/manual/img-101.png` [img].
  - **Verdict: 2nd choice**, with the shortest leads.

### (d) Top deck beside the fan-seat adapter
- **Space.** 5.7–6.4 mm between the adapter and the button panels; an 11.1–12.7 mm strip in front of the panels
  on a rounded edge [img].
- **Covering buttons.** Spanning the panels would cover CH (useless without the RX) or VOL (no audio), but must
  leave the **Display 5-way** at ≈40 mm free [V: P4].
- **Knock and press.** It sits next to the hinge and nut boss (0–6 mm), so any press is a knock risk. A downward
  press of up to 8.5 N lands on the nose bridge.
- The top is also where a helmet brim or visor would meet the goggles [A].
- **Verdict: reject.**

### (e) Strap or helmet
- **The HDO2 strap is elastic**, so a pod on it moves under a 2–8 N press and drifts along the strap [design].
  **Reject.**
- **Helmet side:**
  - rigid and large; GoPro VHB is already in the BOM;
  - fully decoupled from the camera;
  - the goggle trunk would shrink to VBAT/GND/CVBS, because the controls would talk to the AI box on the helmet
    directly [design].
  - Against: the 2026-11-03 decision "przyciski na goglach". **Fallback only.**

## 3. FOV and clash check (OpenSCAD)

- **Files** (scratch, not in the repo): `/tmp/claude-1000/pod_research/placement/pod_fov.scad`, `one.sh`,
  `fov_summary.txt`.
- **Method.** The script includes `cad/camera_mount.scad` (part = "none") and re-uses the FOV pyramids of
  `cad/test/clash.scad`: thermal 50° × 37.2°, Infra worst case 96° × 72°, 300 mm long. Each candidate box is
  intersected with each pyramid, with the cage and with the adapter.
  - Tilts: 0 / 10 / 20°.
  - Two apex positions: 0.5 mm ahead of the lens tip (as in clash.scad), and **at the camera body front**, a
    conservative stand-in for an entrance pupil that sits inside the lens.
  - An empty result means no intrusion.
  - **Limitation (added in verification, V5):** the nearest FOV apex is the thermal body front at tilt 20°,
    x = 58.07. In both pyramids every ray has a positive x component: the extreme corner ray has
    cos 20° − tan(half-angle) · sin 20° = 0.83 (thermal) and 0.69 (Infra). So nothing with x < 58.07 can be inside a
    FOV. All candidate boxes end at x ≤ 58.1 (A at D = 35 grazes by 0.03 mm), D at ≤24.1 and C at ≤11.1. **The
    288 zeros therefore follow from the geometry and do not test the pyramids.** The informative runs are the
    depth sweep below.
  - **Positive control:** a 20 × 10 × 10 mm box at x 100–120 ahead of the lenses was hit by both FOVs at tilt 0
    and by the Infra FOV at tilt 20.
- **Candidate boxes** (CAD frame; FF = 23.1 = front face):

  | Box | x | y | z |
  |---|---|---|---|
  | A_R / A_L | FF−13 … FF+D | ∓62 … ∓28 | −45 … −6 |
  | A_R_near / A_L_near | FF−1 … FF+D | ∓45 … ∓16 | −45 … −6 |
  | C_R / C_L | FF−75 … FF−12 | 22 mm outboard of ±84.6 | −45 … −4 |
  | D_R / D_L | −12 … FF+1 | ∓45 … ∓19 | 0 … 16 |

  D = 20 and 35 mm for the A boxes.
- **Results** [cad]:
  - **All 8 candidates gave 0 mm³ against both FOVs, the cage and the adapter, at every tilt and both apex
    positions.** That is 288 runs: 12 box/depth cases × 3 tilts × 2 apexes × 4 checks.
  - **Depth limit for a front pod beside the cage** (A_R_near, apex at the body front):

    | Pod front proud of the face (D) | Result |
    |---|---|
    | 45 mm | clean at 0/10/20° |
    | 52 mm | clean at 20° (verification re-run) |
    | 54 mm | enters the Infra FOV at 20° (6.7 mm³); clean at 0° and 10° (verification) |
    | 56–58 mm | Infra at 10° (4.9 / 34 mm³) and 20° (63 / 213 mm³); clean at 0° (verification) |
    | 60 mm | enters the Infra FOV at tilt 10° (107 mm³) and 20° (492 mm³); thermal clean (re-run reproduced 492 mm³; mirrored A_L_near identical) |
    | 70 mm | thermal entered at 20° (89 mm³) (verification) |
    | 80 mm | enters both FOVs |

    So the Infra FOV is first entered at **≈53–54 mm**. Keep **≤45 mm** as the design limit, which leaves ≈8 mm of
    margin for the unmeasured Infra FOV [cad].
- **Caveats:**
  - The goggle is a box ghost, and the eye-axis height is `seat_above_eye = 23`. FOV results are insensitive to
    that height because the pods move with the goggles.
  - The Infra FOV is the shop's 120° diagonal turned into a 96 × 72 worst case; the cameras are unmeasured.

## 4. Recommendation: pod = printed VRx-bay casing, wearer's left

### 4.1 Envelope (maximum; design inside it) [design on V/V-comm/img]

| Parameter | Value | Basis |
|---|---|---|
| Face footprint on the shell (fore-aft × vertical) | **≤51 × 34 mm** | SpeedyBee casing documented on HDO2 [V: S1–S4]; stock left door ≳55 × 35.7 [calc on img] |
| In-bay part | **≤42 × 30 × 11 mm** to start; enlarge after P1 | bay ≈44 × 32, deepest 13, depth "varies because the module bay is on a curved part" [V-comm: F1, HDO v1], 1 mm wall clearance [A]. The bay's female socket also takes part of this volume; its size and position are unknown (P1) |
| Body proud of the side surface | **≤12 mm** (SpeedyBee ≈5 mm [calc]) | helmet clearance unknown (P5) [A] |
| Knob / caps above the body | **≤12 mm** | knob on a 20 mm EC11 shaft [V: E1, E3] |
| **Max W × H × depth** | **51 × 34 × ≈35 mm** (11 in the bay + 12 body + 12 knob) | sum of the above |
| Rear end | ≥2 mm ahead of the strap lug | §1.3 |
| Front end | may run onto the R 58 corner up to the door's front edge (lateral ≈60.5 mm, ≈11 mm behind the front face); nothing on the pod may project forward of the front-face plane | §1.1, §1.3 (wording corrected in verification) |

**Lower-bound check that the parts fit** [calc on V]. Board-area estimate:

| Part | Size (mm) | Area (mm²) | Source |
|---|---|---|---|
| XIAO | 21 × 17.8 | 374 | [V: X1] |
| EC11E body | 11.7 × 12 | 140 | [V: E3] |
| 2 × B3S | 6 × 6 each | 72 | [V: O1] |
| D36V6F5 | 13 × 10 | 130 | [V: X2] |
| Vibration motor | Ø10 | 79 | [V: X3] |
| 2 × JST-GH 5-pin side-entry header (SM05B-GHS-TB) | 9.5 × ≈4.85 each (4.05 + 0.8 deep; 4.25 high) | ≈92 | [V: X4, drawing p.3] |
| **Total** | | **≈887** | |

- That is **≈887 mm²**, against **1260 mm²** for a 42 × 30 board, on one layer. Body outlines only: the B3S SMT
  terminals, the EC11 bracket legs (12.5 mm apart) and the mating GHR plugs add area, so this is a lower bound.
- Heights: EC11E body 4.5 + shaft 20 = 24.5 from the board [V: E3]; B3S 4.3 [V: O1]; XIAO thickness not in the
  text [A ≈3.5 with USB-C].
- The reference plane is the goggle side surface (the bay rim). The terminals project 3.5 mm below the board
  [V: E3], so in an 11 mm in-bay budget the board can sit at most ≈7.5 mm below the side surface. The shaft tip
  is then ≈17 mm proud of the side surface. That fits the 12 + 12 = 24 mm budget, with the knob's top at 17–24 mm
  [calc]. Every catalogued EC11E variant has a 20 mm actuator [V: E2 product list], so no shorter-shaft
  variant is available from this source. (Rewritten in verification, V8: the earlier "8 mm under the outer face"
  did not say which face, and 8 + 3.5 exceeded the 11 mm in-bay budget.)
- Layout: the encoder at the front of the face and the two caps stacked at the rear. 34 mm of height allows
  two 12 mm caps at 18 mm centres (05 §3) [design].

### 4.2 Mounting method [design]
1. **Primary:** the pod's inner part plugs into the bay like a receiver module. Copy the stock door's latch and
   seat features (P1) into the printed casing, so it "locks into place" as a module does [V: S4].
2. **Retention aid:** a 9-pin male header (pitch per P2) pressed into the bay socket.
   - **Leave every pin unconnected until P2 has metered the pinout.**
   - It then holds the pod mechanically with no electrical risk.
   - If P2 confirms 5 V / GND / VIDEO, wire 5 V and GND to the XIAO; the Pololu buck then becomes optional.
   - Video through the bay is a later bench experiment (P5 manual note on "image conflict").
3. **No adhesive and no screws into the shell.** The pod comes off like a module, and the stock door goes back on.
4. **Trunk:** a JST-GH 5-pin at the pod's rear end, pointing back along the strap. Split the trunk on the helmet
   (§2 b, "Leads").

### 4.3 What this does not settle
- The encoder axis orientation (lateral knob, or a fore-aft thumbwheel), cap shapes and the internal layout.
  These belong to the pod-design step.
- Whether the HDO2 bay really is 44 × 32 × 13 (an HDO v1 figure).
- Whether a left-hand pod suits Adam (P7).

## 5. Second choice: wearer's-right side above the ports (c-R)
- **Envelope:** ≈52 × 23 mm above the AV boss, or ≈37 × 36 ahead of the AV jack [img, corrected V1]. Proud of
  the side ≤12 + 12 mm, as above.
- **Mounting:** a printed cover glued (VHB) to the Expansion door, or a printed replacement door with port
  cut-outs (needs P3).
- **Advantage:** power and AV plugs within 50 mm; one trunk.
- **Disadvantage:** half the area of (b); the plugs crowd the controls; no empty bay behind it.

## 6. Measurements Adam must take (priority order)
- **P1. VRx Modular Bay, door off (wearer's left).**
  - Photograph it straight on with a ruler.
  - Measure the opening width × height and the depth at the front, middle and rear.
  - Record the socket position and orientation.
  - Measure the stock door: outer size, thickness, and how it latches (tabs, hooks, magnet, screw).
- **P2. Bay socket.**
  - Pin count and pitch.
  - With the goggles on 3S, meter each pin to GND with the RX switch ON and then OFF (with the meter only, no
    shorts). Look for 5 V, GND and video.
  - If 5 V is present, check its current limit with a 100–200 mA dummy load.
- **P3. Expansion Bay door (wearer's right)** — needed only for the fallback:
  - its size and latch;
  - the positions of the power port and AV jack relative to the door;
  - the outer diameter and length of the plugs Adam will use (right-angle or straight).
- **P4. Front corner** (only for fallback a): a profile gauge or card template at lateral 30, 45 and 60 mm, top to
  bottom. Checks the R 58 corner and the flat zone.
- **P5. Worn with the helmet:**
  - the gap from the goggle side face (over the bay) to the helmet shell or rim and to the strap;
  - whether the strap passes over the bay door.

  Sets the ≤12 + 12 mm protrusion.
- **P6. Glove mock-up.**
  - Print a blank casing with a dummy knob and two caps; wear your winter gloves.
  - Time how long it takes to find each control blind.
  - Check that an 8.5 N sideways press (EC11 push max) does not move the goggles enough to bother you, with and
    without a pinch grip.
- **P7. Handedness:** which hand is free while walking (a pole or torch in the right hand?). The left-bay pod
  suits the left hand. If the right hand must operate it, choose (c-R).
- **P8. Fan-screw diameter** (research/06 M1). Gives the real yaw play (±0.6 to ±1.6°) and so how much a knock on
  the cage can cost.
- **P9.** With the RX module removed and the RX switch OFF, confirm that the AV input works (expected [V: P5]).
  Then, if the socket is to be used for 5 V, repeat with the switch ON and look for any "image conflict".

## 7. Sources

**Read at source for this track** (quotes in `papers/extracts_pod_placement.md`):
- `papers/FatShark_HDO2_Manual_RevC.pdf`: pp. 5, 6, 8, 9, 11 (P1–P6).
- `papers/pod_place/speedybee_5g8_goggles_receiver_manual_EN.pdf` (+ .txt): pp. 3–5 (S1–S4).
- `papers/pod_place/intofpv_thread_7613_module_bay_size.html/.txt` (F1, HDO v1 bay size).
- `papers/pod_place/intofpv_thread_24557_speedybee_module.html/.txt` (F2; its manual link led to S).
- `papers/pod_place/alps_EC11E09244BS_detail.html/.txt` (E1), `alps_product_catalog_ec_01_ec11e_en_611f078659.pdf`
  (+ `alps_EC11E_catalog.txt`, render `alps_EC11E_p2-2.png`) (E2, E3), plus the page's figure GIFs
  `alps_product_detail_fig_ec11_*.gif` (downloaded, not used for claims).
- Already in the repo, re-read: `ctrl_omron_B3S.pdf` (O1), `ctrl_xiao_esp32c3_wiki.txt` (X1),
  `ctrl_pololu_D36V6F5.txt` (X2), `ctrl_adafruit_1201_vibration_motor.txt` (X3), `ctrl_jst_GH.pdf` p.3 (X4).

**Images measured:**
- `papers/hdo2_front_img/manual/img-001.png` (top view);
- `fatshark/fs_hdo2_media4_HDO2_e.jpeg` (front view);
- `manual/img-099.png` (side views);
- `manual/img-007.png` (bottom view, controls only);
- `manual/img-101.png` (Expansion Bay interior, qualitative);
- `fatshark/fs_hdo2_media0_HDO2_1024x1024.jpeg` and `oscarliang/…module-bay-front.jpg` (door wrap and labels,
  qualitative).

Annotated crops are in the scratch dir only (`/tmp/claude-1000/pod_research/placement/img/`).

**Project inputs:** `ZALOZENIA.md` §1c; `research/04`, `05`, `06` (+06a); `cad/camera_mount.scad` v0.3;
`cad/test/clash.scad`.

### Retrieved / not retrieved

| Item | Status |
|---|---|
| SpeedyBee goggles receiver manual (HDO2 bay fit, 51 × 34 × 17.8, 5 V 450 mA) | **retrieved, read** |
| IntoFPV 7613 (bay 44 × 32 × 13, HDO v1) and 24557 | **retrieved, read** |
| Alps EC11E series catalog PDF + EC11E09244BS product page | **retrieved, read**. The older URLs `tech.alpsalpine.com/assets/products/catalog/ec11.en.pdf` and `…/cms.media/product_catalog_ec_02_ec11e_en_611f078659.pdf` returned 403. Mouser mirrors returned HTML |
| Fat Shark drawing of the HDO2 shell or the VRx bay (opening, depth, socket, door latch) | **not found**. No claim; replaced by P1/P2 |
| GetFPV HDO2 disassembly ("Fatshark dust removal") https://www.getfpv.com/learn/fpv-diy-repairs-and-mods/fatshark-dust-removal/ | **not retrieved** (403, see 06a). Would show the bay and door latch. Adam: please save it from a browser |
| ImmersionRC rapidFIRE module dimensions / casing drawing (https://www.immersionrc.com/?p=5781) | not attempted beyond search; no claim |
| SpeedyBee product page https://www.speedybee.com/speedybee-5-8ghz-goggles-receiver | not fetched; the manual covers it |
| HDO2 confirmation of the 9-pin bay pinout | **not found**. Only the community schematic (research/04 G1) |
| ISO 4762 / DIN 125 dimensions (M5 head, washer) | not retrieved; used as [A] in §0 |
| XIAO ESP32-C3 thickness (DXF linked on the wiki) | not fetched; [A] |
| MIL-STD-1472H, DTIC ADA256894 (gloved control spacing) | MIL-STD-1472H is now in `papers/pod_MIL-STD-1472H_2020_human_engineering.pdf` (downloaded by another track). It was **not read for this report**, and no spacing claim here rests on it. DTIC ADA256894 is still missing (see research/05) |

**Waiting on:** P1, P2, P5 and P7. Until they are measured, the envelope in §4.1 is a design target, not a
verified fit.

## Verification (adversarial pass, 2026-11-03)

I checked every numeric claim against the files in `papers/`. I re-rendered the PDFs (SpeedyBee pp. 3–5,
HDO2 manual pp. 5–6, 9, 11, Alps p.2, JST GH p.3), re-measured the images and re-ran the OpenSCAD intersections.
Scratch files are in `/tmp/claude-1000/pod_research/verify-placement/` (`top.py`, `side.py`, `edges.py`,
`one.sh`, gridded crops `Lg.png`, `Rg.png`, `Fg.png`, `sb5_top.png`, `sb3_draw.png`, `ec2.png`, `jst-3.png`).

**Changes made:**

- **V1. Side-view scale (`manual/img-099.png`) was wrong.**
  - The report used 205 px = 35.7 mm (0.174 mm/px). But 205 px is the door's bounding-box height: its top
    and bottom edges slope ≈4–6° in the 3/4 view (right door top y 258 at the rear and 232 at the front).
  - Measured perpendicular to those edges, the door is ≈180–185 px tall, which gives **≈0.196 mm/px**.
  - An independent cue agrees: the antenna cover is 49 px tall here and 9.6 mm tall in the front view
    (69 px × 0.139).
  - All §1.3 lengths are re-scaled: doors 47/48 → ≈52/53.5 projected; power port 10 × 10 → ≈11 × 12; AV centre
    8.5 → ≈9.6 mm from the door's rear edge; strap gap 16 → ≈18.
  - The free band above the ports was 21 mm, measured from the door's *front*-top corner to the *power-port* top
    (the power port is not on the door). Corrected to ≈23 mm, from the door top above the AV boss to the boss
    top. The full-height part ahead of the jack is 33 → ≈37 mm.
  - Propagated to the TL;DR, the §2 table, §2 (b)/(c), §4.1 and §5.
- **V2. Antenna-port cover size.** The report had Ø ≈7–8; 06 B5 has Ø≈7. In the front view the cover is 53 px wide
  but 69 px tall: 7.4 × 9.6 mm. The width is foreshortened by the corner, so it is **≈9.6 mm** across. Its centre
  is at lateral ≈65.5 mm (projected), not ≈69. 06 B5 is flagged; I did not edit 06.
- **V3. Door-edge laterals.** The report had 62.4/63 mm, symmetric, which assumes the 125 mm front panel is
  centred. Measured from the silhouette centre (x 998.5 in `fs_hdo2_media4_HDO2_e.jpeg`), the panel spans
  528–1430 px, so the right door edge is at ≈65.4 mm and the left at ≈60.0 mm. This matches 06 B5's door widths
  (84.6 − 18.5 = 66.1; 84.6 − 24 = 60.6).
  - Re-computed on the R 58 fit: the left door starts ≈11 mm behind the front face, with a ≈55 mm arc to the side
    wall. The right door starts ≈15 mm behind, with a ≈48 mm arc. The old figure was ≈13 mm and ≈52 mm for both.
  - The "+ straight part = 55 mm" door length had no measured rear-edge position. It is now stated as a lower
    bound, ≳55 mm for the left door.
  - Contoured front-pod widths are now 37 (R) / 32 (L), not 35.
- **V4. "Side bay ≥60 mm lateral from the cage" was wrong.** The door's front edge is ≈60.5 − 12.95 ≈ **47 mm**
  from the cage side. The flat side part is ≈72 mm. The conclusion (negligible knock risk) stands.
- **V5. FOV check scope.**
  - All 288 zeros are guaranteed by geometry. Every box lies behind the nearest apex (x = 58.07, thermal body
    front at 20°), and every FOV ray has a positive x component (0.83 thermal, 0.69 Infra worst corner). The
    claim stands, but "288 runs" is not evidence of robustness; the text now says so.
  - Re-ran A_R_near/A_L_near with the apex at the body front:
    - 60 mm reproduced 492 mm³ at 20°;
    - bisection: 52 mm clean; first Infra entry at **54 mm** (20°, 6.7 mm³); 56 mm at 10°; 58 mm still clean at
      0°;
    - thermal first entered between 60 and 70 mm (20°).
  - TL;DR "≥60 mm" corrected to ≈54 mm. The ≤45 mm design limit is kept.
- **V6. Adapter-to-panel gap.** "5–6 mm" changed to 5.7 (R) / 6.4 (L), from the stated 12.5/12.8 and 18.2/19.2.
  The strip in front of the panels was re-measured at 11.1–12.7 mm (reported 11.0–12.6; fine).
- **V7. JST-GH area.** The side-entry header drawing (p.3) gives 4.05 + 0.8 mm deep and 4.25 mm high. "≈4.3" was
  the height. Area per header ≈46 mm², total ≈887 mm² (was 875). Added that the table is a body-outline lower
  bound.
- **V8. Encoder height paragraph rewritten.** It was ambiguous about the reference face. Including the 3.5 mm
  terminals, "8 mm under" broke the 11 mm in-bay budget. Re-derived: board ≤7.5 mm below the side surface,
  shaft tip ≈17 mm proud.
  - Drawing No.2 was re-read: 24.5 = 4.5 + (20) from the seating plane, 3.5 mm terminals, 11.7 wide, 6 + 6,
    7.5 max, 12.5 ± 0.05 bracket, travel 0.5. The extract's reading of the seating plane is confirmed.
  - The catalog lists only 20 mm actuators for EC11E.
- **V9. SpeedyBee precedent.** "Proven ergonomic precedent" was downgraded: nothing in the manual shows blind or
  gloved use. Added from the p.3 drawing that the SMA jacks (≈7 mm) and the 5-way stick (≈2.5 mm) protrude beyond
  the 17.8 mm line, and that the casing's inner side is curved [img]. The "≈5 mm proud" estimate is now marked
  rough. Added F1's "The cover hides any of that".
- **V10. Missed hazard added.** The manual p.5 bottom view puts the Receiver on/off switch, the earphone jack and
  the mini-HDMI port on the wearer's-left underside (image-right in a view from below with the front up; consistent
  with the VRx bay being on the left). The proposed pinch-grip thumb lands there.
- **V11. Wording and tags.**
  - Yaw play is now stated as one-sided (±), with the end-to-end range added; θ = c/r was re-checked at
    0.61/1.22/1.62°.
  - Press forces are marked as switch maxima, not hand loads.
  - The stock door size is tagged [calc on img], not [img].
  - The garbled §4.1 "Front end" row was rewritten.
  - The bay socket's volume is noted in the in-bay budget.
  - MIL-STD-1472H status updated: the file is present, not read.

**Checked and found correct:**
- HDO2 manual quotes P1–P6 (pp. 5, 6, 8, 9, 11). Side assignment from the p.6 views: the ports and the Expansion
  Bay are on the wearer's right; the antenna port and the VRx bay are on the left.
- SpeedyBee S1–S4: text and page numbers.
- F1/F2 quotes.
- E1/E2 values. Line numbers are approximate (l.66–68, 93–105).
- O1, X1–X3.
- §0 CAD values against `x.echo` and `camera_mount.scad`: front_x 23.1, hinge (33.6, 0), cage ±12.95, boss to
  +12.8 on +y, lens and cage positions.
- §1.1 plan half-widths: re-measured within ≤0.5 mm. The R 58 circle reproduces 46.0/54.1/71.4/84.25 at
  3.2/6.7/20.7/48.7 mm, and its arc from lateral 45 to the side wall is 72.8 mm.
- §1.2 elevation: silhouette 168.9–169.3 mm from 6.4 to 32.7 mm below the top edge.
- The positive control.
- The 875 sum and 1260 board area (arithmetic).
- The 35 mm total depth.

**Unresolved after verification:**
- All [img] values still come from 3/4 product photos with an unknown camera pose; the ±8 mm fore-aft projection
  error stands. Only P1/P3 can settle the door, bay and port positions.
- The HDO2 bay depth and layout, the socket position, and whether the RX switch gates the socket's 5 V (P1, P2,
  P9).
- Whether a knock can actually slip the 4-screw clamp (friction is unknown).
- The 06 B5 antenna-cover diameter (≈7 mm) disagrees with this pass (≈9.6 mm). It needs re-checking in 06.
- Alternatives not assessed, because the 2026-11-03 decision puts buttons on the goggles: a tethered handheld or
  wrist remote, and a pod on the rear strap or battery-case area.
