# 02: Field of view and magnification for walking at night (HDO2 + Caddx TR1-220SL)

> **Status: working draft, 2026-11-03.** All hardware numbers come from spec sheets (Fat Shark manual,
> BZB UAS shop page). None of them has been measured on the real units yet. `ZALOZENIA.md` sets the
> objectives. Where this file and the spec sheets disagree with a bench measurement, the measurement
> governs. Verbatim quotes are in `papers/extracts_fov.md`.
> **Tags:** `[V: file, p.X]` means the passage was read at source and the quote is in the extracts file.
> `[C]` means my own calculation from `[V]` inputs (formula shown). `[A]` means an assumption that
> still needs a bench check. `[inference]` means my reading of the evidence, not a finding of any paper.

## TL;DR (for this project)

1. **The thermal camera on the HDO2 is ≈0.75× (25% minification), not ≈0.92× as `ZALOZENIA.md` §1b says.** The HDO2's 46° is a *diagonal* figure, so the display is ≈37.5°H × 28.6°V. The thermal camera is 50°H × 37.2°V. The 0.92 came from comparing a diagonal with a horizontal angle. The Infra camera (120°, most likely diagonal) comes out at **≈0.38×**, with fisheye compression at the edges on top of that.
2. **Make thermal the default for walking.** It is closest to 1:1, so head turns cause ≈25% retinal slip against ≈61% for Infra. It needs no light. It detects a person at ≈146 m (Johnson criteria, 1.5 px; 50% probability, ΔT ≥ 2 °C, ideal conditions). Put the Infra camera on a button as a "wide look" mode for orientation, or for when terrain shows no thermal contrast. Check first that Infra shows anything at all in a moonless forest: the kit contains no IR illuminator.
3. **1:1 is not reachable with this hardware without cropping.** It would need a 1.33× digital zoom, which would cut the camera FOV to ≈37.5° × 28°. **Don't chase 1:1 in v1.** On this display the field is already in the range where walking measurably slows down (40°×25° in Jansen 2011). Accept 0.75×, tell the wearer to scan with the head and walk slower, and A/B-test a 1.33× zoom only if the AI Box turns out to have one.
4. **Tilt the camera down ≈10° (adjustable, 0–20°).** With the camera level and its eye at ≈1.8 m, the thermal image shows no ground nearer than ≈5.3 m. At 10° down the nearest visible ground is ≈3.3 m, and at 15° it is ≈2.7 m. The same TNO group reports that restricting the *vertical* field degraded local obstacle avoidance more than restricting the horizontal field (Jansen et al. 2010, known here only from the authors' own one-line summary; primary not retrieved).
5. **PAL does not limit the thermal image:** 256 columns need ≈2.5 MHz and PAL B/G carries 5 MHz. PAL *does* limit the Infra camera: a 5 MHz channel carries at most ≈390 TVL, so the shop's "1500 TVL" cannot get through. One thermal pixel lands on ≈5×5 HDO2 pixels and subtends 11.8 arcmin of world angle. That is a pixel-limited acuity of about 20/240 at best, against ≈20/25 for a 40° image intensifier NVG (measured in semi-dim illumination with pinhole-capped objectives, so a best case for the NVG too).

---

## 1. Geometry of this hardware

### 1.1 HDO2 display FOV
- The manual specifies "46 degrees diagonal", two Sony 0.5" OLED panels at 1280×960, and "AV Mode 4:3" [V: FatShark_HDO2_Manual_RevC.pdf, pdf p.11]. fpv24 gives the same "46 degrees diagonal" [V: ctrl_hdo2_fpv24.txt].
- A 4:3 panel splits the diagonal 3:4:5. With a rectilinear (tangent) eyepiece, **H = 2·atan(0.8·tan 23°) = 37.5°** and **V = 2·atan(0.6·tan 23°) = 28.6°** [C]. Splitting the angles instead (46·0.8 and 46·0.6) gives 36.8° × 27.6° [C]. The real value lies between the two and depends on the eyepiece's distortion, which is unknown [A].
- Display pixel: 37.5°/1280 = **1.76 arcmin (0.51 mrad)** [C].
- Use the **Analog 4:3** mode. The goggles cycle "Analog 4:3, Analog 16:9, HDMI" [V: FatShark_HDO2_Manual_RevC.pdf, pdf p.8]. A 4:3 PAL picture shown in 16:9 mode would get horizontal and vertical magnifications that differ. What the goggles actually do in that mode is not documented [A].

### 1.2 Thermal camera → angular magnification
- Shop specification: 256×192, F1.0/4 mm, **50°(H) × 37.2°(V) × 62.3°(D)**, IFOV 3.43 mrad, 50 fps [V: bzbuas_tr1-220sl_product_page_en.txt; unit "mrad" from bzbuas_tr1-220sl_product_page_pl.txt].
- The specification is self-consistent only in angle space. 256 × 3.43 mrad = 50.3° [C], and √(50² + 37.2²) = 62.3° [C]. So the "D" figure is a Pythagorean sum of angles, not a rectilinear diagonal (a rectilinear diagonal would be 59.8° [C]). Also, 3.43 mrad × 4 mm implies a 13.7 µm pixel pitch [C]. Either the focal length or the angles are rounded. **Measure the FOV on the bench (§8).**
- **Centre magnification** M = tan(display half-angle) / tan(camera half-angle) [C]:
  - Horizontal: tan 18.76° / tan 25° = **0.73**. Full-angle ratio 37.5/50 = 0.75.
  - Vertical: tan 14.29° / tan 18.6° = **0.76**.
  - Diagonal angle ratio: 46/62.3 = 0.74.
  - **⇒ M ≈ 0.73–0.77, i.e. ≈25% minification**, plus or minus any overscan or crop in the goggles' PAL decoder [A]. A 5% overscan would raise M by about 5%.
- **Correction to `ZALOZENIA.md` §1b**: "Termo 50°H na ekranie HDO2 46° → ~0.92×" compares a horizontal angle with a diagonal one. The correct figure is ≈0.75× [C]. I have not edited `ZALOZENIA.md`. Adam should decide.

### 1.3 Infra camera → angular magnification
- Shop specification: B/W, "1500 TVL", **FOV 120°** (axis not stated), M16 F1.0 **2.8 mm**, "0 Lux" [V: bzbuas_tr1-220sl_product_page_en.txt]. The sensor size is not given.
- A 2.8 mm lens cannot give a 120° *rectilinear* diagonal on a ⅓" sensor (6.0 mm diagonal) [A: ⅓" assumed as typical for this camera class; the shop gives no sensor size]: that would be 94° [C]. A rectilinear 120° diagonal at 2.8 mm would need a 9.7 mm (≈⅔") sensor diagonal [C]. An equidistant (f-θ) lens on a ⅓" sensor gives 6.0/2.8 rad = 123° diagonal [C]. **So "120°" is most likely a diagonal of a strongly barrel-distorted (fisheye-like) lens** [A]. That gives about 96°H × 72°V [C, f-θ].
- Centre magnification: 37.5/96 ≈ **0.39** (H), 46/120 = **0.38** (D) [C]. If 120° were horizontal, M ≈ 0.31 [C]. The barrel distortion compresses the edges further, so objects near the image edge are shown even smaller and pulled toward the centre [inference].

### 1.4 Resolution on the display and in the world
| Quantity | Thermal | Infra (through PAL) |
|---|---|---|
| World angle per resolvable element | 3.43 mrad (IFOV) [V] = **11.8 arcmin** [C] | ≈96°/520 ≈ **3.2 mrad** (PAL-limited, §5) [C] |
| Display pixels per sensor pixel | 1280/256 = **5.0**, 960/192 = **5.0** [C] | n/a |
| Size of one sensor pixel on the display | 37.5°/256 = **8.8 arcmin** [C] | n/a |
| Nyquist limit in the world | 1/(2·0.197°) = **2.5 cycles/deg** [C] | 1/(2·0.184°) ≈ **2.7 cycles/deg** [C] |
| Snellen equivalent (MAR = 1 pixel), upper bound | **≈20/240** [C] | ≈20/220 [C] |

The two cameras end up with about the same angular resolution in the world. The Infra camera spreads it over ≈1.9× the thermal camera's horizontal angle (96° against 50°; 2.6× the display's 37.5°) and then shows it 0.39× smaller [C]. Infra's figure is only the PAL ceiling; the sensor's own resolution behind it is unknown [A]. For comparison, aviator image intensifier NVGs with a ~40° FOV gave a Snellen acuity "approaching 20/25" [V: CuQlock-Knapp_2001_ARL-TR-2407…pdf, pdf p.16], measured in "semi-dim illumination" with pinhole lens caps on the objectives [V: same page]. The thermal image is therefore roughly 10× coarser than a 40° NVG, which is expected for 256 px across 50° [C]. The real acuity will be worse than the pixel bound because of optics MTF, NETD and PAL resampling [inference].

