# 01: Camera position relative to the eyes, and latency, for walking in fully occluded video see-through

> **Status: working draft, 2026-11-03.** `ZALOZENIA.md` is the governing document; where this file disagrees with it, or with a later bench measurement, those govern.
> Verbatim quotes, with IDs such as **M6** and **H2**, are in `papers/extracts_placement.md`.
> **Tags:**
> - `[V: papers/<file>, p.X]`: read at source; the quote is in the extracts file.
> - `[V2: … citing X]`: read at source, but the source is reporting someone else's study, and that study was **not** retrieved.
> - `[C]`: my own geometry, with inputs and assumptions given (script below).
> - `[A]`: an assumption that must be measured.
> - `[I]`: my inference, not a finding of any paper.

## TL;DR (recommendations for THIS build)

1. **Mount the camera on the HDO2 front, centred between the eyes, with the thermal lens as close to eye height as possible (0 to +35 mm). Do not mount it on top of the helmet.** One helmet-mounted walking study found that moving the sensor *forward* (17.8 cm) cost almost nothing: +2.9 % course time and 21.6 % *fewer* errors. Moving it *up* cost +14.2 % time and +14.3 % errors. Moving it up *and sideways* was worst: +16.1 % time and +19.9 % errors [V: Mullins 2008, p.5–6, M6/M7]. Forward offset is the cheap axis and vertical is the expensive one. Lateral offset should also be avoided, but no retrieved study isolates a single-camera lateral offset, so "lateral is worse than vertical" is not established (§2.3).
2. **Stack the two camera heads vertically, not side by side: thermal at eye height, Infra directly above it.** Side by side would put each camera about 10 mm off the centre line. Lateral offset caused errors in all three military sources: the combined vertical-plus-lateral "center" position was worst in Mullins, and the paper attributes this to straight-ahead objects actually lying to one side [V: Mullins 2008, M6/M9]. A side-mounted sensor gave a blind-pointing error opposite the sensor side [V2: Rash 2009 p.823 citing Melzer & Moffitt 2007, H3]. In the NVG study, the horizontal (hyperstereo) component caused most of the throwing error [V: CuQlock-Knapp 2001, C1/C5]. None of these tests a pure single-camera lateral shift. Stacked, the Infra camera sits about 20–25 mm higher. The module faces are 19.5 mm (thermal) and 20 × 20.5 mm (Infra) [V: shop page, S2]; the gap between them is [A]. That is still inside the 35 mm vertical limit from hand–eye work [V: Park 2008, p.46, P1].
3. **Hold the camera's yaw boresight within 0.5° of the display axis.** With a horizontal camera-to-display error, subjects "walked in an arc, rather than in a straight line" [V2: Rash 2009 p.823 citing Melzer & Moffitt 2007, H2]. Over a 20 mm mounting base, 0.5° is 0.17 mm [C], so the printed mount needs a keyed, rigid interface or a lockable fine-yaw adjustment. Fixing the camera to the goggle shell rather than the helmet keeps camera and display rigidly coupled [I].
4. **Camera position is not the biggest geometric error in this system. The FOV mismatch is.** The thermal image shows at about 0.73–0.75× (HDO2 46° is *diagonal*, ≈37.5° H) [V: HDO2 manual p.11, F1; C]. A point 15° off-axis appears about 4° off, while camera offsets at 1.5–6 m give 0.2–3.3° [C]. Track 02 (`02_fov_magnification_locomotion.md`) owns the FOV question. This file only ranks the two.
5. **Measure glass-to-glass latency before any walking trials, for both cameras and for camera switching.** Video passthrough at 29 ms was measurably worse than at 14.3 ms or 2 ms for catching and reaction [V: Penner 2026, p.1/p.6, Pn2/Pn6]. Penner gives 12–60 ms as the usual end-to-end latency of "modern devices", meaning HMDs in general [V: Penner 2026, p.1, Pn1]. **No retrieved study gives a latency threshold for walking**, so treat "as low as the analog chain allows, and known" as the requirement. The 20 ms camera figure is the shop's claim, and the HDO2's AV-to-OLED delay is unknown.

---

## 1. What is being decided

