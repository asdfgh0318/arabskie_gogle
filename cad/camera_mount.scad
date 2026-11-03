// arabskie_gogle — mocowanie kamer Caddx TR1-220SL na przód Fat Shark HDO2
// v0.4 (2026-11-03): + przegub GoPro do podstawki VHB na kasku (helm_*). v0.3 — WERSJA ROBOCZA po 2 przeglądach adwersarialnych + test kolizji (test/run_clash.sh). Wymiary kamer z rysunków sklepu BZB UAS,
// geometria HDO2 ze zdjęć/modeli społeczności (research/06) — NIC nie zmierzone na sprzęcie.
//
// Dwie części:
//   1) cage       — klatka: termo (dół, oś na wysokości oczu) + Infra (nad nią), z tyłu 2 palce GoPro (męskie)
//   2) adapter_top — płytka w miejscu usuniętego wentylatora NA GÓRZE HDO2 (śruby 20x20), ramię do przodu
//                    nad krawędź, 3 palce GoPro (żeńskie) tuż przed przednią ścianą
//   (Klatka NIE jest gwarantowanie zgodna z fabryczną klamrą GoPro: płetwa wskaźnika i belka kolidują z pokrętłem.)
// Pochylenie (0–20° w dół) = przegub GoPro na śrubie M5 (tarcie, dokręcać ręcznie), podziałka 0/10/20 + nacięcia 5/15.
// Odchylenie (yaw) ustalają 4 śruby wentylatora; korekty po zbieżeniu na celu 10 m: th_yaw_trim, ir_yaw_trim.
// Bezpiecznik: przewężenie w bloku adaptera (fuse_*) — przy uderzeniu pęka drukowana część, nie gniazdo śrub w goglach.
//
// Układ: x = do przodu (oś optyczna), y = w lewo, z = do góry.
// Klatka: początek = środek przedniej ściany korpusu kamery termo (oś optyczna termo).
// Adapter: początek = środek wzoru śrub wentylatora, z=0 = blat skorupy (gniazdo wentylatora).
//
// Użycie:  openscad -D 'part="cage"' -o cage.stl camera_mount.scad
//          part = "cage" | "adapter_top" | "assembly" | "print_cage" | "print_adapter" | "coupon"

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
ir_screw_x = -7.5;                  // [A] liczone od tylnej ściany (baza = zderzaki z tyłu): 7.9 mm przed tyłem (fit-06)
cam_gap = 1.5;                      // odstęp pionowy między korpusami
ir_yaw_trim = 0;                    // [deg] korekta odchylenia Infra względem termo (po zbieżeniu na celu 10 m)
th_yaw_trim = 0;                    // [deg] korekta odchylenia termo względem gogli (krok 0.25°, przedruk klatki)
ir_z = th_h/2 + cam_gap + ir_h/2;   // oś Infra nad osią termo (= 21.5)

// ---------- klatka ----------
clr = 0.2;          // luz na stronę wokół korpusu
side_t = 2.5;       // grubość ścianki bocznej (przy Infra; przy termo +0.5)
slot_len = 3.0;     // długość szczeliny M2 wzdłuż osi (kompensuje niepewność położenia otworu)
m2_cbore = 0;       // [mm] pogłębienie Ø4.5 pod łeb M2 od zewnątrz (ustawić po zmierzeniu śrub z zestawu)
stop_d = 1.0;       // głębokość zderzaków tylnych (baza kierunku kamery: docisnąć kamerę do tyłu, potem M2)
stop_w = 1.2;       // jak daleko zderzak wchodzi od ścianki (≤3 szerokości ścieżki → mały nawis w druku)
cable_slot_w = 4.0; // [A] szczelina w mostkach na przewód kamery (oplot ~3 mm wg zdjęcia) — kamera z przewodem wkładana bez nawlekania
m2_d = 2.3;
bridge_t = 2.0;     // mostki górny/dolny
cage_y = ir_w/2 + clr + side_t;           // zewnętrzna połowa szerokości (12.95)
cage_x0 = -(ir_body + 1.0);               // tył ścianek bocznych
z_bot = -th_h/2 - clr - bridge_t;
z_top = ir_z + ir_h/2 + clr + bridge_t;

