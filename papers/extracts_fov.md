# Verbatim extracts: FOV, magnification, locomotion (track 02)

Used by `research/02_fov_magnification_locomotion.md`. Each extract gives the quote (verbatim,
typos and PDF text-layer artefacts kept), the file in `papers/`, and the page or section.
"pdf p." is the page index in the PDF file. "p." alone is the printed page number.
Text-layer artefact: in Toet 2008 (Ergonomics) the degree sign comes out as "8" (e.g. "308" = 30°),
and the "ff"/"fi" ligatures come out as single glyphs.

---

## A. Hardware specifications

### A1. Fat Shark Dominator HDO2: FOV definition and AV mode
File: `FatShark_HDO2_Manual_RevC.pdf` (fetched by another track; read here), pdf p.11, "Specifications"
> "FOV (field of view):             46 degrees diagonal"
> "Display:                            Two Sony 0.5” OLED displays
>                                     Resolution 1280 X 960
>                                     NTCS/PAL auto selecting
>                                     AV Mode 4:3
>                                     AV Mode 16:9"

File: `FatShark_HDO2_Manual_RevC.pdf`, pdf p.8, "General Operation / Display mode selection"
> "Display mode selection: Vertically depressing the contrast/brightness button for a short press
> scrolls through the following modes: Analog 4:3, Analog 16:9, HDMI. The OSD indicates mode."

File: `FatShark_HDO2_Manual_RevC.pdf`, pdf p.11, "Electrical"
> "Power Supply:                    7 – 13V input voltage (2S – 3S Supply)"

File: `FatShark_HDO2_Manual_RevC.pdf`, pdf p.9, "DVR Operation" [added by verifier; supports bench item 6]
> "2. DVR is for analog recording only, no HD recording."

Second source, same figure: `ctrl_hdo2_fpv24.txt` (fpv24.com product page), "Technical data / Optics"
> "FOV (field of view): 46 degrees diagonal"

### A2. Caddx TR1-220SL Dual: shop specification (BZB UAS; this is not a Caddx datasheet)
File: `bzbuas_tr1-220sl_product_page_en.txt`, "Specifications" table (cells joined with |)
> "Camera 1 (Infra)|​lmage Sensor|Black & White Sensor|​Horizontal Resolution|1500 TVL|FOV|120°|Min. lllumination|0 Lux|WDR|Super WDR|Lens|M16/F1.0/2.8mm|Frame Rate|50/60fps"
> "Camera 2 (Thermovision)|Sensor|Uncooled Vanadium Oxide Detector|Resolution|256x192px|Lens|F1.0/4mm|FOV|50° (H) x 37.2° (V) x 62.3° (D)|IFOV|3.43|Refresh rate|50fps"
> "Output|PAL|Input voltage|9-24V|...|Interface|Analog (CVBS)|Average Latency|20ms"

File: `bzbuas_tr1-220sl_product_page_pl.txt`, "Kamera 2 (Thermovision)", which gives the IFOV unit
> "Rozdzielczość kątowa piksela (IFOV)
> 3,43 mrad"

File: `bzbuas_tr1-220sl_product_page_en.txt`, "Specifications" [added by verifier]
> "Image Quality
> Al lmage Enhancement"

File: `bzbuas_tr1-220sl_product_page_en.txt`, "Package Includes"
> "1x Caddx TR1-220SL Dual Thermovision Camera|1x 3pin Silicon Cable|1x GPIO Connection Cable|2x Screw Set"

File: `bzbuas_tr1-220sl_product_page_en.txt`, product description
> "The Caddx TR1-220SL Dual Thermal Camera allows you to see in total darkness thanks to the use of the Infra module with a bright F1.0 lens."

### A3. Related Caddx products (different models, given only as reference points)
File: `ctrl_caddx_eclipse004dual_ft483dual.pdf`, pdf p.1, "Specifications" (Eclipse 004 dual kit)
> "Model                                              Ratel Ultra AI
>  lmage sensor                                       1/1.8 Inch Sensor
>  LENS                                               6mm
>  FOV                                                36.86° (H)*29.14° (V)"

File: `bzbuas_eclipse005sl_product_page.txt` (Eclipse 005SL, 576×432: a DIFFERENT model)
> "Digital Zoom
> 1.0–4.0× Stepless Zoom (controllable via UVC)"

---

## B. Field-of-view restriction and locomotion

