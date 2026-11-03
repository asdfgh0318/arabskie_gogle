// test kolizji poda v0.2: pary części, wsuwanie płytki od spodu, ruch przycisku CAM do ogranicznika
include <../pod.scad>
part = "none";
which = ["", ""];
module stack() {   // płytka ze wszystkim, co jest do niej przyklejone/przylutowane
    chassis(); g_enc(); g_pins(); g_b3s(); g_xiao(); g_vib(); g_buck(); g_perf(); g_heads();
    translate([cam_xy[0], cam_xy[1], pocket_z]) shim(shim_nom);
}
module cap_at(d) {  // nakładka przy ugięciu d pod trzpieniem: przesunięcie d + obrót o nachylenie 1,5·d/a
    translate([cam_xy[0], cam_xy[1], body_top - d]) rotate([1.5*d/tongue_a*180/PI, 0, 0]) cap_cam();
}
module lid_fixed() {  // obudowa bez języczka (to, o co nakładka może się oprzeć)
    difference() { shell(); translate([cam_xy[0] - tongue_w/2, tongue_y_free, body_top - lid_t - 0.5]) cube([tongue_w, tongue_y_root - tongue_y_free + 0.01, lid_t + 1]); }
}
module P(n) {
    if (n == "shell") shell();
    else if (n == "chassis") chassis();
    else if (n == "knob") translate([enc_xy[0], enc_xy[1], body_top + knob_gap]) knob();
    else if (n == "cap") translate([cam_xy[0], cam_xy[1], body_top]) cap_cam();
    else if (n == "shim") translate([cam_xy[0], cam_xy[1], pocket_z + 0.01]) shim(shim_nom - 0.02);
    else if (n == "enc") translate([0, 0, 0.01]) g_enc();
    else if (n == "pins") g_pins();
    else if (n == "b3s") translate([0, 0, 0.01]) g_b3s();
    else if (n == "xiao") g_xiao();
    else if (n == "vib") g_vib();
    else if (n == "buck") translate([0, 0, 0.01]) g_buck();
    else if (n == "perf") g_perf();
    else if (n == "heads") g_heads();
    else if (n == "sweep") for (dz = [1 : 1 : 16]) translate([0, 0, -dz]) stack();   // wsuwanie od spodu
    else if (n == "cap_stop") cap_at(d_stop - 0.05);        // tuż przed uszami: nie może dotykać wieka
    else if (n == "lid_fixed") lid_fixed();
    else if (n == "tongue_stop") translate([0, 0, -(d_stop - 0.05)]) intersection() { shell(); translate([cam_xy[0] - tongue_w/2, cam_xy[1] - 3, body_top - lid_t]) cube([tongue_w, 6, lid_t]); }
}
intersection() { P(which[0]); P(which[1]); }
