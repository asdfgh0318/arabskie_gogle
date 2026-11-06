// arabskie_gogle — mocowanie kamer Caddx TR1-220SL na przód Fat Shark HDO2
// v0.6 (2026-11-06), WERSJA ROBOCZA. Decyzje Adama 2026-11-06: przy kamerze zostaje przegub GoPro z v0.4 („wierzę, że
// mocowanie GoPro puści pierwsze”) → czop i bezpiecznik PA66 z v0.5 odrzucone; +12 g masy — tak; przewody z tyłu u góry
// klatki — tak; NOWE: indeksowany kąt kamery na wypustkach. v0.4 jest w historii git (6217b93/eddc09a), v0.5 w
// tactical_mount.scad (odrzucona, źródło pomysłów). Zmiany względem v0.4 oznaczone „v0.6:”, odstępstwa od zlecenia
// „ODSTĘPSTWO”. Wymiary kamer z rysunków sklepu BZB UAS, geometria HDO2 ze zdjęć/modeli (research/06) — NIC nie
// zmierzone na sprzęcie.
//
// Części (PETG, MK4, bez podpór):
//   1) cage        — klatka v0.4: termo (dół) + Infra (nad nią), wsuwane od przodu, z tyłu 2 palce GoPro (męskie)
//                    v0.6: wypustki zapadek na zewnętrznych ścianach palców, szczelina na opaskę przewodów (−y, góra-tył)
//   2) adapter_top — płytka na gnieździe wentylatora (4 śruby 20x20), blok z bezpiecznikiem, 3 palce GoPro (żeńskie)
//                    przed przednią ścianą, nogi do kasku nad płytką (v0.4)
//                    v0.6: belka z dwoma występami popychaczy yaw (M3) przed ścianą gogli — PRZED bezpiecznikiem;
//                    pułapka nakrętki M5 i podziałka po −y; rowki zapadek w zewnętrznych palcach żeńskich
//   3) shroud      — v0.6: osłona przednia (termo + tuba Infra + daszek), trzymana językami pod śrubami M2 kamer
//   4) knob        — v0.6: gałka bez narzędzi po LEWEJ (+y) z wciśniętym łbem M5×20 ISO 4017
// Pochylenie: przegub GoPro M5 na tarcie (dokręcać ręką gałką) + zapadki 0/10/20° (wypustka ↔ rowek).
// Odchylenie (yaw): ustawiane popychaczami przy poluzowanych śrubach wentylatora, potem śruby dokręcone.
// Bezpiecznik: przewężenie w bloku adaptera (fuse_*) — przy uderzeniu pęka drukowana część, nie gniazdo śrub w goglach.
//
// Układ: x = do przodu (oś optyczna), y = w lewo (strona noszącego), z = do góry.
// Klatka: początek = środek przedniej ściany korpusu kamery termo (oś optyczna termo).
// Adapter: początek = środek wzoru śrub wentylatora, z=0 = blat skorupy (gniazdo wentylatora).
//
// Użycie:  openscad -D 'part="print_cage"' -o print_cage.stl camera_mount.scad
//   part = "assembly" | "cage" | "adapter_top" | "shroud" | "knob" | "print_cage" | "print_adapter" | "print_shroud"
//        | "print_knob" | "coupon" | "none" (do include w testach)

part = "assembly";
tilt = 10;              // [deg] pochylenie kamer w dół względem adaptera (podgląd assembly i testy)

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
// v0.6: cam_gap 1.5 → 2.0. Strefa widzenia termo z CAŁEJ soczewki Ø16 (wymóg v0.6, 50×37.2°) przy 1.5 dotykała dolnej
// krawędzi obiektywu Infra (Ø19, do x 19.1): góra strefy na x 19.1 = 12.2 > 12.0. Przy 2.0 zostaje 0.3 mm. Infra wyżej o 0.5.
cam_gap = 2.0;                      // odstęp pionowy między korpusami
ir_yaw_trim = 0;                    // [deg] korekta odchylenia Infra względem termo (po zbieżeniu na celu 10 m)
th_yaw_trim = 0;                    // [deg] korekta odchylenia termo względem gogli (krok 0.25°, przedruk klatki)
ir_z = th_h/2 + cam_gap + ir_h/2;   // oś Infra nad osią termo (= 22.0)
th_fov = [50, 37.2];                // [deg] termo H x V (sklep)
ir_fov = [96, 72];                  // [deg] Infra: najgorszy przypadek f-θ dla 120° po przekątnej (research/02)

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
male_y = [-(gp_slit/2 + gp_leg/2), (gp_slit/2 + gp_leg/2)];
male_out = gp_slit/2 + gp_leg;             // zewnętrzna ściana palca męskiego (4.65)
fem_in = gp_leg/2 + gp_slit;               // wewnętrzna ściana zewnętrznego palca żeńskiego (4.8); luz 0.15 do męskiego

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
front_tol = 1.5;          // niepewność front_x
// v0.6 (z v0.5, PRZEGLĄD optics-03): nic poniżej blatu za płaszczyzną front_x + front_tol + 1.0 (v0.4: +0.5) → przy
// najgorszej ścianie (24.6) zostaje 1 mm, więc obrót adaptera o ±2° przy ustawianiu zbieżności jest wolny (test yaw).
keep_x = front_x + front_tol + 1.0;       // 25.6
seat_above_eye = 23;      // [A] blat nad osią okularów (C3: 19–29!) — KLUCZOWY POMIAR M5
axis_rel_seat = 0;        // wysokość osi przegubu nad blatem; 0 → termo ≈ +12.4 mm nad oczami przy tilt=0
adapter_axis_x = front_x + gp_od/2 + 3.0;  // oś przegubu przed przednią ścianą, 3 mm luzu tarcz (front_x ±1.5)
seat_pitch = 0;           // [A] pochylenie blatu względem osi okularów, przód w dół = + (M4); 0 dopóki nie zmierzone
deck_relief = 0.5;        // spód bloku przed płytką podniesiony → jedyną bazą jest gniazdo 25x25 (mech-8)
fuse_x = 14.0;            // bezpiecznik: przewężenie bloku (rdzeń fuse_core x root_h), rowki V 45° z boków
fuse_core = 10.0;         // ≈2.6 N·m na zginanie przy 25 MPa międzywarstwowo (> poślizg przegubu ≈1.3 N·m)
fuse_x1 = fuse_x + (gp_leg*1.5 + gp_slit - fuse_core/2);   // przód rowków bezpiecznika (16.8): nic nie mostkuje go z przodu
adapter_axis_z = axis_rel_seat;
fem_y = [-(gp_leg + gp_slit), 0, (gp_leg + gp_slit)];
fem_out = 1.5*gp_leg + gp_slit;            // zewnętrzna ściana nóg żeńskich (7.8)
boss_len = 5.0;                            // występ na nakrętkę M5 — v0.6: po stronie −y (gałka po +y)
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