- **Display:** HDO2. The same PAL CVBS frame goes to both eyes, so the display is **biocular**: one sensor, no stereopsis. Rash describes the same situation for a single thermal sensor, "repeated to both eyes, which results in a biocular HMD system" and "with no stereopsis" [V: USAARL_HMD2009 Ch.4, p.115, H5].
- **Candidate camera positions.** All offsets are relative to the eyes (vertical Δy, forward Δz, lateral Δx). The numbers are rough geometry, not yet measured on Adam's head, helmet and goggles [A]:

| Position | Δy (up) | Δz (forward) | Δx (lateral, from centre line) |
|---|---|---|---|
| A. HDO2 front plate, centred, lens at eye height | ≈0 | ≈+80…100 mm (goggle depth plus module length) [A] | 0 (thermal); Infra stacked above at Δy ≈ +20–25 mm |
| B. HDO2 top edge, or helmet brim just above the goggle | ≈+50…70 mm | ≈+50…70 mm | 0 |
| C. Helmet front, high (GoPro VHB on the shell) | ≈+90…120 mm | ≈+40…60 mm | 0 |
| D. Helmet top | ≈+150…200 mm | ≈0…+30 mm | 0 |
| E. Helmet side (GoPro-style) | varies | varies | ≈±80…100 mm |

## 2. Findings

### 2.1 Forward offset (Δz) is the cheapest axis for locomotion

- **Mullins 2008 (ARL/NVESD) is the closest match to this project.** A Sony *day* camera with a 40° FOV and a monochrome Kopin microdisplay were mounted on the helmet. The display was over the preferred eye and the other eye was patched [V: Mullins 2008, p.3–4, M3/M11]. The course was lit: the Fig. 2 layout gives 190–359 lux [V: p.4, M12]. So this is a viewpoint-offset study, not a night or thermal one. Seventeen participants walked an indoor mobility course "Obstacles included furniture, windows, doorways, steps, and a ramp" [V: p.1, p.4, M2/M5]. Against the "front" position (camera directly in front of the display), the "front forward" position (camera shifted forward 17.8 cm) took only **+2.9 % time**, and errors (stumbles etc.) **fell by 21.6 %** [V: p.5, M6]. The paper does not report the front-forward vs front difference (time or errors) as significant. The significant pairwise results are the vertical-offset positions against both front positions [V: p.6, M7].
- **Close-in hand task in the same study** (touching lit posts): +8.3 % time for front-forward, against +22.8 % for above and +34.2 % for centre [V: p.6, M8]. So forward offset costs more within arm's reach than when walking, but vertical offset still costs more.
- **Park 2008 (video see-through, hand–eye tasks):** depth displacements of 130, 165 and 200 mm did not differ significantly: "No significant effects of depth displacement were found during this experiment" [V: p.51, P4]. **Scope:** this compares 130, 165 and 200 mm *with each other*, between subjects (20 per level [V: P6]). No displaced-camera condition at 0 mm depth was tested, so it does not show that forward offset is free compared with none.
- **Forward offset does have an effect in the near field.** In Rolland 1995 the virtual eye was moved 165 mm forward and 62 mm up. While wearing the HMD, subjects "tended to point short of the target" in the forward axis and "point downward" in the vertical axis. The manual task "took 43% longer" (the abstract words this as speed "decreased by 43%") [V: Rolland 1995, p.56/p.64, R1–R4, R8]. Edwards 1993 notes the same qualitatively: cameras in front of the eyes make the world "appear magnified and closer than they actually are" [V: Edwards 1993, p.225, E2].
- **Geometry check** (camera at eye height and Δz = +80 mm; eye height 1.65 m; ground target) [C]:

| Ground distance | 0.7 m | 1.5 m | 3 m | 6 m |
|---|---|---|---|---|
| Angular error | 2.4° | 1.6° | 0.7° | 0.2° |
| Apparent-distance bias (ground-angle model) | −11 % | −5 % | −3 % | −1 % |

  Foothold selection works mostly about 2–3 steps ahead [V: Bonnen 2021, p.1/p.3, B2/B4], roughly 1.5–3 m [I]. At that range the forward offset of position A gives about 1–2° and about 3–5 % [C].

### 2.2 Vertical offset (Δy) costs measurably in walking; keep it at or under ~35 mm

