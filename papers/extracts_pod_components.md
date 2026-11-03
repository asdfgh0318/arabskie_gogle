# Extracts: pod component mechanical dimensions (track 07a)

Verbatim passages and data behind `research/07a_pod_components.md`. Each entry gives the file in `papers/`, its location
(PDF page, text-file line or drawing), and the verbatim text or value. Where a number comes from a drawing (an image,
not text), the entry says **[drawing]**, names the rendered PNG I read, and quotes the dimension as printed. Values
pulled out of DXF/KiCad files are **[file data]**, with the entity or record they come from.

**Where this file and the source files disagree, the source files govern.** Retrieved 2026-11-03.

Text-file line numbers refer to the `.txt` next to each PDF/HTML (pdftotext `-layout` output, or HTML stripped to text).

---

## E1. Alps EC11E series catalog (Update 2510)
File: `pod_alps_EC11E_catalog.pdf` (+ `.txt`). URL: https://tech.alpsalpine.com/cms.media/product_catalog_ec_01_ec11e_en_611f078659.pdf
(Byte-identical, md5 bed05069…, to `pod_Alps_EC11E_catalog_2510.pdf`, which another track saved.)

- E1.1 p.1, txt L13–14: "▪Ratings：10mA 5V DC" / "▪Operating life：15,000 cycles"
- E1.2 p.1, txt L38 (product list row): "EC11E09244BS  Vertical  Flat  20  10±7mN・m  18  9  With  0.5  ●"
  (columns: Control part orientation | Actuator configuration | Actuator length (mm) | Detent torque | Number of detent | Number of pulse | Push-on switch | Travel of push-on switch (mm) | Automotive | Drawing No.)
- E1.3 p.1, txt L47: "EC11E09244AQ  Vertical  Flat  20  10±7mN・m  18  9  With  1.5  ●" (Drawing No. 3)
- E1.4 p.1: all nine listed EC11E part numbers have actuator length **20** mm (txt L32–56). No shorter standard part number is listed.
- E1.5 p.1, txt: "3. Products other than those listed in the above chart are also available. Please contact us for details."
- E1.6 p.2 **[drawing]** Drawing No.2 (push, 0.5 mm travel; applies to EC11E09244BS). Rendered: `pod_render_alps_EC11E_drawing2.png`, zoom `pod_render_alps_EC11E_drawing2_side_zoom.png`. Printed dimensions, "Unit: mm":
  - side view: "24.5" (mounting surface → shaft tip); "4.5" (mounting surface → top of body); "(20)" (top of body → tip); "7" (first shaft section from body); "10" (flat length at tip); "Switch travel 0.5"; "4.5 0/−0.1" (across the flat); "ø6 0/−0.05" (shaft); "C1" (tip chamfer); "R0.5"; "3.5" (terminal length beyond mounting surface, top and bottom terminals "(Switch02)" "(Switch01)"); "2.5" (vertical dimension across the feature on the shaft axis behind the mounting surface, i.e. the mounting tab seen edge-on; consistent with the 2.6 slot; interpretation [img], verification pass).
  - front view: "11.7" (body width); "6" + "6" (shaft axis to body top / body bottom); "7.5 max." (shaft axis → terminal ends, A C B side); "9.2" (lower body feature width); terminals labelled "D E" (top) and "A C B" (bottom). Verification pass [img]: the mounting tabs are drawn protruding past the 11.7 body sides, and the D/E terminals past the +6 body edge; neither extent is dimensioned.
  - no thread is drawn or called out anywhere on the shaft or collar (the side view shows a plain collar then the shaft).
- E1.7 p.2 **[drawing]** Mounting Hole Dimensions, Drawing No.2, "Viewed from mounting side.": "12.5±0.05" (between the two tab slots); "5" (D–E spacing); "7" (shaft axis → D/E row); "7.5" (shaft axis → A/C/B row); "5" (A–B spacing; C in the middle); "1.5 +0.1/0" and "2.6 +0.1/0" (tab slot size); "5-ø1 +0.1/0 hole"; "Tolerance : ±0.1".
- E1.8 p.2 **[drawing]** Drawing No.3 (1.5 mm travel; EC11E09244AQ): identical to No.2 except "Switch travel 1.5". Rendered: `pod_render_alps_EC11E_drawing3.png`.

## E2. Alps EC11E09244BS product detail page
File: `pod_alps_EC11E09244BS_detail.html` (+ `.txt`). URL: https://tech.alpsalpine.com/e/products/detail/EC11E09244BS/
Figures: `pod_alps_EC11E09244BS_detail_dimensions.png` (= catalog drawing No.2), `pod_alps_EC11E09244BS_detail_mounting_holes.png`, `pod_alps_EC11E_shaft_varieties.png`.