### 1.5 How much ground the image shows (camera at h ≈ 1.8 m, flat ground)
The nearest visible ground point is d = h / tan(half-VFOV + camera pitch-down) [C, A: h = 1.8 m for a helmet-top camera].

| Camera pitch-down | Thermal (half-V 18.6°): nearest ground | Horizon position in the camera image |
|---|---|---|
| 0° | **5.3 m** | centre |
| 10° | **3.3 m** | 10° above centre (≈7.5° on the display at 0.75×) |
| 15° | **2.7 m** | 15° above centre |
| 20° | **2.3 m** | 20° above centre (just past the 18.6° top edge, so the horizon leaves the frame) |

The Infra camera (half-V ≈36°, f-θ) sees ground from ≈2.5 m even when level [C]. Walkers also pitch their heads down, and with a head-fixed camera that works the same way [inference]. A fixed downward tilt makes the image horizon sit away from the vestibular horizon. In an HMD (virtual scene), tilting the world up by 5.7° did not change blind-walking distance judgments significantly (84% against 80% baseline, p = 0.86) [V: Kuhl2008_VSS_poster.pdf, p.1]. No retrieved source tests 10–20° tilts, so this needs a bench and field check.

### 1.6 Head rotation: retinal slip with a head-fixed camera and display
The camera and the display both move with the head. A head turn of ω therefore moves the image by M·ω on the display. The VOR counter-rotates the eye by ω ("the VOR gain … is ideally 1" [V: McLean2023…, Background]). **Retinal slip = (1 − M)·ω** [C]:
- Thermal, M ≈ 0.75: **25%** of head velocity. At 100°/s that is ≈25°/s of image motion across the retina.
- Infra, M ≈ 0.39: **≈61%**, or ≈61°/s at 100°/s.

