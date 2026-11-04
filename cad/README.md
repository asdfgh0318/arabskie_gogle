# cad/ — części drukowane

## camera_mount.scad — mocowanie kamer i gogli do kasku na HDO2 (v0.4, WERSJA ROBOCZA)
Po dwóch przeglądach adwersarialnych. **Nic nie zostało zmierzone na sprzęcie**: kamery z rysunków sklepu,
HDO2 ze zdjęć i modeli społeczności (`research/06`). Gotowe STL (PETG, Prusa MK4, w orientacji do druku) w `stl/`.

| Część | Plik | Druk |
|---|---|---|
| Próbka przegubu (drukować **najpierw**) | `stl/coupon.stl` | 3 pary 3.2/3.3/3.4; 4 obwody; para, która składa się ręką bez luzu → `gp_slit` |
| Klatka na kamery | `stl/print_cage.stl` | przodem w dół, **bez brimu**, bez podpór, 4 obwody |
| Adapter na gnieździe wentylatora (kamera z przodu + przegub do kasku nad płytką) | `stl/print_adapter.stl` | tyłem w dół (stoi, 54 mm), brim 5 mm (zewnętrzny), bez podpór, 4 obwody; ≈47 min, 6,7 g |

```
openscad -D 'part="assembly"' -D tilt=10 camera_mount.scad   # podgląd; ECHO = wysokości obiektywów nad osią okularów
./test/run_clash.sh                                          # kolizje: tilt 0/10/20 × przód gogli 21.6/23.1/24.6 (ostatni wynik: OK)
```

### Montaż
1. Zdejmij osłonę i wentylator z **góry** gogli. Adapter na 4 śruby **fabryczne** (pod łbem 1.2 mm = kołnierz
   osłony). Zanim kupisz inne śruby: zmierz śrubę i to, co jest pod wentylatorem (research/06 M1/M2).
2. Kamery wsuń od przodu (przewód wkładasz z boku przez szczelinę w mostku), dosuń do tylnych zderzaków.
   Najpierw dokręć M2 po stronie **+y (lewej)** — korpus dociąga się do ścianki, która jest bazą kierunku — potem −y.
3. Przegub: **M5×20 ISO 4762 + podkładka DIN 125 (Ø10 — większa zakryje podziałkę)** od strony −y, nakrętka M5
   w pułapce (+y). Dokręcaj **ręcznie** (≤0.3 N·m). **Przed zmianą pochylenia poluzuj M5.**
4. Podziałka (−y): kreski 0/10/20°, nacięcia 5/15°, czytane grotem płetwy klatki. Zero i wysokości z ECHO są
   liczone względem blatu, dopóki nie zmierzysz `seat_pitch` (M4).
5. **Kask (v0.4):** na przodzie kasku przyklej podstawkę GoPro VHB, w nią klamrę 3-palcową. Wchodzi w dwie męskie
   nogi na adapterze (oś M5 poprzeczna, nad płytką, `helm_x`/`helm_z`). Gogle wiszą na kasku i obracają się w
   pionie na tym przegubie. Pasek gogli tylko dociska je do twarzy. Jeśli klamra nie sięga, wstaw przedłużkę GoPro.
   Obciążenie z kasku idzie blokiem i płytką na 4 śruby wentylatora, **nie** przez bezpiecznik kamery.
   Nogi drukują się na stole razem z resztą adaptera (tył płytki = stół).
6. Zbieżność: cel ciepły z 10 m, adapter przekręć w luzie otworów i dokręć; resztę → `th_yaw_trim` / `ir_yaw_trim`
   (krok 0.25°, przedruk klatki).

### Bezpieczeństwo (kolejność zniszczenia)
poślizg przegubu (≈1.3 N·m przy dokręceniu ręcznym) → **bezpiecznik w adapterze** (przewężenie 10×8 mm za
przednimi śrubami, ≈2.6 N·m zginania) → nogi klatki (≈5 N·m). Gniazda śrub w goglach: wytrzymałość nieznana.
Wartości wyliczone (PETG ~25 MPa międzywarstwowo), nie zmierzone.

### Wysokość obiektywów nad osią okularów (`seat_above_eye` = 23, nie zmierzone; cel research/01: 0…+35)
| tilt | termo | Infra |
|---|---|---|
| 0° | 12.4 | 33.9 |
| 10° | 6.1 | 25.2 |
| 20° | 0.3 | 16.5 |

Przy `seat_above_eye` z zakresu 19–29 obie liczby przesuwają się o tyle samo → po pomiarze M5 ustaw
`axis_rel_seat`, żeby wrócić do tabeli. Klatka **nie** jest gwarantowanie zgodna z fabryczną klamrą GoPro.

**Do zmierzenia (kask, v0.4):**
- **H1**: przy goglach założonych z kaskiem: odległość od środka gniazda wentylatora do miejsca na podstawkę VHB na
  kasku (w przód/tył i w górę).
- **H2**: którędy klamra wychodzi z podstawki (w dół czy do przodu).
- **H3**: wysokość ramki twarzy tuż za gniazdem.

Z tych pomiarów wyjdzie `helm_z` i ewentualna przedłużka.

**Do zmierzenia** (research/06 §3): M1 śruba, M2 pod wentylatorem (`post_relief`), M4 pochylenie blatu
(`seat_pitch`), **M5 wysokość blatu nad osią okularów** (`seat_above_eye`), M6 środek wentylatora → przód
(`front_x`), kamery suwmiarką (`th_*`, `ir_*`, położenie otworów M2, średnica przewodu → `cable_slot_w`).

---

## tactical_mount.scad — v0.5 PANCERZ+ (WERSJA ROBOCZA po przeglądzie R1, decyzje do akceptacji)

Implementacja punktów MUST (M1–M10) ze specyfikacji `spec/v05_tactical_spec.md` plus poprawki z przeglądu
adwersarialnego R1 (lista niżej). Gdzie ten opis różni się od `tactical_mount.scad`, rozstrzyga plik `.scad`. Gdzie
plik `.scad` różni się od specyfikacji, jest to opisane w kodzie (szukaj `ODSTĘPSTWO` i `PRZEGLĄD`) i zebrane niżej.
**Specyfikacja nie była poprawiana** — jej błędy wykryte w przeglądzie są w „Erraty specyfikacji”.
**v0.4 (`camera_mount.scad`) zostaje bez zmian jako wersja zapasowa.**
Nic nie zostało zmierzone na sprzęcie: wymiary kamer pochodzą z rysunków i zdjęć, wymiary HDO2 z research/06.

**Co się zmienia względem v0.4:**
- **Kierunek (yaw) trzymają kształtem dwa popychacze** M3 w ramionach, oparte o przednią ścianę gogli. Ogranicznikiem
  +x jest stalowy kołek. Luz otworów śrub wentylatora (±0,6–1,6°) nie wpływa już na kierunek.
  Zbieżność ustawia się w terenie, bez przedruku. `th_yaw_trim` usunięty.
