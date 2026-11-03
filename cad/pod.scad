// arabskie_gogle — POD STEROWNIKA w lewej zatoce modułu VRx HDO2 — v0.2 (WERSJA ROBOCZA)
// Źródła: research/07a (wymiary części), 07b (miejsce, obrys, pomiary P1–P9), 07c (ergonomia, sprężynka).
// v0.2 = poprawki z przeglądu v0.1 (cad/README.md, sekcja Pod). Wymiary zatoki są ZASTĘPCZE → blok „P1” niżej.
//
// Układ współrzędnych poda:
//   x = przód–tył gogli (+x do przodu, w stronę kamery)
//   y = pion (+y w górę)
//   z = na zewnątrz od głowy (z = 0 = powierzchnia boku gogli / krawędź zatoki; z < 0 = w zatoce)
//
// Części:
//   shell   — obudowa: wieko (enkoder, przycisk CAM na sprężynce) + ściany + kołnierz + wtyk w zatokę.
//             Jedna część, drukowana wiekiem do stołu: spód kołnierza i spód wtyku są na górze wydruku,
//             więc dają się wyprofilować do zmierzonego kształtu (seat_prof, bay_depth).
//   chassis — płytka montażowa wkładana od spodu wtyku: gniazdo enkodera, cokół B3S z „uszami”
//             ogranicznika, rowek przetwornicy; XIAO, silnik i płytka uniwersalna pod spodem na taśmie
//   knob    — gałka enkodera Ø20 z otworem D i śrubą dociskową M3
//   cap_cam — nakładka CAM (okrągła, wklęsła), klejona do języczka
//   shim    — podkładki pod B3S 0,2…1,0 mm (dobór skoku na sztukę)
//   gauge   — sprawdzian P1: kołnierz + krótki wtyk (dopasowanie zatoki, profil gniazda drzwiczek)
//   assembly / print_* / none

part = "assembly";
show_goggle = true;
$fn = 48;
eps = 0.01;

// =================== P1: POMIARY ZATOKI (ZASTĘPCZE — wpisać z pomiaru, research/07b §6) ===================
bay       = [44, 32];      // otwór zatoki szer. (x) × wys. (y)          [HDO v1, forum]
bay_r     = 3;             // promień narożników otworu                  [A]
bay_off   = [0, 0];        // środek otworu względem środka kołnierza     [A]
bay_depth = [13, 13, 13];  // głębokość zatoki: przód, środek, tył        [HDO v1 „najgłębiej 13”]
door_seat = [51, 34];      // gniazdo drzwiczek = obrys kołnierza         [SpeedyBee 51×34]
seat_prof = [[-25.5, 0], [-12.75, 0], [0, 0], [12.75, 0], [25.5, 0]];  // szczelina pod płaskim sprawdzianem [x, mm]
// gniazdo w zatoce (strefa zakazana) — nieznane: dopisać [x, y, szer, wys, wysokość nad dnem] po P1/P2
// ===========================================================================================================

plug_clr  = 0.25;          // luz wtyku na stronę
rib_int   = 0.15;          // wcisk żeber zaciskowych
floor_clr = 1.0;           // odstęp spodu wtyku od dna zatoki
face   = door_seat;
face_r = 5;
plug   = bay - [2*plug_clr, 2*plug_clr];
plug_r = max(bay_r - plug_clr, 0.6);
plug_wall = 1.2;
pi_in  = plug - [2*plug_wall, 2*plug_wall];
pi_r   = max(plug_r - plug_wall, 0.5);
plug_d = [for (d = bay_depth) d - floor_clr];    // przód, środek, tył
plug_dmin = min(plug_d);

fl_t     = 2.4;
body_top = 12;             // wierzch wieka nad bokiem gogli (07b: ≤12)
lid_t    = 2.0;
wall     = 1.8;
clr      = 0.2;

// ---------- części elektroniczne (07a §7) ----------
ec11_body   = [11.7, 12.0];
ec11_body_h = 4.5;
ec11_collar = [7.0, 7.0];
ec11_shaft_d = 6.0;
ec11_tip_z  = 24.5;
ec11_flat_len = 10;
ec11_pin_len  = 3.5;
ec11_ACB_y = -7.5; ec11_DE_y = 7.0; ec11_pin_pitch = 2.5;
ec11_tab_pitch = 12.5; ec11_tab_slot = [1.5, 2.6];