### B1. Toet, Jansen & Delleman 2008, Ergonomics 51(3):385–394
File: `Toet2008_FOV_manoeuvring_3D_Ergonomics.pdf`, p.385 (pdf p.2), Abstract
> "All FOV restrictions tested (the horizontal FOV was either 308, 758 or 1208, while the vertical FOV was always 488) signiﬁcantly reduced performance compared to the unrestricted condition. Both the time and the number of footsteps needed to traverse the entire obstacle course increased with a decreasing FOV size."

p.386 (pdf p.3), Introduction
> "Dismounted soldiers performing night-time operations in urban terrain frequently deploy night-vision goggles (NVG), with FOV that are typically limited to 30–408 (RCTA Inc. 2001)."
> "For FOV sizes in the order of 40–508, this eﬀect is not found when head movements are allowed (Knapp and Loomis 2004, Creem-Regehr et al. 2005)."

p.390 (pdf p.7), Results 3.1
> "With the smallest FOV size (308) participants needed signiﬁcantly more time to traverse the entire course (p 5 0.001) than with larger FOV sizes. No signiﬁcant diﬀerence was found between FOV sizes of 758 and 1208 (p ¼ 0.998)."

p.390 (pdf p.7), §2.5 Procedures [added by verifier]
> "They were told that it was extremely important not to touch any of the objects constituting the course, thus simulating a potentially dangerous environment. This instruction served to keep the error count at a low level."

p.389 (pdf p.6), §2.4 Variables [added by verifier]
> "The following actions were registered as an error: stumbling and any distinct physical contact"

p.392 (pdf p.9), Results 3.6 and Discussion
> "No signiﬁcant eﬀects on error measurement are found for the diﬀerent viewing conditions."
> "The FOV of HMDs and NVG that are nowadays commonly used are in the order of the smallest FOV sizes used in the present study (typically not much larger than 408). Therefore, the present results indicate that the use of these devices may decrease manoeuvring speed in complex environments."

p.393 (pdf p.10), Discussion
> "When moving in the counter-clockwise direction, participants probably had more time to adjust to the FOV restrictions and become proﬁcient in making compensatory head movements."

### B2. Toet, van der Hoeven, Kahrimanović & Delleman 2008, Proc. SPIE 6955 (HMD XIII)
File: `Toet2008_FOV_human_locomotion_SPIE.pdf`, pdf p.1, Abstract
> "The time needed to traverse a course was significantly longer for a vertical FOV of 18° than for a vertical FOV of 48°. For a fixed vertical FOV size, the traversal time was constant for horizontal FOV sizes ranging between 75° and 180°, and increased significantly for the 30° horizontal FOV condition."

pdf p.2, §2.1 Method [added by verifier]
> "Tubular isolation material was used to create an indoor obstacle course resembling an artificial forest (Fig. 1)."
> "Night vision was simulated through a combination of two optical filters: a 139 Green filter and a 452 Sixteenth White Diffusion filter"
> "Monocular field-of-view conditions were obtained by fitting an opaque occluder to the goggle opening in front of the dominant eye."
pdf p.3, §2.1 [added by verifier]
> "Visual acuity with the restricting field-of-view spectacles ranged from 0.25 to 1."

pdf p.3, Experiment I results (20°/40°/60° circular FOV, NVG-simulating green filter)
> "For both viewing conditions, the time needed to traverse the obstacle course decreases with increasing field-of-view size."
> "When a similar analysis is performed on a logarithmic representation of the measured time data, the main effects of Eyes and FOV remain significant, but the interaction between Eyes and FOV is no longer significant. This implies that performance improves with a constant factor (1.26) at all FOV sizes."

pdf p.9, Discussion
> "This indicates that the effect of field-of-view restriction on locomotion is not a gradual one, but more like a stepwise relationship."
> "It appears that the effects of instantaneous field-of-view restrictions can be compensated to some degree through the construction of an “effective field-of-view”, that can be obtained by sweeping the instantaneous field-of-view over a larger region of space (i.e. through head movements10)."

### B3. Jansen, Toet & Werkhoven 2011, Exp Brain Res 212:449–456 (PMC3127014; Europe PMC full-text XML, no page numbers)
File: `Jansen2011_multiple_obstacle_VF_limitation_ExpBrainRes_PMC3127014.txt`, Abstract
> "During this task, they wore goggles restricting their visual field to small (S: 40° × 25°), medium (M: 80° × 60°), large (L: 115° × 90°), or unlimited (U) visual field sizes."
> "The results show that compared with the U condition, the M and L conditions caused participants to select a wider path around the obstacles without slowing down or altering step width. However, the S condition did slow down the participants, and increased both their step width and path length."