- **Pochylenie na czopie z tarciem po obu stronach:** gałka M4 po lewej (+y, lewa ręka), stała śruba M3 po prawej.
  Podziałka jest na ściance −y, wskaźnik na prawym ramieniu.
- **Bezpiecznik:** śruba PA66 M2.5 w szczelinie wzdłuż x przenosi tylko moment pochylający. Docisk popychaczy idzie
  w stal. Po ścięciu FORK obraca się na stalowym kołku (ogon języka to łuk wokół kołka).
- **Kamery wkłada się od tyłu** do klatki-skorupy, z przewodami. Z przodu jest osłona termo z marginesem do pełnej
  soczewki Ø16 oraz tuba Infra 0,5 mm za szkłem.

### Części
| Część | Plik STL | Druk (PETG, MK4, 0,2 mm, 15% infill, **bez podpór**) | Czas / masa (PrusaSlicer) |
|---|---|---|---|
| Próbka przegubu kasku (v0.4, **najpierw**) | `stl/tac_coupon.stl` | 3 pary 3.2/3.3/3.4 → `gp_slit`; 4 obwody | 66 min / 13,2 g |
| Próbka złącza (**najpierw**, M9) | `stl/tac_coupon_joint.stl` | 4 kawałki: wycinek BASE, język z belką do ucha 55 mm, występ popychacza, wycinek klatki U z bossami; 6 obwodów | 60 min / 14,1 g |
| BASE: płytka + blok widełek + nogi do kasku | `stl/tac_print_base.stl` | płytką w dół, bez brimu, **6 obwodów** (przy 4 PrusaSlicer zgłasza „Floating bridge anchors”) | 31 min / 5,9 g |
| FORK: język + czoło + ramiona + popychacze | `stl/tac_print_fork.stl` | górą czoła (z = 12) w dół, bez brimu, 4 obwody | 30 min / 5,0 g |
| CAGE: klatka z osłoną, tubą i uchem linki | `stl/tac_print_cage.stl` | czołem (x = 12.6) w dół, **brim 5 mm zewnętrzny**, 4 obwody, wysokość 41,5 mm | 66 min / 15,4 g (z brimem; 15,25 bez) |
| Akcesoria: tylna pokrywa + gałka | `stl/tac_print_acc.stl` | zewnętrzną stroną w dół, 4 obwody | 23 min / 4,1 g |

Komplet części nośnych i akcesoriów to **≈30,2 g** (bez brimu; 30,0 g przy BASE z 4 obwodami), a przy 2 obwodach
**≈26,1 g**. v0.4 przy 4 obwodach waży 18,2 g (patrz „Znane braki”).
Podgląd: `img/tac_assembly_iso.png` (tilt 10), `img/tac_side_t0.png`, `img/tac_side_t20.png` (widok z prawej, −y),
`img/tac_front.png` (tilt 10, z przodu, ze strefami widzenia).

**Elementy kupne:**
- kołek: stalowa **M3×16 ISO 7380**, łeb w pogłębieniu po +y, nakrętka M3 w kieszeni −y, Loctite 222;
- bezpiecznik: **PA66 M2.5×20 z łbem walcowym (DIN 84 / ISO 1207)** + stalowa nakrętka M2.5 (mieć zapas);
  blok BASE ma teraz 19 mm, więc ×16 nie sięga nakrętki;
- popychacze: 2× wkręt bez łba M3×10 ISO 4026 (płaski koniec) z nylonową końcówką albo naklejoną kropką PTFE Ø3×1;
- czop lewy: **M4×14 ISO 4017 z łatką nylonową (obowiązkowo)**, łeb wklejony w gałkę; między piastą a ramieniem
  podkładka PTFE 0,5 (Ø4,3/Ø8) + podkładka falista DIN 137B M4;
- czop prawy: M3×8 ISO 7380 + **podkładka PTFE 0,5 (Ø3,2/Ø7) pod łbem** + Loctite 222;
- wkładki wtapiane: M4 krótka (4 mm, Ø5,6) i M3 krótka (3 mm, Ø4,0); za wkładką jest otwór przelotowy do wnęki;
- pokrywa: 2× M2×5 (EVA już niepotrzebna: Infra trzymają 4 słupki pokrywy);
- linka: dyneema 1 mm, **wolna długość 75–85 mm** między wyjściami otworów, na końcach tulejka zaciskowa albo
  koralik zamiast samego węzła;
- gogle: 4 fabryczne śruby wentylatora.

```
openscad -D 'part="assembly"' -D tilt=10 tactical_mount.scad   # podgląd; ECHO: wysokości, śruby, momenty, linka
./test/run_tactical_clash.sh                                    # kolizje §4.1 + przypadki z przeglądu (~12 min przy FN=32, 8 wątków)
PROFILE=…/mk4_petg.ini ./test/export_tactical.sh               # eksport tac_*.stl + manifold + nawisy + wyspy + cięcie + G-code
```

### Montaż (M10, zmieniony po przeglądzie)
1. Przed założeniem FORK: wkręć oba popychacze **od strony ściany** (od tyłu występu) do oporu. Cofnięty do oporu
   popychacz wystaje 0,6 mm (koniec opiera się o stopień Ø3,4→Ø2,4 na x 35) i mieści się przed najgorszą ścianą (24,6).
   Wymiana końcówki popychacza wymaga zdjęcia FORK.
2. BASE na 4 fabryczne śruby wentylatora, na razie luźno.
3. Język FORK wsuń w gniazdo. Wkręć stalowy kołek M3×16 od +y (łeb w pogłębieniu, nakrętka w kieszeni −y, Loctite 222).
   Potem śrubę PA66 M2.5×20 od +y ze stalową nakrętką w pułapce −y, **dokręconą ręką (≈0,1 N·m)**.
4. Ustaw BASE prostopadle, używając popychaczy jako sprawdzianu: oba do dotknięcia ściany, liczba obrotów obu równa
   (±1/4 obrotu ≈ ±0,13 mm). Dokręć śruby wentylatora (przednie przez studzienki Ø5 — wkrętak Ø2,5 przechodzi, test).
5. Kamery włóż od tyłu z przewodami i dociśnij do przednich ramek. Dokręć M2 najpierw po stronie +y, potem −y.
   Oba przewody (bucik prosto do tyłu) połóż w wycięciu w ściance **−y z tyłu u góry** (poziom Infra), od tyłu.
6. Załóż pokrywę: słupki opierają się 0,3 mm za tyłem termo i tyłem Infra, środek zostaje wolny na buciki. Przykręć
   2× M2×5 przez ścianki boczne. Pokrywa zamyka wycięcie przewodów od tyłu.
7. Linka: przez otwór w BASE (x 1,5, z 7,5) i ucho na górze klatki (z tyłu), wolna długość 75–85 mm, tulejki.
   Ucho jest na zewnątrz, więc linkę można założyć w dowolnym momencie.