McLean et al. describe the mechanism: "Mismatched eye rotation can result in retinal slip and oscillopsia" [V: McLean2023…, Background]. Their subjects reported dizziness and visual motion as the main symptoms with only **2–4%** minifying lenses [V: McLean2023…, Abstract]. VOR gain is described as adapting quickly, with possible "oscillopsia … for a short duration each time wearable optics are put on or removed" [V: McLean2023…, Background]. The primary VOR-adaptation-to-magnification paper (Collewijn 1983) was **not retrieved**, so this file makes no claim about the time course. Expect swim and dizziness during the first sessions [inference]. Infra mode should be worse by roughly the ratio of the slips, 61/25 ≈ 2.4× [inference].

---

## 2. Evidence: restricted FOV and walking

All of these studies restricted the view with **optical apertures at 1:1 magnification** (no display). Acuity was normal except in Toet SPIE Experiment I, where green and diffusion filters simulated an NVG and acuity through the goggles was 0.25–1 [V: Toet2008_FOV_human_locomotion_SPIE.pdf, pdf pp.2–3]. Our system adds minification, low resolution, no stereo and latency on top, so these results are best-case bounds [inference].

- **Jansen, Toet & Werkhoven 2011 (Exp Brain Res):** the "S: 40° × 25°" condition, which is close to the HDO2's 37.5° × 28.6°, slowed walking and increased step width and path length. The M (80°×60°) and L (115°×90°) conditions only widened the path [V: Jansen2011…PMC3127014.txt, Abstract]. Step width grew from ≈0.19L to **0.26L** in S, "indicating balancing problems". Head yaw speed dropped in S [V: same, Discussion].
- **Same group, obstacle crossing (J Motor Behav 2011, summarised in the paper above):** a 40–90° vertical field led to larger toe clearance and step length at unchanged speed. A **25° vertical** field also slowed walking [V: Jansen2011…PMC3127014.txt, Introduction]. (That study restricted the *lower* field; the primary J Motor Behav paper was not retrieved; see MISSING.)
- **Same group, earlier study (Jansen et al. 2010, Ergon Open J, summarised in the same Introduction):** "restriction of the vertical viewing angle causes greater performance degradation than that of the horizontal angle" for local obstacle avoidance [V: Jansen2011…PMC3127014.txt, Introduction]. This is the authors' one-sentence summary of their own 2010 paper, which was not retrieved; the summary does not say whether the upper or lower field was cut.
- **Toet et al. 2008 (SPIE):** an 18° vertical field was significantly slower than 48°. Traversal time was flat for horizontal fields from 75° to 180° and rose significantly at 30° [V: Toet2008_FOV_human_locomotion_SPIE.pdf, pdf p.1]. The effect looks "stepwise" rather than gradual [V: same, pdf p.9]. In an indoor "artificial forest" course with simulated-NVG goggles (20/40/60° circular), time fell as FOV grew. Binocular viewing was faster than monocular (one eye occluded) by a constant factor of **1.26** at every FOV [V: same, pdf pp.2–3].
- **Toet, Jansen & Delleman 2008 (Ergonomics):** every restriction (30°/75°/120° H × 48° V) increased time and number of footsteps. 30° was worst, and 75° and 120° did not differ. The **error count (stumbling or distinct contact) did not change** [V: Toet2008_FOV_manoeuvring_3D_Ergonomics.pdf, pp.385, 390, 392], but participants were told that touching any obstacle was "extremely important" to avoid, and "This instruction served to keep the error count at a low level" [V: same, p.390]. So the flat error count partly reflects the instruction and should not be read as "a narrow field causes no extra collisions". NVG FOVs are "typically limited to 30–40°" [V: same, p.386].
- **Creem-Regehr et al.:** with a 42°×32° FOV and **free head rotation**, blind-walking distance judgments matched full FOV (slopes 0.93 and 0.92). With head rotation blocked, the slope fell to 0.78 [V: CreemRegehr2003…pdf, pp.7–8]. Monocular viewing equalled binocular for these distance judgments [V: same, p.10]. People in HMDs limit their head movement unless told to "look around" [V: Jansen2011…PMC3127014.txt, Introduction].

