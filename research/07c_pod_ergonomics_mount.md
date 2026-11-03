# 07c — Control pod on the HDO2: gloved/blind ergonomics, attachment without drilling, cap and knob geometry

**WORKING DRAFT (2026-11-03; adversarially verified the same day, see §9).** Track 07c of `arabskie_gogle`. ZALOZENIA.md governs the project; for every
quoted value **the source files in `papers/` govern** over this report, and the verbatim passages are in
`papers/extracts_pod_ergonomics_mount.md` (cited below as E1.1, E3.2 …). Electronics are not owned and the
goggles are not measured, so every dimension comes from datasheets, the standard, or `research/06`.
This draft is waiting on: Adam's gloves (G1), HDO2 shell finish and front-face profile (M6 in `research/06`),
and the camera-mount assembly check (cage, M5 head) in `cad/camera_mount.scad`.

Tags: **[V: Ex]** read at source (extract number); **[img]** read from a drawing/chart image; **[calc]** my
arithmetic from tagged inputs; **[A]** assumption; **[design]** my design choice, not sourced.

---

## TL;DR

1. **MIL-STD-1472H gives the gloved numbers, and they are big.** Push button Ø ≥ **19 mm** for the gloved
   fingertip, edge-to-edge separation ≥ **25 mm** gloved, travel **2–6 mm**, force **2.8–11 N**, concave top
   [V: E1.17, E1.18]. Blind operation needs **shape coding** (or 125 mm separation) [V: E1.8]. A shape-coded
   control must be at least **13 × 13 mm and 6.5 mm deep** [V: E1.7]. Knob (fingertip grasp): **H 13–25 mm**,
   D ≥ 10 mm, torque ≤ **32 mN·m** for D ≤ 25 mm [V: E1.15]. MIL ties only some gloved values to a glove type:
   the Fig. 14 footnote says *flash gloves* add 5 mm to the bare diameter (→ 15 mm), while 19 mm is also the
   Table VII value for *arctic mittens* [V: E1.11, E1.18]; the 25 mm gloved separation names no glove. Treat the
   values as floors and test with Adam's own winter gloves (G1). *(Corrected in verification, V1.)*
2. **The proposed parts miss MIL criteria.** B3S tactiles have 0.25 mm pretravel and ≤ 1.57/2.26 N
   [V: E12.1], against ≥ 2 mm and ≥ 2.8 N. Fix [design]: put each cap on a **printed PETG flexure tongue**
   (l 15, t 1.0, w 10 mm) with a **1.75 mm free gap**. Calculated result: ≈ 2.0 mm nominal total travel (1.6–2.5 mm
   with the switch tolerances, i.e. *at* the 2 mm minimum, not above it) and ≈ 2.4 N + the B3S operating force
   (≤ 1.57 N, no minimum published) ≈ **≤ 3.9 N** at the click [calc, V4]. The encoder push: EC11E09244BS has
   **6 (+2.5/−2) N** force (meets 2.8–11 N) but 0.5 ± 0.3 mm travel [V: E15]; **EC11E09244AQ** has 1.5 mm travel
   [V: E11.1] — closer, but **still under 2 mm**, and its force is not retrieved. No encoder found meets the 2 mm
   travel; Bourns PEC11R with 12 detents (30°) is a missed alternative for the detent criterion (§1.2, V3).
3. **Layout [design]:** one pod on the **front face, wearer's right** (CAD y = −16…−48 mm), with each control on
   a different face:
   - **CAM:** a Ø20 concave cap on the pod's front face. It pushes straight into the shell.
   - **Encoder knob:** Ø24 × 15 mm, axis **lateral**, on the pod's outer side.
   - **AUX:** a ridged square cap on the pod's underside, **≥ 19 × 19** (the 16 × 16 first proposed is under
     MIL's 19 mm gloved fingertip value; V5).

   Three faces plus three shapes give the coding. They do **not** give MIL's ≥ 25 mm gloved separation: on a
   32 × 36 × 24 mm pod the along-surface CAM–AUX distance is at most ≈ 20–23 mm, and CAM–knob is ≈ 8 mm if CAM
   is centred (≥ 13 mm bare needs CAM ≥ 6 mm inboard) [calc, V6]. The layout relies on the pod edges acting as
   barriers, which is a design judgement, not a MIL/HIDH value; test in G1. The AV and power jacks are on the
   same (right) side [img: `research/06a` l.222].
4. **Attachment: 3M VHB 5952** (1.1 mm, conformable foam, modified acrylic for medium-surface-energy plastics)
   on a **contoured 32 × 36 mm printed base** (11.5 cm²). ABS and PC are in the 3M chart's 38–39 dyn/cm
   "medium" class, where 5952 shows "generally good adhesion" [img: E4.1]. 3M specifies 4910 for
   high-surface-energy substrates [V: E6], so don't use it (V12).
5. **Safety factors** (30 g pod, 20 g shock, 20 N finger), against 3M's dynamic design stress of 85 kPa
   [V: E3.3, E7]:
   - shock: ≤ 11 kPa (utilisation 0.12);
   - CAM push: ≈ 2 kPa;
   - knob or AUX push: 35–46 kPa (≤ 0.54);
   - static dead load: 6.7× the 3M creep rule [calc].

   **Only a 20 N snag pull at the knob tip** exceeds the design stress (125 kPa, 1.5×; lever 33 mm, V7). It is
   still 3.8× below the typical 480 kPa tensile strength, which was measured on aluminium [V: E3.2].
   → add a **hook lip over the top front edge** as a mechanical back-up. That is also the reason the knob axis is lateral: a forward knob
   would put its top 23–30 mm off the bond (0.88–1.15× the design stress) [calc].
6. **Do not use a GoPro adhesive base for the pod.** It adds ≈ 10–14 mm of lever arm and buckle play, and GoPro
   publishes neither the adhesive grade nor the area [V: E10]. A strap or clip mount is a fallback only (§3.4).
7. **Knob on the D-shaft [design]:**
   - D-bore Ø6.20 / flat 4.55 (coupon ±0.1);
   - 8 mm engagement;
   - M3 cup-point set screw onto the flat from a radial nut trap;
   - printed top-down with the bore vertical.

   This meets MIL's "positively and non-reversibly attached" [V: E1.7]. The 20 mm shaft does not fit a 15 mm
   blind-bore knob without cutting ≈ 2 mm or raising H (§4.1, V9). **Lid:** M2 screws, not Z-printed snaps.
   If you use snaps, keep the strain ≤ 1.5 % (the example l 12, t 1.2, undercut 0.8 mm gives 1.0 %) [calc from
   E13, E14].