b3s_body = [6.0, 6.6];      // ±0,3; 6,0 wzdłuż zacisków
b3s_cover_h = 3.4;
b3s_h = 4.3;                // ±0,3 do czubka popychacza
b3s_term_span = 9.0;
b3s_pretravel = 0.25;       // +0,2/−0,1

xiao = [20.955, 17.78];
xiao_usb_over = 1.51;
pololu = [12.7, 10.2, 2.82];
vib = [10.0, 3.15];

// ---------- gałka ----------
enc_xy = [12.5, 0];
knob_d = 20; knob_h = 10.8; knob_gap = 1.2;      // wierzch gałki = body_top + 12
knob_top_t = 1.6;
knob_bore = 6.2; knob_flat = 4.55;               // 07c: D Ø6,20 / 4,55 — skalibrować próbką
knob_ribs = 24;
m3_nut_af = 5.7; m3_nut_t = 2.6;

// ---------- przycisk CAM (języczek w wieku) ----------
cam_cap_d = 16;                                   // 07c: ≥15 dla cienkich rękawic
tongue_t  = 1.0;
tongue_w  = 10;
tongue_a  = 14;                                   // nasada → oś trzpienia (07c: 15; ogranicza ściana górna)
tongue_y_root = face[1]/2 - wall;
cam_xy    = [-14.5, tongue_y_root - tongue_a];
tongue_y_free = cam_xy[1] - cam_cap_d/2 - 1;      // języczek sięga za całą nakładkę
slot_w    = 0.7;
root_taper = 1.5;
peg_d = 4.5; peg_hole = 4.6;                      // trzpień klejony (CA) w języczku
peg_below = 3.0;
collar_d = 7;
sw_gap   = 1.9;                                   // trzpień → popychacz przy podkładce nominalnej
shim_nom = 0.6;                                   // podkładka nominalna (zestaw 0,2…1,0)
d_stop   = sw_gap + b3s_pretravel + 0.35;         // ugięcie, przy którym języczek siada na uszach
rim_tilt = 1 + 1.5 * sqrt(pow(cam_cap_d/2, 2) - pow(tongue_w/2 + slot_w, 2)) / tongue_a;
cap_stop = rim_tilt * d_stop + 0.3;               // brzeg nakładki nie dotyka wieka przed uszami
cap_t = 3.0; cap_ring = 0.8;                      // wklęsłość: pierścień 0,8 mm (druk wierzchem do stołu)

// ---------- płytka montażowa ----------
ms_z   = body_top + knob_gap + knob_h - knob_top_t - ec11_tip_z;
ch_top = ms_z;
ch_t   = 2.0;
ch_clr = 0.3;
ch_size = pi_in - [2*ch_clr, 2*ch_clr];
posts = [[17, 11.2, 5], [17, -11.2, 5], [-6, -11.5, 4.5], [-17, -11.5, 4.5]];   // x, y, Ø (M2 od spodu)
m2_pilot = 1.8; m2_clear = 2.4; m2_head = 4.2;
enc_wall_t = 1.0;

cam_tip_z  = body_top - tongue_t - peg_below;
cam_plg_z  = cam_tip_z - sw_gap;
cam_base_z = cam_plg_z - b3s_h;
pocket_z   = cam_base_z - shim_nom;
pocket     = [b3s_body[0] + 0.9, b3s_body[1] + 0.9];
ear_top    = body_top - tongue_t - d_stop;

xiao_xy = [bay_off[0] - ch_size[0]/2 + 0.3 + xiao[1]/2, bay_off[1] + ch_size[1]/2 - 0.3 - xiao[0]/2];  // USB-C w +y
xiao_z  = ch_top - ch_t - 1 - 3.2 - 1.6;          // spód PCB: taśma 1 + USB 3,2 [A] + PCB 1,6 [A]
usb_z   = ch_top - ch_t - 1 - 3.2/2;
usb_win = [12.5, 7.0];
vib_xy  = [4.0, -6.5];
buck_x  = [1, 1 + pololu[0]];
buck_y  = bay_off[1] - ch_size[1]/2 + 0.4;
perf    = [[enc_xy[0] - 3.4, enc_xy[0] + 6.6], [-5.8, 5.4], 2.5];
pass_xy = [[-0.5, 4.0], [4.5, 10.5]];
cable   = [-5, 6.2, 4.5];                          // wyjście przewodu w ścianie tylnej: y, z, Ø
tie_xy  = [-21.5, -10.5];