**What this means here [inference]:** the field is set by the HDO2 (≈37.5°×28.6°) whatever camera is used. That puts the wearer in the "small field" regime, so expect slower walking, wider steps and bigger clearances. Collisions did not rise in Toet's Ergonomics course, but under an explicit no-contact instruction (above), and Jansen 2011 did not report contacts, so the collision question is open. Mitigations: (a) deliberate head scanning, which should be trained, (b) as much *vertical* coverage of the near ground as possible (§1.5), (c) a slower pace. The system is bi-ocular (one camera to both eyes, no disparity). Toet's 1.26 factor compares one occluded eye with normal binocular vision; a bi-ocular display (both eyes open, identical images) is a different condition, so 1.26× slower traversal of cluttered obstacles is only a rough upper-end guess, not a measured value for this setup [inference from V: Toet SPIE pdf p.3]. For distance judgment, monocular viewing matched binocular in Creem-Regehr's real-world hallway [V: Creem-Regehr p.10], so loss of stereo alone should not distort distance much [inference].

## 3. Evidence: minification (M < 1)

- **Direction of the effect:** minification makes things look **farther**. In an HMD, minifying by 30% (≈0.7×, close to our 0.75×) raised blind-walking distance from 80% to 98% of true distance [V: Kuhl2008_VSS_poster.pdf, p.1]. Scaling to 0.7× raised it from 76% to 95% in a second study, while verbal reports were not significantly affected (74% and 77%, separate participant groups) [V: Zhang2012…pdf, pdf pp.1, 3, 5, 6]. Proposed mechanisms: smaller visual angle (familiar size), less optic flow per metre walked, and less binocular disparity [V: Zhang2012, pdf p.5]. (The disparity mechanism does not apply to our bi-ocular display, which has none to begin with [inference].)
  - Caveat: these were VR scenes that start out compressed (≈76–80%). In a correctly scaled real scene viewed at 0.75×, the same push toward "farther" would turn into **overestimation**. For stepping, that means obstacles look farther and smaller than they are, so the wearer would tend to step late or too low [inference]. Chapman et al. 2011 (gait with lens magnification) would be the direct test, but the paper was **not retrieved**, so no claim is made about its methods or results.
- **Large minification still works for collision avoidance:** a 5× minifying HMD increased the judged collision envelope by only 18% (13 cm) [V: Luo_Peli_2007…pdf, p.1]. That was a judgment task on simulated walking (virtual corridor), not real walking, with 10 normally sighted subjects; the control was unaided viewing with one eye patched, and the test condition blocked the see-through view so "only minified images were visible" [V: same, pdf p.1, Abstract]. The device shows edge images on a 16° display [V: same, pdf p.1, Introduction]. In a minified display, "objects appear closer to the heading direction than they really are" [V: same, pdf p.1, Abstract]. Read together, Infra at 0.38× should be usable for **gross orientation and avoiding collisions** but is poor for **foot placement** [inference].
- **Comfort:** discomfort rose with minification already at 2–4% [V: McLean2023, Abstract]. Expect it to be noticeable at 25%, and strong at 61% [inference].
- **Design norm:** "NVGs are specified to be a unity magnification. That is, the input FOV must match the output FOV to within a few percent." [V: USAARL_HMD2009_…Chapter-17…pdf, p.813].

## 4. Is 1:1 achievable, and is it needed?

**Achievable?** Not as the system stands [C].
| Route | Result | Cost |
|---|---|---|
| Camera digital zoom of 1.33× (50→37.5°) | M ≈ 1.0 | FOV drops to ≈37.5°×28° and each thermal pixel covers ≈6.7 display px, with no new information. It is unknown whether the TR1-220SL AI Box can zoom. The Eclipse 005SL (a different model) lists "1.0–4.0× Stepless Zoom (controllable via UVC)" [V: bzbuas_eclipse005sl_product_page.txt]. |
| External crop/scaler between camera and goggles | M ≈ 1.0 | Adds latency and parts (see the latency track). Same FOV loss. |
| A different camera whose FOV matches the display | e.g. Caddx Ratel Ultra AI at 36.86°H × 29.14°V [V: ctrl_caddx_eclipse004dual_ft483dual.pdf, p.1] → 36.86/37.5 = **0.98×** [C] | 1/1.8" image sensor, i.e. a light-dependent camera; the sheet gives no low-light figure [inference]. Not in the kit. Useful only as a reference. |
| HDO2 in 16:9 mode | Non-uniform M | Not recommended (§1.1). |

**Needed?** Not for v1 [inference, weighing §2 against §3]. Going from 0.75× to 1:1 removes 25% retinal slip and a modest bias toward judging things farther away. It costs 25% of a camera field that is already only slightly wider than the display, in a range where field size measurably slows walking (§2). Toet's and Jansen's data argue that field matters more than exact scale at these sizes, while the NVG norm (§3) argues for unity. Neither tested this exact trade-off, so treat it as a bench A/B test (§8) and not as settled. Keep a "1:1 / zoom" toggle on the button list if the AI Box exposes zoom.

## 5. Does PAL degrade the thermal image?

