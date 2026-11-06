// Test kolizji v0.6 (camera_mount.scad): openscad -D 'which="..."' -D tilt=.. -D g_fx=.. -o out.stl clash.scad
// Pusty wynik = OK. Uruchamiać przez run_clash.sh (siatka tilt × przód gogli × yaw, kontrole pozytywne, GrabCAD).
include <../camera_mount.scad>
part = "none";
which = "adapter_ghost";
g_fx = 23.1;    // przód gogli w teście (niezależny od front_x, z którym zaprojektowano części)
yaw = 0;        // [deg] obrót adaptera (z gałką i śrubą) wokół środka gniazda — luz śrub przy ustawianiu zbieżności
clamp = false;  // zapadki: true = palce dociśnięte (luz szczeliny 0.15 skasowany, wypustka przesunięta o 0.15)
buckle = 0;     // [deg] klamra GoPro na kasku: 0 = korpus do góry, + = obrót do przodu (pomiar)
lens_tol = -0.5;// [mm] strefy widzenia zaczynają się tyle ZA płaszczyzną soczewki/szkła (tolerancja długości obiektywu [A])

// gogle: blat 0.01 niżej (styk płytki z blatem to nie kolizja)
module ghostbox() translate([g_fx - 80, -169.2/2, -45.5]) cube([80, 169.2, 45.5 - 0.01]);
// kamery osadzone: termo na zderzakach (0.2 luzu), Infra 0.01 przed zderzakami (styk to nie kolizja)
module cams_seated() { cam_thermal(0); translate([0.01, 0, 0]) cam_infra(0); }
module cam_th_only() cam_thermal(0);
module cam_ir_only() translate([0.01, 0, 0]) cam_infra(0);
// klatka z osłoną, kamerami i przewodami na przegubie przy pochyleniu t (wypustki zapadek osobno: test „detent”)
module stack(t = tilt, bumps = false) at_hinge(t) { cage(bumps); shroud(); cams_seated(); cables(); }
// strona gogli: adapter (z belką i blokami popychaczy), gałka, M5 + podkładka + nakrętka
module front() { adapter_top(); knob(); m5_hw(); }
module yawed() rotate([0, 0, yaw]) children();
// strefy widzenia (od płaszczyzny soczewki/szkła + lens_tol): termo 50×37.2 z CAŁEJ soczewki Ø16, Infra 96×72 z Ø19
module fov_th(t = tilt) at_hinge(t) th_keepout(300, 0, th_lens_len + lens_tol);
module fov_ir(t = tilt) at_hinge(t) ir_keepout(300, 0, ir_lens_len + lens_tol);
// klamra GoPro (żeńska, 3 palce) na kasku: tarcze R7.5 + korpus 15.6 × 15 od 10 do 30 mm od osi w kierunku `buckle`
module buckle_body() translate([helm_x, 0, helm_z]) rotate([0, buckle, 0]) union() {
  for (yr = [[-1.5, 1.5], [4.8, 7.8], [-7.8, -4.8]]) translate([-7.5, yr[0], 0]) cube([15, yr[1] - yr[0], 10]);
  translate([-7.5, -7.8, 10]) cube([15, 15.6, 20]);
}

// ---- pary ----
if (which == "adapter_ghost") intersection() { yawed() front(); ghostbox(); }                    // yaw 0, ±2
if (which == "stack_ghost")   intersection() { stack(); ghostbox(); }
if (which == "stack_front")   intersection() { stack(); union() { front(); pushers(g_fx); keypaths(); } }
if (which == "knob_front")    intersection() { knob(); union() { adapter_top(); pushers(g_fx); keypaths(); } }
if (which == "detent")        intersection() { adapter_top(); at_hinge(tilt) det_bumps(clamp ? fem_in - male_out : 0); }
if (which == "shroud_cage")   intersection() { shroud(); cage(); }
if (which == "shroud_cams")   intersection() { shroud(); cams_seated(); }
if (which == "cams_cage")     intersection() { cams_seated(); cage(); }
if (which == "cables_cage")   intersection() { cables(); union() { cage(); shroud(); } }
// pole termo: wszystko poza samą kamerą termo; pole Infra: wszystko poza samą kamerą Infra
if (which == "fov") union() {
  intersection() { fov_th(); union() { at_hinge(tilt) { cage(true); shroud(); cables(); cam_ir_only(); } front(); pushers(g_fx); ghostbox(); } }
  intersection() { fov_ir(); union() { at_hinge(tilt) { cage(true); shroud(); cables(); cam_th_only(); } front(); pushers(g_fx); ghostbox(); } }
}
// pomiar: korpus klamry kasku vs adapter (belka nad przegubem) i klatka przy tilt 10
if (which == "buckle")        intersection() { buckle_body(); union() { front(); stack(10); } }
// eksport brył w układzie gogli do sprawdzenia z modelem GrabCAD
if (which == "x_front") yawed() front();
if (which == "x_stack") stack(tilt, true);
// parametry popychaczy dla pusher_reach.py
if (which == "par") echo(str("PAR ", pad_xb, " ", pad_y, " ", pad_z, " ", pad_x1 - pad_xb, " ", pusher_len, " 0"));
