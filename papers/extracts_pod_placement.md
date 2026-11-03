# Extracts: pod placement on the HDO2 (track 07b)

Verbatim passages backing every [V] / [V-comm] claim in `research/07b_pod_placement.md`. Quotes are copied
from the downloaded files; the location is the PDF page (printed page number where it matches) or the line in
the `.txt` copy. Files new in this track are in `papers/pod_place/`. Retrieved 2026-11-03.

Tags: [V] manufacturer document read at source; [V-comm] community/forum text read at source.

## P. Fat Shark HDO2 manual Rev C (`papers/FatShark_HDO2_Manual_RevC.pdf`, already in the repo)

- **P1 (p.5, "HDO2 Headset Overview", figure labels)** [V]:
  "HT Button", "DVR 5-way Switch", "Volume Level", "Display 5-way Switch", "Channel Selection",
  "IPD Adjusters", "Focus Adjustment", "Receiver on/off", "Earphone Jack", "Power/Fan Button",
  "Mini HDMI port", "SD Card Slot", "DVR Indicator LED".
  (Which face each control is on is read from the photos: top view `hdo2_front_img/manual/img-001.png`,
  bottom view `img-007.png`.) *Verification:* in the p.5 bottom view (front up, seen from below, so image-right
  = wearer's left) "Receiver on/off", "Earphone Jack" and "Mini HDMI port" point to the image-right side, the
  same side as the VRx Modular Bay. "Power/Fan Button" points to the image-left side [img].
- **P2 (p.6, figure labels over the two side views)** [V]: "Power Port (7-13V)", "AV Input/Output",
  "Expansion Bay" (one side view); "Antenna Port", "VRx Modular Bay" (the other side view).
- **P3 (p.6, "Input Power")** [V]: "The HDO2 is shipped in Legacy Mode. If you connect a 7-13V (2S or 3S) power
  source to the power port the HDO2 will automatically power on and it will power off when the source is
  removed." … "If you want, you can change the input power to use the Power Button to turn on and off the
  headset. To do this, you need to remove the Expansion Bay door and move the power mode jumper from Legacy
  Mode to Button Mode as show below."
- **P4 (p.8, "Display Configuration")** [V]: "To access the complete image setting menu, press and hold the
  display 5-way switch for 2 seconds. The Image Settings menu should appear onscreen. The 5-way switch is then
  used to adjust the image settings." … "The settings that can be adjusted are contrast, brightness,
  sharpness, saturation, and power."
- **P5 (p.9)** [V]: "RX power switch: The RX module power is independently controlled via this switch. If a
  module is inserted, but desired video source is via the AV cable; the RX module needs to be turned off to
  avoid image conflict."
- **P6 (p.11, "Specifications")** [V]: "Interface: 3.5mm AV in/out port / Power input port / 3.5mm 3p earphone
  port / MicroSD / RF Module Bay / HT connector 3 pin internal connection / Power Button";
  "Dimensions: 169.2 x 80 x 45.5 mm"; "Weight: 206.8 g"; "320mA @ 7.5V input power (no RX module)";
  "770mA @ 7.5V input power (Rapid" (line truncated in the PDF).

## S. SpeedyBee 5.8GHz Goggles Receiver manual (`papers/pod_place/speedybee_5g8_goggles_receiver_manual_EN.pdf`, 15 pp.)

URL: https://store-fhxxhuiq8q.mybigcommerce.com/product_images/img_SpeedyBee_5.8GHz_Goggles_Receiver/SpeedyBee%205.8GHz%20Goggles%20Receiver%20Manual-EN.pdf
(link given in the IntoFPV thread, S-forum below). Text copy: `…_manual_EN.txt`.

- **S1 (PDF p.3, "1. Specifications", .txt l.23–32)** [V]: "Input Voltage 5V"; "Working Current 450mA@5V";
  "Dimension 51x34x17.8 (mm)"; "Weight 32g (excluding antenna)"; "Support FPV Goggles … FatShark Dominator
  Series V1, V2, V3, SE, HD1, HD2, HD3, HDO, HDO2." The drawing under the table dimensions the module
  "17.8mm" (thickness, side view), "51mm" (length, front view), "34mm" (height, end view).
  *Verification (drawing re-rendered at 250 dpi, my reading [img]):*
  - the 17.8 mm line spans the casing only;
  - the SMA jack on the outer face protrudes a further ≈7 mm, and the 5-way stick ≈2.5 mm (scaled from the
    17.8 mm dimension, ≈8.2 px/mm);
  - the casing's inner side is drawn curved;
  - the header pins project from the inner face in the end view.
- **S2 (PDF p.4, "2. Interactive Components", .txt l.69–73)** [V]: labels "OLED Screen,128x64",
  "SMA Jack Connector", "USB Connector For Firmware Update", "5-Way Button", and
  "Compatible Casing with FatShark Dominator Series Goggles".
- **S3 (PDF p.4, "3.1 Recevier Mounting", .txt l.80–88)** [V]: "Example: FatShark HDO 2. Instructions of how to
  install SpeedyBee 5.8GHz onto the goggles." "Step 1： Power off the HDO 2 goggles and remove the receiver
  compartment panel."
- **S4 (PDF p.5, .txt l.89–99)** [V]: "Step 2：Align the receiver's pins with the female socket inside the
  goggles receiver compartment. Press down slowly and firmly until you feel it securely lock into place."
  "Step 3： Installation complete! The SpeedyBee 5.8GHz goggles receiver will power on automatically when the
  goggles are turned on." (The p.5 drawing shows the module with its casing seated on the side of a Fat Shark
  headset in place of the bay door, the 5-way button on its outer face.) *Verification:* the Step 3 drawing shows
  the module at the front corner on the image-right side of a front view, i.e. the wearer's left. That is
  consistent with the HDO2 manual p.6 [img]. Nothing in S1–S4 says the 5-way is operated while flying or with
  gloves.

