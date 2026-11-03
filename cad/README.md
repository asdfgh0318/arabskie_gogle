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