Section "Introduction" (the authors summarising their own J Motor Behav 2011 paper, which was NOT retrieved)
> "It seems that compared with an unrestricted viewing condition, an intermediate vertical viewing angle (40°–90°) causes participants to enlarge their safety margin when stepping over an obstacle by increasing toe clearance and step length. However, no change in speed was found. When confronted with a smaller viewing angle (i.e., 25°), perceived safety became even more compromised, resulting in a further enlargement of clearance as well as a decrease in speed."
> "Specifically, for local obstacle avoidance tasks, we observed that restriction of the vertical viewing angle causes greater performance degradation than that of the horizontal angle (Jansen et al. 2010)."
(Verifier note: this sentence summarises Jansen et al. **2010** (Ergon Open J), not the 2011 J Motor Behav paper. The next sentence of the source introduces the 2011 paper: "Subsequently, in a recent study, we investigated the effects of lower visual field restriction on obstacle crossing behavior (Jansen et al. 2011)." Reference list entries, verbatim as flattened from the XML: "JansenSToetADellemanNRestricting the vertical and horizontal extent of the field-of-view: effects on manoeuvring performanceErgon Open J201031924" and "JansenSToetAWerkhovenPObstacle crossing with lower visual field restriction: shifts in strategyJ Mot Behav2011435562 10.1080/00222895.2010.533593".)
> "Interestingly, Creem-Regehr et al. (2005) report giving explicit instructions to participants to ‘look around’. This is based on observations that when wearing an HMD, people tend to limit their head movement if not explicitly instructed to do so."

Section "Discussion"
> "The present results show that the average step width increased from approximately 0.19L in the M, L, and U conditions to 0.26L in the S condition, indicating balancing problems."
> "However, we did observe a decrease in yaw rotation speed for the smallest visual field condition."

### B4. Creem-Regehr, Willemsen, Gooch & Thompson, Univ. Utah tech report UUCS-03-016 (2003); journal version Perception 34:191–204 (2005)
File: `CreemRegehr2003_restricted_viewing_distance_UUCS-03-016.pdf`, p.1, Abstract
> "Experiment 2 manipulated horizontal field of view and head rotation, finding that a restricted field of view did not affect the accuracy of distance estimations when head movement was allowed. Experiment 3 found that performance with monocular viewing was equal to that with binocular viewing."

p.7, Experiment 2 Method
> "To restrict FOV, we used a pair of viewing goggles that constrained the participants FOV to approximately 42º horizontally by 32º"

p.8, Experiment 2 Results
> "However, restricting head rotation led to underestimated distance judgments (see Figure 5)."
> "The slopes for the full-FOV, FOV-rotate, and FOV-no rotate were .93, .92, and .78, respectively"
> "Our results showed that given the freedom to rotate one’s head, a narrow horizontal field of view of 42 degrees did not impair distance estimations in the real world"

p.10, Experiment 3 Results
> "There was no difference in performance between the monocular and binocular viewing conditions."

