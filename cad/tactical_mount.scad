// arabskie_gogle — mocowanie kamer v0.5 „PANCERZ+” (wersja taktyczna) na przód Fat Shark HDO2
// WERSJA ROBOCZA (2026-11-04, po przeglądzie R1). Źródło: cad/spec/v05_tactical_spec.md — gdzie ten plik różni się
// od specyfikacji, odstępstwo jest opisane w komentarzu przy parametrze (szukaj „ODSTĘPSTWO”; poprawki z przeglądu:
// „PRZEGLĄD”). Parametry przeniesione bez zmian z camera_mount.scad (v0.4, zostaje jako wersja zapasowa) mają te same
// nazwy i wartości. Kamery: rysunki sklepu BZB UAS; HDO2: zdjęcia i modele społeczności (research/06).
// NIC nie zmierzone na sprzęcie.
//
// Trzy części nośne + dwa akcesoria (PETG, MK4, bez podpór):
//   base  — płytka na 4 śrubach wentylatora + blok widełek (clevis) + nogi GoPro do kasku; jedyna część przykręcona do gogli
//   fork  — język w bloku (stalowy kołek M3 + bezpiecznik PA66 M2.5) + czoło + 2 ramiona z czopem i 2 popychaczami yaw
//   cage  — klatka-skorupa ładowana od tyłu: termo (dół) + Infra (nad nią), osłona termo i tuba Infra z przodu
//   cover — tylna pokrywa (słupki dociskowe do obu kamer), knob — gałka czopu po lewej (+y)
// Kierunek (yaw) trzymają kształtem DWA POPYCHACZE (M3 w ramionach) oparte o przednią ścianę gogli + stalowy kołek
// (ogranicznik +x). Luz otworów śrub wentylatora (±0,6–1,6°) nie jest już w łańcuchu yaw.
// Pochylenie 0–20° (nominalnie 10°): czop na tarcie, gałka po lewej, stała śruba M3 po prawej, podziałka na ściance −y.
// Kolejność zniszczenia (§2.3 specyfikacji, wyliczone, nie zmierzone): poślizg czopu → bezpiecznik PA66 → nasady ramion;
// po ścięciu PA66 FORK obraca się na stalowym kołku (ogon języka to łuk wokół kołka, test „hinge”).
//
// Układ gogli: x = do przodu, y = w lewo (strona noszącego), z = do góry; początek = środek wentylatora, z=0 = blat.
// Układ klatki: te same osie; początek = środek przedniej ściany korpusu termo (oś optyczna termo).
//
// Użycie:  openscad -D 'part="print_cage"' -o tac_print_cage.stl tactical_mount.scad
//   part = "assembly" | "base" | "fork" | "cage" | "cover" | "knob" | "print_base" | "print_fork" | "print_cage"
//        | "print_acc" | "coupon" | "coupon_joint" | "none" (do include w testach)

part = "assembly";
tilt = 10;              // [deg] pochylenie klatki w dół (podgląd assembly i testy); + = przód w dół

$fn = 64;
eps = 0.01;

// ======================================================================
// KAMERY (jak v0.4; [A] = odczyt z rysunku, do zmierzenia)
th_w = 19.5;  th_h = 19.5;          // termo: przód 19.5 x 19.5
th_body = 12.7;                     // [A] głębokość korpusu bez obiektywu
th_lens_len = 7.3;  th_lens_d = 16; // [A]
th_screw_x = -5.2;                  // [A] otwór M2 w boku korpusu termo (za przednią ścianą)
// PRZEGLĄD (fit-ir-seat): rysunek Infra ma wysokość 20, nie 20.5 (szerokość 20.5 zostaje). Przód korpusu Infra to
// szyjka ≈16.9 z fazowanymi narożami, pełny przekrój tylko z tyłu → oparcie na ramce do sprawdzenia (S4).
ir_w = 20.5;  ir_h = 20.0;          // Infra
ir_body = 15.4;                     // [A]
ir_lens_len = 19.1; ir_lens_d = 19; // [A]
ir_screw_x = -7.5;                  // [A] otwór M2 Infra względem przedniej ściany korpusu Infra
cam_gap = 1.5;
ir_z = th_h/2 + cam_gap + ir_h/2;   // oś Infra nad osią termo (21.25)
ir_yaw_trim = 0;                    // [deg] korekta Infra względem termo (przedruk klatki). th_yaw_trim USUNIĘTY (yaw = popychacze)
clr = 0.2;                          // luz na stronę wokół korpusów
slot_len = 3.0;                     // szczeliny M2 wzdłuż osi
m2_d = 2.3;
m2_cbore = 0;                       // (jak v0.4; tu nieużywane — łby M2 mieszczą się między klatką a ramionami)
th_fov = [50, 37.2];                // [deg] termo H x V (sklep)
ir_fov_a = [96, 72];                // [deg] Infra: najgorszy przypadek f-θ dla 120° po przekątnej (research/02)
ir_fov_b = [108, 92];               // [deg] Infra: najgorszy przypadek prostoliniowy 120° przekątnej przy 4:3 (§0 spec.)
cam_mass = [10, 15];                // [g] [A] termo, Infra — tylko do ECHO środka ciężkości
// przewody kamer (PRZEGLĄD fit-cover-cable / fit-ir-cable): oba przewody są na stałe w kamerach (oplot do kamery
// i do AI Boxa), wychodzą prosto do tyłu przez bucik. [A] ze zdjęcia zestawu → zmierzyć (S4/S5)
cab_d = 3.0;                        // [A] oplot Ø2–3
boot_l = 3.5;                       // [A] bucik + odcinek prosty przed zgięciem

// ======================================================================
// GNIAZDO WENTYLATORA HDO2 (jak v0.4)
seat = 25.0;  fan_hole = 20;  plate_t = 3.0;
post_relief = 0;                    // [A] (A7) kieszenie Ø4 od spodu pod ewentualne słupki (0 = brak)
screw_cb_d = 4.2;  screw_cb_h = 1.8;// pogłębienie pod łeb fabrycznej śruby, pod łbem zostaje 1.2 mm
front_x = 23.1;                     // [A] środek wentylatora → przednia ściana gogli (±1.5)
front_tol = 1.5;
seat_above_eye = 23;                // [A] blat nad osią okularów (19–29!) — KLUCZOWY POMIAR M5 / S1
seat_pitch = 0;                     // [A] pochylenie blatu (M4)
// ODSTĘPSTWO (PRZEGLĄD optics-03): nic poniżej z=0.5 za płaszczyzną front_x + front_tol + 1.0 (= tył występu
// popychacza, 25.6; spec. 25.1). Przy 0.5 mm ramię dotykało ściany już przy yaw 1.53° (front_x 24.6); teraz ±2°.
keep_x = front_x + front_tol + 1.0;

// nogi GoPro do kasku (geometria v0.4 bez zmian)
gp_leg = 3.0;  gp_slit = 3.3;  gp_od = 15;  gp_hole = 5.5;   // gp_slit z próbki part="coupon"
helm_on = true;
helm_x = -seat/2 + gp_od/2;         // −5
helm_z = 18;                        // [A] → pomiar H1/H2 (S7)
helm_y = [-(gp_slit/2 + gp_leg/2), gp_slit/2 + gp_leg/2];   // ±3.15