// ---------- v0.6: GAŁKA M5 po lewej (+y) — obsługa lewą ręką bez narzędzi ----------
// M5×20 ISO 4017 (łeb sześciokątny 8 × 3.5) wciśnięty (+ kropla CA) w gałkę; łeb wystaje 0.3 z czoła gałki, więc
// docisk idzie stal → podkładka DIN 125 Ø10 × 1 → palec żeński (PETG gałki nie pełznie pod 300 N). Nakrętka w pułapce −y.
// Długość jak w v0.4: pod łbem 1.0 + 15.6 + 0.6 → 2.8 mm gwintu w nakrętce M5.
// Gałka siedzi między palcem żeńskim a słupkiem popychacza +y (y 9.1–13.75). Od strony +y słupek i ukośna podpora
// zasłaniają tylko pas ≈5 mm przez tylną część gałki; przód i dół gałki są dostępne dla palca (przegląd własny v0.6:
// pionowy występ pod blatem zasłaniał całą gałkę; tuleja gałki przez występ nie daje się wydrukować bez podpór).
m5_len = 20;  m5_af = 8.0;  m5_k = 3.5;
washer_d = 10;  washer_t = 1.0;
kn_d = 16;                 // [A] Ø16: ręką w cienkiej rękawicy ≈0.2–0.4 N·m → ogranicza docisk; tył gałki x 25.6 = keep_x
kn_flutes = 10;  kn_flute_r = 1.3;
kn_af = m5_af + 0.15;      // gniazdo łba (wcisk / CA)
kn_pocket = m5_k - 0.3;    // łeb wystaje 0.3 z czoła gałki
kn_y0 = fem_out + washer_t + (m5_k - kn_pocket);   // 9.1 — czoło gałki

// ---------- v0.6: POPYCHACZE YAW (z v0.5 M4) na belce adaptera, PRZED bezpiecznikiem ----------
// Dwa wkręty bez łba M3×20 ISO 4026 (końcówka nylonowa albo kropla PTFE) w blokach na y ±17.75, pchają w −x na
// przednią ścianę gogli. Gwint M3 wprost w wydrukowanym Ø2.5 (jak v0.5) albo wkładka M3 krótka. Klucz imbusowy 1.5 od
// przodu wzdłuż osi popychacza.
// ODSTĘPSTWO od v0.5: pad_z −5 → −9.5. Według GrabCAD zaokrąglenie górnej krawędzi (R ≈ 10.5) kończy się na z ≈ −10.4,
// więc na −9.5 ściana jest prawie pionowa (na −5 była pochylona 31°); na −5 blok popychacza zasłaniałby gałkę.
// S2: zmierzyć ścianę na wysokości −8…−11 przy y ±17.75.
// Druk adaptera tyłem w dół (x = do góry): wszystko poza blokiem musi rosnąć z nachyleniem ≤45°:
//  - belka nad przegubem (z 9–13) i słupki nad blatem: tył skośny 45° w x–y od boku bloku (y ±7.8) i w x–z nad blokiem;
//  - pod blatem: ukośna podpora 45° (pas x + z = 26.1 … 26.1 + w), tył = płaszczyzna x + z = keep_x + deck_relief
//    (nic poniżej blatu za keep_x); na jej końcu blok z gwintem. Oś popychacza (z −9.5) wchodzi w blok na x 35.6,
//    więc popychacz jest dłuższy niż w v0.5 (M3×20 zamiast ×10, wysuw 11–14 mm).
br_x0 = fuse_x1 + 0.5;     // 17.3 — tył belki (0.5 przed rowkami bezpiecznika)
br_x1 = 30.0;              // przód belki i słupków nad blatem
br_z0 = 9.0;               // spód belki (nad gałką i nad palcami żeńskimi: palce zewnętrzne zostają wolne do ugięcia)
br_z1 = 13.0;              // góra belki (klamra kasku przy 90° do przodu by jej dotykała — pomiar w teście)
pad_y = 17.75;             // oś popychaczy (v0.5)
pad_z = -9.5;              // [A] → S2
pad_w = 3.0;               // pół-szerokość słupka/bloku (y 14.75–20.75)
pad_zb = pad_z - 3.0;      // spód bloku
pad_zt = pad_z + 3.0;      // góra bloku
strut_w = 5.0;             // szerokość ukośnej podpory (w x)
kp_c = keep_x + deck_relief;             // 26.1 — płaszczyzna x + z = kp_c (tył części pod blatem)
pad_tap = 2.5;             // otwór pod gwint M3
pad_xb = kp_c - pad_z;     // 35.6 — wejście osi popychacza w blok
pad_x1 = pad_xb + 9.0;     // 44.6 — przód bloku
pusher_len = 20;           // M3×20 ISO 4026
edge_set = 0.0;            // [A] na z −9.5 ściana praktycznie na front_x (GrabCAD: koniec zaokrąglenia z ≈ −10.4)
kn_len = pad_y - pad_w - 1.0 - kn_y0;    // 4.65 — gałka kończy się 1 mm przed słupkiem +y