// ---------- GoPro (biblioteka ridercz/GoProScad: noga 3.0, szczelina 3.5, Ø15, M5) ----------
gp_leg = 3.0;  gp_slit = 3.3;  gp_od = 15;  gp_hole = 5.5;   // slit = szczelina męska i żeńska (para własna); wybrać z próbki part="coupon"
gp_nut_af = 8.2; gp_nut_h = 4.2;          // M5 nakrętka sześciokątna (pułapka)
bar_t = 4.5;                               // tylna belka klatki (przegląd mech-5: 3.0 za słaba na skręcanie)
bar_z0 = 5.6;  bar_z1 = 15.6;              // [A] belka między kamerami: kable termo idą pod nią, Infra nad nią
axis_z = (bar_z0 + bar_z1)/2;              // oś przegubu względem osi termo (10.6)
axis_back = 9.0;                           // odległość osi przegubu za belką
cage_bar_x0 = cage_x0 - bar_t;
cage_axis_x = cage_bar_x0 - axis_back;     // oś przegubu we współrz. klatki

// ---------- gniazdo wentylatora HDO2 — NA GÓRZE gogli (research/06, wentylator usunięty) ----------
// Układ adaptera: początek = środek wzoru śrub wentylatora na płaszczyźnie gniazda (z=0 = blat skorupy),
// x = do przodu, z = do góry. [A] = oszacowanie ze zdjęć/modeli społeczności, do zmierzenia (research/06 §3).
seat = 25.0;              // płytka 25x25 = obrys wentylatora (A4); z tyłu przylega do ramki twarzy (A5)
fan_hole = 20;            // rozstaw śrub 20x20 (A1, pewne)
plate_t = 3.0;            // płytka zamyka otwór Ø23–24 → szczelna na światło (A6)
post_relief = 0;          // [A] (A7) kieszenie Ø4 x post_relief od spodu na ewentualne słupki pod śrubami (0 = brak)
screw_cb_d = 4.2;         // pogłębienie pod łeb śruby wentylatora (łeb ≈3 mm, A2)
screw_cb_h = 1.8;         // pod łbem zostaje 1.2 mm = kołnierz fabrycznej osłony → fabryczne śruby (fit-02); sprawdzić M1/M2
front_x = 23.1;           // [A] środek wentylatora → przednia ściana gogli (A10, ±1.5)
front_tol = 1.5;          // niepewność front_x: wycięcie pod blatem sięga front_x + front_tol + 0.5
seat_above_eye = 23;      // [A] blat nad osią okularów (C3: 19–29!) — KLUCZOWY POMIAR M5
axis_rel_seat = 0;        // wysokość osi przegubu nad blatem; 0 → termo ≈ +12.4 mm nad oczami przy tilt=0
adapter_axis_x = front_x + gp_od/2 + 3.0;  // oś przegubu przed przednią ścianą, 3 mm luzu tarcz (front_x ±1.5)
seat_pitch = 0;           // [A] pochylenie blatu względem osi okularów, przód w dół = + (M4); 0 dopóki nie zmierzone
deck_relief = 0.5;        // spód bloku przed płytką podniesiony → jedyną bazą jest gniazdo 25x25 (mech-8)
fuse_x = 14.0;            // bezpiecznik: przewężenie bloku (rdzeń fuse_core x root_h), rowki V 45° z boków
fuse_core = 10.0;         // ≈2.6 N·m na zginanie przy 25 MPa międzywarstwowo (> poślizg przegubu ≈1.3 N·m)
adapter_axis_z = axis_rel_seat;
fem_y = [-(gp_leg + gp_slit), 0, (gp_leg + gp_slit)];
fem_out = 1.5*gp_leg + gp_slit;            // zewnętrzna ściana nóg żeńskich (7.8)
boss_len = 5.0;                            // występ na nakrętkę M5 po stronie +y (przegląd mech-3)
boss_x0 = fuse_x + (fem_out - fuse_core/2) + boss_len + 0.5;  // występ zaczyna się przed bezpiecznikiem (nie mostkuje go)
root_x1 = adapter_axis_x - gp_od/2 - 0.8;  // przód pełnego bloku (za tarczami męskimi)
root_h = adapter_axis_z + gp_od/2 + 1.0;   // wysokość bloku nad blatem
// ---------- przegub do kasku (decyzja 2026-11-03: gogle wiszą na podstawce GoPro VHB z przodu kasku) ----------
// 2 nogi męskie (jak na kamerze GoPro) → wchodzą w klamrę 3-palcową na podstawce VHB kasku; oś M5 poprzeczna (y),
// więc gogle obracają się w pionie (dopasowanie kąta, podniesienie gogli do góry). Obciążenie z kasku idzie
// blokiem i płytką na 4 śruby wentylatora — NIE przez bezpiecznik kamery (fuse_x leży przed nim).
helm_on = true;
helm_x = -seat/2 + gp_od/2;                // oś nad płytką; tylna krawędź nóg = tył płytki (= stół przy druku)
helm_z = root_h + gp_od/2 + 2.0;           // oś nad blatem: 2 mm luzu między klamrą a blokiem [A] → pomiar H1/H2
helm_y = [-(gp_slit/2 + gp_leg/2), gp_slit/2 + gp_leg/2];

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
module infra_xf() {   // korekta yaw Infra wokół osi pionowej przez środek przedniej ściany
  translate([0,0,ir_z]) rotate([0,0,ir_yaw_trim]) translate([0,0,-ir_z]) children();
}
module th_xf() { rotate([0,0,th_yaw_trim]) children(); }
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
        translate([bx1 + 0.5, yc - gp_leg/2, bar_z0 - 2]) cube([0.01, gp_leg, bar_z1 - bar_z0 + 4]);  // nasada 14 mm (print-leg)
        translate([cage_axis_x, yc - gp_leg/2, axis_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
      }
      // wskaźnik pochylenia: płetwa przy zewnętrznej nodze żeńskiej (-y), czytana na podziałce adaptera
      hull() {
        translate([bx1 + 0.5, -cage_y, axis_z - 1]) cube([0.01, cage_y - (1.5*gp_leg + gp_slit) - 0.3, 2]);
        translate([cage_axis_x + 7.7, -(1.5*gp_leg + gp_slit) - 1.3, axis_z - 0.3]) cube([0.5, 1.0, 0.6]);  // grot za obrzeżem tarczy
      }
    }
    // kieszenie na kamery (wsuwane od przodu)
    th_xf() cam_thermal(clr);
    infra_xf() cam_infra(clr);
    // belka cofnięta 0.5 mm między zderzakami Infra → kamera opiera się tylko na narożnikach (nie na mostku belki)
    infra_xf() translate([-ir_body - 0.5, -(ir_w/2 + clr - stop_w), bar_z0 - 1]) cube([0.5 + eps, ir_w + 2*clr - 2*stop_w, bar_z1 - bar_z0 + 2]);
    // przedłużenie kieszeni do przodu (żeby nic nie wystawało przed korpusy)
    translate([0, -cage_y-1, z_bot-1]) cube([20, 2*cage_y+2, z_top - z_bot + 2]);
    // szczeliny M2 (+ opcjonalne pogłębienie pod łeb)
    th_xf() m2_slots(th_screw_x, 0);
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
    th_xf() translate([-th_body - clr - stop_d, s>0 ? th_w/2+clr-stop_w : -(th_w/2+clr)-0.5,
               t>0 ? th_h/2+clr-3 : -th_h/2-clr-0.5])
      cube([stop_d, stop_w + 0.5, 3.5]);
    // zderzaki Infra w jednej płaszczyźnie z przodem belki (x = -ir_body)
    infra_xf() translate([-ir_body - stop_d, s>0 ? ir_w/2+clr-stop_w : -(ir_w/2+clr)-0.5,
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
  r = d/2;
  rotate([0,0,180]) linear_extrude(h) polygon([[0,0], [r/sqrt(2), r/sqrt(2)], [r*sqrt(2), 0], [r/sqrt(2), -r/sqrt(2)]]);
}

// ---------------- ADAPTER NA GNIEŹDZIE WENTYLATORA (góra gogli) ----------------
module adapter_top() {
  difference() {
    union() {
      // płytka 25x25 na 4 śrubach wentylatora, pełna (zamyka otwór)
      translate([-seat/2, -seat/2, 0]) cube([seat, seat, plate_t]);
      // pełny blok-nasada od tyłu płytki do przegubu (przegląd mech-1: żadnej cienkiej szyjki)
      rbox([-seat/2, -fem_out, 0], [root_x1, fem_out, root_h], r=1.5);
      // nogi żeńskie (3)
      for (yc = fem_y) hull() {
        translate([root_x1 - 6, yc - gp_leg/2, 0]) cube([6, gp_leg, root_h]);
        translate([adapter_axis_x, yc - gp_leg/2, adapter_axis_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
      }
      // nogi męskie do kasku
      if (helm_on) for (yc = helm_y) hull() {
        translate([-seat/2, yc - gp_leg/2, root_h - 2]) cube([gp_od, gp_leg, 2]);
        translate([helm_x, yc - gp_leg/2, helm_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
      }
      // występ na nakrętkę M5 (+y), zrośnięty z blokiem
      hull() {
        translate([adapter_axis_x, fem_out - 0.01, adapter_axis_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=boss_len);
        translate([boss_x0, fem_out - 0.01, 0]) cube([root_x1 - boss_x0, boss_len, root_h]);
        translate([boss_x0 - boss_len, fem_out - 0.01, 0]) cube([0.01, 0.01, root_h]);   // spód występu 45° (druk bez podpór)
      }
    }
    // otwory na śruby wentylatora + pogłębienia pod łby
    for (sx=[-1,1], sy=[-1,1]) translate([sx*fan_hole/2, sy*fan_hole/2, -1]) {
      cylinder(d=m2_d, h=root_h + 2);
      translate([0,0,1 + plate_t - screw_cb_h]) cylinder(d=screw_cb_d, h=root_h + 2);
      if (post_relief > 0) cylinder(d=4.0, h=1 + post_relief);
    }
    // otwór M5 (łezka: w druku tyłem w dół oś M5 jest pozioma, daszek do góry = +x)
    translate([adapter_axis_x, -20, adapter_axis_z]) rotate([-90,0,0]) rotate([0,0,180]) teardrop(gp_hole, 40);
    // otwór M5 przegubu do kasku (łezka, daszek do +x = do góry w druku)
    if (helm_on) translate([helm_x, -20, helm_z]) rotate([-90,0,0]) rotate([0,0,180]) teardrop(gp_hole, 40);
    // pułapka na nakrętkę M5 w występie: dno 0.6 mm → nakrętka dociska nogę żeńską, nie męską
    translate([adapter_axis_x, fem_out + 0.6, adapter_axis_z]) rotate([-90,0,0])
      cylinder(d=gp_nut_af/cos(30), h=boss_len + 1, $fn=6);      // wierzchołek do +x = do góry w druku
    // podziałka na ścianie -y: kreski 0/10/20° (0.6x0.6, r 6.2–7.5) + nacięcia obrzeża 5/15°; zero = oś okularów
    for (t=[0:5:20]) translate([adapter_axis_x, -fem_out - 0.01, adapter_axis_z]) rotate([0, t - seat_pitch, 0])
      translate([t % 10 == 0 ? 6.2 : 7.0, -0.01, -0.3]) cube([t % 10 == 0 ? 1.4 : 0.6, 0.62, 0.6]);
    // nic poniżej blatu za przednią ścianą (+ niepewność + 0.5 luzu): blat i krawędź gogli wolne (fit-01 / optics-ghost-clash)
    translate([-seat/2 - 1, -30, -30]) cube([seat/2 + 1 + front_x + front_tol + 0.5, 60, 30]);
    // odciążenie spodu bloku przed płytką → jedyną bazą jest gniazdo 25x25
    translate([seat/2, -30, -1]) cube([front_x + 0.5 - seat/2, 60, 1 + deck_relief]);
    // bezpiecznik: rowki V 45° z obu boków bloku → rdzeń fuse_core (y) x root_h (z) w płaszczyźnie warstwy
    for (s=[-1,1]) translate([0,0,-1]) linear_extrude(root_h + 2) polygon([
      [fuse_x - (fem_out - fuse_core/2) - 0.02, s*(fem_out + 0.02)],
      [fuse_x + (fem_out - fuse_core/2) + 0.02, s*(fem_out + 0.02)],
      [fuse_x, s*fuse_core/2]]);
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
module hdo2_ghost() {          // [A] gogle jako bryła: przód na x=front_x, blat na z=0, oś okularów na z=-seat_above_eye
  color("black", 0.25) translate([front_x - 80, -169.2/2, -45.5]) cube([80, 169.2, 45.5]);
  color("red", 0.6) for (s=[-1,1]) translate([front_x - 30, s*30, -seat_above_eye]) rotate([0,90,0]) cylinder(d=6, h=30.2);
}

// wysokość środka przedniej soczewki termo / Infra nad osią okularów dla danego pochylenia
function lens_z(t, xl, zl) = seat_above_eye
   + (-adapter_axis_x * sin(seat_pitch) + adapter_axis_z * cos(seat_pitch))
   + (-(xl - cage_axis_x) * sin(t + seat_pitch) + (zl - axis_z) * cos(t + seat_pitch));
for (t=[0,10,20]) echo(str("tilt ", t, "°: termo ", lens_z(t, th_lens_len, 0), " mm, Infra ",
   lens_z(t, ir_lens_len, ir_z), " mm nad osią okularów (cel 0…+35)"));
module assembly() {
  hdo2_ghost();
  rotate([0, seat_pitch, 0]) {
    color("steelblue") adapter_top();
    // klatka: oś przegubu klatki pokrywa się z osią adaptera, obrót o tilt w dół
    translate([adapter_axis_x, 0, adapter_axis_z]) rotate([0, tilt, 0])
      translate([-cage_axis_x, 0, -axis_z]) {
        color("gold") cage();
        ghost_cams();
        fov_thermal();
      }
  }
}

// ---------------- PRÓBKA dopasowania przegubu (drukować najpierw, research/06 M8) ----------------
// 3 pary (żeńska 3 nogi + męska 2 nogi) ze szczeliną 3.2 / 3.3 / 3.4 (wybita na podstawie).
// Druk jak części: nogi pionowo, oś M5 pozioma, 4 obwody. Wybierz parę, która składa się ręką bez luzu → gp_slit.
coupon_ax = 9.5;
module coupon_leg_set(ys, base_w) {
  translate([-9, -base_w/2, 0]) cube([18, base_w, 2]);
  for (yc = ys) hull() {
    translate([-6, yc - gp_leg/2, 0]) cube([12, gp_leg, 2]);
    translate([0, yc - gp_leg/2, coupon_ax]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
  }
}
module coupon() {
  slits = [3.2, 3.3, 3.4];
  for (i=[0:len(slits)-1]) translate([i*22, 0, 0]) {
    g = slits[i];
    difference() {   // żeńska
      coupon_leg_set([-(gp_leg+g), 0, gp_leg+g], 3*gp_leg + 2*g + 2);
      translate([0, -20, coupon_ax]) rotate([-90,0,0]) rotate([0,0,90]) teardrop(gp_hole, 40);
      translate([7.6, 0, 1.5]) linear_extrude(1) rotate([0,0,90]) text(str(g), size=2.2, halign="center", valign="center");
    }
    translate([0, 22, 0]) difference() {   // męska
      coupon_leg_set([-(g/2 + gp_leg/2), g/2 + gp_leg/2], 2*gp_leg + g + 2);
      translate([0, -20, coupon_ax]) rotate([-90,0,0]) rotate([0,0,90]) teardrop(gp_hole, 40);
      translate([7.6, 0, 1.5]) linear_extrude(1) rotate([0,0,90]) text(str(g), size=2.2, halign="center", valign="center");
    }
  }
}

// ---------------- orientacje do druku (PETG, MK4) ----------------
// klatka PRZODEM W DÓŁ (x=0 na stole): ścianki kieszeni pionowe i dokładne, nogi GoPro rosną jako płetwy
// bez podpór (przegląd print/fit-06). BEZ brimu (brim zalałby kieszenie i szczeliny). 4 obwody.
module print_cage() { rotate([0,90,0]) cage(); }
// adapter TYŁEM W DÓŁ (tylna krawędź płytki x=-seat/2 na stole): nogi rosną do góry jako płetwy, podziałka na
// pionowej ścianie, bez podpór. Brim 5 mm (wysoka, wąska część; brim tylko zewnętrzny). 4 obwody.
module print_adapter() { translate([0,0,seat/2]) rotate([0,-90,0]) adapter_top(); }

if (part == "cage") cage();
else if (part == "adapter_top") adapter_top();
else if (part == "print_cage") print_cage();
else if (part == "print_adapter") print_adapter();
else if (part == "coupon") coupon();
else if (part == "none") { }   // do użycia przez include (testy kolizji)
else assembly();
