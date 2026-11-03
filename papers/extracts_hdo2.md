# Verbatim extracts — Track 04: HDO2 hardware + helmet mass/CoG

Each entry: quote (verbatim, from the downloaded file) — file — page/section.
Page numbers: "p.N" = page number printed in the document; "pdf p.N" = PDF page index where they differ.
Retrieved 2026-11-03. Downloaded files are untrusted data; text extracted with `pdftotext`, nothing executed.

---

## A. Fat Shark Dominator HDO2 user manual (official, FSV1123 Rev C 10/26/2019)

File: `papers/FatShark_HDO2_Manual_RevC.pdf` (12 pp., 7 342 309 B; source: Fat Shark help centre attachment,
https://s3.amazonaws.com/helpscout.net/docs/assets/60f07b177f650717b4ecb103/attachments/67193a6b3a0b506883e528c3/FSV1123-HDO2-Manual-RevC.pdf,
linked from https://fat-shark.helpscoutdocs.com/article/202-headsets). Text: `FatShark_HDO2_Manual_RevC.txt`.

A1. "If you connect a 7-13V (2S or 3S) power source to the power port the HDO2 will automatically power on and it will power off when the source is removed." — p.6, "Input Power"

A2. "The HDO2 is shipped in Legacy Mode." / "If you want, you can change the input power to use the Power Button to turn on and off the headset. To do this, you need to remove the Expansion Bay door and move the power mode jumper from Legacy Mode to Button Mode" — p.6, "Input Power"

A3. Figure labels on p.6 (side view photo): "Power Port (7-13V)", "AV Input/Output", "Expansion Bay", "Antenna Port", "VRx Modular Bay" — p.6, figure. (Verifier, from the rendered page: Power Port, AV jack and Expansion Bay arrows all point at the left-hand photo, i.e. the same side; Antenna Port and VRx Modular Bay point at the right-hand photo, the opposite side. Both photos also show an unlabelled black vented block on the top centre of the shell; no text identifies it.)

A4. "Fan speed is proportional to the input voltage. If the headset is being powered from a 2S battery, maximum speed is recommended, and we recommend lowering fan speed if using a 3S source." — p.7

A5. "The low battery alarm also exhibits different behaviors for 2S and 3S sources. It is designed to work for a 2S source and may not provide much warning for a 3S source. We recommend not relying on the low battery indicator if you are using a 3S source" — p.7

A6. "Low battery warning: Audio warning if input voltage drops below 6.8V which only works well for a 2S power supply" — p.8, "General Operation"

A7. "This can be done by using a VRx with an external camera, the AV in, or even the DVR menu." — p.7, "Optical Adjustments"

A8. "Display mode selection: Vertically depressing the contrast/brightness button for a short press scrolls through the following modes: Analog 4:3, Analog 16:9, HDMI." — p.8

A9. "RX power switch: The RX module power is independently controlled via this switch. If a module is inserted, but desired video source is via the AV cable; the RX module needs to be turned off to avoid image conflict." — p.9

A10. "AV connector Pin-out" ... "3.5mm AV Connector: Yellow: Video, White: Audio Left, Red: Audio Right" — p.10. Plug drawing labels, read from sleeve (body) to tip: "Ground  Video  AudR  AuL" — p.10, figure (4 contacts: sleeve = Ground, ring 2 = Video, ring 1 = Audio R, tip = Audio L).

A11. "It seats securely in the headset strap pocket. The soft silicone battery cable extends out of the top of the pack to avoid contact with head strap. Barrel connector cable features high strand count wire" — p.10, "Fat Shark 18650 Battery Case"

A12. Specifications — p.11:
- "FOV (field of view): 46 degrees diagonal"
- "Display: Two Sony 0.5” OLED displays / Resolution 1280 X 960 / NTCS/PAL auto selecting / AV Mode 4:3 / AV Mode 16:9 / HDMI Mode 16:9"
- "Power Supply: 7 – 13V input voltage (2S – 3S Supply)"
- "Power Consumption: 320mA @ 7.5V input power (no RX module) / 770mA @ 7.5V input power (Rapid" [line truncated in the PDF itself]
- "Battery: 7.4V, 1.8A 18650 Battery Case (optional))"
- "Interface: 3.5mm AV in/out port / Power input port / 3.5mm 3p earphone port / MicroSD / RF Module Bay / HT connector 3 pin internal connection / Power Button"
- "Dimensions: 169.2 x 80 x 45.5 mm"
- "Weight: 206.8 g"

A13. "Power is the actual maximum power provided to the OLED panels. ... This will have a negative impact on battery life as it can significantly increase power consumption. It is recommended to keep the OLED power setting at or below 75 for battery life reasons." — p.8, "Display Configuration"

A14. Headset overview figure labels — p.5: top: "HT Button", "DVR 5-way Switch", "Volume Level", "Display 5-way Switch", "Channel Selection"; underside: "IPD Adjusters", "Focus Adjustment", "Power/Fan Button", "Receiver on/off", "Earphone Jack", "Mini HDMI port"; inside: "SD Card Slot", "DVR Indicator LED".

## B. Fat Shark Dominator HDO (v1) manual FSV1122 Rev B — predecessor, for contrast only

File: `papers/FatShark_HDO_FSV1122_Manual_RevB.pdf` (same help-centre page). Applies to HDO v1, NOT HDO2.

B1. "PS/2 Data Port (Head Tracker)" — overview figure, p.6 (txt l.130–132)
B2. "Power Supply: 7 - 13 V (2S/3S supply – fan plate only accepts 2S input)" / "MiniDIN4 data port (head tracking)" / "Weight: 159 g" — Specifications (txt l.412, 442, 455)
B3. "If multiple power sources are supplied at same time (i.e. Futaba radio and head strap battery) the headset will draw power from the highest voltage." — "Power Options" (txt l.267–268)

## C. USAARL / Rash et al. (eds.) 2009, *Helmet-Mounted Displays: Sensation, Perception and Cognition Issues*, Ch. 17 "Guidelines for HMD Design" (Melzer, Brozoski, Letowski)

File: `papers/USAARL_HMD2009_Section-26-Chapter-17-Guidelines-for-HMD-design.pdf` (downloaded by a parallel track; read by this track).

C1. "The human head weighs approximately 9 to 10 pounds (mass of 4 to 4.5 kg) and sits atop the spinal column." — p.827 (pdf p.23)

C2. "The CM of the head is located at or about the tragion notch, the small cartilaginous flap in front of the ear. Because this is up and forward of the head/vertebra pivot point, there is a tendency for the head to tip downwards, were it not for the strong counter force exerted by the neck extensor muscles" — p.827 (pdf p.23)

C3. "In 1998, the USAARL published a set of two curves that defined limits of acceptable longitudinal and vertical CM location as a function of head-supported weight, commonly referred to as the “USAARL curves” ... These were developed to provide HMD designers with guidance that would minimize performance degradation during typical helicopter flight scenarios ... as well as minimize the risk of acute neck injury during severe, but survivable, helicopter mishaps (McEntire and Shanahan, 1998)." — p.829 (pdf p.25)

C4. "Fraser, Alem and Chancey (2006) found that increased head-supported weight and anterior CM position had significant adverse effects on Warfighter performance in visual tracking tasks." — p.829 (pdf p.25)

C5. Figure 17-11 caption: "Vertical CM location as a function of head-supported weight/mass (top); allowable head-supported weight/mass as a function of longitudinal CM location (bottom)." Axes: "Vertical Distance from Tragion Notch - mm" vs "Head Worn Mass (kg)"; "Head Worn Mass (kg)" vs "Longitudinal Distance from Tragion Notch (mm)"; region labels "Accepted Injury Risk" / "Severe Neck Injury Risk", "Acceptable Region" / "Unacceptable Region"; reference line "Ectocanthus (reference line)". — p.830 (pdf p.26)
   Values READ FROM THE PLOT by this track (not printed as numbers; ±~3 mm / ±~0.1 kg): top curve flat at ~52 mm up to ~1.75 kg, falling linearly to 0 mm at 2.5 kg (≈30 mm at 2.0 kg); ectocanthus line at ~15 mm. Bottom curve: 2.5 kg allowed from −20 mm to ~+17 mm; allowed mass falls to ~1.5 kg at +40 mm, ~1.15 kg at +60 mm, ~0.9 kg at +80 mm, ~0.8 kg at +95 mm (right edge); left boundary vertical at −20 mm.
   Verifier re-digitisation (pdftoppm 300 dpi, pdf p.26, axis frame located by pixel counts; curve pixel centre per column): 2.27 kg @ +20, 2.03 @ +25, 1.81 @ +30, 1.53 @ +40, 1.31 @ +50, 1.14 @ +60, 0.92 @ +80, 0.84 @ +90, 0.80 @ +94; knee ≈ +16–17 mm; right boundary ≈ +94–95 mm. The original "~1.6 kg at +40 mm" was corrected to ~1.5 kg.

C6. Knox-box refinement (USAF fixed-wing, origin = occipital condyles): "Maximum head-supported weight of 5 lb (2.5 kg) (including MBU-20/P oxygen mask and 3 inches [7.6 cm] of hose, helmet, visor and HMD components)." / "Vertical CM limits (z-direction): Between +0.5 inches (1.3 cm) and +1.5 inches (3.8 cm) above the occipital condyles." / "Threshold CM horizontal limits (x-direction): between +0.5 inches (1.3 cm) forward and -0.8 inches (2 cm) aft of the occipital condyles." — p.830 (pdf p.26); "Objective CM horizontal limits (x-direction): between +0.2 inches (0.5 cm) forward and -0.8 inches (2 cm) aft of the occipital condyles." / "Lateral CM limits (y-direction): ± 0.15 inches (± 0.4 cm)." — p.831 (pdf p.27)

C7. "Recommendations for dismounted Warfighters are unfortunately less well-defined." — p.831 (pdf p.27)

C8. "Frangibility refers to the ability of an HMD component to break free from the overall helmet-HMD system during a dynamic event. The purpose is to “shed” mass from the HMD system, thereby reducing the risk of neck injury" — p.831 (pdf p.27); "the attachment mechanism was re-designed with a spring-loaded "ball and socket" engagement, allowing the NVG to separate from the mount when exposed to a 10G to 15G load." — p.831 (pdf p.27)

## D. Shivers et al. 2018, USAARL, "Preliminary Characterization of Head-Supported Mass Exposure in a Simulated Dismounted Operating Environment", Army S&T Symposium (slides)

File: `papers/Shivers_2018_NDIA_HSM.pdf` (https://ndia.dtic.mil/wp-content/uploads/2018/armyst/Shivers.pdf), 18 slides.

D1. "Existing HSM criteria do not include guidance for rapid technology advancements" / "No HSM criteria exist for mounted or dismounted Ground Soldiers" — slide 4
D2. "Existing HSM guidelines developed by USAARL around aviation-type exposures (McEntire, 1998) – Acute Injury Risk – Performance Decrement" — slide 5
D3. "Simulated HSM conditions: Varied mass and center of mass offset* a) Baseline ACH (1.5 kg, -1.4 cm rearward offset) b) Mid-mass/neutral offset (2.5 kg, neutral offset) c) Mid-mass/forward offset (2.5 kg, 4 cm forward offset) *Center of mass offset = longitudinal distance from tragion notch" — slide 7
D4. "Low to moderate acceleration with longer duration and/or greater frequency may contribute more to muscle fatigue and performance decrement." — slide 15

## E. Merkle, Kleinberger & Uy 2005, "The Effects of Head-Supported Mass on the Risk of Neck Injury in Army Personnel", JHU APL Tech. Digest 26(1)

File: `papers/Merkle_2005_APL_HSM.pdf` (9 pp.).

E1. "The U.S. Army Aeromedical Research Laboratory (USAARL) at Fort Rucker, Alabama, is conducting research to establish recommended limits and center of gravity (CG) locations of HSM that can be worn safely by soldiers." — p.76
E2. "it is evident that extension is not only significantly affected by HSM position and magnitude, but that the more anteriorly and inferiorly the CG is located on the head, the larger the extension moment becomes. Similarly, the results indicate that neck flexion moment would be expected to increase as the CG moves in the posterior and superior directions." — p.82
E3. "None of the tests conducted with the 3.5-lb helmet, the lowest level of added HSM, exceeded the individual peak force or" — p.82 (sentence continues on next column/page)
   Context: frontal crash sled tests (Hybrid III ATD, ~40 ft/s), not walking.

## F. GoPro mounts

F1. GoPro Universal Adhesive Mount AACFT-011 product page — `papers/gopro_AACFT-011_universal_adhesive_page.html` (+ .txt), https://gopro.com/en/ro/shop/mounts-accessories/universal-adhesive-mounts/AACFT-011.html:
"Apply mount to a clean, smooth surface (non-porous and non-textured) and let it sit at room temperature for at least 24 hours to ensure it sticks properly." — "Product Details" (txt l.154)

F2. GoPro Curved + Flat Adhesive Mounts AACFT-001 product page — `papers/gopro_AACFT-001_product_page.html` (+ .txt):
"Includes 3 Curved Adhesive Mounts and 3 Flat Adhesive Mounts" / "Can be removed by heating the adhesive bond with a hair dryer then peeling off the mount." — "Product Details" (txt l.144–146). "Industrial-strength adhesive ensures secure mounting" — txt l.148. (Neither GoPro page names 3M or VHB.) (No dimensions, curvature radius or adhesive grade given on the page.)

F3. Altair's GoPro mounts library for OpenSCAD v1.2.2 (M. A. Valášek, 2021), community source — `papers/gopro_ridercz_GoPro.scad.txt`, https://github.com/ridercz/GoProScad:
"// These values are fixed and defined by GoPro mount standard" / "__gopro_outer_diameter = 15; // Outer diameter of the legs" / "__gopro_leg_width = 3; // Width of the legs" / "__gopro_slit_width = 3.5; // Width of the slits, including tolerance" / "__gopro_hole_diameter = 5; // M5" / "__gopro_hole_tolerance = .5; // Print tolerance for hole" — lines 8–13; "base_depth = __gopro_slit_width * 2 + __gopro_leg_width * 3 + nut_depth;" — line 31 (female: 2×3.5 + 3×3 + 3 = 19 mm); "base_depth = __gopro_leg_width * 2 + __gopro_slit_width;" — line 59 (male: 2×3 + 3.5 = 9.5 mm)
   `papers/gopro_ridercz_README.md.txt`: "To join the parts together a simple M5 screw and nut (square nut, preferrably) is required." ; male: "depth is always 9.5." ; female: "depth is always 19 mm." ; "Default to M5 square nut." ; "Usually, M5x50 screws are ideal."

## G. Fat Shark module-bay pinout (community, not Fat Shark; generation not confirmed for HDO2)

G1. `papers/skaman82_fatshark_module_schematic_rev06.png` (schematic of the open-source 2.4 GHz Fatshark RX module, https://github.com/skaman82/2.4GHz-Fatshark-Module, img/schematic rev06.png), connector "GOOGLE_IO", pins as drawn: "1 5V", "2" (no net), "3 GND", "4 A_R", "5 A_L", "6 VIDEO", "7 CH3/TXD0", "8 CH2/RXD0", "9 CH1". — schematic, lower right.
G2. `papers/skaman82_fatshark_module_README.md.txt`: "RX28 based Fatshark RX module" / "Fatshark button control" / "GOGGLE CONTROL: Enables fatshark button control." (README l.29; earlier transcription "GOOGLE CONTROL" corrected by verifier) / "it works also with the google buttons (if the feature is active)".

## H. Printables community models for HDO2 (metadata via Printables API; STLs in `papers/printables_stl/`)

File: `papers/printables_hdo2_models.txt`.
H1. #262727 "Triple feed 150mm antenna support for Fatshark HDO 2" (ericogr, 2022-08-20): "With this support, the antenna can be easily removable from goggles." Files: fan.stl, connector.stl, antenna.stl.
H2. #1073216 "Supporto Vrx Walksnail per Fatschark hdo2" (FlowerFpv, 2024-11-14): "permette di tenere la vrx più parallela alla parte anteriore dei googles." File: one STL.
H3. #215826 "HDO2 adapter for HDZERO VRx" (MrMPod, 2022): "After mounting HDZERO VRx on HDO2 there is no room for a patch antenna, so I made a little adapter".
H4. #356617 "HDMI Cable Retainer for HDO2 Goggle" (billyd, 2023): "you will need the following to complete the assembly: 5mmx25mm hex socket head screw / 5mm heat set insert. 6.8mm long".
H5. #43244 "FatShark Goggle 18650 Li-Ion Battery Holder Case" (JRD, 2020): "Angled DC jack ID2.2mm OD5.5" (generic Fat Shark goggles, not HDO2-specific).
H6. #384249 "Fatshark goggle strap battery holder" (SebWer, 2024): "This battery holder is designed for Fatshark Li-Po battery pack 1800mAh." / "completely fall out from my Fatshark HDO goggles strap."
STL bounding boxes (computed by this track): 262727_fan.stl 29.0 × 43.0 × 6.0 mm; 1073216 support 44.3 × 28.1 × 7.0 mm.
H7. STL geometry measured by the verifier (vertex least-squares circle fits, python on the STLs in `papers/printables_stl/`): `262727_fan.stl` = square frame, 4 holes Ø2.0 mm centred at (±10, ±10) mm → 20 × 20 mm square, inner opening ≈25 mm between walls (y −12.6…+12.5), plus a 2-prong tab (prongs 5 mm wide, 4 mm gap, 5 mm thick). `1073216_…stl` = plate with a round hole Ø24.0 mm (fit residual 0.0) and 4 holes Ø1.5–1.6 mm at x = 1.0/21.0, y = ±9.9/±10.0 → 20 × 20 mm square around the hole; plus a 3-finger hinge (fingers ≈3 mm, gaps ≈3 mm). Earlier description "ring frame with 2 hinge fingers" and "round feature of roughly 20–25 mm" replaced by these numbers.

## I. Camera / battery figures used in the mass & power budget (files from parallel tracks, read here)

I1. `papers/bzbuas_tr1-220sl_product_page_en.txt` (shop page, not Caddx manual): "Input voltage 9-24V" (l.82–83); "AI box size 33.5x33.5x16.5mm" / "Weight 55g" (l.90–95, weight listed directly under AI box size — scope ambiguous); Infra "Power Consumption <1.5W" / "Camera size 20x20.5x34.5 mm" (l.111–114); thermal "Power Consumption <1.5W" / "Camera size 19.5x19.5x20mm" (l.128–131); "Working Temperature -10°C ~ 50°C".
I2. `papers/ctrl_molicel_p28a.pdf` (Molicel INR-18650-P28A datasheet): "Typical 2800 mAh" / "10.3 Wh"; "Nominal 3.6 V"; "Charge 4.2 V"; "Discharge 2.5 V"; "Weight 46 g (Typical)"; "Temperature Discharge -40°C to 60°C".