8. Klatkę załóż na czop: najpierw prawa M3×8 z podkładką PTFE (Loctite), potem gałka (M4×14 z łatką nylonową,
   PTFE + podkładka falista między piastą a ramieniem). Wkładki wtopić wcześniej 0,2 mm poniżej czoła bossa
   (mosiądz nie może trzeć o ramię).
9. Ustaw zbieżność i poziom horyzontu (niżej), namaluj linie kontrolne.

### Zbieżność (yaw) popychaczami
Rozstaw popychaczy to 35,5 mm, a obrót odbywa się wokół kołka. Przy procedurze „jeden wkręcany, drugi wykręcany o tyle
samo” **1 obrót każdym = 1,61°, 1/8 obrotu ≈ 0,20° ≈ 1 piksel termo, 1/16 ≈ 0,10°** (ECHO). Kręcenie tylko jednym
popychaczem nie obraca mocowania, tylko zwiększa docisk (kołek blokuje). Zakres ±2° (luz języka w gnieździe); ramię
ma ≥1 mm do najgorszej ściany, więc cały zakres ±2° jest wolny przy każdym `front_x` (test `fork_ghost` przy yaw ±2).
Klucz imbusowy 1,5 wchodzi od przodu wzdłuż osi popychacza; droga klucza jest wolna przy tilt −2…22 (test).
1. Popychacze cofnięte do oporu (krok 1 montażu).
2. Każdy wkręć do dotknięcia ściany gogli.
3. Wyceluj w ciepły cel z 10 m. **Najpierw wykręć jeden popychacz o n, potem wkręć drugi o n** (tylko kątem, nigdy
   „na czucie”). **Po każdej korekcie wyjmij klucz** (nacisk klucza przesuwa FORK, dłoń jest w polu termo) i dopiero
   wtedy oceń cel.
4. Poziom horyzontu: przy tilt 10 sprawdź poziom na obrazie i dociśnij czoło FORK do poziomu, zanim dasz docisk
   końcowy. Owalny otwór kołka ogranicza przechył FORK do ≈±1,2° (test `roll`).
5. Na koniec oba: dotyk + 1/8 obrotu (≈5–15 N [A]). **Nigdy nie dokręcaj „na czucie”:** 0,05 N·m na kluczu daje
   ≈55–65 N na popychacz, a 2·P·12 mm ≈ 1,3–1,6 N·m to już próg mokrego bezpiecznika. Dopuszczalne P ≤ 24 N/szt. (ECHO).
6. Namaluj linie kontrolne przez: popychacz i występ, złącze FORK/BASE, **łeb śruby PA66**, krawędź płytki i skorupę.
   Przerwana linia oznacza, że coś się przesunęło.

### Pochylenie
Pochylenie trzyma tarcie czoła boss/ramię (PETG/PETG; pod piastą gałki i pod łbem M3 jest PTFE, więc ślizgają się
czoła, nie gwinty): **T_slip ≈ 0,55–1,02 N·m** (ECHO, wyliczone). **Pochylenie zmienia się, obracając klatkę za boki
(para sił) albo przy poluzowanej gałce. Nigdy nie pchać obiektywu ani osłony:** soczewka termo jest 2,13× dalej od
kołka niż od czopu, więc pchnięcie do poślizgu daje na bezpieczniku 1,28–2,52 N·m, czyli więcej niż mokry próg 1,6.
Obrót za boki daje 0,67–1,38 N·m (z dociskiem popychaczy) — poniżej mokrego progu z czystego ścinania (1,6), ale
nie poniżej dolnej granicy ≈1,0 z liczenia na zginanie; jeśli próbka (a) to potwierdzi, trzeba zmniejszyć T_slip. Po wielu korektach „nos do góry” gałka może się poluzować —
sprawdzać. Podziałka 0/10/20° (kreska 10° dłuższa, rowki 0,6 × 0,6) jest na ściance −y i czyta się ją grotem na
prawym ramieniu; kresek 5/15° nie ma (za gęste do druku).

Wysokość obiektywów nad osią okularów (ECHO; cel 0…+35):

| `seat_above_eye` | tilt 0° termo / Infra | 10° | 20° |
|---|---|---|---|
| 19 | 8,0 / 29,3 | 3,5 / 23,4 | **−1,0** / 17,0 |
| **23** (nominalnie) | 12,0 / 33,3 | 7,5 / 27,4 | 3,0 / 21,0 |
| 29 | 18,0 / **39,3** | 13,5 / 33,4 | 9,0 / 27,0 |

**Bez pomiaru S1 cel jest spełniony w całym zakresie tilt 0–20 tylko dla `seat_above_eye` 20,0–24,8** (ECHO), czyli
na niecałe 5 mm z 10 mm niepewności. Po pomiarze M5: `piv_rel_seat = −11 − (pomiar − 23)` i przedruk tylko FORK (S1).

### Kolejność zniszczenia (§2.3 spec., wyliczone, NIE zmierzone — rozstrzyga próbka `coupon_joint`)
| Obciążenie kamer | 1. | 2. | Chronione |
|---|---|---|---|
| obiektyw w dół | poślizg czopu 0,55–1,02 N·m; klatka obraca się do styku z goglami (test: **67,5°** przy przodzie 24,6, z przewodami) | popychacze dociskają ścianę | śruby wentylatora |
| obiektyw w górę | klatka opiera się o czoło przy **−2,5°** (test) | **ścięcie PA66 ≈1,0–2,7 N·m** [calc: czyste ścinanie 1,6–1,9 mokra / 2,4–2,7 sucha; z luzem 0,4 i gniazdami V zginanie od ≈1,0] ≈ 18–49 N na obiektywie termo; potem **FORK obraca się na stalowym kołku, wolno do ≥45°** (test `hinge`) | przednie śruby wentylatora: 3,3× siła na obiektywie na parę, **≈81 N/szt. przy progu suchym** |
| w bok | przechył języka bierze stalowy kołek (owal, ±1,2°), potem nasady ramion pękają międzywarstwowo ≈140–280 N na osi czopu; klatka zostaje na lince | — | BASE: policzki 6,3 mm (×1,7); czy pękają po ramionach — tylko próba boczna |
| czołowo (−x) w osłonę | poślizg czopu dopiero przy 120–223 N; poniżej popychacze ściskają ścianę (≈1,9× siła) | brak bezpiecznika (tak samo we wszystkich koncepcjach) | — |
| czołowo w górę klatki przy tilt ≈0 | klatka opiera się o czoło | PA66 przy ≈100–170 N | śruby wentylatora |

Siła boczna przechodzi przez **jeden** popychacz na ścianę HDO2 (≈1,6× siła boczna) — wytrzymałość ściany nieznana (S2).