8. **Bonding procedure:**
   - clean with IPA/water;
   - abrade lightly if the finish allows;
   - press at **100 kPa ≈ 115 N** over the pad (2–3× that on rigid parts);
   - apply above 10 °C, ideally 21–38 °C;
   - wait **72 h** before use (50 % at 20 min, 90 % at 24 h).

   Bonded at 10 °C, the joint reaches only ≈ 70 % at 72 h [V: E3.4, img E5.2]. VHB becomes "shocky" near its
   glass transition at −40 °C [V: E8]. That is far below the camera's −10 °C floor.

---

## 1. Control design numbers for gloved, blind use

### 1.1 What the standards say (MIL-STD-1472H, 15 Sep 2020; NASA HIDH Rev 1)

| Item | Bare hand | Gloved | Source |
|---|---|---|---|
| Push button Ø, fingertip | 10–25 mm | **≥ 19 mm** (footnote: thin flash glove = bare + 5 → 15 mm; the standard gives both) | [V: E1.18] |
| Push button Ø, thumb | 19–25 mm | ≥ 25 mm | [V: E1.18] |
| Push button force, single finger | 2.8–11 N | (no separate gloved value) | [V: E1.18] |
| Push button travel, fingertip | 2–6 mm | — | [V: E1.18] |
| Separation, push buttons, single finger, edge-to-edge | 13 mm min, 50 mm preferred | **≥ 25 mm** | [V: E1.18] |
| Separation, push button ↔ continuous rotary | 13 mm (bare; "increase for gloves") | not given | [V: E1.2, E1.3] |
| Knob separation, one hand | 25 mm min, 50 mm optimum | ganged knobs: "add 13 mm … for gloves" | [V: E1.15, E1.16] |
| Barriers instead of spacing | Table III values are "for push buttons not separated by barriers"; HIDH: barriers "may be used instead of the spacing" | — | [V: E1.3, E2.1] |
| Knob, fingertip grasp | H 13–25 mm, D 10–100 mm | — | [V: E1.15] |
| Knob, thumb + finger encircled | H 13–25 mm, D 25–75 mm | — | [V: E1.15] |
| Knob torque | ≤ 32 mN·m (D ≤ 25), ≤ 42 mN·m (D > 25); "as low as possible without permitting the setting to be changed by vibration" | — | [V: E1.15] |
| Detent angle (rotary *selector*) | 15–40° | **≥ 30° "when tactually ('blind') positioned"** (same Fig. 6 also sets resistance 115–680 mN·m and depth ≥ 16 mm for selector knobs, and ≤ 12 positions if not visible — Fig. 6 is for selector switches, not for a continuous encoder, so only the 30° is borrowed here [design]) | [V: E1.12] |
| Blind operation | shape-coded, or ≥ 125 mm apart | shapes "tactually identifiable when gloves must be worn" | [V: E1.8, E1.6] |
| Shape-coded control, minimum size | H ≥ 13, W ≥ 13, depth ≥ 6.5 mm | — | [V: E1.7] |
| Size coding | ≤ 3 sizes; knob Ø steps ≥ 13 mm | (size coding "may be less effective" with gloves) | [V: E1.5, E1.4] |
| Button top | concave, else high friction; tactile feedback is primary | — | [V: E1.17] |
| Knob rim | knurled (very small), serrated (intermediate), edges rounded | — | [V: E1.14] |
| Shape-coded knob on shaft | "positively and non-reversibly attached" | — | [V: E1.7] |
| Accidental actuation | recess/barrier (control "entirely contained"), spring resistance, or rotary action | — | [V: E1.10] |
| Finish | no gloss for night operations | — | [V: E1.9] |
| Glove effect (qualitative) | — | gloves "reduce tactility", "size and shape of objects is more difficult to discern"; 4-way discrete beat continuous devices for gloved cursor control | [V: E2.2, E2.4] |

**What "gloved" means here (corrected, V1).** MIL is not consistent about the glove. Fig. 14 footnote 1/ says
that for "standard cotton flame-resistant anti-flash gloves" one adds 5 mm to the bare diameter, i.e. 15 mm,
yet its gloved column prints 19 mm [V: E1.18]. In Table VII (keyboards) 19 mm is the value for **arctic mittens**
(trigger-finger type) and 15 mm the value for flash gloves [V: E1.11]. The gloved separation (25 mm) carries no
glove type at all [V: E1.18]. So 19 mm is not a "thin-glove" number; it may correspond to heavy handwear. Treat
all MIL gloved numbers as **floors** and size from G1. MIL itself says to adjust dimensions for the handwear
actually used [V: E1.1].

### 1.2 Proposed parts against the criteria

| Control | Part as proposed (05) | Criterion | Gap → fix |
|---|---|---|---|
| Tactile | B3S-1000: 1.57 N max, pretravel 0.25 mm [V: E12.1] | ≥ 2.8 N, ≥ 2 mm [V: E1.18] | Both miss → **flexure tongue + free gap**, §4.2 [design]; nominal travel lands exactly on 2 mm, so shim the gap to ≥ 2.05 mm (V4) |
| Encoder push | EC11E09244BS: travel 0.5 ± 0.3 mm, operating force **6 (+2.5/−2) N**, push-pull strength 100 N [V: E15] (the catalog omits the force; the Alps product page gives it) | ≥ 2 mm, 2.8–11 N | Force **meets**, travel misses. **EC11E09244AQ, 1.5 mm** (same detents and shaft) [V: E11.1, img E11.2] narrows the travel gap but **still misses 2 mm**; its force is not retrieved (AQ product page not downloaded) → measure (G4) |
| Encoder turn | 18 detents (20°), detent torque 10 ± 7 mN·m [V: E11.1] | knob ≤ 32 mN·m [V: E1.15]; blind selector ≥ 30° [V: E1.12] | Torque OK. 20° is under 30°; 18 is the coarsest *listed* EC11E (the catalog says other products exist) [V: E11.1]. Firmware: consider 2 detents per palette step [design]. **Missed alternative (V3):** Bourns **PEC11R-4320F-S0012** (ordering code built from E16: 4 = rear-facing pins, 3 = 12 detents, 20 mm, F = flatted, S = push, 12 pulses) — 12 detents = 30°, push 0.5 ± 0.3 mm at 610 ± 306 gf (≈ 3.0–9.0 N), flatted Ø6/4.5 shaft, M7 bushing + nut for panel mounting through the pod wall, but **IP40** and detent torque only 30–90 gf·cm (≈ 2.9–8.8 mN·m) [V: E16] |
| Caps | "≥ 12 mm, **centre** spacing ≥ 18 mm" (05 §3, [design]) | ≥ 19 mm Ø, ≥ 25 mm edge gap gloved | 05's values are below MIL → use §5 values |