assert(-(xiao_z) < plug_dmin - 0.5, "elektronika za głęboko względem bay_depth");
assert(tongue_y_free - slot_w > posts[3][1] + posts[3][2]/2, "języczek CAM wchodzi w słupek");

E = 1600; I = tongue_w * pow(tongue_t, 3) / 12; k = 3*E*I/pow(tongue_a, 3);
echo(str("P1: wtyk ", plug, ", głębokość ", plug_d, ", obrys ", face));
echo(str("enkoder: ms_z=", ms_z, "; gałka z ", body_top+knob_gap, "…", body_top+knob_gap+knob_h,
         "; zazębienie D=", ms_z+ec11_tip_z-(body_top+knob_gap), " mm"));
echo(str("CAM: a=", tongue_a, ", trzpień z=", cam_tip_z, ", popychacz z=", cam_plg_z, ", skok do kliku ",
         sw_gap + b3s_pretravel, ", ogranicznik ", d_stop, ", cap_stop ", cap_stop, ", nakładka wystaje ", cap_stop + cap_t));
echo(str("CAM sprężyna: k=", k, " N/mm, przy kliku ", k*(sw_gap+b3s_pretravel), " N + OF; ε klik ",
         150*tongue_t*(sw_gap+b3s_pretravel)/pow(tongue_a,2), "%, ε stop ", 150*tongue_t*d_stop/pow(tongue_a,2), "%"));
echo(str("odstęp krawędzi CAM–gałka ", enc_xy[0] - knob_d/2 - (cam_xy[0] + cam_cap_d/2), " mm"));
echo(str("XIAO spód z=", xiao_z, ", wtyk do z=", -plug_dmin));

// ---------- pomocnicze ----------
module rrect(s, r, h) { linear_extrude(h) offset(r) offset(-r) square(s, center=true); }
function prof(x)   = lookup(x, seat_prof);
function pdepth(x) = lookup(x, [[-plug[0]/2, plug_d[2]], [0, plug_d[1]], [plug[0]/2, plug_d[0]]]);

module flange_solid() {   // kołnierz: wierzch płaski z = fl_t, spód wg seat_prof (plastry co ~1 mm)
    n = ceil(face[0]);
    for (i = [0 : n - 1]) {
        x0 = -face[0]/2 + i*face[0]/n; x1 = x0 + face[0]/n;
        hull() for (x = [x0, x1]) intersection() {
            translate([x - eps, -face[1], -prof(x)]) cube([2*eps, 2*face[1], fl_t + prof(x)]);
            translate([0, 0, -20]) rrect(face, face_r, 40);
        }
    }
}
module plug_solid() {     // wtyk: spód wg bay_depth (przód / środek / tył)
    hull() for (x = [-plug[0]/2 + 0.3, 0, plug[0]/2 - 0.3]) intersection() {
        translate([bay_off[0] + x - 0.25, -50, -pdepth(x)]) cube([0.5, 100, pdepth(x) + eps]);
        translate([bay_off[0], bay_off[1], -40]) rrect(plug, plug_r, 40 + eps);
    }
}
module rib(h) { hull() { cylinder(r = 0.6, h = h, $fn = 16); translate([0, 0, -1.2]) cylinder(r = 0.01, h = 0.01); } }

// ================= OBUDOWA =================
module tongue_cut() {
    x0 = cam_xy[0] - tongue_w/2; x1 = cam_xy[0] + tongue_w/2;
    yf = tongue_y_free; yr = tongue_y_root;
    zc = body_top - lid_t - 1;
    translate([x0 - slot_w, yf - slot_w, zc]) cube([slot_w, yr - yf + slot_w, lid_t + 2]);
    translate([x1, yf - slot_w, zc]) cube([slot_w, yr - yf + slot_w, lid_t + 2]);
    translate([x0 - slot_w, yf - slot_w, zc]) cube([tongue_w + 2*slot_w, slot_w, lid_t + 2]);
    hull() {   // pocienienie od środka, łagodne przy nasadzie
        translate([x0, yf, zc]) cube([tongue_w, yr - yf - root_taper, 1 + lid_t - tongue_t]);
        translate([x0, yr - eps, zc]) cube([tongue_w, eps, 1]);
    }
    translate([cam_xy[0], cam_xy[1], zc]) cylinder(d = peg_hole, h = lid_t + 2);
}