### B5. CuQlock-Knapp et al. 2001, ARL-TR-2407 (fetched by another track; read here)
File: `CuQlock-Knapp_2001_ARL-TR-2407_NVG_viewpoint_offset_grenade.pdf`, pdf p.16
> "The field of view (FOV) for these viewing devices was approximately 40”, equivalent to typical NVG FOVs, with a visual Snellen acuity approaching 20/25."
(The "40”" is the PDF's rendering of 40°.)
Same page, immediately before [added by verifier; gives the conditions of the 20/25 figure]
> "Lens caps with pinholes were fitted to the objective lenses of the NVGs to permit them to be used in semi-dim illumination (approximately 0.016 ft)."

### B6. USAARL "Helmet-Mounted Displays: Sensation, Perception and Cognition Issues" (2009), Ch.17 Melzer et al., "Guidelines for HMD Design" (fetched by another track; read here)
File: `USAARL_HMD2009_Section-26-Chapter-17-Guidelines-for-HMD-design.pdf`, p.813 (pdf p.9)
> "For the dismounted Warfighter, the monocular AN/PVS-14 NVG also provides a 40° circular FOV."
> "In most cases, it is necessary to match the FOV of the HMD with that of the sensor to achieve a 1:1 correspondence between sensor and display FOVs to ensure an optimum task configuration. Similarly, NVGs are specified to be a unity magnification. That is, the input FOV must match the output FOV to within a few percent."

---

## C. Magnification and minification

### C1. Kuhl, Thompson & Creem-Regehr, VSS 2008 poster (single page)
File: `Kuhl2008_VSS_poster.pdf`, p.1
(Verifier note: the poster is three columns, and pdftotext interleaves them line by line, so these quotes are not contiguous strings in the .txt; each was checked by reading the column in `Kuhl2008_VSS_poster.txt`.)
> "Minifying the graphics displayed in the HMD by 30% reduces the angle of declination by approximately the same amount as the tilt manipulation."
> "Baseline condition: Subjects judged targets to be 80% of their actual distance on average when using the HMD with no manipulations."
> "Subjects walked an average of 98% of the way to the targets. This result differs significantly from the baseline condition (F(1,21)=5.94, p<0.05)."
> "World tilted up condition: Subjects judged targets to be 84% of their actual distance when the world was tilted up. This result is not significantly different from the baseline condition (F(1,21)=0.03, p=0.86)."
> "▸ Minification increases the perceived distance to targets in HMDs."
> "- Direct blind walking ... - Targets on floor at 3,4,5,6m"

### C2. Zhang, Nordman, Walker & Kuhl 2012, ACM TAP 9(3) (author copy)
File: `Zhang2012_minification_distance_HMD_TAP.pdf`, pdf p.3, §2.1–2.2
> "We measured the field of view of our HMD to be 47.40 × 39.85 degrees in the horizontal and vertical directions respectively."
> "In the minified condition, the imagery was effectively scaled to 0.7 times its original size to correspond with previous work [Kuhl et al. 2009]."

pdf p.5, §2.3–2.4
> "On average, participants walked 76 and 95% of the displayed target distance in the calibrated and minified conditions respectively."
> "Minification also reduces the overall optic flow for a given viewpoint movement."
> "If a person uses their actual viewpoint velocity information with minification-reduced optic flow, the mathematical equations will indicate that the distance to the points in the flow field have increased. Minification reduces the visual angle of any given object and therefore can cause familiar size cues to indicate that the object is farther away."
> "Minification reduces binocular disparity because the images seen in the left and right eyes are reduced in the HMD." [added by verifier]

pdf p.6, §3.1–3.2 (Experiment 2, verbal reports) [added by verifier; the report previously cited pp.1, 3, 5 for these numbers]
> "We used a between-participant design with 13 participants in the calibrated condition and 14 participants in the minified condition."
> "As shown in Figure 3, minification did not significantly affect verbal reports of distance. On average, participants reported targets to be 74% and 77% of the veridical distance in the calibrated and minification conditions respectively."
(The source breaks "par-/ticipants" across a line; the hyphen is joined here.)

pdf p.1, Abstract
> "This study demonstrates that minification affects blind walking in a sparse classroom and does not influence verbal reports of distance."

### C3. Luo, Lichtenstein & Peli 2007, Proc. SPIE 6426 (author copy)
File: `Luo_Peli_2007_collision_judgment_minified_HMD_SPIE.pdf`, pdf p.1, Abstract
> "Methods: Simulated scenes were presented to subjects as if they were walking in a shopping mall corridor."
> "Results: The use of the 5× minification device caused only an 18% increase of CE (13cm, p=0.048)."
> "Conclusion: Minification had only a small impact on collision judgment."
pdf p.1, Abstract ("Purpose") [section corrected by verifier: was "Introduction"]
> "In the minified display, objects appear closer to the heading direction than they really are."
pdf p.1, Abstract ("Methods") [added by verifier]
> "Ten normally sighted subjects were tested (1) when not using the device and with one eye patched, and (2) when the see-through view of device was blocked and only minified images were visible."
pdf p.1, Introduction [added by verifier]
> "The video signals are processed by a portable controller to derive edge images that are presented in the display (FOV=16°) on another side."

### C4. McLean, Erkelens, Sherbak, Mikkelsen, Sharma & Cooper 2023, J Vis 23(8):10 (PMC10414133; Europe PMC full-text XML, no page numbers)
File: `McLean2023_minification_discomfort_wearable_optics_JVis_PMC10414133.txt`, Abstract
> "Forty participants wore 0%, 2%, and 4% radially symmetric optical minifying lenses binocularly (over both eyes) and monocularly (over just one eye)."
> "All lens pairs except the controls (0% binocular) were consistently associated with increased discomfort along some dimension. Greater minification tended to be associated with greater discomfort"
> "our results suggest that dizziness and visual motion were the most reported physical and perceptual symptoms during naturalistic tasks."

Section "Background / Effect of minification on perception of world and object motion"
> "When minification is present, the amount the eyes need to rotate to stabilize a target differs from the normal rotation executed by the VOR (Figure 1B). Mismatched eye rotation can result in retinal slip and oscillopsia–the perception that the world is moving even when it is stable"
> "Although the VOR gain can adapt quickly, it is possible that oscillopsia is present for a short duration each time wearable optics are put on or removed"

Section "Background / Effect of minification on perception of world and object motion" [added by verifier]
> "In other words, the VOR gain (the ratio of eye velocity to head velocity) is ideally 1."

Section "Methods" (naturalistic task) [added by verifier]
> "participants reported their degree of physical symptoms in terms of headache, dizziness, and nausea on a 1–5 Likert scale (1 = not at all, 2 = mild, 3 = moderate, 4 = bad, 5 = severe)."

Section "Background / Effect of minification on perception of space and shape"
> "Together, these disruptions in perceived space and shape can cause errors or uncertainty when performing tasks like reaching for objects or walking on uneven terrain (Schot, Brenner, Sousa, & Smeets, 2012)."

---

## D. Thermal detection range (Johnson criteria, vendor implementations)

### D1. Axis Communications, "Thermal technology glossary"
File: `Axis_thermal_technology_glossary.pdf`, pdf p.4, §2.1 "Johnson’s criteria"
> "With that resolution, there is a 50% probability that an observer can distinguish an object at the specified level: detection, recognition, or identification."
> "For a thermal sensor, the temperature difference between the object and its background needs to be at least 2 °C (3.6 °F). Objects to distinguish are typically a person, defined with a critical width of 0.75 m (2.5 ft)"
> "At least 1.5 pixels across the object width are needed for detection"
> "At least 6 pixels across the object width are needed for recognition"
> "At least 12 pixels across the object width are needed for identification"

### D2. Dahua, "Thermal Camera Range Performance for DRI and IVS V2.0"
File: `Dahua_thermal_range_performance_DRI_V2.pdf`, pdf p.3, §2
> "Detection–3.6 pixels /1.8m =2 pixel per meter, an object is present [something is there]."
> "Recognition – 14 pixels/1.8m= 7.8 pixel per meter"
> "Identification – 28pixels/1.8m =15.6 pixel per meter"
pdf p.3, §2 [added by verifier]
> "This guide describes the distance the camera can see under ideal conditions, ensuring you understand the best case scenario limitations."
pdf p.5, §3.1 table "(1.8m*0.5m) Human", row 256×192
> "BF1241       3.5mm           50.6°×37.8°          146m             38m              19m"

### D3. MOBOTIX, "Thermal Systems Johnson Criteria" (pixel thresholds stated differently, given for comparison)
File: `Mobotix_Johnson_criteria.pdf`, p.1
> "Detection                  An object is present and moving (2 vertical pixels are visible)"
> "Recognition                It is possible to distinguish objects, e.g., a person or a vehicle (8 vertical pixels are visible)"

---

## E. PAL / CVBS signal limits

### E1. ITU-R BT.470-6 (1998), Conventional television systems
File: `ITU-R_BT.470-6_TV_systems.pdf`, pdf p.1, Annex 1 (general text above the tables) [page corrected by verifier: was "pdf p.2"]
> "All television systems listed in this Annex employ an aspect ratio of the picture display (width/height) of 4/3, a scanning sequence from left to right and from top to bottom and an interlace ratio of 2/1"
pdf p.2, Table 1, item 6 (column "B, B1, D1, G")
> "6     Nominal video bandwidth (MHz)                     4.2             4.2            5             5"
pdf p.5, Table 1-1 (625-line systems B, G, ...)
> "H         Nominal line period (µs)                                       63.492                 64                64(3)"
> "a         Line-blanking interval (µs)                               10.2 to 11.4(4)    10.24 to 11.52            +0.0"
> "(10.9 ± 0.2)        (12 ± 0.3)           12 −0.3 µs(5)"
(The pdftotext layout splits the table across lines. The third column, the 625-line B/G/... systems, reads 12 µs, +0.0/−0.3 µs.)

### E2. ITU-R BT.601-7 (2011), Studio encoding parameters of digital television
File: `ITU-R_BT.601-7_digital_TV_studio.pdf`, pdf p.9 (printed p.7), Table 3 (4:2:2, column 625-line), items 4 and 6
> "4) Sampling frequency:
>     – luminance signal                                           13.5 MHz"
> "6) Number of samples per digital
>     active line:
>     – luminance signal                                                720"