### Testy (wynik dla wersji w repo)
- `test/run_tactical_clash.sh` sprawdza 168 zadań OpenSCAD:
  - części vs bryła gogli przy przodzie 21,6 / 23,1 / 24,6; FORK też przy yaw ±2;
  - klatka+kamery+przewody+pokrywa vs gogle / FORK / BASE przy tilt −2/0/5/10/15/20/22;
  - gałka vs wszystko i droga klucza;
  - strefy widzenia: termo 50×37,2° z całej Ø16; Infra 96×72° i 108×92° z całego szkła Ø19 — **od 0,5 mm za
    soczewką/szkłem** (tolerancja długości obiektywów z rysunku);
  - język w gnieździe z łbami śrub złącza przy yaw 0/±2°; przechył języka na śrubach (±0,8° wolny);
    **obrót FORK na kołku po ścięciu PA66: 3…45° wolny** (FORK przesunięty −0,15 / +0,25 w luzie kołka);
  - kamery i pokrywa w klatce, wsuwanie kamer od tyłu na 45 mm; to samo i pola widzenia przy `ir_yaw_trim` ±2;
  - wkrętak Ø2,5 do przednich śrub wentylatora z założonym FORK; tarcze klamry GoPro kasku vs BASE;
  - kąty pierwszego styku (z przewodami);
  - pomiary: dostęp do śrub pokrywy, zakres obrotu korpusu klamry kasku;
  - model GrabCAD (`grabcad_check.py`, próbki powierzchni w bryłach części, FORK przy yaw 0/±2) i zasięg popychaczy
    do ściany GrabCAD (`pusher_reach.py`, tylko ostrzeżenia — S2).

  Kontrole pozytywne muszą trafić (trafiają):
  - osłona z `hood_m = −0.5` → pole termo; tuba 0,5 przed szkłem (`ir_tube_back = −0.5`) → pole Infra;
  - gogle z przodem na 26,5 → FORK; GrabCAD z przodem na 40 → FORK;
  - stary prostopadłościenny język (`tg_tail = false`) → BASE przy obrocie 6°;
  - przechył FORK ±2° → śruby złącza; wnęka 2,5 (`bay = 2.5`) → bucik przewodu Infra w pokrywie;
  - łeb kołka bez pogłębienia (`pin_cb_h = 0`) → wkrętak do przedniej śruby wentylatora.

  **Wynik (FN=32):**
  ```
  pomiar: śruby pokrywy dostępne wkrętakiem Ø2.5 z obu stron (bez gałki) przy tilt: 20 40
  pomiar: śruby pokrywy dostępne wkrętakiem Ø2.5 z obu stron (z gałką) przy tilt: żadnym z 0 20 40 60
  pomiar: korpus klamry GoPro kasku wolny (vs BASE/FORK/gałka/klatka tilt 10) przy kątach [°, 0 = do góry, + = do przodu]: -30 -15 0 15 30 45 60 75
  OSTRZEŻENIE S2: front_x 21.6, y +17.75, z -5.0: ściana x 20.13 (pochylenie 31° od pionu), wysuw 5.47, wkręcenie 4.53 (< 5)
  OSTRZEŻENIE S2: front_x 21.6, y -17.75, z -5.0: ściana x 20.13 (pochylenie 31° od pionu), wysuw 5.47, wkręcenie 4.53 (< 5)
  zasięg popychacza: front_x 23.1, y +17.75, z -5.0: ściana x 21.63 (pochylenie 31° od pionu), wysuw 3.97, wkręcenie 6.00
  zasięg popychacza: front_x 23.1, y -17.75, z -5.0: ściana x 21.63 (pochylenie 31° od pionu), wysuw 3.97, wkręcenie 6.00
  zasięg popychacza: front_x 24.6, y +17.75, z -5.0: ściana x 23.13 (pochylenie 31° od pionu), wysuw 2.47, wkręcenie 6.00
  zasięg popychacza: front_x 24.6, y -17.75, z -5.0: ściana x 23.13 (pochylenie 31° od pionu), wysuw 2.47, wkręcenie 6.00
  OK: brak kolizji (168 zadań OpenSCAD, $fn=32; pierwszy styk: nos w górę -2.5°, nos w dół 67.5° przy przodzie gogli 24.6; kontrole pozytywne trafiają; GrabCAD sprawdzony (FORK też przy yaw ±2))
  ```
- `test/export_tactical.sh` (PROFILE = MK4 0,4 PETG 0,2 mm, 4 obwody, BASE i `coupon_joint` 6, bez podpór, klatka z
  brimem 5 mm zewn.; kontrola: stara klatka sprzed przeglądu daje w `gcode_check.py` 421 punktów brimu w osłonie):
  ```
  tac_print_base    brył 1  V = 4,97 cm³
  tac_print_fork    brył 1  V = 4,29 cm³
  tac_print_cage    brył 1  V = 12,57 cm³
  tac_print_acc     brył 2  V = 3,12 cm³
  tac_coupon        brył 6  V = 10,64 cm³
  tac_coupon_joint  brył 4  V = 13,73 cm³
  tac_print_base    czas 31m 10s, masa 5.89 g (6 obwody, brim 0 mm); 2 obwody 4.73 g; z auto-podporami 6.03 g
  tac_print_base: brim: nie dotyczy; pojedyncze ściegi zewnętrzne (w < 0.42): 236 mm, z 1.8–11.8
  tac_print_fork    czas 29m 51s, masa 4.97 g (4 obwody, brim 0 mm); 2 obwody 4.03 g; z auto-podporami 5.15 g
  tac_print_fork: brim: nie dotyczy; pojedyncze ściegi zewnętrzne (w < 0.42): 0 mm
  tac_print_cage    czas 1h 5m 37s, masa 15.42 g (4 obwody, brim 5 mm); 2 obwody 13.74 g; z auto-podporami 15.25 g
  tac_print_cage: brim w osłonie/tubie: 0 pkt; pojedyncze ściegi zewnętrzne (w < 0.42): 260 mm, z 29.0–41.0
  tac_print_acc     czas 22m 39s, masa 4.05 g (4 obwody, brim 0 mm); 2 obwody 3.80 g; z auto-podporami 4.11 g
  tac_print_acc: brim: nie dotyczy; pojedyncze ściegi zewnętrzne (w < 0.42): 83 mm, z 9.0–12.6
  tac_coupon        czas 1h 6m 20s, masa 13.18 g (4 obwody, brim 0 mm); 2 obwody 10.76 g; z auto-podporami 13.18 g
  tac_coupon: brim: nie dotyczy; pojedyncze ściegi zewnętrzne (w < 0.42): 66 mm, z 1.8–2.0
  tac_coupon_joint  czas 59m 36s, masa 14.14 g (6 obwody, brim 0 mm); 2 obwody 9.98 g; z auto-podporami 14.28 g
  tac_coupon_joint: brim: nie dotyczy; pojedyncze ściegi zewnętrzne (w < 0.42): 434 mm, z 2.8–15.8
  OK: wszystkie STL manifold, bez nawisów > 45°, bez wysp w powietrzu, bez brimu w osłonie i tubie
  ```
  `overhang.py` nie znajduje ścian w dół >45° (mosty ≤10 mm), `float_check.py` nie znajduje wysp bez podparcia,
  `gcode_check.py` nie znajduje brimu w środku osłony termo ani tuby Infra (odpływ kończy się 0,6 przed czołem).
  Pojedyncze ściegi zewnętrzne (w < 0,42) są wypisywane tylko informacyjnie.