module shell() {
    chamf = (face[0] - 2*wall - pi_in[0])/2 + 0.2;   // wewnętrzny skos 45° na stopniu kołnierz → wtyk
    difference() {
        union() {
            difference() {
                union() {
                    translate([0, 0, fl_t]) rrect(face, face_r, body_top - fl_t);
                    flange_solid();
                    plug_solid();
                    rh = plug_clr + rib_int;
                    for (sx = [-1, 1], xr = [-12, 6]) translate([bay_off[0] + xr, bay_off[1] + sx*(plug[1]/2 + rh - 0.6), -plug_dmin + 1.5]) rib(plug_dmin - 2);
                    for (sx = [-1, 1], yr = [-8, 8]) translate([bay_off[0] + sx*(plug[0]/2 + rh - 0.6), bay_off[1] + yr, -plug_dmin + 1.5]) rib(plug_dmin - 2);
                }
                hull() {
                    translate([0, 0, fl_t + chamf]) rrect(face - [2*wall, 2*wall], face_r - wall, body_top - lid_t - fl_t - chamf);
                    translate([bay_off[0], bay_off[1], fl_t - eps]) rrect(pi_in, pi_r, eps);
                }
                translate([bay_off[0], bay_off[1], -40]) rrect(pi_in, pi_r, 40 + fl_t + eps);
            }
            for (p = posts) translate([p[0], p[1], ch_top]) cylinder(d = p[2], h = body_top - ch_top - 0.5);
            translate([tie_xy[0], tie_xy[1], 3]) cylinder(d = 3, h = body_top - 3 - 0.5);
        }
        translate([enc_xy[0], enc_xy[1], body_top - lid_t - 1]) cylinder(d = ec11_shaft_d + 1.4, h = lid_t + 2);
        tongue_cut();
        for (p = posts) translate([p[0], p[1], ch_top - 1]) cylinder(d = m2_pilot, h = body_top - ch_top - 1.5);
        // szczelina USB-C otwarta od spodu wtyku
        translate([xiao_xy[0] - usb_win[0]/2, bay_off[1] + plug[1]/2 - plug_wall - 1, -40])
            cube([usb_win[0], plug_wall + 2, 40 + usb_z + usb_win[1]/2]);
        // wyjście przewodu w ścianie tylnej (wzdłuż paska)
        translate([-face[0]/2 - 1, cable[0], cable[1]]) rotate([0, 90, 0]) cylinder(d = cable[2], h = wall + 5);
    }
}

// ================= PŁYTKA MONTAŻOWA =================
module chassis() {
    difference() {
        union() {
            translate([bay_off[0], bay_off[1], ch_top - ch_t]) rrect(ch_size, 1.5, ch_t);
            for (s = [-1, 1]) translate([enc_xy[0] + s*(ec11_body[0]/2 + clr + 0.5), enc_xy[1], ch_top + 1.5])
                cube([enc_wall_t, 8, 3], center = true);
            translate([cam_xy[0], cam_xy[1], ch_top - eps])
                linear_extrude(cam_base_z + b3s_cover_h - ch_top + eps) offset(1.2) square(pocket, center = true);
            for (s = [-1, 1]) translate([cam_xy[0] + s*(pocket[0]/2 + 0.6), cam_xy[1], ch_top])
                translate([-0.6, -2.5, 0]) cube([1.2, 5, ear_top - ch_top]);
            translate([buck_x[0] - 0.5, buck_y + pololu[2] + 0.4, ch_top - eps]) cube([pololu[0] + 1, 0.8, 2.5]);
        }
        for (ry = [ec11_ACB_y, ec11_DE_y]) {
            translate([enc_xy[0], enc_xy[1] + ry, 0]) cube([2*ec11_pin_pitch + 1.6, 1.6, 50], center = true);
            translate([enc_xy[0], enc_xy[1] + ry, ch_top - ch_t - 1 + 0.8/2]) cube([8, 3.2, 2 + 0.8], center = true);
        }
        for (s = [-1, 1]) translate([enc_xy[0] + s*ec11_tab_pitch/2, enc_xy[1], 0]) cube([ec11_tab_slot[0] + 0.4, 2.8, 50], center = true);
        translate([cam_xy[0], cam_xy[1], pocket_z]) linear_extrude(10) square(pocket, center = true);
        for (s = [-1, 1]) translate([cam_xy[0], cam_xy[1] + s*2.25, pocket_z - 0.6]) linear_extrude(10) square([b3s_term_span + 0.8, 1.4], center = true);
        translate([pass_xy[0][0], pass_xy[1][0], -50]) cube([pass_xy[0][1] - pass_xy[0][0], pass_xy[1][1] - pass_xy[1][0], 100]);
        translate([buck_x[0] - 0.2, buck_y - 0.2, ch_top - 0.8]) cube([pololu[0] + 0.4, pololu[2] + 0.4, 2]);
        for (p = posts) translate([p[0], p[1], ch_top - ch_t - 1]) cylinder(d = m2_clear, h = ch_t + 2);
    }
}

