# Extracts: GoPro mount dimensions (for research/06c_gopro_dimensions.md)

Verbatim passages from the downloaded files, with the line they come from. **All file names below are
relative to `papers/gopro_dims/`** (`../` = `papers/`). The downloads stay local (`.gitignore`); only this file is versioned. Mesh measurements
(STL/3MF) are not quotes. They are ray-cast intervals in `measurements_raw.txt`, reproducible with
`python3 -I papers/gopro_dims/_measure_tools/run_all.py papers/gopro_dims` (and `curvefit.py`, same arguments), run from the repo root. Those tools are
mine; everything else in `gopro_dims/` is downloaded third-party data.

Retrieved 2026-11-03.

## G1. j-h-a/go-pro-mounts (Jay Abbott 2014, OpenSCAD), https://github.com/j-h-a/go-pro-mounts
- `jha_lib_mounting_prongs.scad.txt` l.16 `ringDiameter = 14.9;` l.20 `prongThicknesses = [3, 3, 3.6, 3, 3];`
  l.22-24 `nutHeight = 3.5;` `nutDiameter = 10;` `holeDiameter = 5.3;` (nut cut as `$fn = 6` cylinder, l.95)
- `jha_connector_triprong.scad.txt` uses layers 1, 3, 5 (3.0 / 3.6 / 3.0); `jha_connector_biprong.scad.txt` uses layers 2 and 4 (3.0 / 3.0).
- `jha_README.md.txt` l.64 "Stack the pieces, being careful to get them in the right order (the middle piece is a bit thicker)."
  l.68 "Place them in-between a bi-pronged connector (use an official one if possible)"
  l.31 "**Also needs**: 1x 50mm M5 bolt." l.40 "There should be about 18.5mm sticking out of the end."
  l.138 "use an official quick-release clip that comes with the GoPro to test the fit."
- `jha_lib_quickrelease_base.scad.txt` l.14-17 `baseWidth = 37.5;` `baseLength = 49.5;` `baseOuterCurveRadius = 58;` `minkowskiRadius = 7;`
- `jha_quickrelease_clip.scad.txt` l.17-31 `baseThickness = 3;` `clipInteriorWidth = 28.6;` `clipInteriorHeight = 4.9;`
  `clipLength = 25.6;` `clipWallThicknessMin = 3.3;` `clipWallThicknessMax = 3.95;` `clipRoofTopHeight = 7.3;`
  `clipRoofOverhang = 3.0;` `centreGuideWidth = 3.5;` `centreGuideHeight = 2;` `centreGuideLength = 34;`
- `jha_thumbscrew_long.scad.txt` l.16-32 `handleDiameter = 19.8;` `handleLength = 10.6;` `boltDepth = 18 + totalLength - 50;` `holeDiameter = 5.4;`

## G2. MoonCactus/gopro_customizable_mounts (= Thingiverse thing:62800, CC-BY-NC 2013), https://github.com/MoonCactus/gopro_customizable_mounts
- `mooncactus_gopro_mounts_mooncactus.scad.txt` l.72-89:
  "// The gopro connector itself (you most probably do not want to change this but for the first two)"
  "// The locking nut on the gopro mount triple arm mount (keep it tight)" `gopro_nut_d= 9.2;` `gopro_nut_h= 2;`
  `gopro_holed_two= 5.2;` `gopro_holed_three= 5.5;` `gopro_connector_th3_middle= 3.2;` `gopro_connector_th3_side= 2.75;`
  `gopro_connector_th2= 2.85;` `gopro_connector_gap= 2.95;`
  l.107 `gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;` (= 14.6, also the boss diameter)
- `mooncactus_README.md.txt`: "Better use PETG instead of PLA for heat resistance." ; "100% fill (probably safer, though 30% is quite OK)"

## G3. ridercz/GoProScad v1.2.2 (already in ../gopro_ridercz_GoPro.scad.txt, see ../extracts_hdo2.md F3)
- l.8-15 "// These values are fixed and defined by GoPro mount standard" `__gopro_outer_diameter = 15;` `__gopro_leg_width = 3;`
  `__gopro_slit_width = 3.5; // Width of the slits, including tolerance` `__gopro_hole_diameter = 5;` `__gopro_hole_tolerance = .5;`
  `__gopro_screw_extension_length = 18;` `__gopro_screw_head_diameter = 9.5;` `__gopro_screw_head_height = 3.5;`