### Poprawki z przeglądu R1 (2026-11-04)
Waga wg weryfikatora (blocker / major / minor / nit). „pominięte” = świadomie bez zmiany geometrii, z powodem.

| Ustalenie | Waga | Co zrobiono |
|---|---|---|
| fit-cover-cable-window-closed | blocker | Zamknięte okno 6×5 w pokrywie usunięte. Wyjście przewodów to wycięcie 7×7 (x × z) w ściance −y klatki, z tyłu u góry, otwarte do tylnej krawędzi; przewody kładzie się z boku, pokrywa zamyka od tyłu. |
| fit-ir-cable-no-room | blocker | Wnęka za Infra 2,5 → **6,0** (`bay`), EVA zastąpiona 4 słupkami Infra. Klatka dłuższa do tyłu o 3,5, ale czop (`piv_x`, PX) i dolny tylny narożnik zostają: fazka tył-dół 5 → 8,5 mm (`ch_rb`), czoło FORK krótsze (`brow_x1` 28,6 → 25,1). Kąty styku bez zmian (test). Buciki przewodów w `cams()` → test `cover_cams` (kontrola: `bay = 2.5` trafia). |
| mech-1, fit-fuse-hinge-locks | blocker / major | Ogon języka: łuk R3,7 wokół kołka + fazka 45° (`tg_tail_r`). Test `hinge` 3…45° wolny; stary język trafia przy 6°. Próbka (a): zapisać kąt swobodnego obrotu po pęknięciu. |
| fit-trunnion-bolts-bottom, print-02 | major / minor | Za wkładkami otwór przelotowy Ø4,4 / Ø3,4 (półka 0,6 zatrzymuje wkładkę, wypływ do wnęki). Końce śrub w ECHO w stanie dociśniętym: M4 wkręcenie 3,55, 0,75 przed ścianką; M3×8 + PTFE 0,5: 3,0 wkręcenia, 0,8 przed ścianką. Gałka odsunięta o 1,0 (PTFE + falista). |
| fit-pusher-reach-edge-radius | major | Nowy `test/pusher_reach.py` (promień na osi popychacza do GrabCAD, wysuw i wkręcenie). Przy `front_x` 21,6 wkręcenie 4,5 < 5 → ostrzeżenie. **S2 blokuje druk FORK.** Geometria bez zmian (decyzja 2). |
| optics-02, fit-tongue-roll-play | major / minor | Otwór kołka w języku owalny 3,3 × 3,1 (`pin_hole_fz`): przechył ≈±1,2° zamiast ±2–3°, bierze go stal, nie PA66. Test `roll` (±0,8 wolny, ±2 trafia). Krok poziomowania horyzontu w procedurze. |
| mech-2 | major | ECHO `T_slip`, nierówność 2,13·T_slip + docisk < M_fuse (nie jest spełniona dla pchania obiektywu → zakaz w README; obrót za boki OK). Podkładki PTFE (z mech-4). Wiersz „obiektyw w górę” przepisany. |
| mech-3 | major | ECHO docisku 2·P·12 mm i limitu P ≤ 24 N/szt.; procedura tylko kątem, najpierw wykręcić, potem wkręcić. Sprężynowy popychacz — nie (otwarte). |
| mech-4 | major | PTFE pod piastą gałki i pod łbem M3, M4 z łatką nylonową obowiązkowo, wkładki 0,2 poniżej czoła, uwaga o luzowaniu gałki. |
| mech-5 | major | `blk_y` 8 → 9,5 (policzki 6,3 mm), przechył bierze stalowy kołek (owal), uwaga S2 o sile popychacza na ścianę, linia kontrolna na łbie PA66 w próbie bocznej. Kolejność policzki/ramiona nadal tylko z próby. |
| fit-cable-exit-at-contact-corner | major | Wyjście przewodów poza narożnikiem styku (patrz wyżej); odcinek przewodu Ø3 w teście `swing` i `stack_*`; pierwszy styk nos w dół nadal 67,5°. |
| optics-01 | minor | ECHO i README: 1 obrót = 1,61°, 1/8 = 0,20°, 1/16 = 0,10°; kręcenie jednym tylko dociska. |
| optics-03 | minor | `keep_x` = przód gogli + tol + 1,0 (= tył występu popychacza): ramię ma 1 mm do najgorszej ściany, yaw ±2° wolny przy każdym `front_x` (test `fork_ghost` yaw ±2, GrabCAD też); krok „BASE prostopadle popychaczami” w montażu. |
| optics-04 | minor | Tuba, żebro i daszek Infra obracane z `ir_yaw_trim` i przycięte do czoła; `ir_tube_back`; `cams_seated` przesuwa Infra wzdłuż jej osi; wnęka za Infra nieobracana; testy przy `ir_yaw_trim` ±2; pola widzenia od 0,5 za soczewką; kontrola pozytywna tuby. |
| print-01 | minor | Odpływ kończy się 0,6 przed czołem (`drain_sill`); `gcode_check.py`: brim w osłonie/tubie = błąd (0 pkt). |
| print-03 | minor | Pominięte w geometrii (jedyna skuteczna zmiana to druk BASE tyłem w dół, kosztem bazy gniazda na stole). Dodana próba boczna nóg na `coupon`. |
| print-04 | minor | Masa przy 2 obwodach dopisana do tabeli i „Znanych braków”. |
| print-05 | minor | Pominięte: `fuse_bx` 16 zostaje (kalibracja bezpiecznika); otwarta kieszeń nakrętki i ścianka 0,65 przed otworem to kosmetyka. |
| print-06 | nit | Otwór linki Ø1,6, przeniesiony na z 7,5 (pod fazkę bloku). |
| print-07 | minor | Wycinek klatki w `coupon_joint` w kształcie U (z dolnym mostkiem): 4 kawałki, `NP` = 4. |
| print-08 | minor | `cov_y` 11,4, krawędź górna 0,9, stopka 1,05 → krawędzie wpustu 0,9 (2 ściegi). |
| print-09 | minor | Tylko kreski 0/10/20°, rowki 0,6 × 0,6. |
| print-11 | nit | `gcode_check.py` w `export_tactical.sh` (brim + pojedyncze ściegi). Analiza zakotwienia mostów w `overhang.py` pominięta. |
| print-12 | nit | Bez zmian (Ø1,7 to typowy otwór pod M2 w PETG). |
| fit-fuse-head-vs-brow | minor | Czoło od x 19,0; łeb walcowy DIN 84 w README; łby śrub złącza w teście `fork_base` przy yaw ±2. |
| fit-ir-seat-vs-drawing | minor | `ir_h` = 20; kształt szyjki i położenie M2 do S4. |
| fit-front-fanscrew-blocked-by-pin-head | minor | Łeb kołka w pogłębieniu Ø6,2 × 2,5; test `fan_access` (wkrętak Ø2,5) z kontrolą pozytywną. `pin_nut_h` 3,0, bo łeb w pogłębieniu. |
| fit-tether-knot-and-order | minor | Ucho linki na zewnątrz klatki (góra, tył), bez węzła we wnęce; kolejność montażu dowolna. |
| fit-posts-on-thermal-screws | minor | Pominięte w geometrii — do S4 (położenie i wysokość łbów w tylnej płytce; ewentualnie podcięcie słupków Ø3 × 1). |
| fit-pusher-install-and-drop | minor | Krok 1 montażu: popychacze od strony ściany, do oporu (wystają 0,6, ECHO). |
| fit-helmet-buckle-margin | minor | Fazka 45° tylnej górnej krawędzi bloku (`blk_ch`): tarcza klamry ma 2,4 mm luzu; test `buckle_disc` + pomiar zakresu korpusu klamry (S7). |
| fit-tests-miss-hardware | minor | Łby śrub złącza, wkrętaki, przewody, obrót po ścięciu, przechył, zasięg popychaczy — w testach; końce śrub czopu w stanie dociśniętym. |
| optics-05 | nit | Krok 3 zbieżności: wyjąć klucz po każdej korekcie. |
| optics-06, mech-9 | nit / minor | Linka: wolna długość 75–85 mm, tulejki zaciskowe; ECHO odległości otworów. |
| optics-07 | nit | `ptr_r` 8,4, kreski od r 8,6. |
| optics-08 | nit | Pasmo `seat_above_eye` w ECHO i README (20,0–24,8). |
| optics-09 | minor | Kryterium powtarzalności ≤0,2° (1 piksel) na oko; 0,1° tylko z celem 30 m albo środkiem ciężkości plamki na nagranej klatce. |
| optics-10 | nit | S4: różnica osi termo/Infra (yaw i pitch) na celu 10 m; `ir_pitch_trim` tylko gdy > ≈1°. |
| mech-7 | minor | ECHO i tabela: przednie śruby, 3,3× siła na obiektywie, ≈81 N/szt. przy progu suchym; próg S3 → 100 N. |
| mech-8 | minor | Bezpiecznik podawany jako ≈1,0–2,7 N·m [calc], rozstrzyga próbka (a). Okrągłe gniazda po stronie obciążenia pominięte (wymagałyby sufitów otworów bez łezki). |
| mech-10 | minor | Tabela: uderzenie czołowe 120–223 N (ECHO) i przypadek górnej części klatki. |

