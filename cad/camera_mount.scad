// arabskie_gogle — mocowanie kamer Caddx TR1-220SL na przód Fat Shark HDO2
// v0.2 (2026-11-03) — WERSJA ROBOCZA (klatka v0.2 po przeglądzie; adapter czeka na geometrię przodu HDO2 bez wentylatora), wymiary kamer z rysunków sklepu BZB UAS, nie zmierzone.
//
// Dwie części:
//   1) cage       — klatka: termo (dół, oś na wysokości oczu) + Infra (nad nią), z tyłu 2 palce GoPro (męskie)
//   2) adapter_fan — ramka nasuwana na wentylator 25x25 z przodu HDO2 (śruby 20x20), z 3 palcami GoPro (żeńskie)
//   Klatka pasuje też do każdej klamry GoPro na podstawce VHB (standard GoPro).
// Pochylenie (0–20° w dół) = przegub GoPro na śrubie M5 (tarcie). Odchylenie (yaw) ustala ramka
// nasunięta na obudowę wentylatora — bez kleju, powtarzalnie.
//
// Układ: x = do przodu (oś optyczna), y = w lewo, z = do góry.
// Klatka: początek = środek przedniej ściany korpusu kamery termo (oś optyczna termo).
// Adapter: początek = środek wentylatora, x=0 = przednia płaszczyzna wentylatora.
//
// Użycie:  openscad -D 'part="cage"' -o cage.stl camera_mount.scad
//          part = "cage" | "adapter_fan" | "assembly" | "print_cage" | "print_adapter"

part = "assembly";
tilt = 10;              // [deg] pochylenie kamer w dół (tylko podgląd assembly)

$fn = 64;
eps = 0.01;

// ---------- kamery (rysunki BZB UAS; [A] = odczyt z rysunku, do zmierzenia) ----------
th_w = 19.5;  th_h = 19.5;          // termo: przód 19.5 x 19.5 (h = [A], rysunek daje tylko szerokość)
th_body = 12.7;                     // [A] głębokość korpusu bez obiektywu (20 całość, odczyt z rysunku)
th_lens_len = 7.3;  th_lens_d = 16; // [A]
th_screw_x = -5.2;                  // [A] boczny otwór M2: 5.2 mm za przednią ścianą, w połowie wysokości
ir_w = 20.5;  ir_h = 20.5;          // Infra: przód 20.5 x 20 wg etykiety; piksele rysunku dają 20.3–20.8 → 20.5 (przegląd fit-08)
ir_body = 15.4;                     // [A] głębokość korpusu (34.5 całość)
ir_lens_len = 19.1; ir_lens_d = 19; // [A]
ir_screw_x = -6.7;                  // [A]
cam_gap = 1.5;                      // odstęp pionowy między korpusami
ir_yaw_trim = 0;                    // [deg] korekta odchylenia Infra względem termo (po zbieżeniu na celu 10 m)
ir_z = th_h/2 + cam_gap + ir_h/2;   // oś Infra nad osią termo (= 21.25)

// ---------- klatka ----------
clr = 0.2;          // luz na stronę wokół korpusu
side_t = 2.5;       // grubość ścianki bocznej (przy Infra; przy termo +0.5)
slot_len = 3.0;     // długość szczeliny M2 wzdłuż osi (kompensuje niepewność położenia otworu)
m2_cbore = 0;       // [mm] pogłębienie Ø4.5 pod łeb M2 od zewnątrz (ustawić po zmierzeniu śrub z zestawu)
stop_d = 1.0;       // głębokość zderzaków tylnych (baza kierunku kamery: docisnąć kamerę do tyłu, potem M2)
stop_w = 3.0;       // jak daleko zderzak wchodzi od ścianki do środka
cable_slot_w = 4.0; // [A] szczelina w mostkach na przewód kamery (oplot ~3 mm wg zdjęcia) — kamera z przewodem wkładana bez nawlekania
m2_d = 2.3;
bridge_t = 2.0;     // mostki górny/dolny
cage_y = ir_w/2 + clr + side_t;           // zewnętrzna połowa szerokości (12.95)
cage_x0 = -(ir_body + 1.0);               // tył ścianek bocznych
z_bot = -th_h/2 - clr - bridge_t;
z_top = ir_z + ir_h/2 + clr + bridge_t;