// ======================================================================
// BASE: blok widełek (M1)
// ODSTĘPSTWO (PRZEGLĄD mech-5): blk_y 8 → 9.5 (policzki 6.3 mm, wskaźnik zginania ×1.7), żeby BASE nie pękła przed
// ramionami przy uderzeniu z boku.
blk_x1 = 18.0;  blk_y = 9.5;  blk_h = 12.0;
// PRZEGLĄD (fit-helmet-buckle): fazka 45° tylnej górnej krawędzi bloku (0,9)→(3,12): luz tarczy klamry GoPro na
// kasku 0.72 → 2.4 mm, łeb śruby klamry Ø16 też się mieści
blk_ch = 3.0;
slot_x0 = 3.0;  slot_y = 3.2;       // gniazdo języka: otwarte z przodu i od góry
j_z = 7.0;  pin_x = 7.0;  fuse_bx = 16.0;
pin_hole_b = 3.2;                   // stalowy kołek M3 (łezka)
// PRZEGLĄD (fit-front-fanscrew): łeb kołka (M3×16 ISO 7380) w pogłębieniu Ø6.2 × 2.5 po +y — inaczej wchodzi w studzienkę
// Ø5 nad przednią śrubą wentylatora (+y) i blokuje śrubokręt
pin_cb_d = 6.2;  pin_cb_h = 2.5;
fuse_d = 2.5;                       // bezpiecznik PA66: 2.5 (domyślnie) albo 2.0 (S3: gdy śruby gogli słabe)
fuse_hole = fuse_d + 0.2;           // 2.7 dla M2.5
// ODSTĘPSTWO: spec. M1 podaje dla M3 „8.2 across corners” (to rozmiar M5); nakrętka M3 ma 5.5 na płaskich →
// kieszeń 5.7 na płaskich (6.6 po narożach), inaczej nakrętka się obraca. M2.5: 5.0 na płaskich + 0.2 luzu.
// PRZEGLĄD: kieszeń M3 3.0 głęboko (było 2.6), żeby M3×16 z łbem w pogłębieniu przeszła przez całą nakrętkę.
pin_nut_af = 5.7;   pin_nut_h = 3.0;
fuse_nut_af = (fuse_d == 2.5) ? 5.2 : 4.2;   fuse_nut_h = 2.2;
pin_len = 16;  fuse_len = 20;       // M3×16 ISO 7380; PA66 M2.5×20 z łbem walcowym (DIN 84 / ISO 1207) — blok ma 19 mm
well_d = 5.0;                       // studzienki nad przednimi śrubami wentylatora (dostęp z założonym FORK)
// PRZEGLĄD (print-06, fit-helmet-buckle): otwór linki niżej (z 7.5, pod fazką), Ø1.6 → ścianki 0.7 dla dyneemy 1 mm
tether_b = [1.5, 7.5];  tether_d = 1.6;

// ======================================================================
// UKŁAD KLATKI (M6, układ klatki)
side_t = 2.0;                       // ścianka boczna (v0.4: 2.5)
bridge_t = 2.0;
cage_y = ir_w/2 + clr + side_t;     // 12.45
bay_y = cage_y - side_t;            // 10.45 — wnęka kablowa / kieszeń Infra
ir_setback = 6.0;                   // Infra cofnięta: przód korpusu na x = −6
ir_x0 = -ir_setback;
ir_glass = ir_x0 + ir_lens_len;     // 13.1 — szkło Infra
face_x = ir_glass - 0.5;            // 12.6 — wspólna płaszczyzna czoła (osłona, tuba) = stół w druku klatki
// ODSTĘPSTWO (PRZEGLĄD fit-ir-cable): wnęka za Infra 2.5 → 6.0 (bucik + zgięcie oplotu; 2.5 minus 2 mm EVA zostawiało
// 0.5). Klatka wydłużona do tyłu o 3.5, ALE czop zostaje w tym samym miejscu (piv_x stałe), a dolny tylny narożnik
// też: fazka tył-dół 5 → 8.5 mm kończy się na dnie w tym samym punkcie (x −20.4) → kąt styku przy obrocie nos w dół
// bez zmian, a nowy tył klatki jest bliżej osi czopu niż ściana gogli (r 10.6 < 11.5).
bay = 6.0;  cover_t = 1.5;
cage_x1 = ir_x0 - ir_body - bay - cover_t;   // −28.9 — tył klatki (= zewnętrzna ściana pokrywy)
z_bot = -th_h/2 - clr - bridge_t;   // −11.95
z_top = ir_z + ir_h/2 + clr + bridge_t;      // 33.45
piv_x = -18.9;                      // oś czopu w układzie klatki (jak przed przeglądem, nie zależy od bay)
piv_z = 0;
ch_rb = (piv_x - 1.5) - cage_x1;    // 8.5 — fazka 45° tył-dół: dno kończy się na x = piv_x − 1.5 (jak w wersji 5 mm)
x_th = 1.5;                         // przód bloku na poziomie termo (ramka 0…1.5)
x_ir = ir_x0 + 1.5;                 // −4.5 — przód bloku na poziomie Infra (ramka pierścieniowa)
z_mid = 11.9;                       // granica poziomów termo / Infra w bloku
s_th = 8.0;  s_ir = 6.8;            // długość przejść 45° blok → szyjka termo / tuba Infra (fazy zamiast półek)
// osłona termo i tuba Infra (M7)
hood_m = 0.5;                       // margines osłona ↔ strefa widzenia termo (kontrola pozytywna: −0.5 → kolizja)
hood_t = 1.6;  tube_t = 1.6;
th_ap = th_lens_d/2;                // NAJGORSZY PRZYPADEK: apertura = cała soczewka Ø16
neck_r = th_lens_d/2 + 0.3 + hood_t;// 9.9 — szyjka wokół otworu Ø16.6
tube_r = ir_lens_d/2 + 0.3 + tube_t;// 11.4 — tuba Infra OD 22.8
// PRZEGLĄD (optics-04): koniec tuby liczony od szkła Infra i obracany razem z Infra (ir_yaw_trim); przycięty do
// płaszczyzny czoła face_x (stół w druku). Kontrola pozytywna w teście: ir_tube_back = −0.5 → trafienie w pole Infra.
ir_tube_back = 0.5;
// PRZEGLĄD (print-01): odpływ w dnie osłony kończy się 0.6 przed czołem → pierwsze 3 warstwy osłony to zamknięty
// pierścień (brim zewnętrzny nie wchodzi do środka osłony)
drain_sill = 0.6;
// bossy czopu
boss_d = 9;  boss_out = 2.0;  boss_in_y = 10.15;   // do środka tylko do |y| 10.15 → termo wchodzi od tyłu
ins_l_d = 5.6;  ins_r_d = 4.0;      // otwory na wkładki: +y M4 krótka, −y M3 krótka
// ODSTĘPSTWO: spec. M5 podaje otwór M4 Ø5.6 × 5.0, ale boss ma 4.3 mm (14.45 → 10.15) — otwór przebiłby ściankę.
// Oba otwory 4.0 głęboko; wkładka M4 krótka 4 mm (np. CNC Kitchen M4×4), M3 krótka 3 mm.
// PRZEGLĄD (print-02, fit-trunnion-bolts): za wkładką otwór przelotowy Ø4.4 / Ø3.4 przez ostatnie 0.3 mm — półka 0.6
// zatrzymuje wkładkę, wyparty plastik wychodzi do wnęki (obciąć), śruba nie może dobić do dna.
ins_depth = 4.0;
ins_l_thru = 4.4;  ins_r_thru = 3.4;
// tylna pokrywa (M8)
// ODSTĘPSTWO (PRZEGLĄD print-08): pokrywa ±11.4 (spec. 11.85) + luz 0.15 we wpuście → krawędzie klatki 0.9 (2 ściegi)
cov_y = 11.4;
cov_clr = 0.15;
cov_lip = 0.9;                      // krawędź wpustu u góry
cov_foot = 1.05;                    // krawędź wpustu pod stopką pokrywy przy fazce (narożnik styku z goglami)
post_yz = 7.75;  post_s = 2.4;
post_x1 = -th_body - 0.3;           // słupki termo kończą się 0.3 przed tyłem termo (−13.0)
post_x1_ir = ir_x0 - ir_body - 0.3; // PRZEGLĄD: słupki Infra (zamiast EVA) kończą się 0.3 przed tyłem Infra (−21.7)
tab_y = [7.3, 10.3];  tab_z = [5.0, 9.8];   // zaczepy na śruby M2×5 (połączone z górnymi słupkami termo)
cov_scr = [-17.0, 7.4];             // [x, z] śrub pokrywy w ściankach bocznych
// PRZEGLĄD (fit-cover-cable, fit-cable-exit): wyjście przewodów to wycięcie w ściance −y z tyłu u góry (poziom Infra),
// otwarte do tylnej krawędzi klatki: przewody kładzie się z boku, pokrywa zamyka je od tyłu. Przy tilt 0 leży nad
// ramieniem, daleko od narożnika styku z goglami (fazka tył-dół).
cab_x = [cage_x1 - 1, ir_x0 - ir_body - 0.5];   // −29.9 … −21.9
cab_z = [19.0, 26.0];
// linka: zewnętrzne ucho na górze klatki z tyłu (PRZEGLĄD fit-tether-knot: węzeł nie mieści się we wnęce)
lug_x0 = cage_x1 + 2.5;  lug_w = 5.0;  lug_h = 3.6;  lug_y = 2.5;
lug_hole = [lug_x0 + 2.5, z_top + 1.6];