### Decyzje do akceptacji (§9 spec.; w pliku są wartości domyślne)
1. **Zastąpienie decyzji 1c.10** (jedna śruba M5 przegubu GoPro) kolejnością: poślizg czopu → ścięcie PA66 → ramiona.
   Klatka nie pasuje już do akcesoriów GoPro.
2. **Popychacze na `pad_z = −5`** (5 mm pod krawędzią blatu), bez pomiaru promienia krawędzi. Jedyne dane 3D (GrabCAD,
   oryginalne HDO) mówią, że ściana na z −5 jest 1,5 mm za `front_x` i pochylona ≈31° → przy `front_x` 21,6 wkręcenie
   tylko 4,5 mm. **Proponuję: S2 przed drukiem FORK.**
3. **Masa:** spec. zakładała ≈+6 g. Po pocięciu wychodzi **+12,0 g** (30,2 g przy 4 obwodach wobec 18,2 g v0.4;
   przy 2 obwodach 26,1 g). Klatka urosła o wnękę za Infra.
4. **Pochylenie na tarcie jako tryb codzienny**, ale **obracać klatkę za boki** (para sił) albo przy poluzowanej
   gałce, nigdy pchając obiektyw/osłonę (patrz „Pochylenie”). Zapadki później (S8).
5. Nowe po przeglądzie: wnęka 6 mm i krótsze czoło FORK; wyjście przewodów u góry z tyłu po −y (spec. M8: na dole
   w narożniku −y); zewnętrzne ucho linki (spec. M6: węzeł we wnęce); BASE szersza (`blk_y` 9,5); PA66 M2.5×**20**;
   podkładki PTFE na czopie (spec. M5: „bez PTFE”, bo tarcie jest funkcją — tarcie zostaje na czołach boss/ramię).
6. Odstępstwa od specyfikacji (powody w komentarzach `ODSTĘPSTWO`):
   - kieszeń nakrętki M3 5,7 na płaskich (spec. „8.2 po narożach” to rozmiar M5), głęboka 3,0;
   - obie kieszenie nakrętek płaskim bokiem do góry (narożnik do góry dawał sufit 30°);
   - otwory na wkładki 4,0 głęboko + przelot (5,0 przebiłoby boss 4,3 mm);
   - po prawej **M3×8** + PTFE, nie ×10;
   - gałka odsunięta o 1,0 (PTFE + falista), kieszeń łba 3,3;
   - daszek kończy się na x 12,6 (13,6 nie da się wydrukować przodem w dół);
   - bossy czopu: łezka z grotem do +x, przy ściance rozszerzona 45°, więc podziałka przeniesiona na r 8,6–10;
   - kieszenie pod czołem tylko do |y| 11,6; czoło od x 19,0;
   - pokrywa ±11,4 + luz 0,15;
   - strefa gogli dla FORK od `front_x + front_tol + 1.0` (spec. +0,5);
   - podziałka bez kresek 5/15°, grot wskaźnika do r 8,4;
   - rowki klucza popychaczy otwarte na zewnątrz ramienia (otwór Ø2,4 przebijał ściankę 1 mm).

