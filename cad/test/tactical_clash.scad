// Test kolizji v0.5 „PANCERZ+” (tactical_mount.scad), §4.1 specyfikacji + przypadki z przeglądu R1.
// openscad -D 'which="..."' -D tilt=.. -D g_fx=.. -o out.stl tactical_clash.scad   → pusty wynik = OK
// Uruchamiać przez run_tactical_clash.sh (siatka tilt × przód gogli, kontrole pozytywne, kąty pierwszego styku).
include <../tactical_mount.scad>
part = "none";
which = "base_ghost";
g_fx = 23.1;    // przód gogli w teście (niezależny od front_x, z którym zaprojektowano części)
yaw = 0;        // [deg] obrót FORK wokół pionowej osi przez stalowy kołek (luz języka ±2°)
roll = 0;       // [deg] przechył FORK wokół osi x przez złącze (z = j_z)
hinge = 0;      // [deg] obrót FORK nosem do góry na stalowym kołku po ścięciu PA66
hinge_dx = 0;   // [mm] przesunięcie FORK w x w luzie otworu kołka
buckle = 0;     // [deg] klamra GoPro na kasku: 0 = korpus do góry, + = obrót do przodu
sweep = 45;     // [mm] droga wsuwania kamery od tyłu
with_knob = true;   // cover_access: z gałką / bez
lens_tol = -0.5;// [mm] strefy widzenia zaczynają się tyle ZA płaszczyzną soczewki/szkła (tolerancja długości obiektywu [A])

// gogle: blat 0.01 niżej (styk płytki BASE z blatem to nie kolizja)
module ghostbox() translate([g_fx - 80, -169.2/2, -45.5]) cube([80, 169.2, 45.5 - 0.01]);
// kamery osadzone 0.01 za ramkami wzdłuż własnych osi (styk powierzchni to nie kolizja); z przewodami
module cams_seated(cab = true) { cam_th(0, -0.01); cam_ir(0, -0.01); if (cab) cables(); }
module stack(t = tilt) at_pivot(t) { cage(); cover(); cams_seated(); }
module stack_nocam(t = tilt) at_pivot(t) { cage(); cover(); cables(); }
module fork_yaw() translate([pin_x, 0, 0]) rotate([0, 0, yaw]) translate([-pin_x, 0, 0]) fork();
module fork_roll() translate([0, 0, j_z]) rotate([roll, 0, 0]) translate([0, 0, -j_z]) fork();
module fork_hinge() translate([pin_x, 0, j_z]) rotate([0, -hinge, 0]) translate([-pin_x + hinge_dx, 0, -j_z]) fork();
// trzpienie śrub złącza (sztywne): kołek Ø3, bezpiecznik Ø2.5 — do testu przechyłu
module joint_bolts() {
  translate([pin_x, blk_y, j_z]) rotate([90, 0, 0]) cylinder(d = 3, h = 2*blk_y);
  translate([fuse_bx, blk_y, j_z]) rotate([90, 0, 0]) cylinder(d = fuse_d, h = 2*blk_y);
}
// droga klucza imbusowego 1.5 do popychaczy: walec Ø2.0 wzdłuż osi popychacza od wnętrza gwintu do x = 80
module keypaths() for (s = [-1, 1]) translate([pad_x0 + 0.5, s*pad_y, pad_z]) rotate([0, 90, 0]) cylinder(d = 2.0, h = 80 - pad_x0 - 0.5);
// wkrętaki Ø2.5 do przednich śrub wentylatora (pionowo przez studzienki, od łba śruby w górę)
module fan_drivers() for (s = [-1, 1]) translate([fan_hole/2, s*fan_hole/2, plate_t - screw_cb_h + 0.1]) cylinder(d = 2.5, h = 60);
// wkrętaki Ø2.5 do śrub pokrywy (wzdłuż y od ścianki klatki na zewnątrz), w układzie klatki
module cover_drivers() for (s = [-1, 1]) translate([cov_scr[0], s*(cage_y + 0.1), cov_scr[1]]) rotate([s > 0 ? -90 : 90, 0, 0]) cylinder(d = 2.5, h = 60);
// strefy widzenia (od płaszczyzny soczewki/szkła + lens_tol): termo 50×37.2 z Ø16, Infra 96×72 i 108×92 z Ø19
module fov_th(t = tilt) at_pivot(t) th_keepout(300, 0, th_lens_len + lens_tol);
module fov_ir(t = tilt) at_pivot(t) { ir_keepout(ir_fov_a, 300, ir_glass + lens_tol); ir_keepout(ir_fov_b, 300, ir_glass + lens_tol); }
module others() union() { fork(); base(); knob(); ghostbox(); }
// wsuwanie kamer od tyłu: obwiednia korpusu (+clr − 0.02) przesuwana od x −sweep do gniazda (hull = dokładny ślad bryły wypukłej)
module sweep_hull(d) hull() { children(); translate([-d, 0, 0]) children(); }
module ins_th() {
  c = clr - 0.02;
  sweep_hull(sweep) translate([-th_body - 0.01, -th_w/2 - c, -th_h/2 - c]) cube([th_body, th_w + 2*c, th_h + 2*c]);
  sweep_hull(sweep) translate([-0.01, 0, 0]) rotate([0, 90, 0]) cylinder(d = th_lens_d + 2*c, h = th_lens_len);
}
module ins_ir() infra_xf() translate([ir_x0 - 0.01, 0, ir_z]) {
  c = clr - 0.02;
  sweep_hull(sweep) translate([-ir_body, -ir_w/2 - c, -ir_h/2 - c]) cube([ir_body, ir_w + 2*c, ir_h + 2*c]);
  sweep_hull(sweep) rotate([0, 90, 0]) cylinder(d = ir_lens_d + 2*c, h = ir_lens_len);
}
// klamra GoPro (żeńska, 3 palce) na kasku wokół osi helm: tarcze palców R7.5 (środkowy |y| ≤ 1.5, zewnętrzne
// |y| 4.8…7.8) + korpus 15.6 × 15 od 10 do 30 mm od osi w kierunku `buckle`
module buckle_discs() translate([helm_x, 0, helm_z]) for (yr = [[-1.5, 1.5], [4.8, 7.8], [-7.8, -4.8]]) translate([0, yr[1], 0]) rotate([90, 0, 0]) cylinder(r = 7.5, h = yr[1] - yr[0]);
module buckle_body() translate([helm_x, 0, helm_z]) rotate([0, buckle, 0]) union() {
  for (yr = [[-1.5, 1.5], [4.8, 7.8], [-7.8, -4.8]]) translate([-7.5, yr[0], 0]) cube([15, yr[1] - yr[0], 10]);
  translate([-7.5, -7.8, 10]) cube([15, 15.6, 20]);
}