- PAL B/G: nominal video bandwidth **5 MHz**, line period **64 µs**, line blanking **12 µs** → active line ≈ **52 µs** [V: ITU-R_BT.470-6…pdf, pdf pp.2, 5; arithmetic C]. 4:3 aspect, 2:1 interlace [V: same, pdf p.1]. BT.601 digitises the active line as **720** luma samples at 13.5 MHz [V: ITU-R_BT.601-7…pdf, pdf p.9 (printed p.7), Table 3]. The 5 MHz figure is the nominal *broadcast* channel bandwidth; a wired CVBS link has no transmitter filter, so the real limit is whatever the AI Box encoder and HDO2 decoder pass [inference, bench item 6].
- Horizontal: 5 MHz × 52 µs = 260 cycles ≈ **520 resolvable elements per line** [C]. 256 thermal columns need 128 cycles / 52 µs = **2.46 MHz** [C]. **The PAL channel does not bottleneck the thermal sensor horizontally.**
- Vertical: 192 rows against ≈576 active lines (≈288 per field) [A: standard 576-active-line figure, not in a retrieved file] gives 3 lines per row per frame and 1.5 per field, so this is not a bottleneck either [C].
- What *can* degrade the picture [inference, all need bench checks]: (a) two non-integer resamplings, 256→720 (×2.81) in the AI Box and then 720→1280 (×1.78) and 576→960 (×1.67) in the HDO2, which soften the edges of thermal pixels; (b) field/frame mismatch between the 50 fps sensor and 50 Hz interlace, which can produce combing on fast head turns depending on how the HDO2 deinterlaces (undocumented); (c) a chroma notch or comb filter in the goggles' decoder cutting luma bandwidth; (d) whatever "AI image enhancement" does [V: shop page lists "Al lmage Enhancement"]. None of these reduces sensor resolution below 256×192. They reduce edge sharpness and temporal clarity.
- **Infra:** 520 elements per active line in 4:3 is ≈390 TV lines per picture height [C; A: TVL counted per picture height]. **The shop's "1500 TVL" cannot pass through PAL.** The effective resolution is ≈3.2 mrad per element over ≈96°H [C], about the same as the thermal IFOV.

## 6. Detection ranges and terrain obstacles (thermal, 3.43 mrad)

Range for n pixels across a critical size W: R = W / (n · IFOV) [C].
- Person, W = 0.75 m, Axis criteria of 1.5 / 6 / 12 px [V: Axis_thermal_technology_glossary.pdf, pdf p.4]: **detection ≈146 m, recognition ≈36 m, identification ≈18 m** [C]. This matches Dahua's own table for a 256×192 camera with a **50.6°×37.8°** lens: **146 / 38 / 19 m** [V: Dahua_thermal_range_performance_DRI_V2.pdf, pdf p.5]. The agreement checks the arithmetic, not the criteria: Dahua's thresholds (3.6/14/28 px over a 1.8 m height [V: same, pdf p.3]) work out to 0.50/0.13/0.064 m per pixel, the same as Axis's 1.5/6/12 px over 0.75 m (0.50/0.125/0.0625 m per pixel) [C]. Dahua states its figures are for "ideal conditions" [V: same, pdf p.3]. These are 50%-probability figures and assume a target-to-background ΔT of at least 2 °C [V: Axis, pdf p.4].
- **Terrain, which is what walking needs** [C]:

| Distance | Pixel footprint | 5 cm root/stone | 10 cm | 20 cm |
|---|---|---|---|---|
| 2 m | 6.9 mm | 7.3 px | 14.6 px | 29 px |
| 3 m | 10.3 mm | 4.9 px | 9.7 px | 19 px |
| 5 m | 17 mm | 2.9 px | 5.8 px | 12 px |
| 10 m | 34 mm | 1.5 px | 2.9 px | 5.8 px |

"Distance" is line-of-sight range and the pixel counts are for the object's width *across* the line of sight. Its extent *along* the ground is foreshortened by the depression angle: from 1.8 m eye height, ground at 3 m horizontal is seen at ≈31° down, so a flat 5 cm patch spans only ≈0.5× as many pixels in depth as in width [C]. Geometry is still not what limits stepping hazards: within 5 m a 5 cm object covers ≈3 px or more across [C]. **Thermal contrast is the limit:** the Johnson-type numbers assume a ΔT of at least 2 °C [V: Axis]. Ground, roots and stones at night can be close to isothermal [inference, no source retrieved]. That is the main argument for keeping Infra one button away.

## 7. Recommendation: default camera for walking

**Default: thermal.** [inference built from §1–§6]
- M ≈ 0.75 against ≈0.38. That means less retinal slip (25% against 61%), less bias toward "farther" (§3), and less distortion (§1.3).
- It works in complete darkness. The Infra camera's "0 Lux" claim [V: shop page] comes with **no IR illuminator in the kit** [V: shop page, "Package Includes"]. Whether Infra shows usable terrain under forest canopy with no moon is unverified, and it may need an 850/940 nm IR flood on the helmet.
- People: detection out to ≈146 m (50% probability, ΔT ≥ 2 °C) [C/V]. Animals are not covered by the retrieved criteria (critical sizes given only for a person and a vehicle), so no range is claimed for them.

**Infra as a button-held or toggled "wide look":** ≈96°×72° gives the full lower field from ≈2.5 m with the camera level, and good orientation and collision avoidance. It is poor for foot placement at 0.38× with fisheye edges. It is the fallback when thermal contrast is washed out (rain, fog on the lens, isothermal ground) and some light or IR illumination is available.