- l.21 `module gopro_mount_f(base_height = 3, base_width = 20, leg_height = 17, nut_diameter = 11.5, nut_sides = 4, nut_depth = 3, ...)`
- l.28 `hole_offset = leg_height - __gopro_outer_diameter / 2 + base_height;`
- ../gopro_ridercz_README.md.txt l.57 "Usually, M5x50 screws are ideal." l.3 "(square nut, preferrably)"
- `connectorfoundry_gopro__body.scad.txt` l.3-4 says it vendors GoProScad: NOT an independent source.

## G4. mbugert/openscad-projects `shared/external/GoPro_Mount.scad` (by Thingiverse user julietta, thing:3088912, BSD)
- `mbugert_README.md.txt` l.63 "`GoPro_Mount.scad`: developed by Thingiverse user [julietta]... https://www.thingiverse.com/thing:3088912"
- `mbugert_shared_external_GoPro_Mount.scad.txt`: l.34 `circle(d=15);` l.39 `circle(d=6);` l.53-57 `translate([0, 4, 0]) flap(3);` `translate([0, 10.5, 0]) flap(3);`
  l.67-68 `translate([0, (-2.5), 0]) flap(8);` -> legs 3.0 thick, slots 3.5, end Ø15, hole Ø6 (my reading of the code).

## G5. Printables #93976 "Parametric GoPro attachments" (BeppeITA, 2021-12-16) — `printables_93976.txt`
- l.13-20 "It was hard but I found the real sizes of Go Pro Mount:" / "Plastic thickness : 3.02 mm" / "Gap : 3.12 mm" /
  "Hole : 5.09 mm" / "Outer radius : 14.88 mm" / "slot depth : 15.66 mm" / "hexagon: 9.5mm face2face"
- l.22 "some compatible mounts have tighter gaps (at the bottom), so you have just to increase the tolerance of 0.1."
- `printables_93976_gopro-size.txt` repeats the same numbers (no hexagon line).
- The 2-prong STL boss is Ø14.88 (measurements_raw.txt l.6: tip 18.506 minus hole centre 11.066 = 7.44 radius), so "Outer radius 14.88" is a diameter.

## G6. Printables #153569 "GoPro Buckle Mount (Short)" (3DHoneyComb) — `printables_153569.txt`
- l.4 "Reversed engineered the GoPro Buckle." l.7-8 "Uses an M5 acorn nut" l.10 "I'd recommend printing out of PETG at 0.2mm quality."

## G7. Printables #65294 "Action Camera Mount Base (GoPro-style...)" (oliverlopez) — `printables_65294.txt`
- l.7 "This model has been verified for compatibility using a GoPro Hero 4 case." l.10 "Diameter (x, y): 29.5 mm"
  l.12 "Hole size: M5 screw & nut compatible (original GoPro screw fits as well)" l.13 "Max. screw head diameter: 10–10.5 mm"

## G8. Printables #1642521 "GoPro Mount - Quick release (ORIGINAL dimensions)" (David Martinek, 2026-06-01) — `printables_1642521.txt`
- l.4 "Very strong GoPro Mount with the original Quick release mechanism" l.7 "I reccommend printing with 100% infill and supports."
- 3MF is in metres (`unit="meter"` in 3D/3dmodel.model), measured ×1000.

## G9. Printables #1063720 (HessenDnD, CC0) — `printables_1063720.txt` l.8 "Designed for a snug and sturdy fit."
## G10. Printables #1031776 (Vani) — `printables_1031776.txt` l.7 "I made the bottom surface perfectly round with a radius that matches my Smith Scout ski helmet."
## G11. Printables #1264483 (Opbrony) — `printables_1264483.txt` l.7-9 "This is a copy of a Gopro mount from (tmorris9)..." "The only thing I did was add a curve for mounting on a helmet"
## G12. Printables #579629 (Spock) — `printables_579629.txt` l.14 "You need one M5 nut for the GoPro thumbscrew to screw into." ; l.22 "Insert M5 nut into the hex cutout. This should also be a secure press fit."
## G13. Printables #95616 (LXO), #189423 (jmshrtn), #934640 (Mark3DP), #1394238 (DrewDeeDoo): descriptions say nothing about dimensions or how they were derived (see the .txt files).
## G14. Printables #897509 — `printables_897509.txt` l.9-11: "hole_diameter 5.1." "bolt_head_hole 8.6 - measured from side to side of the head." "hidden_bolt_length =26.6 mm"
## G15. Printables #59568 — `printables_59568.txt` l.14: "All you need for the thumb screws are screws M5x20 with a hex head." ; l.16 "For the handle bar mount you need three M5 nuts"
## G16. Printables #277814 — `printables_277814.txt` l.4: "using a M5 30mm to 60mm bolt with hex head"