module shim(t) {   // tylko pod korpusem B3S (zaciski wychodzą w kanały gniazda po bokach)
    linear_extrude(t) square([b3s_body[0] - 0.8, pocket[1] - 0.3], center = true);
}

// ================= GAŁKA =================
module d_bore(h) { intersection() { cylinder(d = knob_bore, h = h); translate([knob_bore/2 - knob_flat, -knob_bore, 0]) cube([knob_flat, 2*knob_bore, h]); } }
module knob() {
    bore = ms_z + ec11_tip_z - (body_top + knob_gap) + 0.3;
    ss_z = bore - 1 - (ec11_flat_len - 2)/2;      // śruba M3 na środku płaskiego odcinka osi
    difference() {
        union() {
            cylinder(d = knob_d - 1.6, h = knob_h);
            for (i = [0 : knob_ribs - 1]) rotate(i*360/knob_ribs) translate([knob_d/2 - 1.2, 0, 0]) cylinder(d = 1.6, h = knob_h, $fn = 12);
        }
        translate([0, 0, -eps]) d_bore(bore);
        translate([0, 0, -eps]) cylinder(d1 = knob_bore + 1.6, d2 = knob_bore, h = 0.8);
        translate([0, 0, ss_z]) rotate([0, -90, 0]) cylinder(d = 3.2, h = knob_d);
        translate([-(knob_flat - knob_bore/2) - 1.6 - m3_nut_t, -m3_nut_af/2, -eps]) cube([m3_nut_t, m3_nut_af, ss_z + m3_nut_af/2 + 0.3]);
        translate([knob_d/2 - 4, 0, knob_h - 0.6]) cylinder(d = 2, h = 1);
    }
}

// ================= NAKŁADKA CAM =================
module cap_cam() {   // z = 0: spód kołnierza (opiera się na języczku); trzpień w -z
    difference() {
        union() {
            translate([0, 0, cap_stop]) cylinder(d = cam_cap_d, h = cap_t);
            cylinder(d = collar_d, h = cap_stop + eps);
            translate([0, 0, -(tongue_t + peg_below)]) cylinder(d = peg_d, h = tongue_t + peg_below + eps);
        }
        // wklęsłość: wgłębienie Ø11 → Ø9,4 na 0,8 mm (pierścień wyczuwalny palcem)
        translate([0, 0, cap_stop + cap_t - cap_ring]) cylinder(d1 = cam_cap_d - 5 - 2*cap_ring, d2 = cam_cap_d - 5, h = cap_ring + eps);
    }
}

// ================= SPRAWDZIAN P1 =================
module gauge() {
    difference() {
        intersection() {
            union() { flange_solid(); plug_solid(); }
            translate([-60, -60, -3]) cube([120, 120, fl_t + 3 + prof_max() + 1]);
        }
        translate([bay_off[0], bay_off[1], -10]) rrect(pi_in, pi_r, 20);
        for (s = seat_prof) for (sy = [-1, 1]) translate([s[0], sy*face[1]/2, fl_t]) cube([0.8, 2.4, 1.2], center = true);
    }
}
function prof_max() = max([for (s = seat_prof) s[1]]);

// ================= ATRAPY =================
module g_enc()  { translate([enc_xy[0], enc_xy[1], ms_z]) {
    translate([-ec11_body[0]/2, -ec11_body[1]/2, 0]) cube([ec11_body[0], ec11_body[1], ec11_body_h]);
    cylinder(d = ec11_collar[0], h = ec11_body_h + ec11_collar[1]);
    cylinder(d = ec11_shaft_d, h = ec11_tip_z); } }