- E2.1 txt L18: supply status "Standard" (L22–23 define it: "The product is mass-produced and recommended for new designs.")
- E2.2 txt L66–67: "Actuator length" / "20mm"
- E2.3 txt L79–80: "Operating temperature range" / "-40℃ ～ +85℃"
- E2.4 txt L95–96: "Push-pull strength" / "100N"
- E2.5 txt L103–106: "Travel" / "0.5±0.3mm" / "Operating force" / "6(+2.5, -2)N"
- E2.6 txt L137: "Values in parentheses apply to products without push-on switch."
- E2.8 txt L113–117: "Minimum order unit(pcs.)" / "Japan" / "1,200" / "Export" / "2,400" (added in verification).
- E2.7 **[drawing]** `pod_alps_EC11E_shaft_varieties.png` (figures `product_detail_fig_ec11_c_11/12/13`, "Product Varieties：Single-shaft Type", "Style (Shaft diameter : φ6)"):
  - "1) Knurled Type", "20 teeth Serrated", collar "ø7": table L1 / LB / ℓ1 / ℓ2 / S1 = "20 7 6 1 7" and "25 10 10 2 11".
  - "2) Flat Type", collar "ø7", "C1": table L1 / LB / ℓ = "※ 15 5 7"; "15 7 5 (6)"; "20 7 10 (12)" (row highlighted on the BS page); "25 10 12"; footnote "※ Does not comply with EC111".
  - "3) Slotted Type", collar "ø7", slot "1.6", "1": L1 / LB = "15 7", "20 7", "25 10".