## G17. Instructables "3D Printed GoPro Mount" (freeza36, 2013-02-15) — `instructables_3D-Printed-GoPro-Mount.json/.txt`, sketches in `instructables_freeza36_sketches/`
- txt l.5 "I measured my mount using a dial caliper, and a standard ruler. I wrote the measurements down on the paper that you can see in the pictures"
- txt l.9 "I extended the thinnest areas 0.1 inches outwards ... Remember, I did not change any of the internal distances. Those are crucial."
- Handwritten labels (inches) read by me from the photos (no pixel scaling; the numbers are written on the sketches):
  - `FOO4TUWHD2RTZE2.jpg` (graph paper, full section): ".2", ".1185", ".869", ".3185", ".165", ".155", ".070"(?), ".41755", "1.106", "1.506"(?)
  - `FFJ7MN9HD2RTZEC.jpg`: ".2", ".265", ".165", ".30", ".070"(?), ".155", "1.106"
  - `FUSRMLYHD2RTZEL.jpg`: ".3185", ".10", "0.5650", ".155", ".41755", "1.506"
  - `FQA5SP3HD2RTZDY.jpg` (notebook): ".1185", ".869 in", "1.106 in"
  - `FXPYBT4HD2RTZDX.jpg` ("Final (w/ mod)"): "2", "1.003", "1.343", "1.506", ".265", ".1", "1.106", ".2", ".155", ".076"
  Reading uncertainty: the ridge height digit is ".070" on graph paper and ".076" on the final sketch; "1.506" is partly cut off in two photos.

## G18. GoPro patents (Google Patents HTML) — `patent_US9423673B2.html/.txt`, `patent_US10642133B2.html/.txt`
- US9423673B2 txt l.278 "also includes two prongs 180 a and 180 b that can be flexibly compressed inward when squeezed."
  l.282 "includes securing arms 190 a and 190 b , each with side securing surfaces 192 a and 192 b , top securing surfaces 194 a and 194 b , and back securing surfaces 196 a and 196 b"
- A regex search of both texts for a number followed by mm/inch found no dimensions.

## G19. Multitronic (Rollei third-party adhesive mount, Icecat data) — `web_www_multitronic_fi_en_products_1454591.txt` l.96
- "Weight & dimensions Weight 12 g Height 12 mm Width 45 mm Depth 53 mm" (Rollei product, not GoPro; the page doesn't say whether this is the part or the package).

## Not GoPro geometry (checked so it isn't mistaken for it)
- `../printables_stl/262727_fan.stl`: fork prongs 5.0 mm, slot 4.0 mm; `262727_connector.stl`: hole about Ø3 (M3). Not a GoPro joint.
- `leonardchrist_ParametricGoProBoardMount.scad.txt` l.18-20 `goproMountFinThickness = 4;` `goproMountFinOuterDiameter = 10;`: not standard. Excluded.
- `justcoding_connector-adapter.scad.txt`: generic adapter (outerRadius 5); not GoPro defaults. Excluded.
- `lucasgelfond_CameraMountRewrite.scad.txt` (credits YouMagine fns720): l.7-21 `mountX = 36;` `mountY = 46;` `mountZ = 3;` `midRailX = 4.5;` `midRailY = 34;` `midRailZ = 1.75;` `edgeX = 4;` `edgeY = 25.75;` `edgeZ = 4.5;` `edgeHangX = 7;` `edgeHangZ = 2.5;`. The overhang variables are never used in the shown modules, so the file is incomplete. I used only the rail length and ridge.
- `briandorey_gopro-mounts.pdf`: a 31.8 mm handlebar clamp drawing with no GoPro interface dimensions.
- `printables_30388_generic_gopro_clipuntitled.stl`: orientation and part type are ambiguous. Not used.