**Mounting and use:** camera tilt adjustable over 0–20°, starting at about 10° (§1.5); train deliberate head scanning; walk slower. Expect the first sessions to bring swim and dizziness (§1.6).

---

## 8. Open questions / bench measurements for Adam

1. **Measure the true magnification (thermal and Infra).** Put the OSD crosshair or a marked display centre on a hot target such as a mug of hot water. Yaw the head until the target touches the left or right edge of the display, and read the head yaw from a phone gyro or a protractor on the helmet. Then M = 18.75° / head-yaw, assuming the HDO2 half-width of 18.75°. Repeat vertically (14.3°). This also exposes overscan or crop in the HDO2.
2. **Measure the camera FOVs directly.** Put the camera on a turntable, rotate a hot point source from edge to edge, and record the angles for H, V and D. This settles whether Infra's 120° is diagonal or horizontal and how strong its distortion is (straight-edge test).
3. **Can the TR1-220SL AI Box zoom?** (Interface track.) If it can, A/B-test 1.0× against 1.33× on a fixed obstacle course: time, number of footsteps, contacts, and symptoms rated 1–5 as in McLean 2023.
4. **Infra in real darkness:** a moonless forest, with and without a small IR flood. If it shows nothing, its role shrinks to dusk and urban use.
5. **Thermal contrast of the ground at night:** roots, stones, holes and puddles at 2–5 m. Note the conditions (clear or overcast, after a sunny or a wet day).
6. **Interlace and combing** on fast head yaw (≈100–200°/s) in the HDO2's analog 4:3 mode. Record with the HDO2 DVR, or film the eyepiece through a phone.
7. **Camera pitch:** trial 0°, 10° and 15° on a rooted path. Report comfort with the offset horizon. Of the sources retrieved here, only a 5.7° virtual-world tilt has been tested (Kuhl 2008).
8. **Overscan:** check whether the four thermal image edges are visible on the HDO2 at all. If they are cropped, M is higher than computed.
9. **Spec inconsistency:** the 4 mm lens with 3.43 mrad implies a 13.7 µm pitch. Ask Caddx (support@caddxfpv.com) for the true focal length and pitch, or simply trust the bench FOV.

---

## Retrieved (in `papers/`; read at source)
| File | Source | Fetched by |
|---|---|---|
| `Toet2008_FOV_manoeuvring_3D_Ergonomics.pdf` | Toet, Jansen, Delleman, Ergonomics 51(3):385–394, doi:10.1080/00140130701628329 | this track |
| `Toet2008_FOV_human_locomotion_SPIE.pdf` | Toet et al., Proc. SPIE 6955 (2008) | this track |
| `Jansen2011_multiple_obstacle_VF_limitation_ExpBrainRes_PMC3127014.{xml,txt}` | Jansen, Toet, Werkhoven, Exp Brain Res 212:449–456, doi:10.1007/s00221-011-2757-1 (Europe PMC full-text XML; the PDF was blocked) | this track |
| `CreemRegehr2003_restricted_viewing_distance_UUCS-03-016.pdf` | Univ. Utah TR UUCS-03-016. Journal version: Perception 34:191–204 (2005), doi:10.1068/p5144 | this track |
| `Kuhl2008_VSS_poster.pdf` | Kuhl, Thompson, Creem-Regehr, VSS 2008 poster (year not printed on the poster; not verified) | this track |
| `Zhang2012_minification_distance_HMD_TAP.pdf` | Zhang et al., ACM TAP 9(3) (2012), doi:10.1145/2325722.2325727 (author copy; it prints a placeholder DOI, so volume/issue/DOI are not verified from the file) | this track |
| `Luo_Peli_2007_collision_judgment_minified_HMD_SPIE.pdf` | Luo, Lichtenstein, Peli, Proc. SPIE 6426 (2007) (author copy; volume and year are not printed in it, not verified) | this track |
| `McLean2023_minification_discomfort_wearable_optics_JVis_PMC10414133.{xml,txt}` | McLean et al., J Vis 23(8):10 (2023), doi:10.1167/jov.23.8.10 | this track |
| `Axis_thermal_technology_glossary.pdf` | Axis Communications | this track |
| `Dahua_thermal_range_performance_DRI_V2.pdf` | Dahua, Thermal Camera Range Performance for DRI and IVS V2.0 | this track |
| `Mobotix_Johnson_criteria.pdf` | MOBOTIX (comparison only) | this track |
| `ITU-R_BT.470-6_TV_systems.pdf` | ITU-R BT.470-6 (1998) | this track |
| `ITU-R_BT.601-7_digital_TV_studio.pdf` | ITU-R BT.601-7 (2011) | this track |
| `FatShark_HDO2_Manual_RevC.pdf`, `ctrl_hdo2_fpv24.txt` | Fat Shark HDO2 manual Rev C; fpv24 product page | other tracks |
| `bzbuas_tr1-220sl_product_page_{en,pl}.txt`, `bzbuas_eclipse005sl_product_page.txt`, `ctrl_caddx_eclipse004dual_ft483dual.pdf` | BZB UAS shop pages; Caddx Eclipse 004 dual sheet | other tracks |
| `CuQlock-Knapp_2001_ARL-TR-2407_NVG_viewpoint_offset_grenade.pdf` | ARL-TR-2407 (2001) | other track |
| `USAARL_HMD2009_Section-26-Chapter-17-Guidelines-for-HMD-design.pdf` | Rash et al. (eds.), *Helmet-Mounted Displays: Sensation, Perception and Cognition Issues*, USAARL 2009, Ch.17 | other track |