- **Mullins 2008:** "above" (sensor vertically above the display) gave +14.2 % course time and +14.3 % errors. "Center" (above *and* lateral) gave +16.1 % time and +19.9 % errors [V: p.5, M6]. Participants ranked "above" third and "center" last by majority [V: p.6, M8b]. **Gap:** the paper does not state the size of the vertical offset in mm. It appears only in photographs (Fig. 1).
- **Melzer & Moffitt 2007, via Rash 2009:** with the camera aligned, the high-mounted sensor "gave an indication of a slated [sic] floor" [V2: USAARL_HMD2009 Ch.17, p.823, H3]. The original SPIE paper was not retrieved.
- **Edwards 1993:** cameras above or below the line of sight "can be hard to get used to when objects are close and can cause disorientation when walking" [V: p.225, E1].
- **Park 2008** gives the only quantitative bound found, from hand–eye tasks at about arm's length: "cameras should be placed above or below eye level, but by no more than 35 mm". Performance at 70 mm was significantly worse than at 35 mm [V: p.46, p.51, P1/P2]. **Caveat:** 35 mm *beat* exactly eye level in their setup, because at eye level the hand hid the target [V: p.51, P3]. That mechanism does not apply to walking [I]. Read the result as "≤35 mm costs little", not "35 mm is better than 0".
- **Counter-evidence for distant targets:** a purely vertical 3-inch (76 mm) viewpoint displacement on binocular NVGs produced **no significant** grenade-throw error at 20 ft (6.1 m) [V: CuQlock-Knapp 2001, p.4/p.8/p.11, C2/C3/C5]. Two things limit this. First, the displacement was *downward* ("Viewpoints displaced Vertically downward only" [V: p.6, C4]), the opposite sign to every helmet position here. Second, there was no adaptation period [V: p.16, C6]. Vertical offset seems to matter most for near and ground targets, which is exactly where footholds are [I].
- **Geometry** (ground target; eye height 1.65 m; brain assumed to use eye height and declination angle) [C]:

| Position | 1.5 m | 3 m | 6 m |
|---|---|---|---|
| B (+60 up, +60 fwd) | 2.2° / −7 % | 1.4° / −5 % | 0.7° / −5 % |
| C (+100 up, +50 fwd) | 2.6° / −9 % | 1.9° / −7 % | 1.0° / −7 % |
| D (+180 up, +20 fwd) | 3.3° / −11 % | 2.7° / −10 % | 1.6° / −10 % |

  Position A gives 1.6° / 0.7° / 0.2° at the same distances. Vertical offset makes the ground look closer by a bias that *does not fade with distance*. Forward offset fades with distance. This fits the "slanted floor" report [I].

### 2.3 Lateral offset (Δx): avoid it; with a biocular display, "centred" means centred between the eyes

- **CuQlock-Knapp 2001:** "the horizontal component of a mixed horizontal and vertical offset NVG design accounts for most of the errors in performance". Purely vertical displacement was not significant [V: p.4/p.11, C1/C5]. Their horizontal offsets were binocular hyperstereo, about 3 in per eye [V: p.8, C3]. A single biocular camera cannot create hyperstereo [I]. **So this study does not measure a single-camera lateral shift.** It cannot by itself rank lateral offset above vertical for this build.
- **Mullins 2008, "center" position:** "objects in the environment that appeared to be straight ahead were actually positioned to one side of the participant" [V: p.8, M9]. **This does not transfer one-to-one to this project.** In Mullins the display was over *one* eye, so a camera centred between the eyes was laterally offset from the viewing eye [V: p.3, M3/M4]. With a biocular HDO2, the visual direction reference is most plausibly the cyclopean point midway between the eyes, so a centred camera has Δx ≈ 0 [I, not tested in any retrieved paper]. Test this explicitly (§4).
- **Melzer & Moffitt (via Rash):** a side-mounted sensor "produced a blind pointing error that was opposite of the sensor location" [V2: Ch.17 p.823, H3].
- **Geometry:** each 10 mm of lateral offset is 0.57° at 1 m and 0.19° at 3 m. A GoPro-style side mount (≈±90 mm) would be about 5° at 1 m [C]. **Conclusion:** if both camera heads go on the front, stack them vertically rather than side by side [I].

### 2.4 Boresight alignment (tolerance tighter than position errors [I])