// ---------- GoPro (biblioteka ridercz/GoProScad: noga 3.0, szczelina 3.5, Ø15, M5) ----------
gp_leg = 3.0;  gp_slit = 3.3;  gp_od = 15;  gp_hole = 5.5;   // slit: 3.5 w ridercz; 3.3 do sprawdzenia próbką (part="coupon")
gp_nut_af = 8.2; gp_nut_h = 4.2;          // M5 nakrętka sześciokątna (pułapka)
bar_t = 4.5;                               // tylna belka klatki (przegląd mech-5: 3.0 za słaba na skręcanie)
bar_z0 = 5.6;  bar_z1 = 15.6;              // [A] belka między kamerami: kable termo idą pod nią, Infra nad nią
axis_z = (bar_z0 + bar_z1)/2;              // oś przegubu względem osi termo (10.6)
axis_back = 9.0;                           // odległość osi przegubu za belką
cage_bar_x0 = cage_x0 - bar_t;
cage_axis_x = cage_bar_x0 - axis_back;     // oś przegubu we współrz. klatki

// ---------- wentylator HDO2 (z Printables #262727, zmierzone ze STL: otwór 25.2, otwory Ø2 w 20x20) ----------
fan_size = 25.2;     // kieszeń na obudowę wentylatora
fan_hole = 20;       // rozstaw śrub
fan_wall = 2.0;
fan_wall_depth = 5;  // [A] jak daleko ramka schodzi w stronę skorupy gogli (#262727 ma 6)
fan_plate = 2.0;     // płytka z uszami na przedniej ścianie wentylatora
thermal_z_rel_fan = 0;  // [A] oś termo względem środka wentylatora (ustawić po pomiarze wysokości oczu!)
adapter_axis_x = fan_plate + 9.5;          // oś przegubu przed wentylatorem
adapter_axis_z = thermal_z_rel_fan + axis_z;

// ======================================================================
module rbox(p0, p1, r=1) {   // prostopadłościan z zaokrągleniem w XZ (oś y bez zaokrągleń)
  hull() for (x=[p0[0]+r, p1[0]-r], z=[p0[2]+r, p1[2]-r])
    translate([x, p0[1], z]) rotate([-90,0,0]) cylinder(r=r, h=p1[1]-p0[1]);
}

module cam_thermal(c=0) {     // obwiednia korpusu + obiektywu (c = luz)
  translate([-th_body, -th_w/2-c, -th_h/2-c]) cube([th_body + 0.01, th_w+2*c, th_h+2*c]);
  rotate([0,90,0]) cylinder(d=th_lens_d+2*c, h=th_lens_len);
}
module cam_infra(c=0) {
  translate([0,0,ir_z]) {
    translate([-ir_body, -ir_w/2-c, -ir_h/2-c]) cube([ir_body + 0.01, ir_w+2*c, ir_h+2*c]);
    rotate([0,90,0]) cylinder(d=ir_lens_d+2*c, h=ir_lens_len);
  }
}

module gopro_legs(n, y_centers) {    // nogi w płaszczyźnie XZ, oś otworu = y
  for (yc = y_centers) translate([0, yc - gp_leg/2, 0]) rotate([-90,0,0])
    cylinder(d=gp_od, h=gp_leg);
}

