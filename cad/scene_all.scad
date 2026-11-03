// arabskie_gogle — CAŁY ZESTAW NA HDO2 (podgląd, WERSJA ROBOCZA)
// Gogle: bryła zastępcza z wymiarów research/04 (169,2 × 80 × 45,5), 06 (gniazdo wentylatora, przód) i 07b
// (narożniki R58, środek łuku 27 mm od osi). To NIE jest model producenta: pełnego modelu HDO2 nie znaleziono
// (papers/hdo2_body_models/, research w commicie). Położenie zatok, gniazd AV i drzwiczek jest przybliżone.
// Układ: x = do przodu, y = w lewo (strona noszącego), z = w górę; z = 0 = blat gniazda wentylatora.

use <camera_mount.scad>
use <pod.scad>
use <aibox_mount.scad>

which = "all";
tilt = 10;

W = 169.2; D = 80; H = 45.5;      // HDO2 [V: instrukcja s.11]
front_x = 23.1;                   // środek wentylatora → przód (research/06 A10)
corner_R = 58; corner_c = 27;     // research/07b §1.1
eye_z = -23;                      // oś okularów (seat_above_eye, do pomiaru M5)
side_y = W/2;
pod_c  = [front_x - corner_R - 6, -H/2];      // środek poda na lewym boku (x, z) — zastępczo
box_c  = [front_x - corner_R - 4, -H/2 + 1];  // środek AI boxa na prawym boku (x, z) — zastępczo

module hdo2_body() {
    color([0.18, 0.19, 0.21]) difference() {
        translate([0, 0, -H]) linear_extrude(H) intersection() {   // przód: łuki R58, boki proste ≈22 mm
            hull() {
                for (s = [-1, 1]) translate([front_x - corner_R, s*corner_c]) circle(r = corner_R, $fn = 120);
                translate([front_x - D, -W/2]) square([D - corner_R, W]);
            }
            translate([front_x - D, -W]) square([D + 1, 2*W]);
        }
        // wcięcie na nos (research/06 B5: ≈37 × 8)
        translate([front_x - 30, -37/2, -H - 1]) cube([40, 37, 9]);
        // gniazdo wentylatora (płytka adaptera leży na blacie z = 0)
    }
    // okulary + piankowa ramka twarzy z tyłu
    color([0.1, 0.1, 0.1]) translate([front_x - D - 12, -W/2 + 12, -H + 4]) cube([12, W - 24, H - 8]);
    color("red") for (s = [-1, 1]) translate([front_x - D - 13, s*30, eye_z]) rotate([0, 90, 0]) cylinder(d = 8, h = 2);
    // panele przycisków VOL / CH na górze (research/06 A5)
    color([0.3, 0.3, 0.32]) for (s = [-1, 1]) translate([-8, s*30 - 10, -0.01]) cube([16, 20, 2.5]);
}

module camera_stack() {
    adapter_top();
    translate([adapter_axis_x_(), 0, 0]) rotate([0, tilt, 0]) translate([-cage_axis_x_(), 0, -axis_z_()]) { cage(); ghost_cams(); }
}
// wartości z camera_mount.scad (przez `use` zmienne nie są widoczne → funkcje-kopie, zgodne z v0.4)
function adapter_axis_x_() = 23.1 + 15/2 + 3.0;
function axis_z_() = (5.6 + 15.6)/2;
function cage_axis_x_() = -(15.4 + 1.0) - 4.5 - 9.0;

module pod_on_goggle() {
    translate([pod_c[0], side_y, pod_c[1]]) to_goggle() {
        shell(); chassis();
        translate([12.5, 0, 12 + 1.2]) knob();
        translate([-14.5, 1.2, 12]) cap_cam();
    }
}
module aibox_on_goggle() { translate([box_c[0], -side_y, box_c[1]]) to_goggle_right() { aibox_mount(); aibox_ghost(); } }

if (which == "all" || which == "hdo2") hdo2_body();
if (which == "all" || which == "camera") camera_stack();
if (which == "all" || which == "pod") pod_on_goggle();
if (which == "all" || which == "aibox") aibox_on_goggle();
if (which == "adapter") adapter_top();
if (which == "cage") translate([adapter_axis_x_(), 0, 0]) rotate([0, tilt, 0]) translate([-cage_axis_x_(), 0, -axis_z_()]) cage();
if (which == "cams") translate([adapter_axis_x_(), 0, 0]) rotate([0, tilt, 0]) translate([-cage_axis_x_(), 0, -axis_z_()]) ghost_cams();
if (which == "aibox_mount") translate([box_c[0], -side_y, box_c[1]]) to_goggle_right() aibox_mount();
if (which == "aibox_box") translate([box_c[0], -side_y, box_c[1]]) to_goggle_right() aibox_ghost();