- "the sensor and display must be aligned to within 0.5°. If the alignment error was in the horizontal plane, subjects walked in an arc, rather than in a straight line" [V2: Rash 2009 Ch.17 p.823 citing Melzer & Moffitt 2007, H2]. Their setup was "monocular sensor video" [H2]. A 0.5° yaw error is 87 mm of lateral error per 10 m walked toward an "image-straight-ahead" target [C].
- **Implication for the print** [I]: 0.5° over a 20 mm base is 0.17 mm [C]. That is of the order of FDM layer height and fit clearance in PETG [I, not measured]. Design a keyed dovetail or screw interface with no rotational play about the yaw axis, and boresight once on a far target (§4).
- **Goggle-mounted vs helmet-mounted** [I]: on the goggle, camera and display are one rigid body, so yaw alignment cannot drift when the strap or helmet shifts. On the helmet, alignment depends on where the goggles sit relative to the helmet, and that changes every time they are donned and with sweat. This argument is not from a paper, but it follows directly from the 0.5° tolerance.
- **Pitch** (deliberate down-tilt) is a separate decision. Track 02 recommends about 10° down so that ground nearer than about 5 m is in view. No retrieved study tested a deliberate camera–display pitch offset during walking. The nearest hint is the "slanted floor" from the high mount [V2: H3]. **Open question, test A/B (§4).**

### 2.5 Monocular-to-both-eyes (biocular) vs stereo

- Biocular thermal removes stereopsis [V: Rash Ch.4 p.115, H5]. In natural terrain, disrupting binocular vision caused "a small bias in gaze towards closer footholds" [V: Bonnen 2021, p.1, B1]. Median walking speed did not differ significantly between binocular and disrupted vision [V: Bonnen 2021, p.5/p.7, B6/B7]. **Scope:** Bonnen disrupted binocular vision by blurring one eye with a Bangerter foil [V: B8], not by showing both eyes the same image. The transfer to a biocular display is [I]. Earlier lab work, which Bonnen cites but which was not retrieved, found that with impaired binocular vision people "exhibit slower walking and raise the foot higher when stepping up to or over an obstacle" [V2: Bonnen 2021, p.2, B3].
- **For this project** [I]: losing stereo is a modest cost compared with offset, FOV and resolution. A stereo pair of thermal cores is out of scope. Expect higher toe clearance and a gaze shifted closer to the body.

### 2.6 Adaptation time and aftereffects

- Rolland 1995: pointing errors rose "by several 100%" on donning and fell by about a third during the session. Speed stayed below baseline, and recovery "might take quite a few rounds of extended practice". Negative aftereffects appeared after doffing [V: p.56/p.64/p.65, R2/R5/R6]. The aftereffect runs **opposite** to the errors made on donning. Subjects were "overshooting the target in the pointing task in a direction opposite of the errors they made when they 'entered'" [V: p.65, R7].
- Rash 2009: with the sensor aligned, subjects could re-calibrate "as long as the test subjects were able to view their feet and hands", "albeit with some temporary after effects" [V2: Ch.17 p.823, H3]. Perceptual re-calibration is possible, "though with unknown residual aftereffects" [V: Ch.17 p.838, H4].
- For a different distortion (aviator hyperstereo, TopOwl), subjects reported "an approximate 6-8 hours acclimation period" [V: Ch.12 p.509, H6]. This is a scale reference only and not transferable [I].
- **Practical** [I]: expect a noticeable aftereffect when taking the goggles off at night. The directions follow Rolland 1995, which tested hand pointing rather than stepping; carrying them over to stepping is [I]:
  - **On donning**, with an up/forward camera, errors go low and short [V: R3/R4].
  - **After doffing**, the aftereffect is the opposite: high and long, overshooting [V: R7].

  Do not take off the goggles on a step or a slope.

### 2.7 End-to-end latency (motion-to-photon / glass-to-glass)