// ---------- v0.6: ZAPADKI POCHYLENIA (wypustka na palcu męskim klatki ↔ rowki w zewnętrznym palcu żeńskim) ----------
// ODSTĘPSTWO od zlecenia (0/5/10/15/20 na r 5–6): na palcach Ø15 rowki co 5° nie mieszczą się. Rowek pod wypustkę
// r 0.5–0.7 ma ≥1 mm szerokości, a 5° na r 6.5 to 0.57 mm; osobne rowki co 5° wymagałyby r ≥ 14. Druga wypustka
// „z przesunięciem o 5°” też nie działa: każda wypustka poza rowkiem rozpiera dokręcony przegub. Dlatego: pozycje
// 0/10/20° (podziałka 10°, rowki 1.05 mm co 1.13 mm). 5/15° tylko po przedruku klatki z det_off = 5 (wtedy 5/15/25).
det_on = true;
det_pos = [0, 10, 20];     // [deg] pochylenie względem osi okularów (zero jak podziałka i ECHO), rowki idą za seat_pitch
det_off = 0;               // [deg] przesunięcie wypustki na klatce (5 → pozycje 5/15/25)
det_rho = 6.5;             // promień toru od osi M5 (krawędź wypustki r 7.0, tarcza 7.5)
det_ang = -90;             // [deg] wypustka pod osią (układ klatki, kąt od +x w stronę +z)
det_R = 0.7;               // promień kuli wypustki
det_h = 0.2;               // wysokość wypustki nad ścianą palca: ≤ 0.293·R → brzeg czaszy ≤45° od pionu (druk bez podpór)
det_fl = 40;               // [deg] zbocza rowka 40° do ściany (rowek 100°): w druku zbocze górne 40° od pionu
det_c = 0.02;              // luz kula ↔ zbocza
det_d = (det_R + det_c)/cos(det_fl) - (det_R - det_h);   // głębokość rowka (0.44)
det_w = det_d/tan(det_fl);                               // pół-szerokość rowka na ścianie (0.52)

// ---------- v0.6: PRZEWODY (decyzja 3: wyjście z tyłu u góry) ----------
// Oba przewody są na stałe w kamerach i wychodzą prosto do tyłu przez bucik. Termo: pod belką do x −18.3, w −y za
// tylnym końcem ścianki, w górę w zatrzaskowym kanale Ø3.2 w końcu belki −y (wejście 2.6 od boku) do poziomu Infra.
// Infra: nad belką do x −18.3, w −y. Razem od narożnika −y z tyłu u góry (poziom Infra) do tyłu → nad belką
// popychaczy do AI Boxa (prawy bok). Przegub (|y| ≤ 7.8, gałka po +y) i klamra kasku (|y| ≤ 7.8) zostają z boku.
// Kanał (zamiast pionu na zewnątrz ścianki, y −14.75) — przy tilt 20 pion wchodził w występ popychacza −y.
// [A] Ø3 ze zdjęcia zestawu → zmierzyć (S5).
cab_d = 3.0;  boot_l = 3.5;
cab_xb = cage_x0 - 1.9;                    // −18.3: zakręt przewodów (za ścianką, w obrysie belki w x)
cab_y = -(cage_y - 1.3);                   // −11.65: pion termo (kanał w końcu belki) i wyjście wiązki
cab_ch_r = 1.6;  cab_ch_open = 2.5;        // kanał Ø3.2, wejście 2.5 (zatrzask dla oplotu Ø3)

// ---------- v0.6: OSŁONA PRZEDNIA (z v0.5 M7, na klatkę v0.4) ----------
// Wnętrze osłony termo = strefa widzenia z CAŁEJ soczewki Ø16 (50 × 37.2°) + hood_m; tuba Infra Ø20 (szkło Ø19 + 0.5).
// ODSTĘPSTWO: osłona termo kończy się w tej samej płaszczyźnie co tuba Infra (x 18.55, 0.55 mm za szkłem Infra), czyli
// 11.25 mm przed szkłem termo (zlecenie: ≈5.3). Osłonę drukuje się przodem w dół, więc przód osłony termo musi leżeć na
// stole razem z tubą. Ścianki rozchylają się razem ze strefą widzenia, więc dłuższa osłona nie wchodzi w pole widzenia.
hood_m = 0.5;  hood_t = 1.6;  tube_t = 1.6;
th_ap = th_lens_d/2;                       // NAJGORSZY PRZYPADEK: apertura = cała soczewka Ø16
sh_x0 = 0.05;                              // tył osłony (w rzeczywistości oparty o czoła kamer i klatki)
sh_x1 = ir_lens_len - 0.55;                // 18.55 — przód osłony i tuby (stół w druku)
sh_t = 0.8;                                // ramka z tyłu
sh_sf = 6.0;                               // lejek ≤45° ramka → szyjka termo / tuba (narożnik ramki 4.8 mm od szyjki na 5.2)
sh_bore = th_lens_d/2 + 0.3;               // otwór na obiektyw termo (r 8.3)
neck_r = sh_bore + hood_t;                 // 9.9
tube_ri = ir_lens_d/2 + 0.5;               // 10.0
tube_ro = tube_ri + tube_t;                // 11.6
tab_t = 1.2;  tab_hz = 3.8;  tab_back = 2.6;   // języki pod łby M2: grubość, pół-wysokość, zapas za szczeliną
tab_gap = 0.05;                            // języki na ściankach bocznych (styk)
sh_yo = cage_y + tab_gap + tab_t;          // 14.2
drain_sill = 0.6;                          // odpływ w dnie osłony kończy się 0.6 przed czołem (pierwsze warstwy = pierścień)