## MISSING (not retrieved, no claim made)
Adam, please fetch these in one go if you want them used:
1. **Collewijn, Martins & Steinman 1983**, "Compensatory eye movements during active and passive head movements: fast adaptation to changes in visual magnification", *J Physiol* 340:259–286, doi:10.1113/jphysiol.1983.sp014762, PMC1199209. PMC is blocked by reCAPTCHA. Would support claims about the VOR adaptation time course.
2. **Jansen, Toet & Werkhoven 2011**, "Obstacle crossing with lower visual field restriction: shifts in strategy", *J Motor Behav* 43(1):55–62, doi:10.1080/00222895.2010.533593 (DOI as given in the Exp Brain Res reference list). TNO repository record: https://repository.tno.nl/islandora/object/uuid:d8cc0bea-4807-4049-a05d-31d0c2e51aae ("on request"). Only the authors' own summary in Exp Brain Res 2011 was used.
3. **Chapman, Scally & Elliott 2011**, "Adaptive gait changes in older people due to lens magnification", *Ophthalmic Physiol Opt* 31:311–317, doi:10.1111/j.1475-1313.2010.00807.x. Closed access. Would give direct evidence on magnification and minification and foot placement.
4. **Roscoe 1984**, "Judgments of size and distance with imaging displays", *Human Factors* 26(6):617–629. SAGE; the DTIC reports return 403.
5. **Kuhl, Thompson & Creem-Regehr 2009**, "HMD calibration and its effects on distance judgments", *ACM TAP* 6(3):19. Only the 2008 poster was read.
6. **Hassan, Hicks, Lei & Turano 2007**, "What is the minimum field of view required for efficient navigation?", *Vision Research* 47:2115–2123 (ScienceDirect).
7. **Alfano & Michel 1990**, "Restricting the field of view: perceptual and performance effects", *Percept Mot Skills* 70:35–45 (SAGE).
8. **Leonardo DRS**, "The truth about range data" (MR-2014-10-683): https://www.leonardodrs.com/media/10494/201705_truth_about_rangedata_mr-2014-10-683_rev02.pdf. Returns 404, which is why vendor sheets were used for the Johnson numbers.
9. Any source on **gaze look-ahead distance during walking** (e.g. Patla & Vickers 2003, *Exp Brain Res*). No claim is made about how far ahead walkers look, so the terrain table covers 2–10 m.
10. **HDO2 analog decoder behaviour** (overscan, deinterlacing, behaviour in 16:9 mode). No documentation found; covered by bench items 6 and 8.
11. **Jansen, Toet & Delleman 2010**, "Restricting the vertical and horizontal extent of the field-of-view: effects on manoeuvring performance", *Ergonomics Open Journal* 3:19–24 (as cited in the Exp Brain Res 2011 reference list). Source of the "vertical restriction hurts more than horizontal" statement, which is used here only as the authors' own one-sentence summary. Added by the verifier.

---

## Verification (adversarial pass, 2026-11-03)

**Method.** Every quote in `papers/extracts_fov.md` (98 quoted strings) was checked by a script against the
`pdftotext`/XML text of the named file, whitespace- and quote-normalised, and its page located by form-feed
index. Strings that failed the automatic match were read by hand: the BZB UAS table rows (cells joined with
`|` by the researcher; every cell is in the file), the Kuhl 2008 poster (three columns interleaved by
pdftotext; each quote read in its column) and one hyphenated line break in Zhang 2012. **No quote was
fabricated or altered.** Every [C] number was recomputed: display 37.51°×28.58°; M_H 0.728, M_V 0.757,
full-angle ratios 0.750/0.768, diagonal 0.738; 256×3.43 mrad = 50.31°; rectilinear diagonal 59.8°; pitch
13.72 µm; Infra 93.9° (rectilinear) / 122.8° (f-θ) on ⅓"; M_Infra 0.391/0.383/0.313; IFOV 11.79′; Nyquist
2.54 and 2.71 c/deg; Snellen 20/236 and 20/222; nearest ground 5.35/3.30/2.71/2.25 m; Infra 2.48 m; PAL 260
cycles, 2.46 MHz, 390 TVL; DRI 145.8/36.4/18.2 m; terrain table; zoom 6.67 px; slip ratio 2.44. **All
arithmetic is correct.** The verifier did not edit `ZALOZENIA.md`.

**Changed in this file:**
1. *Misattribution, TL;DR 4 and §2.* "Restricting the lower field hurts stepping more than restricting the
   horizontal field" was attributed to the J Motor Behav 2011 obstacle-crossing study. The source sentence
   is about **Jansen et al. 2010** (Ergon Open J), says **vertical**, not lower, and says "local obstacle
   avoidance", not stepping. Reworded, split into its own bullet, and Jansen 2010 added to MISSING (#11).