- **Modern HMDs:** end-to-end latency is "usually in the range of 12-60 milliseconds" [V: Penner 2026, p.1, Pn1]. Commonly cited targets are "below 15–20 ms". Penner adds that "such numbers are difficult to validate" [V: Penner 2026, p.2, Pn4, citing Elbamby 2018].
- **Penner 2026 (Meta, passthrough with the cameras optically aligned to the eyes [V: p.1, Pn7]):** "2 and 14.3 millisecond latencies are preferred over 23 and 29 milliseconds" for ball catching. "Performance was significantly improved at 2 ms compared to 29 ms across all tasks" [V: p.1/p.6, Pn2/Pn6]. Latency in passthrough misaligns "haptic and proprioceptive feedback" with vision [V: p.2, Pn3]. They also note that FPV video is latency-optimised, but these "mono camera systems do not account for capture or viewing optics" [V: p.3, Pn5].
- **Jerald 2010 (perception of latency-induced scene motion in an HMD, head yaw):** mean difference threshold 16.9 ms (SD 10.4), range 3.2–60.5 ms. A "difference threshold" here is JND-like, not an absolute detection threshold, and it was measured on a simulated HMD with 7.4 ms of base system delay [V: p.106/p.196, J4/J5]. "Latency thresholds decrease as peak head-yaw acceleration increases" [V: p.37/p.145, J1/J2]. The author notes the thresholds may not hold across conditions [V: p.191, J3].
- **Physiology anchor:** the VOR has a latency "of less than 16 ms" [V: Rash Ch.12 p.555, H7].
- **Walking specifically:** an MEng pilot study with Quest 3 video see-through (n = 20) found gait about 0.1 m/s slower than with normal vision [V: Balachandran 2024, p.4/p.68, Ba1/Ba3/Ba4]. Higher knee/hip flexion and marker heights during obstacle clearance were reported in the abstract, pooled across the AR and VR headsets [V: p.4, Ba5]. Statistical power was low by the author's own statement [V: p.4, Ba2]. It does not separate latency from FOV, offset or weight. **No retrieved study measured the effect of a controlled latency change on walking or obstacle negotiation.** I make no claim about a walking-specific threshold.
- **This chain** [A, measure]:
  - camera "Average Latency 20ms" (shop claim [V: shop page, S1]; `ZALOZENIA.md` §1a)
  - plus PAL field timing: 50 fields/s nominal, so a 20 ms field period [V: ITU-R BT.470-6 Table 1, T1; C]
  - plus HDO2 AV decode/scaler/OLED (unknown)
  - plus possibly a GPIO-switch transient when changing camera.

  Expect tens of ms, which is the commercial-passthrough range. Measure it.

### 2.8 Military practice

- ENVG (AN/PSQ-20) and AN/PVS-14 "mount to the front of the Warfighter's helmet, with the entrance aperture in line with the user's eye". Integrating the sensors into the top or sides of the helmet improves weight and CM, but "can create an offset of the sensor aperture with respect to the wearer's normal line-of-sight" [V: Rash Ch.17 p.823/p.838, H1/H4].
- **Weight/CM** [I]: a 19.5 × 19.5 × 20 mm thermal head plus the 20 × 20.5 × 34.5 mm Infra head on the goggle front is small [V: shop page, S2]. The AI Box (33.5 × 33.5 × 16.5 mm) and the battery can go at the back as counterweight (see track 04). The shop lists "Weight 55g" directly after the AI Box size; it is not clear whether that is the box or the whole kit [S1; `ZALOZENIA.md` §1a]. So the CM argument that pushes the military toward top mounts is weak here.

## 3. Ranked recommendation

1. **A: HDO2 front, centred, thermal lens at eye height, Infra stacked directly above (≤35 mm higher).** Shortest vertical offset, zero lateral offset, and rigidly coupled to the display for boresight. Its forward offset (≈8–10 cm [A]) is the axis with the smallest walking cost [V: M6/M7, P4]. Cost: more mass on the front of the goggle, and the cameras move with the goggle (that is the point).
2. **B: HDO2 top edge or helmet brim directly above the goggle** (≈+60 mm up). Acceptable only if A is mechanically impossible. Expect a "ground closer / floor tilted" bias of about 5–7 % and the Mullins-type "above" penalty [V: M6; V2: H3; C].
3. **C/D: helmet front-high or helmet top** (≈+100…200 mm up). Not recommended for walking: largest constant ground-distance bias (≈7–11 %) [C], Mullins "above"-type penalties [V], and boresight drift between helmet and goggle [I].
4. **E: side mount.** Reject. ±80–100 mm of lateral offset gives a direction error of about 5° at 1 m [C]. A side-mounted sensor produced a blind-pointing error opposite the sensor side [V2: H3], and lateral offset shifts "straight ahead" [V: M9].