## E3. Alps EC11M and EC111 catalogs, EC11B series page (shorter-shaft search)
- E3.1 `pod_alps_EC11M_catalog.pdf`, p.1 txt: "EC11M1565403  Vertical  Serrated  25 …  With  1.5" and "EC11M1575403 … Serrated 25 … With 1.5". Both 25 mm.
- E3.2 `pod_alps_EC111_catalog.pdf`, p.1 txt: "▪Output signal：Self-return switch"; rows "EC1110120005 … Flat 15 … Without", "EC111012010H … Flat 20 … With 0.5", "EC1110120201 … Flat 20 … With 1.5". EC111 is a self-return switch, not an A/B encoder.
- E3.3 `pod_alps_EC11B_series_page.html` (https://tech.alpsalpine.com/e/products/category/encorders/sub/01/series/ec11b/): "11mm Size Metal Shaft Type EC11B Series Compact and highly reliable type available in many varieties. Back to Previous Page Discontinued".
- E3.4 `pod_alps_encoders_metal_shaft_list.html` (category page): lists series ec09e, ec111, ec11b, ec11e, ec11g, ec11j, ec11k, ec11m, ec11n, ec20a, em11b, em20b. On their saved series pages (`pod_alps_EC11{B,G,J,K,M,N}_series_page.html`, `pod_alps_EC111_series_page.html`), EC11M and EC111 are "Standard"; EC11B and EC11G "Discontinued"; EC11J, EC11K and EC11N "Not Recommended for New Designs". EC11E09244BS is "Standard" per its detail page (E2.1).

## E4. Bourns PEC11R datasheet (REV. D04/26)
File: `pod_bourns_PEC11R.pdf` (+ `.txt`). URL: https://www.bourns.com/docs/Product-Datasheets/PEC11R.pdf
Renders: `pod_render_bourns_PEC11R_p1.png`, `_p2.png`, `_p3_shaft_hw.png`.

- E4.1 txt L11: "PEC11R Series - 12 mm Incremental Encoder"
- E4.2 txt L47: "IP Rating … IP 40"; L66: "Weight … 5 gm (0.17 oz.) max."; L59: "Mounting … 10.2 kgf-cm (8.83 lb.-in.) max."
- E4.3 txt L81–83: "Hardware… One flat washer and one mounting nut supplied with each encoder"
- E4.4 txt L102–106: "Switch Travel … 0.5 ± 0.3 mm"; "Switch Actuation Force … 610 ± 306 gf (8.47 ± 4.24 oz.in.)"
- E4.5 txt L311–312: "1 = PC Pin Vertical / Side Facing 7 mm   4 = PC Pin Horizontal / Rear Facing"; "2 = PC Pin Vertical / Side Facing 10 mm"
- E4.6 txt L315–316: "0 = No Detents (12, 18, 24 pulses)  2 = 24 Detents (12, 24 pulses)"; "1 = 18 Detents (18 pulses)  3 = 12 Detents (12, 24 pulses)"
- E4.7 txt L317–320: "Standard Shaft Length" / "15 = 15.0 mm  25 = 25.0 mm" / "20 = 20.0 mm  30 = 30.0 mm"; L322: "F = Metal Flatted Shaft"; L324: "S = Push Momentary Switch"; L328: "0018 = 18 Pulses per 360 ° Rotation"
- E4.8 **[drawing]** p.2, "PEC11R-4xxxF-Sxxxx" (shaft perpendicular to PCB): "6.5" (from the "MOUNTING SURFACE", whose leader points to the body rear = PCB plane, to the bushing base / body front; L is measured from the bushing base; corrected in verification); "M7 x 0.75"; "L", "LB", "F"; "0.5 SWITCH TRAVEL"; "C: 0.5"; "4.5 +0/-.05" (across flat); "6.0 ± 0.1 DIA."; "12.5" × "13.4" body; "13.2" (between the two mounting-tab slots); "2.6 +0.2/-0" × "1.8 +0.2/-0" tab slots, "2 PLCS."; "1.0 +0.1/-0 DIA. 5 PLCS."; "5.0" (A–B and switch-pin spacing); "7.0" (axis → switch pins row), "7.5" (axis → A C B row); "14.0".
  The -4xxxF-S side view also prints "7.0" (axis → switch pins), "7.5" (axis → A C B pins), "2.5" (tab width) and "3.7" (pins/tabs below the mounting surface); the -4xxxF-N view prints "2.5", "7.5", "3.7". "14.0" is the overall width over the bent mounting tabs (end view); "0.8 … 5 PLCS." is the pin width (verification pass).
- E4.9 **[drawing]** p.1, "PEC11R-1xxxF-Sxxxx" (shaft parallel to PCB): "7.0" (PCB → shaft axis), "6.5", "12.5", "13.4", "13.0", "14.0", "M7 x 0.75", "MOUNTING SURFACE".
- E4.10 **[drawing]** p.3 "Shaft Dimensions — Flatted Shaft": table L / LB / F = "15 5 7"; "20 7 10"; "25 7 12"; "30 7 12".
- E4.11 **[drawing]** p.3 "Hardware": "M7 x 0.75"; NUT "10.0 ± 0.5" (across the flats of the drawn hex) and "2.0 ± 0.2" (thickness); WASHER "12.0 ± 0.3 DIA." (outer), "7.1 ± 0.3 DIA." (inner), "0.5" (thickness).
- E4.12 drawing note on every page: "TOLERANCE: <10 = ±0.3, ≥10 = ±0.5" (mm). So the 12.5 × 13.4 body and the 14.0 tab span are ±0.5.
- E4.13 p.1 left column (`pdftotext -x 0 -W 300`, added in verification): "Operating Temperature Range … -30 °C to +70 °C (-22 °F to +158 °F)"; "Shaft Side Load (Static) … 2.04 kgf (4.5 lbs.) min."; "Wave Soldering … Sn95.5/Ag2.8/Cu0.7 solder with no-clean flux: 260 °C max. for 3 ± 1 sec."; "Hand Soldering … Not recommended".
- E4.14 **[drawing]** p.2 "PEC11R-4xxxF-Sxxxx" end view and hole layout: "14.0 (.551)"; "0.8 (.031) 5 PLCS."; "3.7 (.146)"; "13.2 (.520)"; "2.6 +0.2/-0", "1.8 +0.2/-0" "2 PLCS."; "7.0 (.276)", "7.5 (.295)"; "1.0 +0.1/-0 DIA. 5 PLCS." (added in verification).
- E4.15 p.3 txt: "Knurled Shaft With Switch" table L / LB / P / A: "15 5 7 6", "20 7 7 6", "25 7 12 10", "30 7 16 12"; "K = Metal Knurled Shaft1"; footnote "Metal knurled shaft with push momentary switch is available in 15 and 20 mm shaft lengths." (added in verification).

## E5. Omron B3S datasheet
File: `ctrl_omron_B3S.pdf` (+ `.txt`), already in the repo from track 05. Render: `pod_render_omron_B3S_dimensions.png` (PDF p.2).

- E5.1 p.1, txt L24: "B3S-1000  Silver  4.3 mm 1.57 N  Ivory …"; L27: "2.26 N  Yellow  B3S-1002"
- E5.2 p.1, txt L49–50: "Weight  Approx. 0.3 g"; "Degree of protection  IEC IP67"
- E5.3 p.1, txt L59, L61: "Operating force (OF)  1.57 N {160 gf} max.  2.26 N {230 gf} max."; "Pretravel (PT)  0.25 +0.2/–0.1 mm"
- E5.4 **[drawing]** p.2 "Dimensions (Unit: mm)", "Without Ground Terminal B3S-1000 B3S-1002": top view "6" (body, along the terminal direction), "6.6" (body, other direction), "3.3 dia." (plunger), "0.7" (terminal width), "4.5" (terminal pitch); side view "4.3" (overall height), "3.4" (cover height), "9" (terminal tip to tip), "0.1"; end view "0.7", "0.7".
  Verification pass (1200 dpi render): "3.4" runs from the cover top to the *upper* of two closely spaced base lines; "4.3" runs to the *lower* line; "0.1" is the gap between those lines. The "With Ground Terminal B3S-1100/1102" view prints the same features as "4.3±0.2" and "0.1±0.2" (txt L122, L125: "4.3r0.2", "0.1r 0.2"), so "0.1" is a vertical offset, **not** a terminal thickness. Plunger stand-proud is 0.8 (4.3 − 3.4 − 0.1) on this reading, 0.9 if the offset is ignored.
- E5.5 **[drawing]** p.2 "PCB Pad (Top View)": "9.5" (outer pad span), "6.4" (inner pad span), "4.5" (pad pitch), "1.3" (pad width).
- E5.6 p.2, txt L129: "Note: Unless otherwise specified, a tolerance of ±0.3 mm applies to all dimensions."
- E5.8 p.1, txt L31: "Note: Switches in bags must be ordered in units of 100 Switches, and Switches on embossed taping must be ordered in units of 1,000 Switches."; L37: "Ambient operating temperature -25°C to +70°C at 60%RH max. (with no icing or condensation)"; L60: "Releasing force (RF) 0.2 N {20 gf} min. 0.49 N {50 gf} min." (added in verification).
- E5.7 p.2, txt L132: "Be sure to read the safety precautions common to all Tactile Switches for correct use." (that common-precautions document was **not** retrieved)

## E6. Seeed XIAO ESP32-C3
### E6a. Wiki (track 05 file)
File: `ctrl_xiao_esp32c3_wiki.txt`.
- E6a.1 L168–171: "1x Reset button" / "1x Boot button" / "Dimensions" / "21 x 17.8mm"
- E6a.2 L147: "This board comes included with an external antenna … It also has a small and exquisite form-factor combined with a single-sided surface-mountable design."
- E6a.3 L284–292 (hardware overview labels): "Reset", "Boot", "Enter Boot Mode", "U.FL-R-SMT1", "LNA_IN", "UFL antenna".
- E6a.4 L452: "📄[2D Dimensions] XIAO ESP32-C3 Dimension in DXF" (link → `XIAO-ESP32C3-DXF.zip`).

### E6b. Product page
File: `pod_seeed_xiao_esp32c3_product_page.html` (+ decoded `.txt`). URL: https://www.seeedstudio.com/Seeed-XIAO-ESP32C3-p-5431.html
- E6b.1 txt L3827: "Thumb-sized Design: 21 x 17.8mm, Seeed Studio XIAO series classic form factor and elegant productization of single-sided components mounting"; spec table L3938–3941: "Dimensions" / "21 x 17.8mm".
- E6b.2 txt L3645 / L7925 (an older copy of the description embedded in the same page): "Thumb-sized Design: 21 x 17.5mm"; spec table L3714–3715 / L7994–7995: "Dimensions" / "21 x 17.5mm". **Conflicts** with 17.8 (E6a.1, E6b.1, E6c).
- E6b.3 txt L3671: "Please connect the antenna at the vertical direction and do not drag at the horizontal direction."
- E6b.4 part list (txt L3790–3801, one token per line: "Part List" … "x1" … "Antenna" / "x1"): "Seeed Studio XIAO ESP32C3 x1  Antenna x1". **No antenna dimensions and no board thickness or height** anywhere on the page (searched for mm, thick, size, antenna).

### E6c. Dimensioning DXF (v1.2) [file data]
File: `pod_seeed_xiao_esp32c3_v1.2_dimensioning_DXF.zip` → `XIAO ESP32C3 v1.2 Dimensioning.dxf`. URL: https://files.seeedstudio.com/wiki/Seeed-Studio-XIAO-ESP32/XIAO_ESP32C3_v1.2_Dimensioning.zip
I parsed it with my own Python DXF reader (ezdxf would not install); render: `pod_render_xiao_dimensioning_dxf.png`. DIMENSION entities, measured value (group 42) and definition points (13/23, 14/24):
- "20.955" between x = −79.04492 and −58.08992 (board length)
- "17.78" between y = 5.6148 and 23.3948 (board width)
- "15.24" between x = −76.18742 and −60.94742 (first to last pin centre) → first pin centre 2.8575 from each short edge [calc]
- "2.54" ×4 (pin pitch)
- ARC_DIMENSION "2.994390" ×4 at the four corners; radius DIMENSION "1.906344" ×2 → corner radius 1.906 (π/2 × 1.906 = 2.994) [calc]
- also "15.16145" and "13.62551" (vertical, between pin features; see the report §3.1) and pad dimensions "1.6256", "0.9144", "1.2659". (Verification: the file holds about 35 DIMENSION entities in all; others such as 8.636, 6.858, 4.191, 2.794, 1.905 dimension pad features and were not used. The list above is a selection, not the whole file.)

### E6d. Gerber-export DXFs [file data]
File: `pod_seeed_xiao_esp32c3_DXF.zip` → `113991054/top.dxf`, `bottom.dxf`. URL: https://files.seeedstudio.com/wiki/XIAO_WiFi/Resources/XIAO-ESP32C3-DXF.zip
Layers: XIAOESP32C3_GTO (top silk), _GTS (top mask), _GBO, _GBS. Board outline (silk 0.0254 line) x 2.837…23.792, y 4.214…21.994 (20.955 × 17.78). Render: `pod_render_xiao_top_silk_dxf.png`.
- E6d.1 GTO rectangle (USB-C receptacle outline), segments: "17.950,17.612 -> 17.950,8.595", "17.950,8.595 -> 25.316,8.595", "25.316,8.595 -> 25.316,17.612", "25.316,17.612 -> 17.950,17.612" (w 0.1524). Board edge segment "23.792,6.119 -> 23.792,20.089". → overhang 25.316 − 23.792 = **1.524** [calc].
- E6d.2 GTO button outlines: "3.061,16.050 -> 3.061,19.050", "5.659,19.050 -> 5.659,16.050" and "3.061,7.160 -> 3.061,10.160", "5.659,10.160 -> 5.659,7.160" (2.598 × 3.000 each). Silk letters "B" at y≈20.1–20.5 and "R" at y≈5.5–6.1.
- E6d.3 GTO U.FL outline: "2.964,14.404 -> 2.964,11.803", "5.631,11.803 -> 5.631,12.342", "5.631,14.404 -> 5.631,13.866".
- E6d.4 GTO large rectangle (w 0.508): "6.520,6.881 -> 6.520,19.327", "16.807,19.327 -> 16.807,6.881", "16.807,6.881 -> 6.520,6.881", "6.520,19.327 -> 16.807,19.327".

### E6e. KiCad v1.3 project [file data]
File: `pod_seeed_xiao_esp32c3_v1.3_kicad.zip` → `XIAO ESP32C3_v1.3.kicad_pcb` (KiCad 9). URL: https://files.seeedstudio.com/wiki/XIAO_WiFi/Resources/XIAO_ESP32C3_v1.3_KiCad_260116.zip
- E6e.1 L5–6: "(general" / "(thickness 1.6)". The file has no `(stackup …)` section.
- E6e.2 Edge.Cuts bbox: x 138.0236…158.9786, y 96.1136…113.8936 → 20.955 × 17.78.
- E6e.3 Footprints (name, layer, "(at x y rot)", reference):
  - "XIAO ESP32C3_v1.3:BUTTON_TD1183SA" F.Cu "139.5476 100.5586 90" BOOT0; same footprint "139.5476 109.4486 -90" RST0; F.SilkS outline local ±1.5 × ±1.3
  - "XIAO ESP32C3_v1.3:U-FL3P-SMD-2.6X2.6X1.0MM" F.Cu "139.4206 105.0036 180" ANT0; F.CrtYd local x ±1.397, y ±2.032
  - "XIAO ESP32C3_v1.3:USB2.0-TYPE-C" F.Cu "153.1366 105.0036 180" USB0; F.SilkS lines "(0 4.5)-(-7.35 4.5)", "(-7.35 4.5)-(-7.35 -4.5)", "(-7.35 -4.5)-(0 -4.5)", "(0 -4.5)-(0 4.5)"; shell pads "S1 thru_hole oval (at -4.7625 -4.318) (size 1.778 0.889) (drill 0.508)", S2 (−4.7625, 4.318), S3 (−0.5715, −4.318), S4 (−0.5715, 4.318); "np_thru_hole circle (at -1.1 ±2.875) drill 0.58"
  - "XIAO ESP32C3_v1.3:H7-HALF-HOLE-2.54" J2 at "148.4376 97.3836 -90", J1 at "148.4376 112.6236 90"; pads "thru_hole circle … (size 1.5 1.5) (drill 0.85)"; pad nets J2: D0…TX_D6, J1: RX_D7, D8, D9, D10, VCC_3V3, GND, VUSB
  - "XIAO ESP32C3_v1.3:LED-0402" F.Cu "158.3563 110.7186 90" CHG0
  - "TP-80X40MIL" B.Cu BAT0 "148.8186 100.5586", GND0 "150.7236 100.5586"
  - Layers: F.Cu, In1.Cu, In2.Cu, B.Cu (4 copper layers); no `(stackup …)`.
- E6e.4 Converted to the report frame (origin at the board corner, top view, USB-C toward +X, Y up, mm) [calc]: BOOT centre (1.524, 13.335); RESET (1.524, 4.445); U.FL (1.397, 8.890); USB-C silk X 15.113…22.463, Y 4.390…13.390; shell legs at X 15.684 / 19.875, Y 4.572 / 13.208; header holes at Y 1.270 and 16.510 (row spacing 15.240); castellations on Y 0 and 17.78; pin X 2.794 + k·2.54 (KiCad) vs 2.8575 + k·2.54 (dimensioning DXF); D0 and 5 V (VUSB) at the USB end; CHG LED (20.333, 3.175).

- E6e.5 Pads re-extracted in the verification pass (own script; report frame X = x − 138.0236, Y = 113.8936 − y):
  - H7-HALF-HOLE-2.54 pads 1–7: "thru_hole circle (size 1.5 1.5) (drill 0.85)" at Y 1.270 / 16.510 (header holes); pads 13–19: "thru_hole circle (size 1.27 1.27) (drill 0.7)" at Y 0.000 / 17.780 (the edge half-holes). J2 pad 1 = D0 at X 18.034 (USB end), pad 7 = TX_D6 at X 2.794; J1 pad 7 = VUSB at X 18.034, pad 1 = RX_D7 at X 2.794.
  - BUTTON_TD1183SA (BOOT0, RST0): "np_thru_hole circle (size 0.7 0.7) (drill 0.7)" at the footprint centre (1.524, 13.335) / (1.524, 4.445); SMD pads 1.8 × 0.65. BOOT pad 2 net "D9"; RST pad 2 net "EN".
  - USB2.0-TYPE-C: np_thru_hole drill 0.58 at (16.213, 6.015) and (16.213, 11.765); shell S1–S4 "thru_hole oval (size 1.778 0.889) (drill 0.508)" at X 15.684 / 19.875, Y 4.572 / 13.208; S5/S6 SMD 2 × 2.
  - Footprints on B.Cu: only TP-D45MIL ×6, TP-80X40MIL ×2 (BAT0, GND0) and LOGO-SEEED; no components.
  - Gerber top.dxf (verification): besides the 0.1524-wide USB outline (x 17.950…25.316) there is a second 0.127-wide rectangle "17.950,17.605 -> 25.298,17.605 … 25.298,8.606", i.e. overhang 1.506.

### E6f. Front pinout image
File: `pod_seeed_xiao_esp32c3_front_pinout.png`. URL: https://files.seeedstudio.com/wiki/XIAO_WiFi/XIAO_ESP32-C3_front_pinout.png
- **[drawing]** Labels: "D0 … D6" on one side with D0 nearest the USB-C; "VBUS, GND, 3.3V-OUT, D10, D9, D8, D7" on the other side with VBUS nearest the USB-C; "BOOT GPIO9", "RESET CHIP_EN" and "Ext. Antenna LNA_IN" at the end opposite the USB-C; "CHARGE_LED" beside the USB-C.

## E7. Pololu D36V6F5
### E7a. Product page (track 05 file) `ctrl_pololu_D36V6F5.txt`
- E7a.1 L84–85: "Small size: 0.5″ × 0.4″ × 0.1″ (13 mm × 10 mm × 3 mm)" / "Weight: 0.5 g"
- E7a.2 L87: "This regulator has four connections: shutdown ( SHDN ), input voltage (VIN), ground (GND), and output voltage (VOUT)."
- E7a.3 L90: "The four connections are labeled on the back side of the PCB and are arranged with a 0.1″ spacing along the edge of the board …"

### E7b. Dimension diagram
File: `pod_pololu_D36V6x_dimensions.pdf` (+ `.txt`), render `pod_render_pololu_D36V6x_dims_p1.png`. URL: https://www.pololu.com/file/0J1571/step-down-voltage-regulator-d24v3x-d24v6x-d36v6x-dimensions.pdf (linked from `pod_pololu_D36V6F5_resources_page.html`, https://www.pololu.com/product/3792/resources)
- E7b.1 p.1 title block, txt L40–41: "Step-Down Voltage Regulator D24V3Fx, D24V6Fx, and D36V6Fx", item numbers "2097-2100, 2106-2109, 3791-3797" (D36V6F5 = product 3792). Dev code "reg04b". (p.2 is the adjustable "D24V3Ax, D24V6Ax, D36V6Ax", items 2101-2104, 3798-3799, which does not apply.)
- E7b.2 **[drawing]** p.1 "Board dimensions (top view)": "10.2 [400]" × "12.7 [500]".
- E7b.3 **[drawing]** p.1 "Connector callouts (bottom view)": "1.27 [50]" (hole centre from the board edge), "1.27 [50]" (first hole from the side edge), "2.54 [100]", "4× ⌀ 1.02 [40]".
- E7b.4 **[drawing]** p.1 "Profile": "1.8 [71]" (tallest component above the PCB), "1.02 [40]" (PCB thickness).
- E7b.5 p.1 notes, txt L45, L50: "2. Drill location tolerance: ±0.1 [±5]." / "3. Board edge tolerance: ±0.3 [±10]." / "Units: mm [mil]".
- E7b.6 **[drawing]** p.1 isometric view: silk labels "SHDN", "VIN", "GND", "VOUT" next to the four holes, in that order along the edge.
- Also saved: `pod_pololu_D36V6x_drill_DXF.zip` (reg04a/reg04b drill guides; not parsed, since the PDF gives the same numbers).

## E8. Adafruit 1201 vibration motor
### E8a. Product page (track 05 file) `ctrl_adafruit_1201_vibration_motor.txt`
- E8a.1 L118: "Dimension: 10mm diameter, 2.7mm thick"; L122: "Weight: 0.9 gram"
- E8a.2 L113: "… (red is positive, blue is negative) … The rated voltage is 2.5 to 3.8V and for many projects, we found it vibrates from 2V up to 5V …"

### E8b. Datasheet "MOTOR VIBRATOR, 10 Diam×2.7Housing Length", model 10B27.3018 (linked from the Adafruit page as P1012_datasheet.pdf)
File: `pod_adafruit_1201_P1012_datasheet.pdf` (+ `.txt`). URL: https://cdn-shop.adafruit.com/product-files/1201/P1012_datasheet.pdf
- E8b.1 txt L109: "2-1 Rated Voltage  DC 3.0V"; L136: "2-5 Voltage Range for Use  DC 2.5~3.8V"
- E8b.2 txt L164: "3-2 Rated Current … 75mA or less"; L198: "3-7 Starting Current … 120mA or less"
- E8b.3 txt L224: "Weight  Balance  1.2g Approx" (**conflicts** with the product page's 0.9 g, E8a.1)
- E8b.4 txt L401 (PDF p.9): "Do not press the product with more than 0.5Kgf or drop it, It can cause the transformation of performance or external appearance."
- E8b.5 txt L449 (PDF p.11): "9-1 Material Lead/导线材质： UL AWM 1571 AWG32"
- E8b.6 **[drawing]** PDF p.12 "Figure 1 Motor Housing Configuration", render `pod_render_adafruit_1201_drawing_p12.png`: "Ø10.0±0.1"; "2.7±0.2" (housing); "0.3" (layer on top of the housing); "0.15" (layer under the housing); "10" (motor centre → end of the lead-exit tab); "5.0±0.5" (stripped wire ends); "Ø1.5"; "Ø9.0"; "7.1"; "UV 胶水" (UV glue at the lead exit); "UL1571 AWG#32"; "RED"+"" pole. Total lead length is **not** dimensioned (the leads are drawn broken). Verification: the lower view also has a vertical dimension ending "…MAX" that is cut off by the page edge (value unreadable); the "10" tab-end dimension and a re-measured tab width of 4.34 mm (244 px at 56.2 px/mm, [img]) agree with the report.
- E8b.7 txt L141: "2-6 Allowable Temperature Range Working Temperature: -30C ~ +70C" (added in verification).

## E9. JST GH connector catalog
File: `ctrl_jst_GH.pdf` (+ `.txt`), already in the repo from track 05. Renders: `pod_render_jst_GH_layout_mated.png` (p.2), `pod_render_jst_GH_housing_header.png` (p.3).
- E9.1 p.1, txt L2: "1.25 mm pitch/Wire-to-Board connectors/Crimp style and Mating style"; L7: "Current rating: 1.0 A AC/DC（AWG #26）"; L19–20: "Conductor size/ AWG #30 to AWG #26" / "Insulation O.D./ φ0.76 mm to φ1.0 mm"; L27: "* Dimensional unit: mm"
- E9.2 p.2, txt L108: "SSHL-002T-P0.2  #30 to #26（0.05 to 0.13） 0.76 to 1.0" (contact)
- E9.3 **[drawing]** p.2 "PC board layout and Assembly layout":
  - Top entry: "0.6±0.05", "1.25±0.05", "1.35±0.1", "1±0.1", "2.8±0.1", "3.9±0.1", "5.6±0.1", "(0.3)", "(0.1)"; assembly "4.25" and "(7.3)" (PCB → top of the mated housing).
  - Side entry: "0.6±0.05", "1.25±0.05", "1.35±0.1", "1±0.1", "2.7±0.1", "3.7±0.1", "5.4±0.1", "(0.25)", "(0.1)"; assembly "(7.15)" (length, header rear → housing rear) and "(4.35)" (height above the PCB).
  - txt L84–86: "Note: 1. The PC board layout figure shown is viewed from the connector mounting surface. 2. Tolerance for the PCB pattern pitch shall be ± 0.05 and shall not accumulate. The above dimensions are reference values."
- E9.4 p.3 Housing table, txt L141–145: "2 GHR-02V-S 1.25 3.75", "3 GHR-03V-S 2.50 5.00", "4 GHR-04V-S 3.75 6.25", "5 GHR-05V-S 5.00 7.50", "6 GHR-06V-S 6.25 8.75" (A, B). **[drawing]** housing "4.15" (thickness) and "5.7" (length).
- E9.5 p.3 Header table, txt L175–184: "2 BM02B-GHS-TBT SM02B-GHS-TB 1.25 5.75", "3 … 2.50 7.00", "4 … 3.75 8.25", "5 … 5.00 9.50", "6 BM06B-GHS-TBT SM06B-GHS-TB 6.25 10.75" (A, B).
  **[drawing]** "Top entry type": "4.25" (depth), "0.7" (lead beyond the body), "4.05" (height), "0.15". "Side entry type": "4.05" (depth), "0.8" (lead beyond the body), "4.25" (height), "0.1".
- E9.6 p.4 "Housing（Keying pattern A）": "GHR-02V-2P", "GHR-04V-2P", "GHR-05V-2P", "PBT, purple"; p.5 "Housing（Keying pattern B）": "GHR-02V-3HD", "GHR-04V-3HD", "GHR-05V-3HD", "PBT, dark gray". p.1 txt L2: "1.25 mm pitch/Wire-to-Board connectors/Crimp style and Mating style"; p.1 "Temperature range: ‑40 ℃ to +105 ℃". Header models listed are SMT only (BM…-GHS-TBT, SM…-GHS-TB) (added in verification).

---

## Not retrieved (no claim made from these)
- Hirose U.FL catalog (U.FL-R-SMT-1 receptacle height, mated plug height). Tried https://www.hirose.com/en/product/document?…documentid=D31688_en (returned an HTML auth page), https://www.mouser.com/datasheet/2/185/U.FL_catalog-939761.pdf and https://www.hirose.co.jp/cataloge_hp/e32119372.pdf (both returned a JavaScript bot wall).
- Size of Seeed's supplied FPC antenna and length of its cable: not stated on the product page or the wiki; no antenna document found.
- Omron "safety precautions common to all Tactile Switches" (maximum plunger load): referenced by B3S p.2, not fetched.
- Datasheet for the TD1183SA tact switch (XIAO BOOT/RESET), for actuator height: not searched for (minor).

---

## Verification log (adversarial pass, 2026-11-03)
Every entry above was re-checked against the source files by a separate agent (renders and scripts in
`/tmp/claude-1000/pod_research/verify-components/`). Changes to this file: E1.6 (2.5 interpretation, tab/terminal
protrusion), E2.8 new, E4.8 (mounting-surface label corrected, S-variant dimensions, 14.0, 0.8), E4.12 note, E4.13–E4.15
new, E5.4 (the "0.1" is a vertical offset, not terminal thickness), E5.8 new, E6b.4 (line location), E6c (§ reference
fixed, completeness note), E6e layer note, E6e.5 new (castellation pads ø1.27/0.7, peg holes, B.Cu contents, second USB
outline), E8b.6 note, E8b.7 new, E9.6 new. All other quoted text and values were found as stated.