2. *Overstated "no more collisions", §2.* Toet's Ergonomics participants were told contact was "extremely
   important" to avoid, and the paper says "This instruction served to keep the error count at a low
   level". Jansen 2011 reports no contacts at all. The inference now says the collision question is open.
3. *Wrong scope, §2 header.* "Full acuity" was false for Toet SPIE Experiment I (green + diffusion filters,
   acuity 0.25–1 through the goggles). Corrected.
4. *Over-reach, §2 inference.* The 1.26 factor is one-eye-occluded vs binocular, not bi-ocular vs stereo.
   Now marked as a rough upper-end guess, not a prediction for this display.
5. *Wrong page and missing extract, §3.* The 74%/77% verbal-report numbers are on Zhang pdf p.6 (separate
   participant groups, Experiment 2), not pp.1/3/5. Citation fixed; quote added to extracts. The disparity
   mechanism now has its quote and a note that it does not apply to a bi-ocular display.
6. *Missing scope, §3, Luo & Peli.* Added that the test showed only minified edge images on a 16° display
   to 10 subjects in a virtual corridor; the "closer to the heading direction" quote is in the Abstract, not
   the Introduction.
7. *Claim from an unretrieved paper, §3.* The description of Chapman 2011's methods ("raised surface,
   1–5% lens magnification") rested on no downloaded file. Removed; only the citation remains.
8. *Missing qualifiers.* NVG 20/25 acuity was measured with pinhole-capped objectives in "semi-dim
   illumination" (now stated, TL;DR 5 and §1.4). Dahua's ranges are for "ideal conditions", and its criteria
   equal Axis's in metres per pixel, so the match checks arithmetic, not independent validity (§6).
   "People and animals" detection reduced to people: no retrieved source gives an animal critical size (§7).
9. *Unclear or wrong comparison, §1.4.* "Spreads it over 2.6× the angle" now gives both bases (1.9× the
   thermal camera's angle, 2.6× the display's). Added that Infra's 3.2 mrad is only the PAL ceiling.
10. *Untagged assumptions.* ⅓" sensor for the Infra lens now [A]. Ratel Ultra AI "needs ambient light" was
    unsourced and is now marked [inference]. VOR gain ≈1 now carries the McLean quote. Head-pitch and
    "expect swim" statements are tagged [inference].
11. *Geometry caveat, §6.* Terrain pixel counts are widths across the line of sight. Depth along the ground
    is foreshortened by sin(depression), ≈0.5× at 3 m from 1.8 m.
12. *PAL caveat, §5.* 5 MHz is the nominal broadcast bandwidth; on a wired link the encoder and decoder set
    the real limit. The interlace citation was moved to pdf p.1 and BT.601 got its page (pdf p.9, Table 3).
13. *Literature over-reach, §8 item 7.* "Only 5.7° has been tested in the literature" became "of the sources
    retrieved here".
14. *Bibliography.* Zhang 2012's DOI/volume, Luo & Peli's SPIE volume/year and Kuhl's poster year are not
    printed in the downloaded copies and are now marked unverified. The J Motor Behav DOI was taken from the
    Exp Brain Res reference list.

**Changed in `papers/extracts_fov.md`:** two location fixes (BT.470 aspect/interlace on pdf p.1; Luo
& Peli quote in the Abstract), BT.601 page added, and new verbatim extracts that support the changes above:
Toet instruction/error definition, Toet SPIE filters/acuity/occluder, Jansen 2010 vs 2011 note and reference
entries, CuQlock-Knapp pinhole caps, McLean VOR gain and Likert scale, Zhang Exp 2 and disparity, Luo & Peli
methods and 16° display, Dahua "ideal conditions", shop "Al lmage Enhancement", and HDO2 analog DVR. All are
marked "[added by verifier]".

**Checked and left as is:** HDO2 "46 degrees diagonal", 1280×960 and the mode cycle; shop specification
values; Eclipse 005SL zoom (a different model, as stated); Ratel Ultra AI FOV; Jansen S/M/L sizes, the
0.19L→0.26L step width and the head-yaw drop; Toet SPIE 18°/48° and 30° vs 75–180° results and "stepwise";
Toet Ergonomics time and footsteps; Creem-Regehr 42°×32°, slopes .93/.92/.78 and monocular = binocular;
Kuhl 80→98% and tilt 84% p=0.86; Zhang 76→95% and 47.40×39.85° HMD; McLean 2–4% lenses, discomfort, dizziness and
visual motion; USAARL unity-magnification norm and 40° PVS-14; Axis 1.5/6/12 px, 0.75 m, ΔT ≥2 °C and 50%;
Dahua 146/38/19 m; BT.470 5 MHz, 64 µs, 12 µs.

**Still weak (no fix possible without new sources or bench data):** every hardware number is from a shop
page or manual; the 576-active-line figure is [A]; the HDO2 decoder behaviour is undocumented; the
Jansen 2010/2011 and Collewijn findings rest on unretrieved primaries. **This file is a working draft. The
spec sheets and this file give way to bench measurements (§8), and the cited sources govern over any
paraphrase here.**