## 2. Pod layout [design]

```
   Front view of HDO2 (wearer facing you is NOT the view; this is looking at the goggles' front)
   CAD y: +62 (wearer's left) ............ 0 ............ −62 (wearer's right)

        ┌───────────────── front face ≈125 × 39 mm (06 B1) ───────────────────┐
        │  [VRx bay door]      ┌──cage──┐   ┌───── POD 32×36 ─────┐ ⟲ knob │[Exp. bay door]
        │                      │ Infra  │   │   ◯ CAM Ø20 concave │═══Ø24  │  power + AV jacks
        │                      │ thermal│   │                     │  (axis │  on this side wall
        │                      └±12.95──┘   └──── □ AUX (underside)┘  lateral)
        └────────────────────────────────────────────────────────────────────┘
```

- **Footprint:** y −16…−48 mm, i.e. ≥ 3 mm clear of the cage's ±12.95 mm (`camera_mount.scad` l.51). Height 36
  of the 39 mm flat panel (06 B1). The pod sticks out **≈ 24 mm** from the face.
- **Contoured base.** The face is flat to ≤ 0.7 mm only within ±35 mm and sets back 2.9–3.6 mm at ±46.7 mm
  [img: 06 B2]. VHB "will not flow to fill gaps" [V: E3.3]. So the pod base must be **printed to the measured
  profile** (M6), not flat. A flat base that fits only y −16…−35 (19 × 36 mm) is too small: the knob push alone
  reaches 1.5× the design stress [calc].
- **CAM:** on the pod's forward face. It is the forward-most point on the right side of the goggles, easy to
  find, and the push goes into the shell (compression) [design].
- **Knob:** axis lateral (−y), centre ≈ 14 mm off the face, so a Ø24 knob clears the shell by ≥ 2 mm [calc]. Its
  rim reaches ≈ 26 mm off the face, i.e. ≈ 2 mm forward of a 24 mm pod. It hangs out past the pod side from
  y ≈ −50 to −65. The Expansion Bay door starts at y ≈ −62.7 (06a front view x 395…528 at 0.139 mm/px, panel
  centre x ≈ 979) [img calc, V8], so the knob overlaps the door's span by only ≈ 2 mm, where the face is
  already set back ≈ 12–13 mm (06 B2). The manual requires removing that door to move the power-mode setting
  (`FatShark_HDO2_Manual_RevC.txt` l.161). So the knob must **not bond to the door** and should come off with its
  set screw. Check the door's opening direction on the real goggles.