### Erraty specyfikacji (wykryte w przeglądzie; specyfikacja niepoprawiona)
- M4: „1 obrót = 0,81°, 1/8 ≈ 0,10°” → przy procedurze z M4 (jeden w, drugi z) **1,61° / 0,20°**.
- M2 „przeciążenie”: liczy jeden popychacz; dwa dają 2 × 80 N × 12 mm = **1,92 N·m > mokry bezpiecznik**.
- M2 „śruby wentylatora”: moment względem kołka / 22,5 i tylne śruby → **przednie śruby, 3,3 × F na parę, ≈81 N/szt.**
- M2 „pan head” → **łeb walcowy** (pan head dotyka czoła przy yaw 0).
- §2.3 „obiektyw w górę”: przy pchaniu obiektywu bezpiecznik widzi 2,13 × T_slip, więc pęka przed poślizgiem czopu.
- §2.3: „FORK obraca się na stalowym kołku” nie było prawdą dla prostopadłościennego języka (klinował się po ≈3,6°).
- §4.3: „≤0,1° (2 piksele termo)” → 0,1° to **0,5 piksela** (IFOV 3,43 mrad ≈ 0,20°).
- M5: końce śrub trzeba liczyć w stanie dociśniętym, względem dna otworu wkładki.
- M6/M8: węzeł linki we wnęce i wyjście przewodów przez zamknięte okno 6 × 5 są niewykonalne (przewody na stałe).
- M1: przy `blk_y` 8 kołek M3 ISO 7380 wchodził łbem w studzienkę przedniej śruby wentylatora.

### Znane braki
- **Budżet masy ≤20 g nie jest spełniony** (30,2 g przy 4 obwodach, 26,1 g przy 2). Cienkie ścianki przy 4 obwodach
  drukują się prawie pełne (≈1,2 g/cm³). Kalibracja 0,73 g/cm³ z v0.4 była cięta przy 2 obwodach, ale nawet przy
  2 obwodach budżet jest przekroczony. Kandydaci do odchudzenia wg spec.: okna w ściankach klatki na poziomie Infra →
  żebrowana pokrywa → kieszenie czoła; do tego pełne przejścia 45° klatki (≈2 cm³).
- **Środek ciężkości kamer wychodzi x ≈ 50** (ECHO, korpus + obiektyw jednorodnie), a nie ≈38 jak w spec.
- **Pchanie obiektywu w górę ścina PA66** (2,13·T_slip > mokry próg) — rozwiązane tylko procedurą. Trwałe rozwiązanie
  (mniejsze, zdefiniowane T_slip: tuleje dystansowe + docisk podkładką falistą) — otwarte.
- **Docisk popychaczy** ograniczony tylko procedurą (kąt, nie moment). Popychacz sprężynowy — otwarte.
- **Bok:** czy policzki BASE (teraz 6,3 mm) wytrzymują dłużej niż ramiona (≈140–280 N) — tylko próba boczna §4.3.
- **Zasięg popychaczy:** GrabCAD wskazuje zaokrągloną krawędź (R ≈ 11) na wysokości popychaczy (ostrzeżenie S2 w teście).
- **Linka** ogranicza, ale nie usuwa ryzyka, że uwolniona klatka zwisa przed dolną częścią twarzy.
- Śruby pokrywy: z klatką na czopie wkrętak Ø2,5 dochodzi do nich z obu stron tylko bez gałki, przy tilt 20 i 40
  (test, pomiar); z gałką — przy żadnym z 0/20/40/60. Pokrywę zdejmuje się więc po zdjęciu gałki albo całej klatki.
- Model GrabCAD to oryginalne HDO z „niedokładnymi wymiarami” i nie jest zamknięty. Sprawdzane są tylko jego próbki
  wewnątrz części; przód modelu (21,7) jest przesuwany na badany `front_x`.
- Nogi do kasku drukują się warstwami w poprzek zginania (druk płytką w dół) — standard dla mocowań GoPro, ale siłę
  zmierzyć na `coupon` (próba niżej).

### Do zmierzenia (wyzwalacze SHOULD, §5 spec.)
- **S1:** wysokość blatu nad osią okularów (M5) → `piv_rel_seat`.
- **S2 (blokuje druk FORK):** `front_x`, płaskość ściany i profil górnej krawędzi przy y ±17,75 na wysokości
  z −4…−6 → `pad_z`, `front_tol`; wytrzymałość ściany pod jednym popychaczem (siła boczna ≈1,6× trafia w jeden).
- **S3:** śruby wentylatora i to, co jest pod nimi, z próbą wyrwania → `fuse_d` 2.0, jeśli **przednia** śruba trzyma <100 N.
- **S4 (przed drukiem klatki):** kamery suwmiarką — położenie M2 względem czoła korpusu, głębokość, średnice obiektywów;
  **położenie czoła obiektywu/szkła względem przedniej ściany korpusu (±0,1)** obu kamer; Infra: kształt szyjki przed
  korpusem (kwadrat/okrąg, naroża), położenie czoła szyjki, wysokość (rysunek: 20); **długość bucika i promień zgięcia
  przewodów**; położenie i wysokość łbów śrub w tylnych płytkach (słupki pokrywy); rzeczywiste FOV; **różnica osi
  termo/Infra (yaw i pitch) na celu 10 m** (ewentualnie `ir_yaw_trim`, `ir_pitch_trim` gdy > ≈1°).
- **S5:** średnica przewodów → wymiar wycięcia `cab_x`/`cab_z`; pętla serwisowa ≥15 mm na obrót klatki.
- **S7:** H1–H3 kasku → `helm_*`. Test: tarcze klamry mają luz do BASE, korpus klamry jest wolny przy −30…75°
  (0 = do góry, + = do przodu), przy 90° dotyka bloku/czoła.

Próbki z M9:
- (a) waga bagażowa na uchu `coupon_joint` w górę: pęknięcie przy 30–50 N, na sucho i po 48 h w wilgotnym worku;
  po pęknięciu sprawdzić, że język obraca się na kołku swobodnie (≥45°);
- (b) gwint M3 popychacza wytrzymuje 20 cykli;
- (c) wyrwanie wkładek > 2× docisk; po wtopieniu sprawdzić wybrzuszenie od strony wnęki (obciąć);
- (d) **nowe:** nogi `coupon` — siła boczna do pęknięcia (warstwy w poprzek), zapisać w README.

Próby fizyczne z §4.3:
- bezpiecznik w górę 30–50 N;
- ciągnięcie w bok: ramiona pękają przy ≈140–280 N, a BASE zostaje cała; **linia kontrolna na łbie PA66**
  (czy bok nie uszkadza bezpiecznika);
- tarcie czopu 0,55–1,02 N·m;
- powtarzalność zbieżności po 10 cyklach pochylenia i pchnięciu osłony w bok 50 N: **≤0,2° (1 piksel termo)** na oko;
  0,1° tylko z celem 30 m albo środkiem ciężkości plamki na nagranej klatce.

---

## pod.scad — pod sterownika w lewej zatoce modułu VRx (v0.2.1, WERSJA ROBOCZA)

Decyzja 2026-11-03: pod zastępuje drzwiczki lewej zatoki VRx (moduł RX wyjęty), obsługa **lewą ręką**, **cienkie
rękawice**. Źródła: `research/07a` (wymiary części), `07b` (miejsce, obrys, pomiary P1–P9), `07c` (ergonomia,
sprężynka, MIL-STD-1472H). Gdzie ten opis różni się od `pod.scad` — rozstrzyga `pod.scad`.