## 4. Open questions / bench measurements for Adam

**Geometry (with goggles and helmet on, mirror or calliper):**
1. Δx, Δy, Δz from the midpoint between the pupils to each camera's lens front (entrance pupil ≈ lens front for these tiny lenses [A]), for position A and for the planned fallback. This replaces every [A] in §1.

**Boresight procedure:**
2. Put a heat source, such as a mug of hot water or a hand warmer, at 10 m. Centre it in the goggle image using the OSD centre mark, if any, or a printed reticle on a test card. Without moving your head, flip the goggles up and check where the target is with the naked eye. Target: ≤0.5° (≤87 mm at 10 m) yaw and pitch error. Repeat after 5 don/doff cycles to check repeatability (goggle-mounted vs helmet-mounted).

**Glass-to-glass latency:**
3. Put an LED, blinked by the XIAO, in front of the camera. Film the LED and the HDO2 eyepiece together with a phone at 240 fps (4.2 ms resolution), or use a photodiode on the eyepiece and a scope. Do this for:
   - thermal (blink a hot resistor or a Peltier element instead, since the LED is invisible to LWIR, or use a mechanical shutter flag in front of a hot target)
   - Infra
   - **the time from a GPIO switch to a stable image.**

   Report median and 95th percentile. Also log how often and for how long the thermal shutter/NUC freezes the image; it was not found in any retrieved document.

**Walking protocol (after Mullins 2008):**
4. Baseline naked eye in light, then each camera position (A vs B or D, counterbalanced), then a recovery run naked eye.
   - Course: corridor or doorway, 2–3 steps up and down, a kerb step-down, a 15–20 cm obstacle, a 10 m tape line to walk straight (arc detection), and an uneven path.
   - Measures: time; errors (contacts, stumbles, hand-reaching for support) from video; lateral deviation at the end of the 10 m line; toe clearance over the obstacle (side-on video against a grid).
   - 5+ repetitions per condition to see the adaptation curve. Adam is n = 1; add a second person if possible.

**Pointing/aftereffect test (after Rolland 1995):**
5. Point at 5 targets at 0.5–1 m with eyes closed (blind pointing) before, after 20 min of use, and right after doffing. For up/forward camera positions, expect errors going low and short on donning [V: R3/R4]. Right after doffing, expect the opposite: high and long, overshooting [V: R7].

**Distance:**
6. Blind walking to targets at 3, 6 and 10 m seen through thermal. This measures the combined bias from offset and the 0.75× minification [C]. Coordinate with track 02.

**Pitch A/B:**
7. Camera at 0° vs 10° down relative to the display axis, using the course above plus a "does the floor look tilted?" rating. No retrieved study tested this (§2.4).

**Biocular centre check:**
8. With position A, blind-point at a target seen straight ahead in the image. Does the error stay ≈0 laterally, as the cyclopean argument predicts [I]?

## 5. Geometry script

The geometry was computed with `python3` in the session scratchpad. Not saved in the repo; formulas below.
- Angular error of a ground point at distance d: `atan((H+Δy)/(d−Δz)) − atan(H/d)`.
- Apparent distance if the declination angle is read from eye height H: `d' = H / tan(atan((H+Δy)/(d−Δz)))`.
- Inputs: H = 1.65 m [A].
- HDO2: 46° diagonal, 4:3 → 37.5° × 28.6° (rectilinear assumption).
- Thermal: 50° H → centre scale `tan(18.75°)/tan(25°)` = 0.728. An object at θ off-axis is shown at `atan(0.728·tan θ)`: 10° → 7.3°, 15° → 11.0°, 18.6° → 13.8°.

## Retrieved (read at source, in `papers/`)