- **AUX:** on the pod's underside, pushed upward [design].
- **Spacing (corrected, V6).** The three controls sit on three faces. HIDH allows "mechanical interlocks or
  barriers … instead of the spacing" [V: E2.1]; treating a 90° pod edge as such a barrier is **my judgement
  [design]**, not a sourced rule. The 25 mm gloved value [V: E1.18] is **not reachable** on this pod [calc,
  pod 32 (y) × 36 (z) × 24 (x) mm, positions as below]:
  - CAM ↔ AUX along the surface: even with CAM pushed to the top (lower edge ≈ 16 mm above the bottom edge) and
    a 16 mm AUX pushed to the back of the underside (x 1…17, front edge ≈ 7 mm from the pod's front edge),
    ≈ 23 mm; with a 19 mm AUX ≈ 20 mm. Straight-line distances are smaller still.
  - CAM ↔ knob: with CAM centred laterally (y −32, edge −42) and the knob's inner face at y −50, ≈ **8 mm**,
    under the 13 mm **bare-hand** push-button↔continuous-rotary value [V: E1.3]. Offset CAM ≥ 6 mm inboard
    (centre y ≤ −26) to reach 14 mm.
  - AUX ↔ knob: with AUX centred under the pod and the knob centred in z, ≈ 12 mm straight-line; move AUX inboard.
  A real raised rib between controls (HIDH's "barrier") is a cheap addition; confirm everything with G1.
- **Clearances to check in the assembly:**
  - the pod front must stay ≥ 3 mm behind the camera lens front plane, so it is not in the 120° Infra field.
    From `camera_mount.scad` v0.3 parameters (all [A]) at tilt 0: camera front faces ≈ 40.4 mm, thermal lens
    front ≈ 47.7 mm and Infra lens front ≈ 59.5 mm in front of the face [calc, V10]; pod front 24 mm (CAM cap
    top ≈ 30.5 mm) is ≥ 17 mm behind. Re-check after M5/M6;
  - the **pod's inboard top corner (y −16)** — not the knob, which is at y −50…−65 — must clear the M5 head +
    Ø10 washer on the −y side of the adapter (`cad/README.md` step 3). Female legs' outer face is at y −7.8
    (`fem_out`); ISO 4762 M5 head 5 mm + washer 1 mm [A] put the head face at ≈ y −13.8, ≈ 10.5 mm in front of the
    face and ±5 mm about deck level → ≈ 2 mm clearance [calc, V10]; the tilt scale on that side must stay
    readable;
  - leave a USB-C opening for the XIAO.
- **Vibration motor.** Inside the pod, the alarm vibration now reaches the face through the goggle shell,
  not through the forehead foam as `05` §4.4 assumed. Untested.

## 3. Attachment to the goggle shell without drilling

### 3.1 Shell material
Not in the HDO2 manual (no hit for material/plastic/PC/ABS). Treat it as **unknown plastic with an unknown
coating** [A]. If it is bare ABS or PC, both are 38–39 dyn/cm "medium surface energy" on the 3M chart [img:
E4.1]. A paint or soft-touch coating can change that [V: E4.1 notes].

### 3.2 Tape choice

| Tape | Thickness | Adhesive / substrates | Key data | Verdict |
|---|---|---|---|---|
| **3M VHB 5952** | 1.1 mm | modified acrylic; HSE, MSE, M/LSE; "very conformable foam" for "slightly mismatched" surfaces [V: E3.1, E3.3] | normal tensile 480 kPa (Al), overlap shear 550 kPa (SS), 90° peel 39 N/cm, static shear 1000 g / 0.5 in² for 10,000 min at 23 °C; min application 10 °C; G = 3×10⁵ Pa [V: E3.2] | **Use** |
| 3M VHB 4941 family | 1.1 mm | chart: "generally good" to ≈ ⅓ of the way past 39–38 dyn/cm [img: E4.1] | TDS not retrieved | fallback |
| 3M VHB 4910 | 1.0 mm | general-purpose acrylic; 3M says the family bonds "well to high (HSE)" materials, incl. "easier to bond paints and plastics"; 4910 is not on the MSE chart [V: E6] | normal tensile 690 kPa, dynamic overlap shear 480 kPa, 90° peel 26 N/cm [V: E6] | **No** (specified for HSE; ABS/PC are MSE) |
| RP family (RP45 …) | — | chart bar ends just past 39–38 [img: E4.1] | TDS not retrieved | not assessed |

- **T-peel:** neither the 5952 nor the 4910 sheet gives a T-peel value, only 90° peel [V: E3.2, E6]. The only
  T-peel curve found is for F-9473PC in the cold bulletin [V: E8].
- **Design values:**
  - **dynamic: 85 kPa (12 psi)**, "a useful design factor … for most dynamic stresses" [V: E3.3]. For the glazing
    tapes 3M states that this value "provides a safety factor of >5" [V: E7]. I apply 85 kPa to 5952 as the
    allowable stress [A].
  - **static: 57 cm²/kg** [V: E3.3].
- **Substrates behind those numbers.** The typical strengths were measured on aluminium or stainless steel. No
  value for PC or ABS was found, so the "SF vs 480 kPa" column below is an **upper bound** [A].

### 3.3 Load cases and safety factors [calc]

Inputs:
- pad 32 (y) × 36 (z) mm, A = 11.52 cm²;
- section moduli: Z about the vertical axis = 6.14e-6 m³, about the horizontal axis 6.91e-6 m³;
- rigid-pod linear stress model [A]. Real VHB peel stresses peak at the edges, so treat the results as
  optimistic.

Loads:
- 30 g pod at 20 g = **5.89 N** [calc] (20 g and 30 g are the task's inputs [A]);
- finger load **20 N** (task input [A]). This is about 2× MIL's 11 N maximum button force [V: E1.18].

| Case | σ tension | τ shear | σ / 85 kPa | SF vs 480 kPa (Al, typical) |
|---|---|---|---|---|
| 20 g shock, pull-off normal | 5.1 kPa | — | 0.06 | 94 |
| 20 g shock, in-plane, CoG 11 mm off bond | 10.5 kPa | 5.1 kPa | 0.12 | 46 |
| Static 30 g dead load | needs 1.71 cm² (57 cm²/kg) → pad is **6.7×** | | | |
| CAM push 20 N normal, 6 mm off-centre | ≈ 2 kPa (net) | — | 0.03 | > 200 |
| Knob push 20 N inward (in-plane), axis 14 mm off bond | 45.6 kPa | 17.4 kPa | 0.54 | 10.5 |
| AUX push 20 N up, 12 mm off bond | 34.7 kPa | 17.4 kPa | 0.41 | 13.8 |
| **Knob snag: 20 N pulled forward at knob tip (33 mm lateral from pad centre = 16 half-pad + 2 skirt gap + 15 knob; was 31, V7)** | **125 kPa** | — | **1.47** | **3.8** |
| *Variant: knob axis forward, 20 N sideways at the top, h = 15 / 23 / 30 mm* | 49 / 75 / 98 kPa | 17.4 | 0.57 / 0.88 / 1.15 | 9.8 / 6.4 / 4.9 |
| *Variant: flat-only pad 19 × 36, knob push inward, axis 14 mm* | 129 kPa | 29 kPa | 1.52 | 3.7 |

Conclusions:
- Shock and the normal button pushes are trivial.
- Lever arms decide everything. Keep every control's line of action ≤ 15 mm from the bond, which is why the knob
  axis is lateral.
- The snag case exceeds 85 kPa. Add a **mechanical back-up that takes forward and peel loads**. Proposal
  [design]: a **2 mm PETG hook lip over the top front edge** of the shell, ≤ 5 mm deep onto the top deck so it
  stays clear of the VOL panel (lateral edge at 18.2 mm from the fan centre, 06 A5). 06 A5 gives ≈ 9.9 mm of
  deck in front of the fan seat [img, ±4 %]; the deck depth at y −16…−48 and the VOL panel's fore-aft position
  are not known; check them on the goggles. The top-edge radius is unknown (06 M6), so print the lip from the
  measurement. 3M itself notes that "periodic use of rigid fasteners" may be needed when stiffness matters
  [V: E3.3]. In addition, the trunk cable acts as a tether if the pod ever comes off. The encoder shaft itself
  is rated 100 N push-pull (BS) [V: E15], so the 20 N snag is a bond problem, not a shaft problem.
- **Assembly force.** 100 kPa over 11.5 cm² = **115 N**, and 2–3× (230–345 N) on rigid parts [V: E3.4; calc].
  Clamp the pod with the goggles supported from inside, not by pressing on the lenses.

### 3.4 Alternatives considered

- **GoPro flat or curved adhesive base.** GoPro gives only "clean, smooth surface (non-porous and non-textured)"
  and 24 h dwell, with no grade, area or load rating [V: E10]. The base is 10.3–14.4 mm tall in community models
  (06c l.41, low confidence). It adds that much lever arm to every push, and the buckle/finger joint adds play
  under button presses [design]. Good for a camera, wrong for a button pod.
- **Clip over the shell edge.** The top front edge is free outboard of the cage, but its radius is unmeasured
  and the deck depth is known only at the fan seat (≈ 9.9 mm, 06 A5 [img]; 06 M6). Used as the **back-up lip**
  above, not as the sole mount.
- **Reclosable fastener (e.g. 3M Dual Lock) instead of VHB** — would make the pod removable. Not assessed: no
  datasheet was retrieved, so no claim (added in verification, V12).
- **Strap mount** (pod on the HDO2 strap near the lug). No drilling and a head-backed push. But the strap is
  elastic, so the pod moves with every press, and the lug area is next to the side ports. No source for strap
  width or thickness. Fallback only.
- **Integrate with the camera adapter** (4 screws in the fan seat). No adhesive. But the screws' strength is
  unknown and the adapter is the designed breakaway (`cad/README.md`, safety order). Coupling the pod to it
  would change the fuse loads. Not recommended for v1.

### 3.5 Bonding procedure [V: E3.4, E5.2, E8, E9, E10]
1. Print the pod base **face-down on the smooth sheet**, so the bonding face is the smooth first layer
   [design]. PETG is a copolyester. "Polyester" sits in the 42–50 dyn/cm column [img: E4.1]; the mapping to
   PETG is [A].
2. Clean both faces with 50:50 IPA/water. Abrade the shell only if it is not a visible or coated surface.
   Priming "can significantly improve initial and ultimate adhesion to many materials such as plastics and
   paints" [V: E3.4]. The design guide lists AP111, AP115, Primer 94 and Primer UPUV but does **not** say which
   one suits which plastic, and refers the choice to 3M Technical Service [V: E9]; picking Primer 94 or AP115 is
   therefore [A]. Primer 94 is solvent-based (flash point −20 °C) [V: E9]; solvents can craze PC [A]. Try any
   primer on a test plaque first (V11).
3. Apply above 10 °C, ideally 21–38 °C, dry with no condensation. Press at ≥ 100 kPa (≈ 115 N) for the pad.
4. No load for 24 h (≈ 90 %), full strength at 72 h. On the "50°F" curve: ≈ 50 % at 24 h and ≈ 70 % at 72 h
   [img: E5.2]; that the curve means "bonded and kept at 10 °C" is my reading of the legend [A].
   "150°F [66°C] for 1 hour" accelerates the bond [V: E3.4], but do not do this with the goggles, whose maximum
   temperature is unknown [A].
5. Removal: heat and peel, as GoPro describes for its mounts [V: E10]. Cold use: VHB stiffens and gets stronger
   down to near its −40 °C glass transition, where impact strength drops [V: E8]. The TR1 is rated only to
   −10 °C, so this is not the limit.

## 4. Caps and knob that print well in PETG and survive

PETG data used (Prusament, printed specimens) [V: E13]:
- yield 47–50 MPa, E 1.5–1.6 GPa (flexural 1.6–1.7), elongation at yield 5.1 %;
- **interlayer adhesion 18 ± 4 MPa**, i.e. ≈ 0.38× in-plane yield [calc];
- notched Charpy 6 (horizontal) vs 3 (vertical) kJ/m²;
- HDT 68 °C.

Rule: **bending strain must run along the layers**, never across them.

Strain allowance: amorphous plastics may be strained to about 70 % of the yield strain for one snap, and to 60 %
of that for repeated use [V: E14]. For PETG that gives 0.7 × 5.1 = **3.6 %** once and **2.1 %** repeated
[calc]. I use **≤ 1.5 %** for printed flexures to cover print variability and fatigue [A]. No PETG fatigue data
was retrieved.

### 4.1 Knob on the EC11 D-shaft
- **Shaft** [img: E11.2]:
  - Ø6 (0/−0.05);
  - flat 4.5 (0/−0.1), 10 mm long from the tip;
  - shaft 20 mm, C1 tip chamfer.

  Same shaft on drawing No.3 (EC11E09244AQ).
- **Bore** [design]:
  - **Ø6.20** with the flat at **4.55** from the round side;
  - print a coupon at 6.10/6.20/6.30 × 4.45/4.55/4.65 and pick the one that slides on with no rotational play;
  - **engagement 8 mm** on the flat. Cutting the shaft is allowed only while ≥ 8 mm of flat remains, i.e. remove
    at most 2 mm from the tip;
  - wall around the bore ≥ 2.5 mm.
  - **Stack-up check (added in verification, V9)** [calc; assumes the encoder body face against a 2.0 mm pod
    wall]: the actuator is 20 mm from the body [V: E11.1], of which the first 7 mm is a Ø7 collar [V: E15] and the
    last 10 mm the flat. Outside the wall that is 18 mm; minus the 2 mm skirt gap, **16 mm enters the knob**: the
    collar for the first 3 mm (needs a Ø7.4 counterbore), the flat from 6 to 16 mm. A 15 mm knob printed
    top-down with a 1.2 mm top skin holds only 13.8 mm, so either cut ≈ 2.2 mm off the shaft (flat engagement
    ≈ 7.8 mm, just under the 8 mm target), stand the encoder ≈ 2 mm further inside, or make the knob H 17
    (still inside MIL's 13–25 mm).
- **Retention** [design]:
  - **M3 cup-point set screw** onto the flat, from a radial M3 nut trap (AF 5.5 + 0.2). It is serviceable: the
    knob comes off for the bay door;
  - add threadlocker if it loosens;
  - press-fit alone: no (PETG creep, glove pull-off);
  - snap collet: no (Z-printed fingers);
  - glue (CA/epoxy): only as a permanent fallback.

  The D-flat gives the "positively and non-reversibly attached" MIL asks for [V: E1.7, E1.13].
- **Shape** [design within V: E1.14, E1.15]:
  - Ø24, H 15 (fingertip grasp H 13–25);
  - **18 serrations**, 1.2 mm deep, about 4.2 mm pitch, all edges R ≥ 1. Detent torque 10 ± 7 mN·m [V: E11.1]
    is under the 32 mN·m limit, so the serrations are there for grip through a glove, not for torque;
  - **2.0 mm** gap from the knob skirt to the pod wall (1.5 mm push travel + 0.5) [calc].
- **Print:** top face down, bore vertical, no supports, 4+ perimeters so the serrations are solid perimeter.
  Matte, as printed [V: E1.9].

### 4.2 Tactile caps on a flexure tongue (recommended) [design]
- The tongue is cut into the pod wall, printed **flat in XY**, so it bends along the layers.
- The tongue is a type-1 rectangular cantilever: y = 0.67 ε l²/h, P = (b h²/6)(E ε/l) [V: E14 Table 1].
  - l = 15 mm, t = 1.0 mm, w = 10 mm, E = 1.6 GPa [V: E13].
  - **Free gap 1.75 mm** from the cap boss to the B3S plunger (plunger Ø3.3, stands 0.9 mm proud, ±0.3 mm
    tolerance [img: E12.2]).
  - At contact: strain 1.16 %, spring force ≈ **2.1 N** [calc].
  - **Corrected (V4).** The tongue keeps bending through the 0.25 mm pretravel, so at the click it is deflected
    2.0 mm: spring ≈ **2.36 N** (2.21–2.51 N for E 1.5–1.7 GPa), strain 1.33 %. Add the B3S-1000 operating force,
    which has only a maximum (≤ 1.57 N) [V: E12.1]: click **≈ 2.4 N + OF ≤ 3.9 N** (was "≈ 3.6 N"). It meets
    2.8 N whenever OF ≥ 0.45 N [calc].
  - **Travel.** Nominal 1.75 + 0.25 = 2.0 mm = **exactly** MIL's minimum [V: E1.18]. With pretravel 0.25 +0.2/−0.1
    [V: E12.1] and ±0.3 mm on the switch height [V: E12.2], travel spans ≈ 1.6–2.5 mm [calc]. To be ≥ 2 mm
    for every build, set the gap ≥ 2.05 mm on the shim; at l = 15 that pushes strain to ≈ 1.5–1.7 % at the click,
    over the 1.5 % limit. A **l = 18 mm** tongue with a 2.25 mm gap gives ≈ 1.15 % and ≈ 1.7 N + OF at 2.5 mm
    [calc] — use it if the pod face has room (it must also carry the cap, see P6/P7).
- The dome snap stays the tactile cue that MIL requires [V: E1.17]. How clear it feels on top of the 2 N spring
  ramp is **untested** [A].
- **Tolerance stack.** ±0.3 mm on the B3S height [V: E12.2] plus print error. Make the gap adjustable: a printed
  shim, or a boss with a Ø3.5 × 0.6 mm centring pocket, sized on the first print.
- **Cap tops** (shapes meet ≥ 13 × 13 × 6.5 [V: E1.7]):
  - **CAM:** Ø20 round, top **concave** (spherical dish 1.0 mm deep) [V: E1.17]; stands 6.5 mm proud of the
    tongue face.
  - **AUX:** **19 × 19** square (was 16 × 16, V5: 16 mm meets only the 15 mm flash-glove footnote, not the
    19 mm gloved column [V: E1.18]) with 3 raised ridges 0.8 mm. Square vs round is the shape code; ≤ 10 shapes
    [V: E1.6]. Packaging is tight: a 15–18 mm tongue plus half a 19 mm cap is 24.5–27.5 mm on a 24 mm deep
    underside [calc] — run the tongue laterally (along y, 32 mm) instead.
- **Guard [design].** A fence around the CAM cap, 1.5 mm below the cap top, against brush hits. Fully
  "contained" per E1.10 b would defeat the gloved finger. A false CAM press only toggles the camera.
- **Fallback:** a separate captive cap with a flange under the wall (0.3 mm radial clearance, no glue) sitting
  directly on the plunger. This gives only 0.25 mm travel and ≤ 1.57/2.26 N, and does not meet MIL.

### 4.3 Lid and housing [design]
- Lid fixing: **M2 screws** into PETG bosses (pilot about Ø1.7, to be checked on a coupon) [A]. Not Z-printed snap hooks:
  interlayer adhesion is 18 MPa against 47 MPa in-plane [V: E13].
- If snaps are wanted, make them in-plane, type 1: with l = 12, t = 1.2 and undercut 0.8 mm, ε = 1.0 %. With
  l = 8 the strain would be 2.25 %, too high for repeated use [calc, E14].
- Walls ≥ 1.6 mm (4 × 0.4 perimeters); base 2.0 mm (it is the bond face and carries the contour).

## 5. Parameters for CAD (pod v0.1)

| # | Parameter | Value | Basis |
|---|---|---|---|
| P1 | Pod footprint on front face | y −16…−48, z full 36 of 39 mm; base contoured to the measured face | [design]; 06 B1, B2 |
| P2 | Pod depth (off face) | ≈ 24 mm; keep its front ≥ 3 mm behind the lens front plane | [design] |
| P3 | Bond | 3M VHB 5952, 1.1 mm, full base 32 × 36 (≥ 11.5 cm²) | [V: E3]; [calc] §3.3 |
| P4 | Back-up hook lip | 2 mm thick, ≤ 5 mm onto top deck, outboard of y −16 | [design]; needs M6 |
| P5 | CAM cap | Ø20 round, concave 1.0 mm, 6.5 mm proud, on forward face, centre **≥ 6 mm inboard** (y ≤ −26) for ≥ 13 mm to the knob | [V: E1.3, E1.7, E1.17, E1.18] + [design]; V6 |
| P6 | AUX cap | **19 × 19** square, 3 ridges 0.8 mm, 6.5 mm proud, on underside, inboard of centre | [V: E1.6, E1.7, E1.18] + [design]; V5 |
| P7 | Cap flexure | l 15 (18 preferred), t 1.0, w 10 mm, printed XY; free gap 1.75 mm nominal, shim to ≥ 2.05 mm (2.25 with l 18) | [calc] from E13, E14; V4 |
| P8 | Expected button feel | ≈ 2.4 N + OF (≤ 1.57 N) ≤ 3.9 N; travel 2.0 mm nominal (1.6–2.5 with tolerances) at gap 1.75 | [calc]; MIL 2.8–11 N, 2–6 mm; V4 |
| P9 | Encoder | **EC11E09244AQ** (18 det., 1.5 mm push — still < 2 mm, force unknown) or BS (0.5 mm, 6 N); alternative Bourns PEC11R 12 det. (30°), IP40 | [V: E11.1, E15, E16]; V2, V3 |
| P10 | Knob | Ø24 × H15 (H17 if the shaft is not cut, §4.1), 18 serrations 1.2 deep, R ≥ 1; axis lateral (−y), 14 mm off face | [V: E1.14, E1.15] + [design]; V9 |
| P11 | Knob bore | Ø6.20 / flat 4.55 (coupon ±0.1), 8 mm engagement, M3 set screw + nut trap AF 5.7 | [img: E11.2] + [design] |
| P12 | Knob skirt gap | 2.0 mm | [calc] |
| P13 | Control spacing | target ≥ 25 mm gloved [V: E1.18] is **not reachable** on this pod (CAM–AUX ≤ ≈ 20–23 mm along the surface); rely on separate faces + raised ribs as barriers [design, HIDH E2.1 allows barriers]; minimum ≥ 13 mm bare between any two controls [V: E1.3] | V6 |
| P14 | Lid | M2 screws; snaps only in-plane, ε ≤ 1.5 % | [V: E13, E14] + [A] |
| P15 | Pod mass budget | ≤ 30 g including caps and knob | task [A] |

## 6. Tests before freezing the CAD
- **G1 Gloves:** print a cap/knob coupon with:
  - caps Ø15/19/22;
  - edge gaps 15/25/35 mm;
  - square vs round shapes;
  - knob Ø20/24/28.

  Then, wearing Adam's actual winter gloves, without looking: find CAM in under 1 s, tell AUX from CAM,
  turn exactly one detent (extends `05` §8 item 10).
- **G2 Flexure:** 10,000 presses on a printed tongue; check for set (gap change) and cracking (no PETG fatigue
  data retrieved).
- **G3 Bond:** VHB 5952 on a scrap of ABS/PC, and if possible on a similarly coated surface. Snag-pull 20 N
  at 33 mm lever after 72 h, at room temperature and at 0 °C.
- **G4 Encoder:** measure the EC11E09244AQ push force (its product page was not retrieved; the BS page gives
  6 (+2.5/−2) N [V: E15]). If 30° detents matter more than IP rating, also try a Bourns PEC11R 12-detent part.
- **G5 Goggles (with `06` M6):** front-face profile from y −10 to −65, top-edge radius, Expansion Bay door
  opening, shell finish (paint or bare, textured or not).

## 7. Sources

### Retrieved and read (in `papers/`)
| File | Document | Used for |
|---|---|---|
| `pod_MIL-STD-1472H_2020_human_engineering.pdf/.txt` | MIL-STD-1472H, 15 Sep 2020 (everyspec) | E1 (controls, gloves, coding) |
| `pod_NASA_HIDH_SP-2010-3407_Rev1.pdf/.txt` | NASA HIDH, SP-2010-3407 Rev 1 (nasa.gov) | E2 (barriers, glove tactility) |
| `pod_3M_VHB_5952_TDS_2022-10.pdf/.txt` | 3M VHB 5952 TDS, Oct 2022 (multimedia.3m.com) | E3 |
| `pod_3M_VHB_5952_TDS_2019-04_startsafety.pdf/.txt` | 3M VHB 5952 TDS, Apr 2019 (mirror) | E4 surface-energy chart |
| `pod_3M_VHB_5952_TDS_2024-08_digikey.pdf/.txt` | 3M VHB 5952 TDS, Aug 2024 (Digi-Key mirror) | E5 bond build vs time |
| `pod_3M_VHB_4910_TDS_2018-08_tbp.pdf/.txt` | 3M VHB 4910 TDS, Aug 2018 (TBP Converting reprint) | E6 |
| `pod_3M_VHB_SGT_B23F_G23F_TDS_2014.pdf/.txt` | 3M VHB Structural Glazing Tapes TDS, Aug 2014 (3M) | E7 design strengths |
| `pod_3M_VHB_cold_temperature_bulletin_2002.pdf/.txt` | 3M VHB Cold Temperature Performance, 70-0707-3991-0 (Ellsworth mirror) | E8 |
| `pod_3M_VHB_tape_design_guide.pdf/.txt` | 3M VHB Tape Design Guide (3M) | E9 |
| `pod_Alps_EC11E_catalog_2510.pdf/.txt` | Alps Alpine EC11E catalog, update 2510 (tech.alpsalpine.com) | E11 |
| `pod_place/alps_EC11E09244BS_detail.txt` | Alps EC11E09244BS product page (already in `papers/pod_place/` from another pod track; read in verification) | E15 (push force, push-pull strength, Ø7 collar) |
| `pod_bourns_PEC11R.pdf/.txt` | Bourns PEC11R datasheet REV. D04/26 (already in `papers/` from another pod track; read in verification) | E16 (12-detent alternative) |
| `pod_Prusament_PETG_TDS_v1.1_2022.pdf/.txt` | Prusament PETG TDS v1.1 (copy, Prusa header) | E13 |
| `pod_Bayer_SnapFit_Joints_for_Plastics_2005.pdf/.txt` | Bayer "Snap-Fit Joints for Plastics" (SparkFun copy) | E14 |
| `ctrl_omron_B3S.pdf`, `gopro_AACFT-*.txt`, `FatShark_HDO2_Manual_RevC.txt` | already in repo, re-read | E10, E12; manual l.161 |
| `pod_ergo_img/*.png` | my renders of image-only pages and drawings (MIL p.34/70/71, 3M charts, Alps drawings, B3S drawing, Bayer Table 1) | [img] values |

### Not retrieved (no claims rest on these)
- **NASA-STD-3001 Vol. 2:** not downloaded. HIDH (its companion handbook) was used instead.
  https://standards.nasa.gov
- **DTIC ADA256894, "Gloved Operator Performance Study":** https://apps.dtic.mil/sti/pdfs/ADA256894.pdf
  returned HTML (blocked) again on 2026-11-03. Adam, please fetch it if gloved spacing data beyond MIL is wanted.
- **Thompson, Meyer, Sandor, Holden 2009** (gloved cursor-control study cited by HIDH): not searched or
  retrieved.
- **3M VHB 4941 TDS:** not downloaded (3M Canada product page b40072028 links it). **3M VHB RP45 / RP-family
  TDS:** not downloaded. Only their positions on the E4 chart are used.
- **3M "Surface Preparation for 3M VHB Tape Applications"** (70-0704-8701-5): not retrieved.
- **Alps EC11E formal specification:** not retrieved; the catalog says to obtain it [V: E11.1]. The BS
  product page (E15) gives push force and push-pull strength for the **BS** only. **Alps EC11E09244AQ product
  page** (https://tech.alpsalpine.com/e/products/detail/EC11E09244AQ/): not retrieved, so the AQ push force is
  unknown.
- **3M Dual Lock datasheet** (reclosable alternative to VHB): not searched or retrieved; no claim made.
- **HDO2 shell material and finish:** no source (the manual is silent). **GoPro adhesive grade, area and load
  rating:** no source.
- **PETG fatigue data** for printed flexures: not retrieved.
- **MIL-STD-1472G:** not needed (superseded by H, which was read).

## 8. Self-check (claims against sources)
- **Pages.** All MIL values were re-read in the text extract (p.27, 31–33, 35–36, 47, 66–67, 72–73, 80–81) or
  in the rendered images (p.34, 70, 71). Printed page = PDF page − 17, checked on p.72 (PDF 89).
- **Figure 14 inconsistency** (gloved fingertip 19 mm vs footnote "+5 mm" = 15 mm) is reported, not resolved.
  The report uses 19 mm. (Verification V1: Table VII gives 19 mm for arctic mittens and 15 mm for flash gloves.)
- **85 kPa ">5" scope.** The ">5" safety-factor statement is quoted only from the glazing-tape sheet (E7) and
  flagged [A] when applied to 5952.
- **Arithmetic** re-run in Python: A = 11.52 cm², Z = 6.144e-6 / 6.912e-6 m³ (flat-only pad 2.166e-6), F = 5.886 N, the stresses in
  §3.3, flexure 2.06–2.13 N, snap strains 2.25/1.44/1.0 %.
- **Superseded advice.** `05` §3's caps ≥ 12 mm and centre spacing ≥ 18 mm (tagged [design] there) are below the MIL
  gloved values. This report supersedes them **for the pod design only**. `05` itself was not edited.

## 9. Verification (adversarial check, 2026-11-03)

Every numeric claim was re-checked against the files in `papers/` (text extracts re-grepped, image-only pages
and drawings re-opened, chart bar ends re-measured in pixels). Arithmetic was re-run in
`/tmp/claude-1000/pod_research/verify-ergo/check.py` (scratch, not part of the repo). **Confirmed as quoted:**
all MIL-STD-1472H values and page numbers (Fig. 1 p.34, Table III p.32, Table IV p.32–33, §5.1.1.6 p.35,
§5.1.1.7.4 p.35–36, Table VII p.47, Fig. 6 p.66, §5.1.4.1.1.1.9 p.67, p.70–71 images, Fig. 10 p.72, Fig. 11 p.73,
§5.1.4.2.1.1 p.80, Fig. 14 p.81; PDF = printed + 17 checked on p.72 and p.81); HIDH quotes and pages
(969, 1019, 1023, 1122); 5952 TDS 2022 values and page split; 4910 values; glazing-tape ">5" scope; cold
bulletin −40 °C; design guide p.8/p.17; GoPro text; EC11E catalog rows and drawing No.3; B3S force, pretravel,
±0.3 mm note and 4.3/3.4 mm heights; Prusament PETG values; Bayer 70 %/60 % rules and Table 1 formulas; 06 B1,
B2, A5 values; `camera_mount.scad` l.51 (12.95). Arithmetic confirmed: A, Z, 5.886 N, all §3.3 rows except the
snag lever, 1.71 cm²/6.7×, 115/230/345 N, contact strain 1.16 % and 2.06 N, snap strains, serration pitch,
3.6 %/2.1 % strain allowances.

| # | Where | Was | Now | Why |
|---|---|---|---|---|
| V1 | TL;DR 1, §1.1 | "Every gloved value is for thin cotton flash gloves" | MIL ties only Fig. 14's diameters to flash gloves (+5 mm → 15 mm); Table VII's 19 mm is for **arctic mittens**; the 25 mm gloved separation names no glove | Overclaim; Table VII columns re-read (E1.11) |
| V2 | TL;DR 2, §1.2, P9, G4 | EC11E09244BS push force "not in catalog"; AQ presented as the fix | BS force **6 (+2.5/−2) N** and push-pull 100 N are on the Alps product page already in `papers/pod_place/`; AQ 1.5 mm **still < 2 mm** and its force is unknown | Source in repo was missed; "fix" overstated |
| V3 | §1.2, P9 | No alternative to 20° detents | Bourns PEC11R 12-detent (30°) with published push force, M7 panel bushing, but IP40 | Missing obvious alternative; datasheet already in `papers/` |
| V4 | TL;DR 2, §4.2, P7, P8 | Click ≈ 3.6 N, travel ≈ 2.0 mm "inside MIL" | Spring at click is 2.36 N (tongue deflects 2.0 mm, not 1.75) → ≤ 3.9 N; travel 2.0 mm nominal = exactly the minimum, 1.6–2.5 mm with tolerances; shim to ≥ 2.05 mm or use l = 18 mm | Arithmetic error + tolerance stack ignored |
| V5 | TL;DR 3, §4.2, P6 | AUX cap 16 × 16 | 19 × 19 | 16 mm is below the report's own 19 mm gloved floor |
| V6 | TL;DR 3, §2, P5, P13 | "Each pod edge acts as a barrier [V: E2.1]"; ≥ 25 mm achievable | Barrier reading is [design]; ≥ 25 mm is not reachable (CAM–AUX ≤ 20–23 mm); CAM–knob ≈ 8 mm if CAM centred (< 13 mm bare) → CAM ≥ 6 mm inboard | Tier inflated; geometry not checked |
| V7 | TL;DR 5, §3.3, G3 | Snag lever 31 mm → 118 kPa, 1.39×, SF 4.1 | 33 mm (16 + 2 gap + 15) → **125 kPa, 1.47×, SF 3.8** | Skirt gap omitted from lever |
| V8 | §2 knob | Knob "in front of the Expansion Bay door" | Overlaps the door span by ≈ 2 mm only (door from y ≈ −62.7) | 06a pixel coordinates |
| V9 | TL;DR 7, §4.1, P10 | Knob H 15 with 8 mm engagement, no stack-up | 20 mm shaft (Ø7 × 7 collar) gives 16 mm into the knob; 15 mm blind bore holds 13.8 → cut ≈ 2.2 mm or H 17 | Packaging inconsistency |
| V10 | §2 clearances | "Knob must clear the M5 head"; lens plane unchecked | Knob is 36+ mm from the M5 head; the **pod's inboard corner** (≈ 2 mm) is the item to check; lens fronts ≈ 47.7/59.5 mm ahead of the face vs pod ≤ 30.5 | Wrong element; computed from scad params (all [A]) |
| V11 | §3.5 | "Primer 94 / AP115" for plastics, quote attributed loosely | Guide lists 4 primers without substrate mapping; choice is [A]; Primer 94 solvent-based | Claim not in source |
| V12 | §3.2, §3.4 | 4910 "HSE only"; chart "two-thirds"; 24 h ≈ 95 %; deck depth "unmeasured"; no reclosable option | 4910 "specified for HSE"; 5952 bar reaches the 37–36 column (x 685 vs label 684 px); room-temp 24 h ≈ 90 %; deck ≈ 9.9 mm at the seat (06 A5); Dual Lock listed as not assessed | Re-measured / re-read |
| V13 | TL;DR 7 vs P14; §1.2; Fig. 6 | Snap strain ≤ 1 % vs ≤ 1.5 %; 05 "spacing"; 30° borrowed silently | Harmonised to ≤ 1.5 %; 05 is *centre* spacing; Fig. 6 also sets 115–680 mN·m and ≤ 12 blind positions for selectors — noted | Consistency |

**Still unresolved after verification:**
- No encoder found meets MIL's 2 mm push travel; AQ force unknown (product page not retrieved).
- The ≥ 25 mm gloved separation cannot be met on a 32 × 36 × 24 mm pod; whether separate faces + ribs are enough
  is only testable with G1 (Adam's gloves).
- The flexure travel sits at the 2 mm minimum; whether the B3S snap is still felt through a ≈ 2.4 N spring ramp
  and a winter glove is untested.
- The 85 kPa allowable, the rigid-pad stress model and every substrate-dependent number remain [A] until G3 on
  real ABS/PC (and the HDO2 shell's actual finish).
- All goggle geometry (B1/B2/A5, door position, front_x, M5 head position) is [img]/[A] until M6 is measured.
- Fig. 14's 19 mm vs 15 mm conflict is in the standard itself and cannot be resolved from the text.