// ======================================================================
// POŁOŻENIE KLATKI W GOGLACH (§2.1)
X0 = 55.0;                          // przód korpusu termo (x gogli) przy tilt 0
piv_rel_seat = -11.0;               // oś czopu względem blatu = 12 (nad okiem) − 23 (seat_above_eye) → S1: tylko FORK
PX = X0 + piv_x;                    // 36.1
PZ = piv_rel_seat;

// FORK (M2–M4)
tg_y = 2.8;  tg_x0 = 3.3;  tg_z0 = 3.3;      // język: ±0.4 luzu → ±2° yaw wokół kołka
// PRZEGLĄD (mech-1, fit-fuse-hinge): ogon języka to łuk R3.7 wokół kołka; tylna górna ćwiartka zdjęta fazką 45°.
// Prostopadłościenny język po ścięciu PA66 klinował się w gnieździe po 3.6° (test „hinge”, kontrola pozytywna
// tg_tail = false); teraz FORK obraca się na kołku do ≈50°.
tg_tail = true;
tg_tail_r = min(pin_x - slot_x0, j_z - plate_t) - 0.3;   // 3.7
// PRZEGLĄD (optics-02, fit-tongue-roll): otwór kołka w języku owalny 3.3 (x) × 3.1 (z) — luz w x (yaw, +x stop) zostaje,
// przechył (roll) wokół x ograniczony do ≈±1.2° (było ±2–3° na luzach śrub)
pin_hole_f = 3.3;  pin_hole_fz = 3.1;  fuse_slot_x = [15.7, 16.3];
// ODSTĘPSTWO (PRZEGLĄD fit-fuse-head): czoło od x 19.0 (spec. 18.5) — łeb walcowy PA66 (dk 4.5) ma 0.75 luzu przy
// yaw 0 i nie dotyka czoła w całym zakresie ±2°
brow_x0 = 19.0;  brow_z0 = 5.0;  brow_z1 = 12.0;
brow_x1 = X0 + cage_x1 - 1.0;       // 25.1 — 1 mm za tyłem klatki → ogranicznik „nos do góry” ≈ −2.5°
// ODSTĘPSTWO: kieszenie pod czołem do |y| 11.6 (spec. 13.0) — inaczej zaokrąglenie R3 wisi nad kieszenią w druku
brow_pk = [brow_x0 + 1.6, brow_x1 - 1.6, 4.5, 11.6, 10.4];     // x0, x1, |y|0, |y|1, z1
arm_t = 4.0;  arm_gap = 0.3;
arm_in = cage_y + boss_out + arm_gap;        // 14.75
arm_out = arm_in + arm_t;                    // 18.75
eye_d = 12;
piv_hole_l = 4.4;  piv_hole_r = 3.4;         // +y M4 (gałka), −y M3 (stała)
// PRZEGLĄD (optics-07): grot wskaźnika do r 8.4 (bok 45.6° od poziomu — granica bez podpór 8.49), kreski od r 8.6
ptr_r = 8.4;                                 // grot wskaźnika pochylenia na ramieniu −y
// popychacze yaw (M4)
pad_x0 = front_x + front_tol + 1.0;          // 25.6
pad_len = 6;  pad_y = arm_in + 3.0;  pad_out = arm_in + 6.0;   // oś ±17.75, występ do ±20.75
pad_z = -5.0;                                // [A] 5 mm pod krawędzią blatu (zakres −4.5…−6.5) → decyzja / S2 (BLOKUJE druk FORK)
pad_tap = 2.5;  pad_bore = 3.4;  pad_bore_x1 = 35.0;  key_d = 2.4;
pusher_len = 10;                             // M3×10 ISO 4026
// gałka (M8)
// ODSTĘPSTWO: piasta odsunięta o 1.0 od ramienia: podkładka PTFE 0.5 + podkładka falista DIN 137B M4 (spec.: od 18.75).
// PRZEGLĄD (mech-4, fit-trunnion-bolts): PTFE pod piastą i pod łbem M3 → ślizgają się czoła, nie gwinty (gałka nie
// dokręca się/nie odkręca sama przy zmianie pochylenia); końce śrub liczone w stanie dociśniętym.
knob_gap = 1.0;  ptfe_t = 0.5;
hub_d = 7;  hub_len = 2.75;  knob_d = 16;  knob_len = 6;  n_flutes = 12;  flute_r = 1.5;
hex_af = 7.2;  hex_depth = 3.3;     // ODSTĘPSTWO: 2.8 → 3.3 (kieszeń łba M4)
knob_bore = 4.3;
knob_y0 = arm_out + knob_gap;       // 19.75