// ---------------- KLATKA ----------------
module infra_xf() {   // transformacja Infra: korekta yaw wokół osi pionowej przez środek przedniej ściany
  translate([0,0,ir_z]) rotate([0,0,ir_yaw_trim]) translate([0,0,-ir_z]) children();
}
module cage() {
  male_y = [-(gp_slit/2 + gp_leg/2), (gp_slit/2 + gp_leg/2)];
  bx1 = cage_x0 - bar_t;                       // tył belki
  difference() {
    union() {
      // ścianki boczne
      for (s=[-1,1])
          rbox([cage_x0, s>0 ? th_w/2+clr : -cage_y, z_bot],
               [0,       s>0 ? cage_y      : -(th_w/2+clr), z_top], r=1.5);
      // mostki górny i dolny na całej długości (do x=0, za obiektywami — poza polem widzenia)
      rbox([cage_x0, -cage_y, z_top - bridge_t], [0, cage_y, z_top], r=0.8);
      rbox([cage_x0, -cage_y, z_bot], [0, cage_y, z_bot + bridge_t], r=0.8);
      // tylna belka (zachodzi 1 mm na ścianki, nie 0.5)
      rbox([bx1, -cage_y, bar_z0], [cage_x0 + 1.0, cage_y, bar_z1], r=1);
      // nogi męskie (2) — hull z belką
      for (yc = male_y) hull() {
        translate([bx1 + 0.5, yc - gp_leg/2, bar_z0]) cube([0.01, gp_leg, bar_z1 - bar_z0]);
        translate([cage_axis_x, yc - gp_leg/2, axis_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
      }
      // wskaźnik pochylenia: płetwa przy zewnętrznej nodze żeńskiej (-y), czytana na podziałce adaptera
      hull() {
        translate([bx1 + 0.5, -cage_y, axis_z - 1]) cube([0.01, cage_y - (1.5*gp_leg + gp_slit) - 0.3, 2]);
        translate([cage_axis_x + 6.0, -(1.5*gp_leg + gp_slit) - 1.3, axis_z - 0.5]) cube([0.5, 1.0, 1]);
      }
    }
    // kieszenie na kamery (wsuwane od przodu)
    cam_thermal(clr);
    infra_xf() cam_infra(clr);
    // przedłużenie kieszeni do przodu (żeby nic nie wystawało przed korpusy)
    translate([0, -cage_y-1, z_bot-1]) cube([20, 2*cage_y+2, z_top - z_bot + 2]);
    // szczeliny M2 (+ opcjonalne pogłębienie pod łeb)
    m2_slots(th_screw_x, 0);
    infra_xf() m2_slots(ir_screw_x, ir_z);
    // szczeliny na przewody w mostkach (pełna długość → pętla otwarta, przewód wkłada się z boku)
    translate([cage_x0 - 1, -cable_slot_w/2, z_bot - 1]) cube([-cage_x0 + 2, cable_slot_w, bridge_t + 2]);
    translate([cage_x0 - 1, -cable_slot_w/2, z_top - bridge_t - 1]) cube([-cage_x0 + 2, cable_slot_w, bridge_t + 2]);
    // otwór M5 przegubu (łezka: w druku przodem w dół oś M5 jest pozioma)
    translate([cage_axis_x, -20, axis_z]) rotate([-90,0,0]) teardrop(gp_hole, 40);
  }
  // zderzaki tylne: 4 narożniki każdej kieszeni, środek wolny na wyjście przewodu.
  // Wchodzą 0.5 mm w ściankę i mostek (bez styków krawędziowych → manifold).
  for (s=[-1,1], t=[-1,1]) {
    translate([-th_body - clr - stop_d, s>0 ? th_w/2+clr-stop_w : -(th_w/2+clr)-0.5,
               t>0 ? th_h/2+clr-3 : -th_h/2-clr-0.5])
      cube([stop_d, stop_w + 0.5, 3.5]);
    infra_xf() translate([-ir_body - clr - stop_d, s>0 ? ir_w/2+clr-stop_w : -(ir_w/2+clr)-0.5,
               ir_z + (t>0 ? ir_h/2+clr-3 : -ir_h/2-clr)])
      cube([stop_d, stop_w + 0.5, 3.5]);
  }
}
module m2_slots(px, pz) {
  module slot(d, y0, h) hull() for (dx=[-slot_len/2, slot_len/2])
    translate([px+dx, y0, pz]) rotate([-90,0,0]) cylinder(d=d, h=h);
  slot(m2_d, -cage_y-1, 2*cage_y+2);
  if (m2_cbore > 0) { slot(4.5, cage_y - m2_cbore, m2_cbore + 1); slot(4.5, -cage_y - 1, m2_cbore + 1); }
}
module teardrop(d, h) {    // otwór z daszkiem 45° (w kierunku -x lokalnie = do góry w druku przodem w dół)
  cylinder(d=d, h=h);
  rotate([0,0,180]) linear_extrude(h) polygon([[0, d/2/sqrt(2)], [d/2*sqrt(2), 0], [0, -d/2/sqrt(2)]]);
}

// ---------------- ADAPTER NA WENTYLATOR ----------------
module adapter_fan() {
  fo = fan_size/2 + fan_wall;               // zewnętrzna połowa ramki
  fem_y = [-(gp_leg + gp_slit), 0, (gp_leg + gp_slit)];
  difference() {
    union() {
      // tuleja wokół obudowy wentylatora (w stronę skorupy gogli: x<0)
      translate([-fan_wall_depth, -fo, -fo]) cube([fan_wall_depth + fan_plate, 2*fo, 2*fo]);
      // nogi żeńskie (3) — podstawa na górnej części ramki
      for (yc = fem_y) hull() {
        translate([0, yc - gp_leg/2, fo - 6]) cube([fan_plate, gp_leg, 6]);
        translate([adapter_axis_x, yc - gp_leg/2, adapter_axis_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
      }
      // żebro usztywniające pod nogami
      hull() {
        translate([0, -(1.5*gp_leg + gp_slit), fo - 2]) cube([fan_plate, 3*gp_leg + 2*gp_slit, 2]);
        translate([adapter_axis_x - gp_od/2 + 1, -(1.5*gp_leg + gp_slit), adapter_axis_z + gp_od/2 - 3])
          cube([1, 3*gp_leg + 2*gp_slit, 1]);
      }
    }
    // kieszeń na wentylator (przelotowa, z uszami na śruby w narożnikach)
    difference() {
      translate([-fan_wall_depth - 1, -fan_size/2, -fan_size/2]) cube([fan_wall_depth + 1 + fan_plate + 1, fan_size, fan_size]);
      // uszy (płytka przednia) w 4 narożnikach — 2D w płaszczyźnie (y,z), wyciągnięte wzdłuż x
      rotate([90,0,90]) linear_extrude(fan_plate) for (sy=[-1,1], sz=[-1,1]) hull() {
        translate([sy*fan_hole/2, sz*fan_hole/2]) circle(d=5);
        translate([sy*fan_size/2, sz*fan_size/2]) square(2, center=true);
      }
    }
    // otwory M2 (śruby wentylatora, dłuższe o grubość płytki)
    for (sy=[-1,1], sz=[-1,1]) translate([-1, sy*fan_hole/2, sz*fan_hole/2]) rotate([0,90,0]) cylinder(d=m2_d, h=fan_plate+2);
    // szczeliny między nogami (żeby nogi były rozdzielone także w hull żebra)
    for (yc = [-(gp_leg/2 + gp_slit/2), (gp_leg/2 + gp_slit/2)])
      translate([fan_plate, yc - gp_slit/2, fo - 8]) cube([adapter_axis_x + gp_od, gp_slit, 40]);
    // M5 + pułapka na nakrętkę (strona +y)
    translate([adapter_axis_x, -20, adapter_axis_z]) rotate([-90,0,0]) cylinder(d=gp_hole, h=40);
    translate([adapter_axis_x, 1.5*gp_leg + gp_slit - gp_nut_h + 1.2, adapter_axis_z]) rotate([-90,0,0])
      rotate([0,0,30]) cylinder(d=gp_nut_af/cos(30), h=10, $fn=6);
  }
}

// ---------------- GHOST: kamery, gogle, pola widzenia ----------------
module ghost_cams() {
  color("dimgray") cam_thermal(0);
  color("gray") cam_infra(0);
}
module fov_thermal(len=60) {   // 50° H x 37.2° V
  color("orange", 0.15) hull() {
    translate([th_lens_len,0,0]) cube(0.1, center=true);
    translate([len, 0, 0]) cube([0.1, 2*len*tan(25), 2*len*tan(18.6)], center=true);
  }
}
module hdo2_ghost() {          // [A] gogle jako prostopadłościan 169.2 x 80 x 45.5, wentylator na środku przodu
  color("black", 0.25) translate([-45.5 - fan_wall_depth, -169.2/2, -40]) cube([45.5, 169.2, 80]);
  color("red", 0.3) translate([-fan_wall_depth, -12.5, -12.5]) cube([fan_wall_depth, 25, 25]);
}

module assembly() {
  hdo2_ghost();
  color("steelblue") adapter_fan();
  // klatka: oś przegubu klatki pokrywa się z osią adaptera, obrót o tilt w dół
  translate([adapter_axis_x, 0, adapter_axis_z]) rotate([0, tilt, 0])
    translate([-cage_axis_x, 0, -axis_z]) {
      color("gold") cage();
      ghost_cams();
      fov_thermal();
    }
}

// ---------------- orientacje do druku (PETG, MK4) ----------------
// klatka PRZODEM W DÓŁ (x=0 na stole): ścianki kieszeni pionowe i dokładne, nogi GoPro rosną jako płetwy
// bez podpór (przegląd print/fit-06). Brim 5 mm. Nogi: 4 obwody lub modyfikator 100% (przegląd print-legs-sparse-core).
module print_cage() { rotate([0,90,0]) cage(); }
// adapter na boku (oś M5 pionowo)
module print_adapter() { translate([0,0,fan_size/2+fan_wall]) rotate([-90,0,0]) adapter_fan(); }

if (part == "cage") cage();
else if (part == "adapter_fan") adapter_fan();
else if (part == "print_cage") print_cage();
else if (part == "print_adapter") print_adapter();
else assembly();