**Wymiary zatoki są zastępcze** (HDO v1 z forum, obrys modułu SpeedyBee 51×34 udokumentowany na HDO2). Wszystkie
wejścia z pomiaru są w bloku **P1** na początku pliku (`bay`, `bay_r`, `bay_off`, `bay_depth[przód, środek, tył]`,
`door_seat`, `seat_prof`). Wtyk, żebra, kołnierz i atrapa gogli wyliczają się z nich.

| Plik | Druk | Uwagi |
|---|---|---|
| `stl/pod_print_gauge.stl` | **pierwszy**, ~9 min, 2 g | sprawdzian P1: kołnierz + 3 mm wtyku, nacięcia stacji `seat_prof` |
| `stl/pod_print_shell.stl` | wiekiem do stołu, bez podpór, ~43 min, 11 g | obudowa w jednym kawałku (wieko, ściany, kołnierz, wtyk) |
| `stl/pod_print_chassis.stl` | płasko, ~15 min | płytka montażowa |
| `stl/pod_print_knob.stl` | wierzchem do stołu | gałka Ø20, otwór D + M3 dociskowa (nakrętka od spodu) |
| `stl/pod_print_caps.stl` | wierzchem do stołu, 3 szt. | nakładka CAM; wybrać najlepszą |
| `stl/pod_print_shims.stl` | płasko | podkładki B3S 0,2/0,4/0,6/0,8/1,0 |

**v0.2.1 — odbicie lustrzane:** układ poda (x do przodu, y w górę, z na zewnątrz po lewej) jest lewoskrętny.
Wszystkie pliki `print_*` są więc odbite w x, a dopiero włożony wydruk ma gałkę z przodu i wyjście przewodu z
tyłu. Podgląd `assembly` w `pod.scad` pokazuje model nieodbity. W `scene_all.scad` pod siedzi na goglach poprawnie.

**Sterowanie (v0.2):** enkoder (obrót = jasność/paleta, krótkie wciśnięcie = zmiana trybu, długie = NUC) + przycisk
**CAM** (termo ↔ Infra). Przycisk AUX z v0.1 usunięty: nie dawał się wydrukować, nie miał skoku i leżał na drodze
dłoni wzdłuż paska. Firmware: 2 ząbki enkodera na krok + krótka wibracja (07c: 20° na ząbek < 30° wg MIL).

**Przycisk CAM:** języczek w wieku (a = 14 mm, t = 1,0) z wklejoną nakładką Ø16. Ogranicznik skoku to „uszy” na
cokole płytki: języczek siada na nich po 2,5 mm, niezależnie od przechyłu nakładki. Klik przy ≈2,15 mm, siła
≈3,1 N + siła B3S, odkształcenie 1,65% przy kliku i 1,9% na ograniczniku (z ECHO `pod.scad`; PETG E = 1,6 GPa [A]).
B3S ma tolerancję wysokości ±0,3, więc **skok dobiera się podkładką** (nominalnie 0,6). Klik musi wypaść przed
ogranicznikiem: brak kliku → cieńsza podkładka, za wczesny → grubsza.

### Montaż (kolejność)
1. Enkoder w płytkę: piny w szczeliny, zaczepy zagiąć pod płytką, przylutować przewody (odciążenia pod pinami).
2. B3S na podkładce w gnieździe cokołu (klej), przewody kanałami. Przetwornica pionowo w rowku przy dolnej ścianie.
3. Pod płytką na taśmie piankowej: XIAO (elementami do płytki, USB-C do góry, +y), silnik wibracyjny (przewody w
   +y), płytka uniwersalna (Schottky, FET silnika, dzielnik napięcia) między rzędami pinów enkodera.
4. Przewód magistrali przez otwór w ścianie tylnej, opaska na słupku przy otworze.
5. Płytkę wsunąć **od spodu wtyku** (USB-C jedzie szczeliną otwartą od dołu) i przykręcić 4× M2 (pan head) od spodu.
6. Nakładkę CAM wkleić (CA) w języczek. Gałkę nasunąć i dokręcić M3 dociskową na płaskim osi.
7. Wcisnąć pod w zatokę. Trzymają go żebra zaciskowe (wcisk 0,15 mm na stronę).
   **Zatrzask jak w fabrycznych drzwiczkach dopiero po pomiarze P1.**

### Test
`cad/test/run_pod_clash.sh` sprawdza pary części i atrap elektroniki, wsuwanie płytki od spodu (16 mm) oraz ruch
nakładki CAM do ogranicznika (czy nie dotyka wieka; kontrola: 1,6 mm dalej już dotyka). Wynik v0.2: **OK, brak kolizji**.

### Do zmierzenia (research/07b §6)
- **P1**, lewa zatoka bez drzwiczek: otwór (szer. × wys., promień narożników), głębokość z przodu, w środku i z tyłu,
  położenie gniazda; drzwiczki: obrys, grubość, zatrzask.
- **`seat_prof`**: połóż wydrukowany sprawdzian na gnieździe drzwiczek i zmierz szczelinomierzem szczelinę przy pięciu
  nacięciach.
- **P2**: piny gniazda zatoki (bez zwierania).
- **P5**: odstęp od boku gogli do kasku.
- **P6**: próba w rękawicach.
- **P7**: ręka (lewa, potwierdzone).

Elektronika jeszcze niekupiona. Do zmierzenia na sztukach:
- grubość PCB i wysokość elementów XIAO;
- wysokość B3S;
- tolerancja otworu D gałki (wydrukować próbkę).

---

## aibox_mount.scad — uchwyt AI Boxa na prawym boku (v0.1, PROPOZYCJA)
AI Box ma 33,5×33,5×16,5 mm i otwory 25,5×25,5 (rysunek BZB). Stoi na prawym boku, przed gniazdem AV, bo:
- tam są gniazdo AV i zasilania HDO2, więc przewody CVBS i zasilania są krótkie;
- równoważy masę poda po lewej.

Płytka 38×37 mm na taśmie VHB 5952, 4 dystanse M2 o wysokości 5 mm (miejsce na złącze kamer na spodzie boxa),
szczeliny na opaskę przy przedniej krawędzi. Płytka zasłania drzwiczki Expansion Bay.

Do sprawdzenia po dostawie:
- długość przewodów kamera ↔ box (z przodu do prawego boku to ok. 80–100 mm);
- położenie złącza kamer;
- pomiar P3 (07b).

## scene_all.scad — wszystko na HDO2 (podgląd)
Gogle to bryła zastępcza z wymiarów (research/04, 06, 07b), nie model producenta. Pełnego modelu HDO2 nie znaleziono:
na Printables są tylko akcesoria i przednie skorupy Walksnail/Dominator. Na GrabCAD jest model oryginalnego HDO, ale
pobranie wymaga logowania, a autor pisze, że wymiary są niedokładne.

Podgląd w przeglądarce: `cd cad/web && python3 -m http.server 8765`, potem http://127.0.0.1:8765/ (bez internetu).