// ======================================================================
module rbox(p0, p1, r=1) {   // prostopadłościan z zaokrągleniem w XZ (oś y bez zaokrągleń)
  hull() for (x=[p0[0]+r, p1[0]-r], z=[p0[2]+r, p1[2]-r])
    translate([x, p0[1], z]) rotate([-90,0,0]) cylinder(r=r, h=p1[1]-p0[1]);
}
function circ(r) = r / cos(180 / $fn);   // promień opisany (strefy widzenia: wielokąt nie może być mniejszy od koła)

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

// strefy widzenia (układ klatki): termo z całej soczewki Ø16, m = margines; Infra z całego szkła Ø19
module th_keepout(L = 300, m = 0, x0 = th_lens_len) hull() {
  translate([x0, 0, 0]) rotate([0, 90, 0]) cylinder(r = circ(th_ap + m), h = 0.01);
  translate([x0 + L, 0, 0]) cube([0.01, 2*(th_ap + m + L*tan(th_fov[0]/2)), 2*(th_ap + m + L*tan(th_fov[1]/2))], center = true);
}
module ir_keepout(L = 300, m = 0, x0 = ir_lens_len) infra_xf() translate([x0, 0, ir_z]) hull() {
  rotate([0, 90, 0]) cylinder(r = circ(ir_lens_d/2 + m), h = 0.01);
  translate([L, 0, 0]) cube([0.01, 2*(ir_lens_d/2 + m + L*tan(ir_fov[0]/2)), 2*(ir_lens_d/2 + m + L*tan(ir_fov[1]/2))], center = true);
}

// ---------------- KLATKA ----------------
module infra_xf() {   // korekta yaw Infra wokół osi pionowej przez środek przedniej ściany
  translate([0,0,ir_z]) rotate([0,0,ir_yaw_trim]) translate([0,0,-ir_z]) children();
}
module th_xf() { rotate([0,0,th_yaw_trim]) children(); }
// v0.6: wypustki zapadek na zewnętrznych ścianach palców męskich (czasza kuli R 0.7, wysokość 0.2); shift = przesunięcie
// na zewnątrz (test: 0.15 = palce dociśnięte, luz szczeliny skasowany)
module det_bumps(shift = 0) for (s = [-1, 1])
  translate([cage_axis_x + det_rho*cos(det_ang + det_off), s*(male_out - (det_R - det_h) + shift), axis_z + det_rho*sin(det_ang + det_off)])
    sphere(r = det_R, $fn = 24);