## F. IntoFPV forum (community; `papers/pod_place/`)

- **F1 (`intofpv_thread_7613_module_bay_size.txt` l.10–11; https://intofpv.com/printthread.php?tid=7613,
  post by SnowLeopardFPV, 24 Feb 2019)** [V-comm]: "I just measured the bay on my HDO's and it's approximately
  44mm width x 32mm height. The depth varies because the module bay is on a curved part of the goggles, but the
  deepest part is 13mm." "And for reference, my Realacc RX5808 module measures 43mm width x 28mm height x
  16.5mm depth. … As you can see, the module depth is more than the bay depth which is why it isn't flush but
  sticks out a bit. The cover hides any of that."
  The elided part (l.11) defines the depth: "The depth is measured from the face of the screen on the front, to
  the back surface of the bottom circuit board. The length of the RPA sockets are excluded from any
  measurements."
  **Scope:** measured on an HDO (v1), not an HDO2. *Verification:* a commenter in the already-downloaded
  `ctrl_hdo2_oscarliang.txt` l.191 writes "create the mold for the HDO2 alone", which suggests a new shell. The
  bay figures therefore need P1. (This is a hint from a comment, not a claim.)
- **F2 (`intofpv_thread_24557_speedybee_module.txt` l.14, 15, 20; https://intofpv.com/printthread.php?tid=24557)**
  [V-comm]: "Operating Current: 450mA@5V"; "Supported FPV Goggles:Fat Shark Dominator: Includes
  V1,V2,V3,SE,HD1,HD2,HD3,HDO,HDO2."; "Dimensions: 51x34x17.8mm". (Same figures as S1; the manual governs.)

## E. Alps EC11E09244BS encoder (`papers/pod_place/`)

- **E1 (product page `alps_EC11E09244BS_detail.txt`, l.66–68, 93–105 (line refs corrected in verification); https://tech.alpsalpine.com/e/products/detail/EC11E09244BS/)** [V]:
  "Detent torque 10±7mN・m"; "Push-pull strength 100N"; push-on switch: "Travel 0.5±0.3mm",
  "Operating force 6(+2.5, -2)N"; "Actuator length 20mm"; "Number of detent 18".
- **E2 (catalog `alps_product_catalog_ec_01_ec11e_en_611f078659.pdf`, p.1 product list, .txt l.38)** [V]:
  "EC11E09244BS Vertical Flat 20 10±7mN・m 18 9 With 0.5" — the "With 0.5" group uses **Drawing No.2**.
- **E3 (same PDF, p.2 "Drawing No.2 ▪Dimensions", read from the 300 dpi render `alps_EC11E_p2-2.png`)** [V]:
  body "11.7" wide; "6" + "6" about the shaft axis (12 tall); in the side view "24.5" runs from the board
  seating plane to the shaft tip, split into "4.5" (body) and "(20)" (shaft); the terminals project "3.5"
  below the seating plane; shaft sections "7" (round) and "10" (flat); "ø6" shaft with flat "4.5"; "7.5 max."
  from the shaft axis to the terminal row; "Switch travel 0.5". Mounting-hole drawing: "12.5±0.05" between
  the bracket legs. (The reading of which line is the seating plane is mine, from the drawing.)
  *Verification:* re-read on the 300 dpi render; every value above is confirmed. The 3.5 mm dimension runs from
  the terminal tips to the line where the 24.5 dimension starts, which supports the seating-plane reading. The
  p.1 product list gives "20" mm actuator length for all nine EC11E part numbers (catalog .txt l.29–53), so the
  catalog offers no shorter shaft.

## O. Omron B3S (`papers/ctrl_omron_B3S.pdf`, already in the repo; text `ctrl_omron_B3S.txt` l.18–30)

- **O1 (p.1, "List of Models")** [V]: "6 × 6 mm Models"; "B3S-1000 Silver 4.3 mm 1.57 N {160 gf} max.";
  "2.26 N {230 gf} max. Yellow B3S-1002".

## X. Other component datasheets already in the repo (quoted for the envelope lower bound)

- **X1 XIAO ESP32-C3** (`ctrl_xiao_esp32c3_wiki.txt` l.170–171) [V]: "Dimensions" / "21 x 17.8mm".
  (No thickness is given in the text.)
- **X2 Pololu D36V6F5** (`ctrl_pololu_D36V6F5.txt` l.84) [V]: "Small size: 0.5″ × 0.4″ × 0.1″ (13 mm × 10 mm × 3 mm)".
- **X3 Adafruit 1201 vibration motor** (`ctrl_adafruit_1201_vibration_motor.txt` l.118) [V]:
  "Dimension: 10mm diameter, 2.7mm thick".
- **X4 JST GH** (`ctrl_jst_GH.pdf` p.3, "Header" table, .txt l.177–178) [V]: "4 BM04B-GHS-TBT SM04B-GHS-TB 3.75
  8.25"; "5 BM05B-GHS-TBT SM05B-GHS-TB 5.00 9.50" (columns: circuits, top-entry, side-entry, A, B in mm;
  B = overall header width). Housing (.txt l.144): "5 GHR-05V-S 5.00 7.50".
  *Verification (p.3 drawing, rendered):* the side-entry header is dimensioned "4.05" + "0.8" deep and "4.25"
  high (plus "0.1"). The top-entry header is "4.25" + "0.7" and "4.05" high. The housing is "4.15" × "5.7". So
  the side-entry footprint is ≈9.5 × 4.85 mm; the "≈4.3" in the first draft was the height.

## R. Project files used as inputs (not new sources)

- `cad/camera_mount.scad` v0.3: `front_x = 23.1`, `seat_above_eye = 23`, `m2_d = 2.3`, `fan_hole = 20`,
  `cage_y = ir_w/2 + clr + side_t` (= 12.95), `fem_out` (7.8), `boss_len = 5.0`, hinge
  `adapter_axis_x = front_x + gp_od/2 + 3.0` (33.6). The Infra worst-case FOV 96 × 72 and the thermal 50 × 37.2
  FOV pyramids are taken from `cad/test/clash.scad` (`fovs()`), apex 0.5 mm ahead of the lens tip.
- `research/06_hdo2_front_and_gopro.md` table B (front face 125 × 39 mm, flatness, doors 18.5/24 × 35.7 mm,
  antenna cover Ø≈7 mm, nose notch ≈37 × 8 mm) and A2/A5 (stock screw Ø1.5–2.0, deck ±18 mm, VOL/CH from
  ±21.7/22.6 mm). Those are [img]/[STL] values from tracks 06a/06b, re-used here with their tags.
- `ZALOZENIA.md` §1c item 2 (yaw ≤ 0.5° between camera and goggles) and the 2026-11-03 decision "Przyciski na
  goglach, kompaktowo".

## Verification (adversarial pass, 2026-11-03)

I re-opened every source above, re-rendered the PDF pages that hold drawings, and checked each quote and figure.
Report-side changes are listed in `research/07b_pod_placement.md` § "Verification" (V1–V11).

Changes to this file:
- **P1:** added which side of the underside the RX switch, earphone jack and mini-HDMI are on (from the p.5
  bottom view) [img].
- **S1:** added what the 17.8 mm line includes and what protrudes beyond it [img on the manual drawing].
- **S4:** added that the Step 3 drawing places the module on the wearer's left, and that the manual says nothing
  about gloved or blind use of the 5-way.
- **F1:** added the elided sentence that defines the 16.5 mm depth, and a pointer to the "new mold" comment. The
  comment is a hint, not a claim.
- **E1:** line numbers corrected.
- **E3:** confirmed; added that the catalog lists only 20 mm actuators.
- **X4:** added the side-entry header depth and height from the p.3 drawing. This corrects the "≈4.3 mm" depth
  used in the report.

Confirmed unchanged: P2–P6 (text matches `pdftotext` of pp. 6, 8, 9, 11); S1–S4 text and pages; F2; E2; O1;
X1–X3; and the R entries against `cad/camera_mount.scad` and the `x.echo` output.

Image measurements re-done in verification (not quotes; scratch scripts in
`/tmp/claude-1000/pod_research/verify-placement/`):
- **Side views `manual/img-099.png`.** The door outline is tilted, so its perpendicular height is ≈180–185 px,
  not the 205 px bounding box. That gives ≈0.196 mm/px for 35.7 mm.
- **Front view `fatshark/fs_hdo2_media4_HDO2_e.jpeg`, antenna cover.** The cover spans x 1444–1497 and y 405–474,
  so 7.4 × 9.6 mm at 0.139 mm/px. Its 49 px height in img-099 confirms 0.196 mm/px.
- **Front view, door edges.** The silhouette runs x 390–1607 (centre 998.5) and the panel x 528–1430. The door
  edges are therefore at lateral ≈65.4 (R) and ≈60.0 (L).
- **Top view `manual/img-001.png`.** The half-widths in report §1.1 reproduce within ≤0.5 mm. The deck strip in
  front of the panels measures 11.1–12.7 mm.