// ---- pary ----
if (which == "base_ghost")   intersection() { base(); ghostbox(); }
if (which == "fork_ghost")   intersection() { fork_yaw(); ghostbox(); }              // yaw 0, ±2
if (which == "knob_fixed")   intersection() { knob(); union() { fork(); base(); ghostbox(); } }
if (which == "fork_base")    intersection() { fork_yaw(); union() { base(); joint_heads(); } }   // język w gnieździe + łby śrub, yaw 0/±2
if (which == "roll")         intersection() { fork_roll(); joint_bolts(); }          // przechył: ±0.8 wolny, ±2 MUSI trafić
if (which == "hinge")        intersection() { fork_hinge(); base(); }                // po ścięciu PA66: obrót do 45° wolny
if (which == "fan_access")   intersection() { fan_drivers(); union() { base(); fork(); joint_heads(); knob(); } }
if (which == "cover_access") intersection() { at_pivot(tilt) cover_drivers(); union() { fork(); base(); if (with_knob) knob(); } }
if (which == "buckle_disc")  intersection() { buckle_discs(); base(); }
if (which == "buckle_body")  intersection() { buckle_body(); union() { base(); fork(); knob(); stack(); } }
if (which == "cams_cage")    intersection() { cams_seated(); cage(); }
if (which == "cover_cage")   intersection() { cover(); cage(); }
if (which == "cover_cams")   intersection() { cover(); cams_seated(); }
if (which == "ins_th")       intersection() { ins_th(); cage(); }
if (which == "ins_ir")       intersection() { ins_ir(); cage(); }
if (which == "stack_ghost")  intersection() { stack(); ghostbox(); }
if (which == "stack_fork")   intersection() { stack(); fork(); }
if (which == "stack_base")   intersection() { stack(); base(); }
if (which == "knob_stack")   intersection() { knob(); stack(); }
if (which == "keypath")      intersection() { keypaths(); union() { knob(); fork(); base(); stack(); } }
// pole termo: wszystko poza samą kamerą termo; pole Infra: wszystko poza samą kamerą Infra
if (which == "fov")          union() {
  intersection() { fov_th(); union() { stack_nocam(); at_pivot(tilt) cam_ir(0, -0.01); others(); } }
  intersection() { fov_ir(); union() { stack_nocam(); at_pivot(tilt) cam_th(0, -0.01); others(); } }
}
// kąt pierwszego styku przy obrocie klatki (nos w dół → gogle, nos w górę → czoło FORK); z przewodami
if (which == "swing")        intersection() { stack(); union() { ghostbox(); fork(); base(); } }
// eksport brył w układzie gogli do sprawdzenia z modelem GrabCAD
if (which == "x_base")  base();
if (which == "x_fork")  union() { fork_yaw(); knob(); }
if (which == "x_stack") stack();