// ======================================================================
// POMOCNICZE
module ext_y(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();   // 2D (x,z) → wzdłuż y
module ext_x(x0, x1) translate([x0, 0, 0]) rotate([0, 90, 0]) linear_extrude(x1 - x0)
  multmatrix([[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) children();                                // 2D (y,z) → wzdłuż x
module ext_z(z0, z1) translate([0, 0, z0]) linear_extrude(z1 - z0) children();                                    // 2D (x,y) → wzdłuż z
// łezka 2D: okrąg + grot 45° w kierunku ang [deg] (w układzie 2D); cap > 0 → grot ścięty w odległości cap od środka
module td2(d, ang = 90, cap = 0) {
  intersection() {
    rotate(ang) polygon(concat([[d/2*sqrt(2), 0]], [for (i = [0 : 1 : $fn*3/4]) d/2*[cos(45 + i*270/($fn*3/4)), sin(45 + i*270/($fn*3/4))]]));
    if (cap > 0) rotate(ang) translate([cap - 50, 0]) square(100, center = true);
  }
}
module rrect(x0, z0, x1, z1, r) offset(r = r) offset(delta = -r) translate([x0, z0]) square([x1 - x0, z1 - z0]);
module ymir(s) if (s > 0) children(); else mirror([0, 1, 0]) children();   // lustro y dla strony −y
function circ(r) = r / cos(180 / $fn);   // promień opisany (strefy widzenia: wielokąt nie może być mniejszy od koła)
module clip_face() intersection() { children(); translate([-100, -100, -100]) cube([100 + face_x, 200, 200]); }   // nic przed czołem

// ======================================================================
// KAMERY I STREFY WIDZENIA (układ klatki)
module infra_xf() translate([ir_x0, 0, ir_z]) rotate([0, 0, ir_yaw_trim]) translate([-ir_x0, 0, -ir_z]) children();
module cam_th(c = 0, dx = 0) translate([dx, 0, 0]) {
  translate([-th_body, -th_w/2 - c, -th_h/2 - c]) cube([th_body + eps, th_w + 2*c, th_h + 2*c]);
  rotate([0, 90, 0]) cylinder(d = th_lens_d + 2*c, h = th_lens_len);
}
module cam_ir(c = 0, dx = 0) infra_xf() translate([ir_x0 + dx, 0, ir_z]) {   // dx wzdłuż osi Infra (po ir_yaw_trim)
  translate([-ir_body, -ir_w/2 - c, -ir_h/2 - c]) cube([ir_body + eps, ir_w + 2*c, ir_h + 2*c]);
  rotate([0, 90, 0]) cylinder(d = ir_lens_d + 2*c, h = ir_lens_len);
}
// przewody: bucik prosto do tyłu z tyłu każdej kamery + wyjście przez wycięcie w ściance −y (6 mm na zewnątrz)
module cables() {
  translate([-th_body - boot_l, 0, 0]) rotate([0, 90, 0]) cylinder(d = cab_d, h = boot_l + eps);
  infra_xf() translate([ir_x0 - ir_body - boot_l, 0, ir_z + 0.5]) rotate([0, 90, 0]) cylinder(d = cab_d, h = boot_l + eps);
  translate([(cage_x1 + cover_t + cab_x[1])/2, -bay_y + 1, (cab_z[0] + cab_z[1])/2]) rotate([90, 0, 0])
    cylinder(d = cab_d, h = cage_y - bay_y + 1 + 6);
}
module cams(c = 0, cab = true) { cam_th(c); cam_ir(c); if (cab) cables(); }
// termo: z CAŁEJ soczewki Ø16 (apertura = najgorszy przypadek), m = margines (osłona: hood_m, ścianka: hood_m+hood_t)
module th_keepout(L = 300, m = 0, x0 = th_lens_len) hull() {
  translate([x0, 0, 0]) rotate([0, 90, 0]) cylinder(r = circ(th_ap + m), h = 0.01);
  translate([x0 + L, 0, 0]) cube([0.01, 2*(th_ap + m + L*tan(th_fov[0]/2)), 2*(th_ap + m + L*tan(th_fov[1]/2))], center = true);
}
// Infra: z całego szkła Ø19, fov = [H, V]
module ir_keepout(fov = ir_fov_a, L = 300, x0 = ir_glass) infra_xf() translate([x0, 0, ir_z]) hull() {
  rotate([0, 90, 0]) cylinder(r = circ(ir_lens_d/2), h = 0.01);
  translate([L, 0, 0]) cube([0.01, 2*(ir_lens_d/2 + L*tan(fov[0]/2)), 2*(ir_lens_d/2 + L*tan(fov[1]/2))], center = true);
}

// ======================================================================
// BASE (M1) — układ gogli
module base() {
  difference() {
    union() {
      translate([-seat/2, -seat/2, 0]) cube([seat, seat, plate_t]);
      // blok widełek, R1; spód przed płytką: fazka 45° (12.5,0)→(15.5,3), dalej płasko na z=3 (zamiast deck_relief);
      // tylna górna krawędź: fazka 45° blk_ch (klamra GoPro na kasku)
      ext_y(-blk_y, blk_y) difference() {
        rrect(0, 0, blk_x1, blk_h, 1);
        polygon([[seat/2, -1], [seat/2, 0], [seat/2 + plate_t, plate_t], [blk_x1 + 1, plate_t], [blk_x1 + 1, -1]]);
        polygon([[-1, blk_h - blk_ch - 1], [-1, blk_h + 1], [blk_ch + 1, blk_h + 1]]);
      }
      // nogi męskie do klamry GoPro na kasku (v0.4): hull od prostokąta na płytce x[−12.5, 2.5] do tarczy
      if (helm_on) for (yc = helm_y) ext_y(yc - gp_leg/2, yc + gp_leg/2) hull() {
        translate([-seat/2, plate_t - 1]) square([gp_od, 1]);
        translate([helm_x, helm_z]) circle(d = gp_od);
      }
    }
    // śruby wentylatora: tylne — pogłębienie Ø4.2, przednie — studzienka Ø5 do góry bloku (od z = 1.2)
    for (sx = [-1, 1], sy = [-1, 1]) translate([sx*fan_hole/2, sy*fan_hole/2, -1]) {
      cylinder(d = m2_d, h = 40);
      // (studzienka Ø5 jest styczna do przedniej krawędzi płytki x = 12.5 → przedłużona do przodu, bez styku krawędzi)
      translate([0, 0, 1 + plate_t - screw_cb_h]) if (sx > 0) hull() { cylinder(d = well_d, h = 40); translate([3, 0, 0]) cylinder(d = well_d, h = 40); }
        else cylinder(d = screw_cb_d, h = 40);
      if (post_relief > 0) cylinder(d = 4.0, h = 1 + post_relief);
    }
    // gniazdo języka (otwarte z przodu i od góry)
    translate([slot_x0, -slot_y, plate_t]) cube([blk_x1 - slot_x0 + 1, 2*slot_y, blk_h]);
    // stalowy kołek M3 i bezpiecznik PA66 (łezki, grot +z = do góry w druku); nakrętki od −y, łeb kołka w pogłębieniu +y
    // ODSTĘPSTWO: kieszeń nakrętki płaskim bokiem do góry (most 3 mm) — „narożnik do +z” daje sufit 30° od poziomu
    ext_y(-blk_y - 1, blk_y + 1) { translate([pin_x, j_z]) td2(pin_hole_b, 90); translate([fuse_bx, j_z]) td2(fuse_hole, 90); }
    ext_y(blk_y - pin_cb_h, blk_y + 1) translate([pin_x, j_z]) td2(pin_cb_d, 90);
    ext_y(-blk_y - 1, -blk_y + pin_nut_h) translate([pin_x, j_z]) circle(d = pin_nut_af/cos(30), $fn = 6);
    ext_y(-blk_y - 1, -blk_y + fuse_nut_h) translate([fuse_bx, j_z]) circle(d = fuse_nut_af/cos(30), $fn = 6);
    // otwór M5 przegubu do kasku (łezka, grot +z)
    if (helm_on) ext_y(-20, 20) translate([helm_x, helm_z]) td2(gp_hole, 90);
    // otwór na linkę zabezpieczającą (dyneema 1 mm) przez tylną ściankę gniazda i nogi
    ext_y(-20, 20) translate(tether_b) td2(tether_d, 90);
  }
}

// ======================================================================
// FORK (M2–M4) — układ gogli
module arm2d(s) {
  hull() {
    translate([brow_x0, brow_z0]) square([brow_x1 - brow_x0, brow_z1 - brow_z0]);
    translate([PX, PZ]) circle(d = eye_d);
    translate([pad_x0, pad_z - 4]) square([pad_len, 8]);
  }
  // wskaźnik pochylenia (tylko −y): grot do +x na r ptr_r; boki styczne do oka (≥45° → bez podpór)
  if (s < 0) translate([PX, PZ]) hull() { circle(d = eye_d); polygon([[ptr_r, 0], [0, eye_d/4], [0, -eye_d/4]]); }
}
// profil XZ języka (wchodzi 1 mm w czoło). Ogon: łuk tg_tail_r wokół kołka + fazka 45° od góry (styczna do łuku)
module tongue2d() {
  if (tg_tail) hull() {
    translate([pin_x, j_z]) circle(r = tg_tail_r);
    xc = pin_x + (brow_z1 - j_z) - tg_tail_r*sqrt(2);   // 6.77: górny tylny narożnik na stycznej 45°
    translate([xc, tg_z0 + (j_z - tg_z0)]) square([brow_x0 + 1 - xc, brow_z1 - j_z]);
    translate([pin_x, tg_z0]) square([brow_x0 + 1 - pin_x, brow_z1 - tg_z0]);
  }
  else translate([tg_x0, tg_z0]) square([brow_x0 + 1 - tg_x0, brow_z1 - tg_z0]);   // stary język (kontrola pozytywna)
}
// otwory języka: kołek owalny (luz w x, ciasno w z), szczelina bezpiecznika wzdłuż x (ciasno w z, luźno w x);
// łezki z grotem −z (góra w druku FORK)
module tongue_holes2d() {
  hull() for (dx = [-(pin_hole_f - pin_hole_fz)/2, (pin_hole_f - pin_hole_fz)/2]) translate([pin_x + dx, j_z]) td2(pin_hole_fz, -90);
  hull() for (x = fuse_slot_x) translate([x, j_z]) td2(fuse_hole, -90);
}
module fork() {
  difference() {
    union() {
      ext_y(-tg_y, tg_y) tongue2d();
      // czoło: R1.5 tylko na dolnych krawędziach (góra z = 12 = stół w druku)
      ext_y(-arm_out, arm_out) union() {
        rrect(brow_x0, brow_z0, brow_x1, brow_z1, 1.5);
        translate([brow_x0, brow_z1 - 2]) square([brow_x1 - brow_x0, 2]);
      }
      for (s = [-1, 1]) {
        ext_y(s > 0 ? arm_in : -arm_out, s > 0 ? arm_out : -arm_in) arm2d(s);
        // występ popychacza na zewnątrz ramienia; góra fazowana (bez nawisu w druku)
        ymir(s) hull() {
          translate([pad_x0, arm_out - eps, pad_z - 4]) cube([pad_len, pad_out - arm_out + eps, 8]);
          translate([pad_x0, arm_out - eps, pad_z - 4]) cube([pad_len, 0.01, 8 + 2.5]);
        }
        // zaokrąglenie R3 ramię ↔ spód czoła (w obrysie ramienia)
        ymir(s) intersection() {
          ext_x(brow_x0, brow_x1) difference() {
            translate([arm_in - 3, brow_z0 - 3]) square([3 + eps, 3 + eps]);
            translate([arm_in - 3, brow_z0 - 3]) circle(r = 3);
          }
          ext_y(0, 40) arm2d(1);
        }
      }
    }
    // strefa gogli: nic poniżej z = 0.5 za x = keep_x
    translate([-50, -50, -60]) cube([keep_x + 50, 100, 60 + 0.5]);
    // kieszenie odciążające pod czołem (otwarte w dół = do góry w druku)
    for (s = [-1, 1]) translate([brow_pk[0], s > 0 ? brow_pk[2] : -brow_pk[3], brow_z0 - 1]) cube([brow_pk[1] - brow_pk[0], brow_pk[3] - brow_pk[2], brow_pk[4] - brow_z0 + 1]);
    ext_y(-10, 10) tongue_holes2d();
    // czopy: +y Ø4.4 (gałka M4), −y Ø3.4 (M3) — łezki, grot −z
    ext_y(arm_in - 1, arm_out + 1) translate([PX, PZ]) td2(piv_hole_l, -90);
    ext_y(-arm_out - 1, -arm_in + 1) translate([PX, PZ]) td2(piv_hole_r, -90);
    // popychacze: gwint M3 wprost w Ø2.5 (6 mm), dalej Ø3.4 do x 35 (ścięta łezka: ≥2 mm do otworu czopu), potem Ø2.4 na klucz
    for (s = [-1, 1]) {
      ext_x(keep_x - 1, pad_x0 + pad_len) translate([s*pad_y, pad_z]) td2(pad_tap, -90);
      // Ø3.4 i Ø2.4 wychodzą 0.2–0.7 mm poza ścianę ramienia (y 18.75) → rowek otwarty poziomo na zewnątrz: w druku zostaje
      // półka 1 mm przyklejona do ramienia zamiast cienkiej łuski zaczynającej się w powietrzu (rowek pod 45° w stronę −z
      // osłabiłby mostek do otworu czopu i wszedł pod podkładkę gałki)
      ext_x(pad_x0 + pad_len - eps, pad_bore_x1) translate([s*pad_y, pad_z]) hull() { td2(pad_bore, -90, cap = 2.05); translate([s*3, 0]) td2(pad_bore, -90, cap = 2.05); }
      ext_x(pad_bore_x1 - eps, PX + 20) translate([s*pad_y, pad_z]) hull() { td2(key_d, -90); translate([s*3, 0]) td2(key_d, -90); }
    }
  }
}

// ======================================================================
// CAGE (M5–M7) — układ klatki
module cage_outer() {
  arc = [for (a = [90 : 15 : 180]) [cage_x1 + 2 + 2*cos(a), z_top - 2 + 2*sin(a)]];   // R2 tył-góra
  // blok: poziom termo do x_th, poziom Infra do x_ir; fazka ch_rb × 45° tył-dół
  ext_y(-cage_y, cage_y) polygon(concat([[cage_x1, z_bot + ch_rb], [cage_x1 + ch_rb, z_bot], [x_th, z_bot], [x_th, z_mid],
                                          [x_ir, z_mid], [x_ir, z_top]], arc));
  // przejścia 45° zamiast półek 1–4 mm (blok → szyjka termo, blok → tuba Infra)
  hull() {
    translate([x_th - eps, -cage_y, z_bot]) cube([eps, 2*cage_y, z_mid - z_bot]);
    translate([x_th + s_th, 0, 0]) rotate([0, 90, 0]) cylinder(r = neck_r, h = eps);
  }
  hull() {
    translate([x_ir - eps, -cage_y, z_mid]) cube([eps, 2*cage_y, z_top - z_mid]);
    infra_xf() translate([x_ir + s_ir, 0, ir_z]) rotate([0, 90, 0]) cylinder(r = tube_r, h = eps);
  }
  // szyjka termo, osłona (strefa widzenia + hood_m + hood_t), tuba Infra (obrócona z Infra, przycięta do czoła)
  translate([x_th - 0.5, 0, 0]) rotate([0, 90, 0]) cylinder(r = neck_r, h = th_lens_len - x_th + 1);
  intersection() { th_keepout(40, hood_m + hood_t); translate([0, -50, -50]) cube([face_x, 100, 100]); }
  clip_face() infra_xf() {
    translate([x_ir - 0.5, 0, ir_z]) rotate([0, 90, 0]) cylinder(r = tube_r, h = ir_glass - ir_tube_back - x_ir + 0.5);
    // daszek 16 × 1.6 na górze, żebro tuba → daszek
    // ODSTĘPSTWO: daszek kończy się na czole x = 12.6 (spec.: 13.6) — przy druku przodem w dół nic nie może wystawać przed stół
    translate([x_ir - 0.5, -8, z_top - 1.6]) cube([ir_glass - ir_tube_back - x_ir + 0.5, 16, 1.6]);
    translate([x_ir - 0.5, -0.8, ir_z]) cube([ir_glass - ir_tube_back - x_ir + 0.5, 1.6, z_top - ir_z]);
  }
  // mostek osłona → tuba (z 9–13)
  translate([x_th - 0.5, -0.8, 9]) cube([face_x - x_th + 0.5, 1.6, 4]);
  // bossy czopu na zewnątrz (2 mm): łezka z grotem do +x (spód w druku przodem w dół), przy ściance grot dłuższy o 2 mm
  // (rozszerzenie 45° w y) → grot bossa nie zaczyna się półką 2 mm w bok
  // ODSTĘPSTWO: spec. M6 mówi „grot do −x” — dla otworów tak (sufit), dla wystającego bossa nawis jest od strony +x
  for (s = [-1, 1]) ymir(s) hull() {
    ext_y(cage_y + boss_out - eps, cage_y + boss_out) translate([piv_x, piv_z]) td2(boss_d, 0);
    ext_y(cage_y - eps, cage_y) translate([piv_x, piv_z]) hull() { td2(boss_d, 0); translate([boss_out, 0]) td2(boss_d, 0); }
  }
  // ucho linki na górze z tyłu: przód fazowany 45° (spód w druku)
  ext_y(-lug_y, lug_y) polygon([[lug_x0, z_top - 0.5], [lug_x0 + lug_w + lug_h + 0.5, z_top - 0.5], [lug_x0 + lug_w, z_top + lug_h], [lug_x0, z_top + lug_h]]);
}
module cover2d() {     // profil XZ pokrywy: płyta 1.5 + pas wzdłuż fazki 45°
  ui = ch_rb + cover_t*sqrt(2);
  polygon([[cage_x1, z_top - cov_lip - cov_clr], [cage_x1 + cover_t, z_top - cov_lip - cov_clr], [cage_x1 + cover_t, z_bot + ui - cover_t],
           [cage_x1 + ui - cov_foot, z_bot + cov_foot], [cage_x1 + ch_rb - cov_foot, z_bot + cov_foot], [cage_x1, z_bot + ch_rb]]);
}
module cage_cavities() {
  // kieszeń termo: korpus dociśnięty do ramki x = 0, otwarta do tyłu przez wnękę
  translate([cage_x1 - 1, -(th_w/2 + clr), -(th_h/2 + clr)]) cube([-cage_x1 + 1, th_w + 2*clr, th_h + 2*clr]);
  translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d = th_lens_d + 0.6, h = th_lens_len + 1);
  hull() {   // fazka 45° z otworu Ø16.6 do wnętrza osłony
    translate([th_lens_len - (circ(th_ap + hood_m) - th_lens_d/2 - 0.3) - 0.03, 0, 0]) rotate([0, 90, 0]) cylinder(d = th_lens_d + 0.6, h = eps);
    translate([th_lens_len, 0, 0]) rotate([0, 90, 0]) cylinder(r = circ(th_ap + hood_m), h = eps);
  }
  th_keepout(40, hood_m);
  // kieszeń Infra: przód korpusu na ramce x = −6, otwarta do tyłu (6 mm wnęki za korpusem)
  infra_xf() translate([cage_x1 - 1, -bay_y, ir_z - ir_h/2 - clr]) cube([ir_x0 - cage_x1 + 1, 2*bay_y, ir_h + 2*clr]);
  infra_xf() translate([ir_x0 - eps, 0, ir_z]) rotate([0, 90, 0]) cylinder(d = ir_lens_d + 0.6, h = 40);
  // wnęka kablowa za Infra NIE obraca się z ir_yaw_trim (przewody wychodzą wycięciem w ściance −y)
  translate([cage_x1 - 1, -bay_y, ir_z - ir_h/2 - clr]) cube([ir_x0 - ir_body - cage_x1 + 1, 2*bay_y, ir_h + 2*clr]);
  // wnęka kablowa za termo: y ±10.45, z [−9.95, ir_z]
  translate([cage_x1 - 1, -bay_y, -(th_h/2 + clr)]) cube([-th_body - cage_x1 + 1, 2*bay_y, ir_z + th_h/2 + clr]);
}
module cage_holes() {
  // szczeliny M2 (Ø2.3, długość 3), sufit 45° (grot −x = do góry w druku)
  ext_y(-cage_y - 3, cage_y + 3) {
    hull() for (dx = [-slot_len/2, slot_len/2]) translate([th_screw_x + dx, 0]) td2(m2_d, 180);
  }
  infra_xf() ext_y(-cage_y - 3, cage_y + 3)
    hull() for (dx = [-slot_len/2, slot_len/2]) translate([ir_x0 + ir_screw_x + dx, ir_z]) td2(m2_d, 180);
  // wkładki wtapiane od zewnątrz: +y M4, −y M3 (łezki, grot −x), za wkładką otwór przelotowy do wnęki
  ext_y(cage_y + boss_out - ins_depth, cage_y + boss_out + 1) translate([piv_x, piv_z]) td2(ins_l_d, 180);
  ext_y(boss_in_y - 1, cage_y + boss_out - ins_depth + eps) translate([piv_x, piv_z]) td2(ins_l_thru, 180);
  ext_y(-cage_y - boss_out - 1, -cage_y - boss_out + ins_depth) translate([piv_x, piv_z]) td2(ins_r_d, 180);
  ext_y(-cage_y - boss_out + ins_depth - eps, -boss_in_y + 1) translate([piv_x, piv_z]) td2(ins_r_thru, 180);
  // wpust pokrywy (krawędź cov_lip u góry, cage_y − cov_y − cov_clr na bokach, cov_foot − cov_clr przy fazce)
  ext_y(-(cov_y + cov_clr), cov_y + cov_clr) {
    offset(delta = cov_clr) cover2d();
    translate([-3, 0]) cover2d();
    intersection() { translate([-2, -2]) cover2d(); translate([cage_x1 - 10, z_bot + cov_foot - cov_clr]) square([30, 60]); }
  }
  // śruby pokrywy M2×5 przez ścianki boczne
  ext_y(-cage_y - 1, cage_y + 1) translate(cov_scr) td2(m2_d, 180);
  // wyjście przewodów: wycięcie w ściance −y, otwarte do tyłu
  translate([cab_x[0], -cage_y - 1, cab_z[0]]) cube([cab_x[1] - cab_x[0], cage_y - bay_y + 1 + eps, cab_z[1] - cab_z[0]]);
  // linka: Ø1.6 wzdłuż y przez ucho (łezka, grot −x = do góry w druku)
  ext_y(-lug_y - 1, lug_y + 1) translate(lug_hole) td2(tether_d, 180);
  // odpływ w dnie osłony termo (2 × 2), kończy się drain_sill przed czołem
  hull() { translate([th_lens_len + 1.2, -1, -20]) cube([face_x - drain_sill - th_lens_len - 1.2, 2, 12]); translate([th_lens_len + 0.2, -eps, -20]) cube([eps, 2*eps, 12]); }   // koniec ostrołukowy 45° (bez mostu)
  // podziałka pochylenia na ściance −y: kreski 0.6 × 0.6 przy 0/10/20°, r 8.6–10.0 (10°: 8.6–11.0)
  // ODSTĘPSTWO (PRZEGLĄD print-09): bez kresek 5/15° — przy podziałce 5° między rowkami zostawało 0.3 mm (poniżej ściegu)
  ext_y(-cage_y - 1, -cage_y + 0.6) for (v = [0 : 10 : 20]) translate([piv_x, piv_z]) rotate(v)
    translate([8.6, -0.3]) square([v == 10 ? 2.4 : 1.4, 0.6]);
}
module cage() {
  difference() {
    union() {
      difference() { cage_outer(); cage_cavities(); }
      // bossy wewnętrzne: tylko 0.3 mm (do |y| 10.15), łezka grot +x
      for (s = [-1, 1]) ext_y(s > 0 ? boss_in_y : -bay_y - eps, s > 0 ? bay_y + eps : -boss_in_y) translate([piv_x, piv_z]) td2(boss_d, 0);
    }
    cage_holes();
  }
}

// ======================================================================
// POKRYWA I GAŁKA (M8)
module cover() {
  difference() {
    intersection() {
      union() {
        ext_y(-cov_y, cov_y) cover2d();
        // 4 słupki 2.4 × 2.4 do termo (y ±7.75, z ±7.75) do 0.3 przed tyłem termo
        for (s = [-1, 1], t = [-1, 1]) translate([cage_x1 + 1, s*post_yz - post_s/2, t*post_yz - post_s/2]) cube([post_x1 - cage_x1 - 1, post_s, post_s]);
        // 4 słupki do Infra (y ±7.75, z ir_z ±7.75) do 0.3 przed tyłem Infra — zamiast EVA; środek wolny na bucik przewodu
        // (obracane z ir_yaw_trim razem z Infra)
        infra_xf() for (s = [-1, 1], t = [-1, 1]) translate([cage_x1 + 1, s*post_yz - post_s/2, ir_z + t*post_yz - post_s/2]) cube([post_x1_ir - cage_x1 - 1, post_s, post_s]);
        // zaczepy 3 mm na śruby M2 (przy ściankach, nad bossami czopu)
        for (s = [-1, 1]) translate([cage_x1 + 1, s > 0 ? tab_y[0] : -tab_y[1], tab_z[0]]) cube([post_x1 - cage_x1 - 1, tab_y[1] - tab_y[0], tab_z[1] - tab_z[0]]);
      }
      // nic poza obrysem klatki (płaszczyzna tyłu + fazka)
      ext_y(-20, 20) polygon([[cage_x1, z_bot + ch_rb], [cage_x1 + ch_rb, z_bot], [cage_x1 + 40, z_bot], [cage_x1 + 40, z_top + 5], [cage_x1, z_top + 5]]);
    }
    // otwory pilotowe Ø1.7 w zaczepach (łezka, grot +x = do góry w druku pokrywy)
    ext_y(-tab_y[1] - 1, tab_y[1] + 1) translate(cov_scr) td2(1.7, 0);
  }
}
module knob_local() {   // oś = z lokalne, z = 0 = czoło piasty (przy ramieniu)
  difference() {
    union() {
      cylinder(d = hub_d, h = hub_len + eps);
      translate([0, 0, hub_len]) cylinder(d = knob_d, h = knob_len);
    }
    for (i = [0 : n_flutes - 1]) rotate([0, 0, i*360/n_flutes]) translate([knob_d/2, 0, hub_len - 1]) cylinder(r = flute_r, h = knob_len + 2, $fn = 24);
    translate([0, 0, -1]) cylinder(d = knob_bore, h = 20);
    translate([0, 0, hub_len + knob_len - hex_depth]) cylinder(d = hex_af/cos(30), h = hex_depth + 1, $fn = 6);
  }
}
module knob() translate([PX, knob_y0, PZ]) rotate([-90, 0, 0]) knob_local();

// ======================================================================
// ZŁOŻENIE
module at_pivot(t = tilt) translate([PX, 0, PZ]) rotate([0, t, 0]) translate([-piv_x, 0, -piv_z]) children();
module hdo2_ghost() {     // [A] gogle jako bryła: przód na x = front_x, blat na z = 0, oś okularów na z = −seat_above_eye
  color("black", 0.25) translate([front_x - 80, -169.2/2, -45.5]) cube([80, 169.2, 45.5]);
  color("red", 0.6) for (s = [-1, 1]) translate([front_x - 30, s*30, -seat_above_eye]) rotate([0, 90, 0]) cylinder(d = 6, h = 30.2);
}
// łby śrub złącza FORK/BASE (też w teście fork_base i fan_access): kołek M3 ISO 7380 (kopułka Ø5.7 × 1.65) w pogłębieniu,
// bezpiecznik PA66 M2.5 DIN 84 (walec Ø4.5 × 1.8) na policzku +y
module joint_heads() {
  translate([pin_x, blk_y - pin_cb_h, j_z]) rotate([-90, 0, 0]) resize([5.7, 5.7, 1.65]) intersection() { sphere(d = 5.7); cylinder(d = 6, h = 3); }
  translate([fuse_bx, blk_y, j_z]) rotate([-90, 0, 0]) cylinder(d = 4.5, h = 1.8);
}
module hardware_ghost() {
  // popychacze M3×10 dosunięte do ściany, stalowy kołek M3×16, bezpiecznik PA66 M2.5×20, M3×8 + PTFE po prawej, M4 w gałce
  color("silver") for (s = [-1, 1]) translate([front_x, s*pad_y, pad_z]) rotate([0, 90, 0]) cylinder(d = 3, h = pusher_len);
  color("silver") translate([pin_x, blk_y - pin_cb_h, j_z]) rotate([90, 0, 0]) cylinder(d = 3, h = pin_len);
  color("white") translate([fuse_bx, blk_y, j_z]) rotate([90, 0, 0]) cylinder(d = fuse_d, h = fuse_len);
  color("white") joint_heads();
  color("white") translate([PX, -arm_out, PZ]) rotate([90, 0, 0]) cylinder(d = 7, h = ptfe_t);
  color("silver") translate([PX, -arm_out - ptfe_t, PZ]) rotate([90, 0, 0]) cylinder(d = 5.7, h = 1.65);
  color("silver") translate([PX, -arm_out - ptfe_t, PZ]) rotate([-90, 0, 0]) cylinder(d = 3, h = 8);
}
module assembly() {
  hdo2_ghost();
  rotate([0, seat_pitch, 0]) {
    color("steelblue") base();
    color("olivedrab") fork();
    color("darkorange") knob();
    hardware_ghost();
    at_pivot() {
      color("tan") cage();
      color("sienna") cover();
      color("dimgray") cam_th(0);
      color("gray") cam_ir(0);
      color("black") cables();
      color("orange", 0.15) th_keepout(60);
      color("cyan", 0.08) ir_keepout(ir_fov_a, 40);
    }
  }
}

// ======================================================================
// ECHO — liczby do README
// wysokość środka soczewki termo / szkła Infra nad osią okularów
function lens_h(t, xl, zl, sae) = sae + (-PX*sin(seat_pitch) + PZ*cos(seat_pitch))
  + (-(xl - piv_x)*sin(t + seat_pitch) + (zl - piv_z)*cos(t + seat_pitch));
for (sae = [19, seat_above_eye, 29]) for (t = [0, 10, 20])
  echo(str("seat_above_eye ", sae, ", tilt ", t, "°: termo ", round(lens_h(t, th_lens_len, 0, sae)*10)/10,
           " mm, Infra ", round(lens_h(t, ir_glass, ir_z, sae)*10)/10, " mm nad osią okularów (cel 0…+35)"));
// pasmo seat_above_eye, w którym cel 0…+35 jest spełniony w całym zakresie tilt 0–20 (termo najniżej przy 20°,
// Infra najwyżej przy 0°) — PRZEGLĄD optics-08
echo(str("cel 0…+35 dla tilt 0–20 spełniony przy seat_above_eye ", round(-lens_h(20, th_lens_len, 0, 0)*10)/10, " … ",
         round((35 - lens_h(0, ir_glass, ir_z, 0))*10)/10, " mm"));
// środek ciężkości kamer [A: termo 10 g, Infra 15 g, gęstość jednorodna korpus + obiektyw], tilt 0, x gogli
th_v = [th_w*th_h*th_body, PI*pow(th_lens_d/2, 2)*th_lens_len];
ir_v = [ir_w*ir_h*ir_body, PI*pow(ir_lens_d/2, 2)*ir_lens_len];
th_cx = (th_v[0]*(-th_body/2) + th_v[1]*(th_lens_len/2)) / (th_v[0] + th_v[1]);
ir_cx = ir_x0 + (ir_v[0]*(-ir_body/2) + ir_v[1]*(ir_lens_len/2)) / (ir_v[0] + ir_v[1]);
echo(str("X0 = ", X0, ", oś czopu (gogle) x = ", PX, ", z = ", PZ, "; brow_x1 = ", brow_x1, "; tył klatki x = ", X0 + cage_x1,
         "; środek ciężkości kamer x = ", round((X0 + (cam_mass[0]*th_cx + cam_mass[1]*ir_cx)/(cam_mass[0] + cam_mass[1]))*10)/10,
         " (x gogli, tilt 0)"));

// mostek otwór popychacza Ø3.4 (koniec x 35, grot ścięty 2.05) ↔ otwór czopu Ø4.4
web = (pad_z - 2.05) - (PZ + sqrt(pow(piv_hole_l/2, 2) - pow(PX - pad_bore_x1, 2)));
// śruby czopu w stanie DOCIŚNIĘTYM (ramię dosunięte o arm_gap do bossa) — PRZEGLĄD fit-trunnion-bolts
m4_tip = knob_y0 + hub_len + knob_len - hex_depth - 14 - arm_gap;   // M4×14 ISO 4017, łeb w gałce
m3_tip = -(arm_out + ptfe_t) + 8 + arm_gap;                          // M3×8 ISO 7380 na podkładce PTFE 0.5 (−y)
ins_bot_l = cage_y + boss_out - ins_depth;                           // 10.45 — koniec gniazda wkładki M4
echo(str("mostek Ø3.4 ↔ czop Ø4.4: ", round(web*100)/100, " mm (wym. ≥ 2.0); dociśnięte: M4×14 wkręcenie ",
         round((cage_y + boss_out - max(m4_tip, ins_bot_l))*100)/100, " mm (≥ 3.5), koniec ",
         round((m4_tip - boss_in_y)*100)/100, " mm przed ścianką bossa (≥ 0.3); M3×8: wkręcenie ",
         round((min(3, cage_y + boss_out + m3_tip))*100)/100, " mm z 3, koniec ", round((-m3_tip - boss_in_y)*100)/100,
         " mm przed ścianką (≥ 0.3); otwory przelotowe za wkładkami → śruby nie dobijają"));
// popychacze — PRZEGLĄD optics-01: obrót wokół kołka (dx = 0) → θ = (e₋ − e₊)/(2·pad_y); procedura „jeden wkręcany,
// drugi wykręcany o tyle samo” daje θ = n·0.5/pad_y. Kręcenie jednym tylko zwiększa docisk (kołek blokuje).
echo(str("popychacze (para: jeden +n, drugi −n obrotu): 1 obrót = ", round(atan(0.5/pad_y)*100)/100, "°, 1/8 = ",
         round(atan(0.5/8/pad_y)*100)/100, "°, 1/16 = ", round(atan(0.5/16/pad_y)*100)/100,
         "°; piksel termo ≈ 0.20° (256 px / 50°)"));
// popychacz w pełni cofnięty (koniec przy stopniu Ø3.4→Ø2.4 na x pad_bore_x1) wystaje z bossa o:
echo(str("popychacz M3×", pusher_len, " cofnięty do oporu wystaje ", pad_bore_x1 - pusher_len - pad_x0 < 0 ? pad_x0 - (pad_bore_x1 - pusher_len) : 0,
         " mm (koniec x ", pad_bore_x1 - pusher_len, "; ściana najgorzej x ", front_x + front_tol, ")"));

// MOMENTY — PRZEGLĄD mech-2/3/4/7/8/10 (wszystko [calc], μ i N założone; rozstrzyga próbka coupon_joint (a))
clamp_N_l = [250, 400];             // [N] gałka dokręcona ręką
clamp_N_r = [250, 250];             // [N] M3 po prawej (Loctite, dokręcona raz)
mu_petg = [0.3, 0.4];  mu_ptfe = [0.05, 0.1];
r_boss_l = (boss_d/2 + piv_hole_l/2)/2;  r_boss_r = (boss_d/2 + piv_hole_r/2)/2;   // czoło boss/ramię (PETG/PETG)
r_hub = (hub_d/2 + knob_bore/2)/2;  r_head = (5.7/2 + 3.4/2)/2;                   // czoło piasta/łeb na PTFE
function tslip(i) = (mu_petg[i]*(clamp_N_l[i]*r_boss_l + clamp_N_r[i]*r_boss_r)
                   + mu_ptfe[i]*(clamp_N_l[i]*r_hub + clamp_N_r[i]*r_head))/1000;           // [N·m]
T_slip = [tslip(0), tslip(1)];
M_fuse_wet = [1.6, 1.9];  M_fuse_dry = [2.4, 2.7];  M_fuse_bend_min = 1.0;   // [calc] ścięcie 2 płaszczyzn; zginanie ≈1.0
P_push = [5, 15];                   // [N] docisk popychacza „dotyk + 1/8 obrotu” [A, sztywność pętli nieznana]
M_pre = [2*P_push[0]*(j_z - pad_z)/1000, 2*P_push[1]*(j_z - pad_z)/1000];   // oba popychacze × ramię 12 mm
lens_x10 = PX + (th_lens_len - piv_x)*cos(10);   // soczewka termo przy tilt 10 (x gogli)
k_lens = (lens_x10 - pin_x)/(lens_x10 - PX);     // stosunek ramion kołek / czop (≈2.13)
echo(str("czop: T_slip ≈ ", round(T_slip[0]*100)/100, "–", round(T_slip[1]*100)/100, " N·m (PETG boss/ramię + PTFE pod piastą/łbem)"));
echo(str("pchnięcie obiektywu W GÓRĘ do poślizgu: bezpiecznik widzi ", round(k_lens*100)/100, "·T_slip + docisk = ",
         round((k_lens*T_slip[0] + M_pre[0])*100)/100, "–", round((k_lens*T_slip[1] + M_pre[1])*100)/100,
         " N·m wobec ", M_fuse_wet[0], " (mokry) → ", k_lens*T_slip[1] + M_pre[1] < M_fuse_wet[0] ? "OK" : "NIE WOLNO pchać obiektywu/osłony",
         "; obrót klatki za boki (para sił): ", round((T_slip[0] + M_pre[0])*100)/100, "–", round((T_slip[1] + M_pre[1])*100)/100,
         " N·m → ", T_slip[1] + M_pre[1] < M_fuse_wet[0] ? "OK" : "ZA DUŻO"));
echo(str("docisk popychaczy: 2·P·", j_z - pad_z, " mm = ", M_pre[0], "–", M_pre[1], " N·m; dopuszczalne P ≤ ",
         round((M_fuse_wet[0] - T_slip[1])/(2*(j_z - pad_z))*1000), " N/szt. (przy obrocie klatki za boki); 0.05 N·m na kluczu ≈ 55–65 N/szt."));
F_dry = M_fuse_dry[1]*1000/(lens_x10 - pin_x);   // [N]
echo(str("śruby wentylatora przy progu suchym: F na soczewce ", round(F_dry), " N → PRZEDNIA para ",
         round(F_dry*(lens_x10 + seat/2)/(seat/2 + fan_hole/2)), " N, ", round(F_dry*(lens_x10 + seat/2)/(seat/2 + fan_hole/2)/2), " N/szt. (płytka obraca się na tylnej krawędzi)"));
echo(str("uderzenie czołowe (−x) w soczewkę termo przy tilt 10: poślizg czopu dopiero przy ",
         round(T_slip[0]*1000/((th_lens_len - piv_x)*sin(10))), "–", round(T_slip[1]*1000/((th_lens_len - piv_x)*sin(10))), " N (bez bezpiecznika)"));
// linka: odległość otworów BASE (x 1.5, z 7.5) ↔ ucho klatki przy tilt −2.5 / 10 / 67.5
function anchor(t) = [PX + (lug_hole[0] - piv_x)*cos(t) + (lug_hole[1] - piv_z)*sin(t), PZ - (lug_hole[0] - piv_x)*sin(t) + (lug_hole[1] - piv_z)*cos(t)];
function tdist(t) = norm(anchor(t) - tether_b);
echo(str("linka: odległość otworów (prosto) ", round(tdist(-2.5)*10)/10, " / ", round(tdist(10)*10)/10, " / ", round(tdist(67.5)*10)/10,
         " mm przy tilt −2.5 / 10 / 67.5"));

// ======================================================================
// PRÓBKI (M9) — drukować NAJPIERW
// coupon: przegub GoPro z v0.4 (3 pary 3.2/3.3/3.4) → gp_slit dla nóg do kasku
coupon_ax = 9.5;
module coupon_leg_set(ys, base_w) {
  translate([-9, -base_w/2, 0]) cube([18, base_w, 2]);
  for (yc = ys) hull() {
    translate([-6, yc - gp_leg/2, 0]) cube([12, gp_leg, 2]);
    translate([0, yc - gp_leg/2, coupon_ax]) rotate([-90, 0, 0]) cylinder(d = gp_od, h = gp_leg);
  }
}
module coupon() {
  slits = [3.2, 3.3, 3.4];
  for (i = [0 : len(slits) - 1]) translate([i*22, 0, 0]) {
    g = slits[i];
    difference() {
      coupon_leg_set([-(gp_leg + g), 0, gp_leg + g], 3*gp_leg + 2*g + 2);
      ext_y(-20, 20) translate([0, coupon_ax]) td2(gp_hole, 90);
      translate([7.6, 0, 1.5]) linear_extrude(1) rotate([0, 0, 90]) text(str(g), size = 2.2, halign = "center", valign = "center");
    }
    translate([0, 22, 0]) difference() {
      coupon_leg_set([-(g/2 + gp_leg/2), g/2 + gp_leg/2], 2*gp_leg + g + 2);
      ext_y(-20, 20) translate([0, coupon_ax]) td2(gp_hole, 90);
      translate([7.6, 0, 1.5]) linear_extrude(1) rotate([0, 0, 90]) text(str(g), size = 2.2, halign = "center", valign = "center");
    }
  }
}
// coupon_joint: (1) wycinek BASE z blokiem widełek i kikutem płytki (do imadła), (2) język FORK z belką do ucha
// obciążenia 55 mm przed kołkiem na z = −11 (próba a: waga bagażowa w górę, pęknięcie 30–50 N; potem kąt swobodnego
// obrotu na kołku), (3) występ popychacza z gwintem M3 (próba b: 20 cykli), (4) wycinek klatki z bossami i wkładkami
// M4 i M3 (próba c: wyrwanie > 2× docisk, wybrzuszenie od środka)
load_x = pin_x + 55;
module cj_tongue() {
  difference() {
    union() {
      ext_y(-tg_y, tg_y) tongue2d();
      ext_y(-5, 5) hull() {
        translate([brow_x0, tg_z0]) square([1, brow_z1 - tg_z0]);
        translate([load_x - 4, brow_z1 - 1]) square([9, 1]);
        translate([load_x, PZ]) circle(d = 10);
      }
    }
    ext_y(-10, 10) {
      tongue_holes2d();
      translate([load_x, PZ]) td2(4.0, -90);
      translate([36, 1]) td2(9, -90);   // odciążenie belki (sufit 45° w druku)
    }
  }
}
module coupon_joint() {
  // (1) BASE: x −4…18.5, z ≤ 13 (nogi do kasku obcięte) — płytką na stół
  intersection() { base(); translate([-4, -13, -1]) cube([22.5, 26, 14]); }
  // (2) język + belka — jak FORK: z = 12 na stół
  translate([0, 28, brow_z1]) rotate([180, 0, 0]) cj_tongue();
  // (3) występ popychacza (+y) — z = 0 na stół (jak FORK, odwrócony)
  translate([-pad_x0 - 30, 50 - pad_y, 0]) rotate([180, 0, 0]) intersection() { fork(); translate([keep_x, arm_in, -10]) cube([33.5 - keep_x, 7, 10]); }
  // (4) wycinek klatki: obie ścianki z bossami + dolny mostek (jedna bryła w kształcie U) — cięciem x = −13.5 na stół
  // (jak klatka: przodem w dół). PRZEGLĄD print-07: same ścianki stały na 2 × 12 mm i PrusaSlicer zgłaszał słabą przyczepność.
  translate([-55, 0, -13.5]) rotate([0, 90, 0]) intersection() { cage(); translate([-24, -20, -12]) cube([10.5, 40, 18]); }
}

// ======================================================================
// ORIENTACJE DO DRUKU (PETG, MK4, 0.2 mm, bez podpór)
module print_base() base();                                                   // płytką w dół, bez brimu, 4 obwody
module print_fork() translate([0, 0, brow_z1]) rotate([180, 0, 0]) fork();    // z = 12 (góra czoła) na stół, bez brimu
module print_cage() translate([0, 0, face_x]) rotate([0, 90, 0]) cage();      // czołem x = 12.6 w dół, brim 5 mm zewn.
module print_acc() {                                                          // pokrywa i gałka zewnętrzną stroną w dół
  translate([0, 0, -cage_x1]) rotate([0, -90, 0]) cover();
  translate([28, 0, hub_len + knob_len]) mirror([0, 0, 1]) knob_local();
}

if (part == "base") base();
else if (part == "fork") fork();
else if (part == "cage") cage();
else if (part == "cover") cover();
else if (part == "knob") knob();
else if (part == "print_base") print_base();
else if (part == "print_fork") print_fork();
else if (part == "print_cage") print_cage();
else if (part == "print_acc") print_acc();
else if (part == "coupon") coupon();
else if (part == "coupon_joint") coupon_joint();
else if (part == "none") { }      // include w testach
else assembly();