module cage(bumps = det_on) {
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
      if (bumps) det_bumps();
      // wskaźnik pochylenia: płetwa po −y czytana na podziałce na zewnętrznej ścianie występu nakrętki (v0.6: y −12.8;
      // grot sięga 0.5 za tę ścianę, r 7.7–8.2 → 0.2 mm za obrzeżem tarczy występu)
      hull() {
        translate([bx1 + 0.5, -cage_y, axis_z - 1]) cube([0.01, cage_y - fem_out - 0.3, 2]);
        translate([cage_axis_x + 7.7, -(fem_out + boss_len + 0.5), axis_z - 0.3]) cube([0.5, boss_len + 0.2, 0.6]);  // grot za obrzeżem tarczy
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
    // v0.6: zatrzaskowy kanał przewodu termo w końcu belki −y (łezka, grot −x = do góry w druku), wejście od −y
    translate([cab_xb, cab_y, bar_z0 - 1]) teardrop(2*cab_ch_r, bar_z1 - bar_z0 + 2);
    // wejście 2.5 od −y, tył wejścia równo z grotem łezki (w druku: płaski sufit 1.3 mm zakotwiony od środka belki)
    translate([cab_xb - cab_ch_r*sqrt(2), -cage_y - 1, bar_z0 - 1]) cube([cab_ch_open, cage_y + 1 + cab_y, bar_z1 - bar_z0 + 2]);
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

// v0.6: przewody (do testów i podglądu): buciki prosto do tyłu, zakręty, pion termo po −y, ogon wiązki 8 mm do tyłu
module cab_seg(a, b) hull() { translate(a) sphere(d = cab_d, $fn = 16); translate(b) sphere(d = cab_d, $fn = 16); }
module cables() {
  cab_seg([-th_body - 0.01, 0, 0], [cab_xb, 0, 0]);
  cab_seg([cab_xb, 0, 0], [cab_xb, cab_y, 0]);
  cab_seg([cab_xb, cab_y, 0], [cab_xb, cab_y, ir_z]);
  cab_seg([-ir_body - 0.01, 0, ir_z], [cab_xb, 0, ir_z]);
  cab_seg([cab_xb, 0, ir_z], [cab_xb, cab_y, ir_z]);
  cab_seg([cab_xb, cab_y, ir_z], [cab_xb - 8, cab_y, ir_z]);
}

// ---------------- v0.6: OSŁONA PRZEDNIA (układ klatki) ----------------
// Drukowana przodem w dół (x 18.55 = stół): lejek 45° od ramki z językami do szyjki termo i tuby Infra, osłona termo
// rozchyla się jak strefa widzenia (25°/18.6° ≤ 45°), tuba i daszek pionowo, języki rosną do góry z ramki.
module shroud_outer() {
  // dwie ramki z tyłu (y ±14.2 w obrysie języków, z ±tab_hz przy osi termo i osi Infra) + lejki do szyjki i do tuby.
  // Osobno, bo jedna ramka nad przewężeniem między szyjką a tubą dawała w druku płaski nawis 22 × 11 mm.
  for (c = [[0, neck_r], [ir_z, tube_ro]]) hull() {
    translate([sh_x0, -sh_yo, c[0] - tab_hz]) cube([sh_t, 2*sh_yo, 2*tab_hz]);
    translate([sh_x0 + sh_sf, 0, c[0]]) rotate([0, 90, 0]) cylinder(r = c[1], h = eps);
  }
  // szyjka termo do soczewki, osłona (strefa + hood_m + hood_t), tuba Infra
  translate([sh_x0, 0, 0]) rotate([0, 90, 0]) cylinder(r = neck_r, h = th_lens_len - sh_x0 + eps);
  intersection() { th_keepout(300, hood_m + hood_t); translate([0, -50, -50]) cube([sh_x1, 100, 100]); }
  translate([sh_x0, 0, ir_z]) rotate([0, 90, 0]) cylinder(r = tube_ro, h = sh_x1 - sh_x0);
  // daszek 16 × 1.6 nad tubą (do płaszczyzny czoła; z czoła ≥0.55 za szkłem Infra → poza polem widzenia)
  translate([sh_x0 + sh_sf, -8, ir_z + tube_ro - 0.5]) cube([sh_x1 - sh_x0 - sh_sf, 16, 1.6]);
  // mostek szyjka → tuba (szczelina 0.5 między szyjką Ø19.8 a tubą)
  translate([sh_x0 + sh_sf - 0.5, -0.8, neck_r - 1]) cube([5.5, 1.6, ir_z - tube_ro - neck_r + 2.5]);
  // języki pod łby śrub M2 kamer: na zewnątrz ścianek bocznych, szczeliny jak w klatce
  for (s = [-1, 1], c = [[th_screw_x, 0], [ir_screw_x, ir_z]])
    translate([c[0] - slot_len/2 - tab_back, s > 0 ? cage_y + tab_gap : -sh_yo, c[1] - tab_hz])
      cube([sh_x0 + sh_t - (c[0] - slot_len/2 - tab_back), tab_t, 2*tab_hz]);
}
module shroud() {
  difference() {
    shroud_outer();
    // obiektyw termo: otwór r 8.3, fazka 45° do wnętrza osłony, strefa widzenia + hood_m
    translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(r = sh_bore, h = th_lens_len + 1 + eps);
    hull() {
      translate([th_lens_len - (circ(th_ap + hood_m) - sh_bore) - 0.03, 0, 0]) rotate([0, 90, 0]) cylinder(r = sh_bore, h = eps);
      translate([th_lens_len, 0, 0]) rotate([0, 90, 0]) cylinder(r = circ(th_ap + hood_m), h = eps);
    }
    th_keepout(40, hood_m);
    // obiektyw Infra (Ø19) w tubie Ø20, strefa Infra (z całego szkła) od szkła
    translate([-1, 0, ir_z]) rotate([0, 90, 0]) cylinder(r = tube_ri, h = sh_x1 + 2);
    ir_keepout(40, 0);
    // nic przed czołem
    translate([sh_x1, -50, -50]) cube([50, 100, 100]);
    // szczeliny M2 w językach (łezka: grot −x = do góry w druku)
    for (s = [-1, 1], c = [[th_screw_x, 0], [ir_screw_x, ir_z]])
      hull() for (dx = [-slot_len/2, slot_len/2]) translate([c[0] + dx, -sh_yo - 1, c[1]]) rotate([-90, 0, 0]) teardrop(m2_d, 2*sh_yo + 2);
    // odpływ 2 × 2 w dnie osłony termo, koniec ostrołukowy 45°, kończy się drain_sill przed czołem
    hull() {
      translate([th_lens_len + 1.2, -1, -25]) cube([sh_x1 - drain_sill - th_lens_len - 1.2, 2, 17]);
      translate([th_lens_len + 0.2, -eps, -25]) cube([eps, 2*eps, 17]);
    }
  }
}

// ---------------- ADAPTER NA GNIEŹDZIE WENTYLATORA (góra gogli) ----------------
// v0.6: transformacja układu klatki → układ adaptera dla pochylenia t (względem adaptera)
module at_hinge(t = tilt) translate([adapter_axis_x, 0, adapter_axis_z]) rotate([0, t, 0]) translate([-cage_axis_x, 0, -axis_z]) children();
// v0.6: rowek zapadki w układzie klatki, przy wypustce strony s (ściana żeńska y = s*fem_in): V 100° promieniowo r 5.3–8.5
module det_groove(s) translate([cage_axis_x, s*fem_in, axis_z]) rotate([0, -(det_ang + det_off), 0])
  translate([det_rho - 1.2, 0, 0]) rotate([0, 90, 0]) linear_extrude(3.2)
    polygon([[-det_w - 0.3*det_w/det_d, -s*0.3], [det_w + 0.3*det_w/det_d, -s*0.3], [0, s*det_d]]);
// v0.6: belka nad przegubem, słupki, ukośne podpory i bloki popychaczy — część adaptera PRZED bezpiecznikiem
module hs_xz(c, sgn) multmatrix([[1, 0, -1, c], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])   // sgn>0: x + z ≥ c, sgn<0: x + z ≤ c
  translate([sgn > 0 ? 0 : -100, -50, -50]) cube([100, 100, 100]);
module brow() {
  // tył skośny 45°: x ≥ br_x0 + max(0, |y| − fem_out, z − root_h) (pochylenia w druku tyłem w dół)
  module rear45() intersection() {
    translate([br_x0, -50, -50]) cube([100, 100, 100]);
    // (dwie półprzestrzenie osobno: for wewnątrz intersection() dałby ich sumę)
    multmatrix([[1,  1, 0, br_x0 - fem_out], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) translate([0, -50, -50]) cube([100, 100, 100]);   // x ≥ br_x0 + y − fem_out
    multmatrix([[1, -1, 0, br_x0 - fem_out], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) translate([0, -50, -50]) cube([100, 100, 100]);   // x ≥ br_x0 − y − fem_out
    multmatrix([[1, 0, 1, br_x0 - root_h], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) translate([0, -50, -50]) cube([100, 100, 100]);    // x ≥ br_x0 + z − root_h
  }
  intersection() {
    rear45();
    union() {
      // belka nad przegubem (z 9–13, nad gałką i nad palcami żeńskimi)
      translate([0, -(pad_y + pad_w), br_z0]) cube([br_x1, 2*(pad_y + pad_w), br_z1 - br_z0]);
      // nad blokiem i występem nakrętki (−y): od z 8.0 (zachodzi na blok 8.5) do przodu bloku
      translate([0, -(fem_out + boss_len), root_h - 0.5]) cube([root_x1, fem_out + boss_len + fem_out, br_z0 - root_h + 0.5 + eps]);
      for (s = [-1, 1]) {
        y0 = s > 0 ? pad_y - pad_w : -(pad_y + pad_w);
        // słupek nad blatem
        translate([0, y0, deck_relief]) cube([br_x1, 2*pad_w, br_z1 - deck_relief]);
        // pod blatem: ukośna podpora + blok popychacza, oba za płaszczyzną x + z ≥ kp_c
        intersection() {
          translate([0, y0, pad_zb]) cube([pad_x1, 2*pad_w, deck_relief - pad_zb + eps]);
          hs_xz(kp_c, 1);
          union() {
            hs_xz(kp_c + strut_w, -1);
            translate([0, y0, pad_zb]) cube([pad_x1, 2*pad_w, pad_zt - pad_zb]);
          }
        }
      }
    }
  }
}
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
      // v0.6: występ na nakrętkę M5 po −y (gałka po +y), zrośnięty z blokiem — lustro występu v0.4
      mirror([0, 1, 0]) hull() {
        translate([adapter_axis_x, fem_out - 0.01, adapter_axis_z]) rotate([-90,0,0]) cylinder(d=gp_od, h=boss_len);
        translate([boss_x0, fem_out - 0.01, 0]) cube([root_x1 - boss_x0, boss_len, root_h]);
        translate([boss_x0 - boss_len, fem_out - 0.01, 0]) cube([0.01, 0.01, root_h]);   // spód występu 45° (druk bez podpór)
      }
      // v0.6: belka i występy popychaczy
      brow();
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
    // pułapka na nakrętkę M5 w występie −y: dno 0.6 mm → nakrętka dociska nogę żeńską, nie męską.
    // v0.6: wsuwana ukośnie (45° do przodu-góry) w płaszczyźnie występu — prosto wzdłuż y zasłania ją ukośna podpora
    // popychacza −y. Płaskie ścianki wzdłuż drogi trzymają nakrętkę przed obrotem; w druku sufit 45°, reszta to podłogi;
    // droga omija podziałkę (0…−20°). Nakrętkę wkłada się przed założeniem klatki.
    translate([adapter_axis_x, -(fem_out + 0.6), adapter_axis_z]) rotate([90,0,0]) rotate([0, 0, 45]) hull() {
      cylinder(d=gp_nut_af/cos(30), h=boss_len + 1, $fn=6);      // wierzchołek wzdłuż drogi wsuwania
      translate([12, 0, 0]) cylinder(d=gp_nut_af/cos(30), h=boss_len + 1, $fn=6);
    }
    // v0.6: podziałka na zewnętrznej ścianie występu −y (y −12.8): kreski 0.6 × 0.6 tylko na pozycjach zapadek
    // (10° dłuższa); zero = oś okularów (za seat_pitch); czytana grotem płetwy klatki
    for (t = det_pos) translate([adapter_axis_x, -(fem_out + boss_len) - 0.01, adapter_axis_z]) rotate([0, t - seat_pitch, 0])
      translate([t == 10 ? 5.8 : 6.2, -0.01, -0.3]) cube([t == 10 ? 1.6 : 1.2, 0.62, 0.6]);
    // v0.6: rowki zapadek w zewnętrznych palcach żeńskich, po jednym na pozycję (położenie wypustki klatki przy tym tilt)
    if (det_on) for (t = det_pos, s = [-1, 1]) at_hinge(t - seat_pitch) det_groove(s);
    // nic poniżej blatu za keep_x (gogle przy najgorszym front_x + 1 mm; v0.4: +0.5)
    translate([-seat/2 - 1, -30, -30]) cube([seat/2 + 1 + keep_x, 60, 30]);
    // odciążenie spodu bloku przed płytką → jedyną bazą jest gniazdo 25x25
    translate([seat/2, -30, -1]) cube([keep_x - seat/2, 60, 1 + deck_relief]);
    // bezpiecznik: rowki V 45° z obu boków bloku → rdzeń fuse_core (y) x root_h (z) w płaszczyźnie warstwy
    for (s=[-1,1]) translate([0,0,-1]) linear_extrude(root_h + 2) polygon([
      [fuse_x - (fem_out - fuse_core/2) - 0.02, s*(fem_out + 0.02)],
      [fuse_x + (fem_out - fuse_core/2) + 0.02, s*(fem_out + 0.02)],
      [fuse_x, s*fuse_core/2]]);
    // v0.6: gwinty popychaczy M3 (Ø2.5) wzdłuż x
    for (s = [-1, 1]) translate([keep_x - 1, s*pad_y, pad_z]) rotate([0, 90, 0]) cylinder(d = pad_tap, h = pad_x1 - keep_x + 2, $fn = 24);
  }
}

// ---------------- v0.6: GAŁKA ----------------
module knob_local() {   // oś = z lokalne, z = 0 = czoło przy podkładce, z = kn_len = wierzch (stół w druku)
  difference() {
    union() {
      cylinder(d1 = kn_d - 1.0, d2 = kn_d, h = 0.5);
      translate([0, 0, 0.5]) cylinder(d = kn_d, h = kn_len - 1.0);
      translate([0, 0, kn_len - 0.5]) cylinder(d1 = kn_d, d2 = kn_d - 0.8, h = 0.5);   // fazka przy stole (stopa słonia)
    }
    for (i = [0 : kn_flutes - 1]) rotate([0, 0, i*360/kn_flutes]) translate([kn_d/2 + 0.3, 0, -1]) cylinder(r = kn_flute_r, h = kn_len + 2, $fn = 24);
    translate([0, 0, -1]) cylinder(d = kn_af/cos(30), h = kn_pocket + 1, $fn = 6);   // gniazdo łba M5 (otwarte do czoła)
    translate([0, 0, -1]) cylinder(d = 3.0, h = kn_len + 2, $fn = 16);   // przelot Ø3: łeb wypycha się od zewnątrz
  }
}
module knob() translate([adapter_axis_x, kn_y0, adapter_axis_z]) rotate([-90, 0, 0]) knob_local();
// śruba M5×20 ISO 4017 + podkładka (+y) + nakrętka (−y) — do testów i podglądu
module m5_hw() translate([adapter_axis_x, 0, adapter_axis_z]) {
  translate([0, fem_out, 0]) rotate([-90, 0, 0]) cylinder(d = washer_d, h = washer_t);
  translate([0, fem_out + washer_t, 0]) rotate([-90, 0, 0]) cylinder(d = m5_af/cos(30), h = m5_k, $fn = 6);
  translate([0, fem_out + washer_t - m5_len, 0]) rotate([-90, 0, 0]) cylinder(d = 5, h = m5_len);
  translate([0, -(fem_out + 0.6), 0]) rotate([90, 0, 0]) cylinder(d = 8.0/cos(30), h = 4.0, $fn = 6);
}
// popychacze M3×20 oparte o ścianę na wx (płaska ściana) — do testów i podglądu
module pushers(wx = front_x) for (s = [-1, 1]) translate([wx, s*pad_y, pad_z]) rotate([0, 90, 0]) cylinder(d = 3, h = pusher_len, $fn = 24);
// droga klucza imbusowego 1.5 (walec Ø2.0) wzdłuż osi popychaczy od występu do x 80
module keypaths() for (s = [-1, 1]) translate([pad_xb + 1, s*pad_y, pad_z]) rotate([0, 90, 0]) cylinder(d = 2.0, h = 80 - pad_xb - 1, $fn = 16);

// ---------------- GHOST: kamery, gogle, pola widzenia ----------------
module ghost_cams() {
  color("dimgray") cam_thermal(0);
  color("gray") cam_infra(0);
}
module fov_thermal(len=60) {   // 50° H x 37.2° V (podgląd)
  color("orange", 0.15) th_keepout(len);
}
module hdo2_ghost() {          // [A] gogle jako bryła: przód na x=front_x, blat na z=0, oś okularów na z=-seat_above_eye
  color("black", 0.25) translate([front_x - 80, -169.2/2, -45.5]) cube([80, 169.2, 45.5]);
  color("red", 0.6) for (s=[-1,1]) translate([front_x - 30, s*30, -seat_above_eye]) rotate([0,90,0]) cylinder(d=6, h=30.2);
}

// ======================================================================
// ECHO
// wysokość środka przedniej soczewki termo / Infra nad osią okularów dla pochylenia t (względem adaptera)
function lens_z(t, xl, zl) = seat_above_eye
   + (-adapter_axis_x * sin(seat_pitch) + adapter_axis_z * cos(seat_pitch))
   + (-(xl - cage_axis_x) * sin(t + seat_pitch) + (zl - axis_z) * cos(t + seat_pitch));
for (T = [0, 10, 20]) echo(str("tilt ", T, "° (wzgl. osi okularów): termo ", round(lens_z(T - seat_pitch, th_lens_len, 0)*10)/10,
   " mm, Infra ", round(lens_z(T - seat_pitch, ir_lens_len, ir_z)*10)/10, " mm nad osią okularów (cel 0…+35)"));
// zapadki — [calc], μ i τ założone; rozstrzyga próbka (coupon: waga bagażowa na klatce)
F_m5 = 0.3/(0.2*0.005);                    // [N] M5 ręką ≤0.3 N·m, K = 0.2 → ≈300 N
r_fr = 2/3*(pow(gp_od/2, 3) - pow(gp_hole/2, 3))/(pow(gp_od/2, 2) - pow(gp_hole/2, 2));   // średni promień tarcia tarczy
T_fr = [4*0.2*F_m5*r_fr/1000, 4*0.35*F_m5*r_fr/1000];   // 4 styki palców, μ 0.2 (założenie v0.4) … 0.35
A_b = PI*(pow(det_R, 2) - pow(det_R - det_h, 2));       // podstawa wypustki
T_det = [2*20*A_b*det_rho/1000, 2*35*A_b*det_rho/1000]; // 2 wypustki ścinane (τ 20–35 MPa) na r det_rho
echo(str("zapadki: rowki ", 2*round(det_w*100)/100, " mm co ", round(det_rho*PI/18*100)/100, " mm (10° na r ", det_rho,
   "), głęb. ", round(det_d*100)/100, ", wypustka ", det_h, " × Ø", round(2*sqrt(pow(det_R,2) - pow(det_R-det_h,2))*100)/100,
   "; pozycje ", det_pos, (2*det_w < det_rho*PI/18) ? " (OK)" : " (ROWKI NA SIEBIE!)"));
echo(str("poślizg przegubu przy M5 ≤0.3 N·m (", F_m5, " N): tarcie ", round(T_fr[0]*100)/100, "–", round(T_fr[1]*100)/100,
   " N·m (μ 0.2–0.35) + zapadki ", round(T_det[0]*100)/100, "–", round(T_det[1]*100)/100,
   " N·m (ścięcie 2 wypustek; przy dokręconej M5 nie wysuną się sprężyście) = ", round((T_fr[0]+T_det[0])*100)/100, "–",
   round((T_fr[1]+T_det[1])*100)/100, " N·m wobec bezpiecznika ≈2.6 N·m"));
// popychacze
echo(str("popychacze M3×", pusher_len, " na y ±", pad_y, ", z ", pad_z, ": wejście w występ x ", pad_xb, "; wysuw (płaska ściana) ",
   pad_xb - front_x - front_tol, "–", pad_xb - front_x + front_tol, ", z krawędzią wg GrabCAD ", pad_xb - front_x - front_tol + edge_set,
   "–", pad_xb - front_x + front_tol + edge_set, " mm; wkręcenie ≥ ", min(pad_x1 - pad_xb, pusher_len - (pad_xb - front_x + front_tol + edge_set)),
   " mm (gwint ", pad_x1 - pad_xb, ")"));
echo(str("popychacze (para: jeden +n, drugi −n obrotu; obrót wokół środka gniazda): 1 obrót = ", round(atan(0.5/pad_y)*100)/100,
   "°, 1/8 = ", round(atan(0.5/8/pad_y)*100)/100, "°; piksel termo ≈ 0.20°; zakres = luz śrub wentylatora (±0.6–1.6°)"));
echo(str("M5×", m5_len, ": wkręcenie w nakrętkę ", m5_len - washer_t - 2*fem_out - 0.6, " mm z 4.0; gałka Ø", kn_d, " y ", kn_y0, "–",
   kn_y0 + kn_len, " (tył x ", adapter_axis_x - kn_d/2, ", do słupka +y ", pad_y - pad_w - kn_y0 - kn_len, " mm)"));

module assembly() {
  hdo2_ghost();
  rotate([0, seat_pitch, 0]) {
    color("steelblue") adapter_top();
    color("darkorange") knob();
    color("silver") { m5_hw(); pushers(); }
    // klatka: oś przegubu klatki pokrywa się z osią adaptera, obrót o tilt w dół
    at_hinge(tilt) {
      color("gold") cage();
      color("olivedrab") shroud();
      ghost_cams();
      color("black") cables();
      fov_thermal();
    }
  }
}

// ---------------- PRÓBKA dopasowania przegubu (drukować najpierw, research/06 M8) ----------------
// 3 pary (żeńska 3 nogi + męska 2 nogi) ze szczeliną 3.2 / 3.3 / 3.4 (wybita na podstawie).
// Druk jak części: nogi pionowo, oś M5 pozioma, 4 obwody. Wybierz parę, która składa się ręką bez luzu → gp_slit.
// v0.6: + próbka zapadek — wycinek adaptera (3 palce żeńskie z rowkami, pułapka nakrętki, podziałka) i wycinek klatki
// (2 palce męskie z wypustkami, kawałek belki), w orientacjach jak części. Z gałką i M5×20: klik na 0/10/20, moment
// poślizgu (waga bagażowa na wycinku klatki), czy wypustka się ścina / rozgniata rowek.
coupon_ax = 9.5;
module coupon_leg_set(ys, base_w) {
  translate([-9, -base_w/2, 0]) cube([18, base_w, 2]);
  for (yc = ys) hull() {
    translate([-6, yc - gp_leg/2, 0]) cube([12, gp_leg, 2]);
    translate([0, yc - gp_leg/2, coupon_ax]) rotate([-90,0,0]) cylinder(d=gp_od, h=gp_leg);
  }
}
cpd_ax = 22.0;   // cięcie wycinka adaptera (x)
cpm_ax = -17.0;  // cięcie wycinka klatki (x)
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
  // v0.6: wycinki z zapadkami (jak print_adapter: x do góry; jak print_cage: przodem w dół)
  translate([0, 50, 0]) rotate([0, -90, 0]) translate([-cpd_ax, 0, 0])
    intersection() { adapter_top(); translate([cpd_ax, -(fem_out + boss_len + 0.5), -9]) cube([20, 2*(fem_out + boss_len) + 1, root_h - 0.6 + 9]); }
  translate([38, 50, 0]) rotate([0, 90, 0]) translate([-cpm_ax, 0, -axis_z])
    intersection() { cage(); translate([cpm_ax - 25, -(male_out + 0.5), axis_z - 8.5]) cube([25, 2*male_out + 1, 17]); }
}

// ---------------- orientacje do druku (PETG, MK4) ----------------
// klatka PRZODEM W DÓŁ (x=0 na stole): ścianki kieszeni pionowe i dokładne, nogi GoPro rosną jako płetwy
// bez podpór (przegląd print/fit-06). BEZ brimu (brim zalałby kieszenie i szczeliny). 4 obwody.
module print_cage() { rotate([0,90,0]) cage(); }
// adapter TYŁEM W DÓŁ (tylna krawędź płytki x=-seat/2 na stole): nogi rosną do góry jako płetwy, podziałka na
// pionowej ścianie, belka i występy popychaczy ze skosami 45°, bez podpór. Brim 5 mm (zewnętrzny). 4 obwody.
module print_adapter() { translate([0,0,seat/2]) rotate([0,-90,0]) adapter_top(); }
// v0.6: osłona PRZODEM W DÓŁ (x 18.55 na stole), brim 5 mm zewnętrzny, 4 obwody
module print_shroud() { translate([0, 0, sh_x1]) rotate([0, 90, 0]) shroud(); }
// v0.6: gałka wierzchem w dół, gniazdo łba otwarte do góry
module print_knob() { translate([0, 0, kn_len]) mirror([0, 0, 1]) knob_local(); }

if (part == "cage") cage();
else if (part == "adapter_top") adapter_top();
else if (part == "shroud") shroud();
else if (part == "knob") knob();
else if (part == "print_cage") print_cage();
else if (part == "print_adapter") print_adapter();
else if (part == "print_shroud") print_shroud();
else if (part == "print_knob") print_knob();
else if (part == "coupon") coupon();
else if (part == "none") { }   // do użycia przez include (testy kolizji)
else assembly();