| File | What |
|---|---|
| `Mullins_2008_ADA505752_indirect_view_viewpoint_offset.pdf` | ARL/NVESD, 4 sensor positions, mobility course plus close-in task (Wayback copy of DTIC) |
| `CuQlock-Knapp_2001_ARL-TR-2407_NVG_viewpoint_offset_grenade.pdf` | ARL, vertical/horizontal/mixed NVG viewpoint offsets (govinfo.gov) |
| `Rolland_Biocca_1995_quantification_adaptation_virtual_eye.pdf` | VRAIS'95; 165 mm forward / 62 mm up virtual-eye displacement, adaptation, aftereffects |
| `Edwards_Rolland_Keller_1993_video_see-through_design.pdf` | VRAIS'93; camera mounting schemes for VST HMD |
| `Park_2008_hand-eye_video_see-through_camera_displacement.pdf` | 15 camera positions, 35 mm vertical bound |
| `USAARL_HMD2009_Section-10-Chapter-4-…`, `…Section-20-Chapter-12-…`, `…Section-26-Chapter-17-…`, `…Section-24-Chapter-16-…` | Rash et al. 2009 HMD book chapters. Ch.16 was downloaded and searched, but nothing from it is cited. |
| `Penner_2026_arXiv2603.15796_low-latency_passthrough_requirements.pdf` | 2–29 ms passthrough latency study |
| `Jerald_2010_latency_perception_thresholds_HMD_UNC_dissertation.pdf` | HMD latency perception thresholds |
| `Bonnen_2021_SciRep_binocular_vision_foot_placement.pdf` | Binocular vision and foot placement in natural terrain |
| `Balachandran_2024_Auckland_MEng_HMD_gait_thesis.pdf` | Pilot gait study, Quest 3 VST vs normal |
| `FatShark_HDO2_Manual_RevC.pdf` | Fetched by another track; only "46 degrees diagonal" used here |
| `bzbuas_tr1-220sl_product_page_en.txt` | Shop page text (camera track); only latency, AI Box size/weight and head dimensions used here (S1/S2) |
| `ITU-R_BT.470-6_TV_systems.pdf` | Fetched by another track; only the 50 field/s PAL field rate used here (T1) |

## MISSING (not retrieved, no claim made on them directly)