module g_pins() { translate([enc_xy[0], enc_xy[1], ms_z - ec11_pin_len]) {
    for (x = [-1, 0, 1]) translate([x*ec11_pin_pitch, ec11_ACB_y, 0]) cylinder(d = 0.8, h = ec11_pin_len);
    for (x = [-1, 1]) translate([x*ec11_pin_pitch, ec11_DE_y, 0]) cylinder(d = 0.8, h = ec11_pin_len); } }
module g_b3s()  { translate([cam_xy[0], cam_xy[1], cam_base_z]) {
    translate([-b3s_body[0]/2, -b3s_body[1]/2, 0]) cube([b3s_body[0], b3s_body[1], b3s_cover_h]);
    cylinder(d = 3.3, h = b3s_h); } }
module g_xiao() { translate([xiao_xy[0], xiao_xy[1], xiao_z]) {
    rrect([xiao[1], xiao[0]], 1.906, 1.6);
    translate([-4.5, xiao[0]/2 - 7.35 + xiao_usb_over, 1.6]) cube([9, 7.35, 3.2]); } }
module g_vib()  { translate([vib_xy[0], vib_xy[1], ch_top - ch_t - 1 - vib[1]]) {
    cylinder(d = vib[0], h = vib[1]); translate([-2.2, 0, 0]) cube([4.4, 10, vib[1]]); } }
module g_buck() { translate([buck_x[0], buck_y, ch_top - 0.8]) cube([pololu[0], pololu[2], pololu[1]]); }
module g_perf() { translate([perf[0][0], perf[1][0], ch_top - ch_t - 1 - perf[2]]) cube([perf[0][1] - perf[0][0], perf[1][1] - perf[1][0], perf[2]]); }
module g_heads(){ for (p = posts) translate([p[0], p[1], ch_top - ch_t - 1.6]) cylinder(d = m2_head, h = 1.6); }
module ghost_parts() {
    color("silver") { g_enc(); g_pins(); }
    color("orange") g_b3s();
    color("green") g_xiao();
    color("gray") g_vib();
    color("purple") g_buck();
    color("tan") g_perf();
}
module ghost_goggle() {   // bok gogli z zatoką wg bloku P1 (łuk R58 i profil gniazda — przez seat_prof)
    color("black", 0.25) difference() {
        translate([-40, -30, -20]) cube([80, 60, 20]);
        translate([bay_off[0], bay_off[1], -max(bay_depth)]) rrect(bay, bay_r, 30);
    }
}

module assembly() {
    if (show_goggle) ghost_goggle();
    color("LightSteelBlue", 0.85) shell();
    color("Khaki") chassis();
    color("DimGray") translate([enc_xy[0], enc_xy[1], body_top + knob_gap]) knob();
    color("tomato") translate([cam_xy[0], cam_xy[1], body_top]) cap_cam();
    color("white") translate([cam_xy[0], cam_xy[1], pocket_z]) shim(shim_nom);
    ghost_parts();
}

// ================= DRUK =================
module print_shell()   { translate([0, 0, body_top]) mirror([0, 0, 1]) shell(); }
module print_chassis() { translate([0, 0, -(ch_top - ch_t)]) chassis(); }
module print_knob()    { translate([0, 0, knob_h]) mirror([0, 0, 1]) knob(); }
module print_caps()    { for (i = [0 : 2]) translate([i*30 - 30, 0, cap_stop + cap_t]) mirror([0, 0, 1]) cap_cam(); }
module print_shims()   { for (i = [1 : 5]) translate([(i - 3)*10, 0, 0]) shim(0.2*i); }
module print_gauge()   { translate([0, 0, fl_t]) mirror([0, 0, 1]) gauge(); }

if (part == "shell") shell();
else if (part == "chassis") chassis();
else if (part == "knob") knob();
else if (part == "cap_cam") cap_cam();
else if (part == "gauge") gauge();
else if (part == "print_shell") print_shell();
else if (part == "print_chassis") print_chassis();
else if (part == "print_knob") print_knob();
else if (part == "print_caps") print_caps();
else if (part == "print_shims") print_shims();
else if (part == "print_gauge") print_gauge();
else if (part == "assembly") assembly();
else if (part == "none") { }