- Biocca & Rolland 1998, "Virtual eyes can rearrange your body…", *Presence* 7(3):262–277, doi:10.1162/105474698565703. MIT Press; the UCF STARS record has no PDF. The 1995 conference precursor was used instead.
- Melzer & Moffitt 2007, "Sensor-offset HMD perception and performance", Proc. SPIE 6557, 65570G, doi:10.1117/12.721156. Closed access. Cited only through Rash 2009 Ch.17 ([V2]).
- Lee & Park 2020 (online 2019), "Visuomotor adaptation to excessive visual displacement in video see-through HMDs", *Virtual Reality* 24:211–221, doi:10.1007/s10055-019-00390-0. Closed (Unpaywall: no OA copy). It is **the only eye–foot coordination study found, so it is the most important one to fetch.**
- Lee & Park 2014, "The effects of visual displacement on simulator sickness in video see-through HMDs", ISWC 2014, doi:10.1145/2634317.2634339. Closed.
- State, Keller & Fuchs 2005, "Simulation-based design and rapid prototyping of a parallax-free, orthoscopic video see-through HMD", ISMAR 2005 pp.28–31. The UNC URL (https://www.cs.unc.edu/~andrei/pubs/2005_ISMAR_VSTHMD_design.pdf) returns 404; the Wayback copy is truncated at 1 MiB and unreadable.
- Redden et al. 2005, "Digital enhanced night vision goggles limited user evaluation", ARL-TR-3536. Not found; cited only via Mullins (M1).
- Carstens, Bonnett & Redden 2006, "Enhanced Night Vision Goggle customer test", ARL-TR-3839, DTIC ADA453392 (https://apps.dtic.mil/sti/pdfs/ADA453392.pdf). DTIC was down and the Wayback fetch failed.
- Search turned up no study of controlled latency vs walking or obstacle negotiation in fully occluded video see-through. This is a literature gap, not a missing file.

## Verification (adversarial check, 2026-11-03)

**Method.** Every quote in `papers/extracts_placement.md` (E1–F1, 60+ passages) was normalised for whitespace and line-break hyphens. Each was then searched in the `pdftotext -layout` output in `papers/` and in a fresh plain `pdftotext` run (scratchpad). Each quote's page was located per page with `pdftotext -f N -l N`. All quotes are verbatim, apart from the OCR artefacts already marked [sic] (R2 "113", R6 "l/3", C4 "vi&point", H3 "slated", B4 "◦"). All pdf page numbers are correct. Every number in §2.1/§2.2 (geometry tables), §2.3 (lateral angles), §2.4 (0.17 mm, 87 mm), §4 (4.2 ms at 240 fps) and §5 (37.5° × 28.6°, 0.728, 7.3°/11.0°/13.8°) was recomputed in Python with the stated formulas. All agree within rounding: B at 6 m is −4.5 %, shown as −5 %; C at 6 m is −6.5 %, shown as −7 %.

**Changed in this file:**
1. **Rolland aftereffect direction was wrong.** The report said post-doffing pointing goes "low/short" (§2.6, §4.5, and the researcher summary: "Pointing stayed off after removal: low for a raised camera, short for a forward one"). R3/R4 describe errors *while wearing*. The paper states the aftereffect is "in a direction opposite" (new R7, p.65). Both places are corrected to: low and short on donning, high and long on doffing.
2. **"Lateral is the worst axis" was overstated** (TL;DR 1–2, §2.3 heading, §3 E). No retrieved study isolates a single-camera lateral shift. CuQlock-Knapp's horizontal condition is binocular hyperstereo. Mullins "center" mixes vertical and lateral. Melzer & Moffitt is second-hand and gives no ranking. The recommendation to avoid lateral offset stands; the ranking claim was removed.
3. **"The throw was untimed" (CuQlock-Knapp)** is not supported anywhere in the PDF. Removed. Added that their vertical displacement was *downward* (C4), the opposite sign to this project's.
4. **Bonnen "walking speed did not change" was cited to B5**, which is about terrain. It is now cited to B6/B7. The scope is now stated: binocular vision was disrupted by a Bangerter blur foil on one eye (B8), not by a biocular display. B3 (higher foot clearance) is retagged [V2], since Bonnen is citing earlier lab work.
5. **Balachandran "more cautious obstacle clearance"** had no supporting extract. Added Ba5, and noted that the abstract pools AR and VR.
6. **Park 2008 depth result scoped.** 130/165/200 mm were compared with each other, between subjects (P6). There was no 0 mm displaced-camera condition.
7. **Mullins scope.** Day camera, lit course (M11/M12). Front-forward vs front is not reported as significant.
8. **Penner wording.** "Commercial passthrough 12–60 ms" became "modern devices" (HMD e2e), as Pn1 says. Added the "difficult to validate" caveat to the 15–20 ms target. The FPV remark is now quoted exactly ("do not account for capture or viewing optics") instead of paraphrased as "perspective-correct parallax".
9. **Jerald.** Stated that the 16.9 ms is a JND-like difference threshold, measured on a rig with 7.4 ms base delay (J4/J5).
10. **Rash printed page numbers were off by +1.** p.824 → 823, p.839 → 838, p.116 → 115, p.510 → 509, p.556 → 555; fixed in both files. pdf page numbers were already correct.
11. **Previously unsourced numbers now sourced:**
    - shop latency, AI Box size and head sizes (S1/S2);
    - the PAL 50 field/s rate (T1, ITU-R BT.470-6).

    "55 g AI Box" is downgraded: the shop does not say what the 55 g covers. "0.17 mm ≈ PETG layer/fit tolerance" is retagged [I].
12. Rolland "speed fell by 43 %" now quotes the body text, "took 43% longer" (R8). The abstract's wording is kept in parentheses.

**Checked and left unchanged:**
- Mullins M2–M10 (all percentages and rankings, including the 9/17 and 10/17 majorities in Table 2);
- CuQlock-Knapp C1–C3, C5, C6;
- Park P1–P5;
- Edwards E1–E2;
- Rash H1–H7 text;
- Penner Pn2/Pn3/Pn6/Pn7, including the Meta affiliation;
- Jerald J1–J3;
- Bonnen B1/B2/B4;
- Balachandran Ba1–Ba4 (Ba4 is the VR condition, §3.2.1);
- HDO2 F1 "46 degrees diagonal" (manual p.11).

**Still open:** the MISSING list above is unchanged, and no claim rests on those papers. Melzer & Moffitt (the 0.5° tolerance and arc walking) remains [V2] only. It is the most load-bearing second-hand claim in this file, so fetching doi:10.1117/12.721156 would firm up TL;DR 3. This file remains a working draft; `ZALOZENIA.md` governs.
