# cad/ — części drukowane

## camera_mount.scad — mocowanie kamer i gogli do kasku na HDO2 (v0.6, WERSJA ROBOCZA, 2026-11-06)
Decyzje Adama z 2026-11-06:
1. Przy kamerze zostaje przegub GoPro („wierzę, że mocowanie GoPro puści pierwsze”), więc czop i bezpiecznik PA66 z
   v0.5 odpadają.
2. Dodatkowe +12 g masy — zgoda.
3. Przewody z tyłu u góry klatki — zgoda.
4. Nowe: indeksowany kąt kamery na wypustkach.

v0.6 = architektura v0.4 (adapter na gnieździe wentylatora, bezpiecznik V w bloku, przegub GoPro, klatka ładowana od
przodu, nogi do kasku) + te elementy v0.5, które pasują do przegubu GoPro. v0.4 jest w historii git (commit `6217b93`).
**Gdzie ten opis różni się od `camera_mount.scad`, rozstrzyga plik `.scad`** (zmiany oznaczone `v0.6:`, odstępstwa
od zlecenia `ODSTĘPSTWO`). **Nic nie zostało zmierzone na sprzęcie**: kamery z rysunków sklepu, HDO2 ze zdjęć i
modeli społeczności (`research/06`) oraz z modelu GrabCAD oryginalnego HDO (plik lokalny, poza repo).

**Co się zmienia względem v0.4:**
- **Popychacze yaw (z v0.5).**
  - Belka nad przegubem (z 9–13) jest przyczepiona do bloku adaptera **przed** bezpiecznikiem (od x 17.3; rowki
    kończą się na 16.8).
  - Z belki schodzą dwa słupki i ukośne podpory 45° do bloków z gwintem M3 na y ±17.75, z −9.5.
  - Dwa wkręty bez łba M3×20 pchają w −x na przednią ścianę gogli. Zbieżność ustawia się nimi w terenie, bez
    przedruku.
- **Gałka bez narzędzi po lewej (+y):** Ø16, radełkowana, z wciśniętym łbem M5×20 ISO 4017. Nakrętka M5 i podziałka
  przeszły na −y.
- **Zapadki pochylenia 0/10/20°** na stykach palców GoPro. Wypustki są na zewnętrznych ścianach palców męskich klatki,
  rowki na wewnętrznych ścianach zewnętrznych palców żeńskich.
- **Osłona przednia (nowa część `shroud`, z v0.5):** osłona termo, tuba Infra i daszek. Trzyma się na językach pod
  istniejącymi śrubami M2 kamer, bez nowych śrub.
- **Przewody wychodzą z tyłu u góry po −y.** Przewód termo biegnie pod belką i w górę zatrzaskowym kanałem w końcu
  belki −y. Przewód Infra biegnie nad belką. Wiązka idzie do tyłu na poziomie Infra, z boku przegubu i klamry kasku.
- **`cam_gap` 1.5 → 2.0.** Strefa widzenia termo liczona z całej soczewki Ø16 dotykała przy 1.5 dolnej krawędzi
  obiektywu Infra. Teraz zostaje 0.3 mm. Infra jest wyżej o 0.5.
- **`keep_x` = front_x + 1.5 + 1.0 (było +0.5).** Pod blatem nic nie wchodzi bliżej ściany niż 1 mm przy najgorszym
  `front_x`, więc obrót adaptera o ±2° przy ustawianiu zbieżności jest wolny (test).

| Część | Plik | Druk (PETG, MK4, 0,2 mm, 15% wypełnienia, 4 obwody, **bez podpór**) | Czas / masa (PrusaSlicer) |
|---|---|---|---|
| Próbka (drukować **najpierw**) | `stl/coupon.stl` | 3 pary szczelin 3.2/3.3/3.4 → `gp_slit`; wycinek adaptera z rowkami, pułapką nakrętki i podziałką; wycinek klatki z wypustkami | 1 h 08 min / 18,1 g |
| Klatka na kamery | `stl/print_cage.stl` | przodem w dół, **bez brimu** | 35 min / 9,0 g |
| Adapter (kamera z przodu, popychacze, nogi do kasku nad płytką) | `stl/print_adapter.stl` | tyłem w dół (stoi, 54 mm), brim 5 mm zewnętrzny | 56 min / 11,9 g |
| Osłona przednia | `stl/print_shroud.stl` | przodem w dół (stoi, 30 mm), brim 5 mm zewnętrzny | 26 min / 6,3 g |
| Gałka | `stl/print_knob.stl` | wierzchem w dół, gniazdem łba do góry | 5 min / 0,9 g |

Masa wszystkich części v0.6 (adapter, klatka, osłona, gałka): **28,1 g** (z brimem). To samo cięcie dla STL v0.4 daje adapter 9,3 g + klatka 9,0 g =
18,3 g, więc **v0.6 = +9,8 g** (zgoda była na +12). Przy 2 obwodach: 9,1 + 7,5 + 6,1 + 0,75 = 23,5 g.
Profil: „Original Prusa MK4 Input Shaper 0.4 nozzle” + „0.20mm SPEED @MK4IS 0.4” + „Generic PETG @PGIS” (spłaszczony
`mk4_petg.ini`, ten sam co w projekcie Rotorwing), przy czym 4 obwody są ustawione z linii poleceń.

**Kupne:**
- przegub:
  - M5×20 **ISO 4017** (łeb sześciokątny) wciśnięty w gałkę + kropla CA;
  - podkładka DIN 125 Ø10 × 1;
  - nakrętka M5 w pułapce −y;
- popychacze: 2× wkręt bez łba **M3×20 ISO 4026** z nylonową końcówką albo naklejoną kropką PTFE Ø3 × 1;
- kamery: śruby M2 z zestawu **dłuższe o 1,2 mm** (języki osłony leżą pod łbami);
- gogle: 4 fabryczne śruby wentylatora.

```
openscad -D 'part="assembly"' -D tilt=10 camera_mount.scad   # podgląd; ECHO: wysokości obiektywów, zapadki, momenty, popychacze
./test/run_clash.sh                                          # kolizje (80 zadań, ~12 min przy 8 wątkach; ostatni wynik: OK)
PROFILE=…/mk4_petg.ini ./test/export.sh                      # eksport STL + manifold + nawisy + wyspy + cięcie + brim w osłonie
```
Podgląd: `img/assembly_iso.png` (tilt 10, od lewej), `img/side_t0.png`, `img/side_t20.png` (widok z prawej, −y),
`img/front.png`, `img/shroud.png`, `img/adapter_top.png`, `img/cage_rear.png`, `img/coupon.png`.

### Montaż
1. Zdejmij osłonę i wentylator z **góry** gogli.
2. Adapter przykręć **luźno** 4 śrubami **fabrycznymi** (pod łbem 1.2 mm = kołnierz osłony). Zanim kupisz inne śruby,
   zmierz śrubę i to, co jest pod wentylatorem (research/06 M1/M2).
3. Popychacze M3×20 wkręć od przodu w bloki popychaczy, aż wystaną z tyłu ok. 10 mm.
4. **Nakrętkę M5 wsuń w pułapkę po −y ukośnie, od przodu-góry (45°), przed założeniem klatki.** Prosto z boku się
   nie da: drogę zasłania podpora popychacza −y.
5. Kamery wsuń od przodu i dosuń do tylnych zderzaków. Najpierw dokręć M2 po stronie **+y (lewej)**, bo ta ścianka jest
   bazą kierunku, potem po −y. Na razie tylko lekko: przed dokręceniem M2 trzeba jeszcze założyć osłonę (krok 7).
6. Przewody:
   - termo: bucik prosto do tyłu, pod belką w stronę −y za tylnym końcem ścianki, potem wcisnąć w kanał w końcu
     belki −y (wejście 2,5 mm, oplot Ø3 wchodzi na zatrzask) i w górę do poziomu Infra;
   - Infra: nad belką w stronę −y;
   - oba razem do tyłu na poziomie Infra, nad belką popychaczy, do AI Boxa po prawej;
   - przy przegubie zostawić pętlę ≥15 mm na zmianę pochylenia.
7. Osłonę nasuń językami na zewnętrzne strony ścianek klatki, aż oprze się o czoła kamer. Teraz dokręć M2 (dłuższe o
   1,2 mm) przez szczeliny w językach. Osłona dociska kamery do zderzaków.
8. Klatkę wsuń palcami w przegub. M5×20 z gałką włóż od **+y** (podkładka pod łbem) i dokręć **ręką, gałką**. Gałka
   Ø16 ogranicza moment do ≈0,2–0,4 N·m [A].
9. Kask (jak v0.4): na przodzie kasku przyklej podstawkę GoPro VHB, w nią klamrę 3-palcową, która wchodzi w dwie
   męskie nogi nad płytką. Obciążenie z kasku idzie blokiem i płytką na 4 śruby wentylatora, **nie** przez bezpiecznik.
   Klamra jest wolna przy kątach −30…75° (0 = do góry, + = do przodu). Przy 90° dotyka belki popychaczy (test,
   pomiar H2).

### Zbieżność (yaw) popychaczami
Popychacze ustawiają kierunek adaptera **w luzie otworów śrub wentylatora** (±0,6–1,6°). Rozstaw 35,5 mm. Przy
procedurze „jeden wkręcany, drugi wykręcany o tyle samo” **1 obrót = 1,61°, 1/8 obrotu = 0,20° ≈ 1 piksel termo** (ECHO).
1. Poluzuj 4 śruby wentylatora (o ćwierć obrotu).
2. Oba popychacze wkręć do dotknięcia ściany gogli.
3. Wyceluj w ciepły cel z 10 m. Najpierw **wykręć** jeden popychacz o n, potem **wkręć** drugi o n, tylko kątem.
   Kluczem 1,5 wchodzisz od przodu wzdłuż osi popychacza; droga klucza jest wolna przy tilt 0–20 (test). **Po każdej
   korekcie wyjmij klucz** i dopiero wtedy oceń cel.
4. Oba popychacze ustaw na dotyk + 1/8 obrotu (≈5–15 N [A]). Docisk wypycha adapter do przodu, więc śruby
   wentylatora opierają się o tylne krawędzie otworów.
5. Dokręć 4 śruby wentylatora. Przednie dokręca się przez pogłębienia, wkrętakiem pionowo z góry: belka zaczyna się
   na x 17.3, ale dostępu wkrętaka nie sprawdza żaden test.
6. Namaluj linie kontrolne przez popychacz i blok oraz przez krawędź płytki i skorupę. Przerwana linia oznacza, że
   coś się przesunęło.

Korekta Infra względem termo (różnica osi na celu 10 m) nadal tylko przez `ir_yaw_trim` i przedruk klatki.

### Pochylenie: przegub GoPro + zapadki 0/10/20°
- **Zmiana pozycji:** poluzuj gałkę o ok. 1 obrót, przestaw klatkę do następnego kliku i dokręć ręką.
- **Pozycje:** 0 (oś termo poziomo względem osi okularów, to samo zero co podziałka i ECHO), 10 (nominalnie) i 20.
  - Rowki są liczone za `seat_pitch`.
  - Między rowkami wypustka rozpiera palce, więc przegub dokręca się tylko w zapadce.
- **Podziałka:** kreski 0/10/20 (10 dłuższa) na zewnętrznej ścianie występu nakrętki (−y), czytane grotem płetwy
  klatki. Są widoczne z prawej strony nad ukośną podporą.
- **Geometria** (ECHO):
  - wypustka: czasza kuli R 0,7, wysokość 0,2, podstawa Ø0,98; brzeg czaszy 44° od pionu, więc drukuje się bez podpór
    na pionowej ścianie;
  - rowki: V 100°, głębokość 0,44, szerokość 1,04, co 10° na promieniu 6,5 (1,13 mm), promieniowo do obrzeża tarczy;
  - wypustka leży pod osią M5. Luz kula–zbocze to 0,02.
- **ODSTĘPSTWO od zlecenia (0/5/10/15/20):** na tarczach Ø15 rowki co 5° się nie mieszczą.
  - 5° na r 6,5 to 0,57 mm, a rowek pod wypustkę r 0,5–0,7 ma ≥1 mm szerokości. Osobne rowki co 5° wymagałyby r ≥ 14.
  - Druga wypustka przesunięta o 5° też nie pomaga: każda wypustka poza rowkiem rozpiera dokręcony przegub.
  - Pozycje 5/15 są dostępne tylko po przedruku klatki z `det_off = 5` (wtedy pozycje to 5/15/25).
- **Moment poślizgu** (ECHO, [calc], μ i τ założone):
  - M5 dokręcona ręką ≤0,3 N·m daje ≈300 N docisku. Tarcie 4 styków palców to **1,32 N·m przy μ 0,2** (założenie v0.4)
    albo 2,31 N·m przy μ 0,35.
  - Zapadki dokładają **0,20–0,34 N·m**. Przy dokręconej M5 wypustka nie wysunie się sprężyście (pakiet palców jest
    sztywny), więc przy uderzeniu ścina się albo rozgniata krawędź rowka (τ 20–35 MPa na podstawie Ø0,98, dwie
    wypustki na r 6,5).
  - Razem 1,51–1,66 N·m przy μ 0,2 wobec bezpiecznika ≈2,6 N·m: przegub nadal puszcza pierwszy.
  - **Przy μ 0,35 zapas znika** (2,51–2,65 N·m), ale już samo tarcie v0.4 przy μ 0,35 to 2,31. Rozstrzyga próbka:
    waga bagażowa na wycinku klatki, na sucho, z gałką dokręconą ręką.
  - Po takim uderzeniu wypustki mogą być ścięte. Wtedy przegub działa dalej na samo tarcie; przedruk klatki.

### Bezpieczeństwo (kolejność zniszczenia, wyliczone, nie zmierzone)
poślizg przegubu (≈1,5–1,7 N·m z zapadkami przy μ 0,2) → **bezpiecznik w adapterze** (przewężenie za przednimi
śrubami, ≈2,6 N·m zginania) → nogi klatki (≈5 N·m).

Belka popychaczy jest przyczepiona tylko przed bezpiecznikiem, więc po jego pęknięciu przód adaptera z kamerami
odpada razem z popychaczami. Popychacze dociskają ścianę tylko siłą 5–15 N. Gniazda śrub w goglach: wytrzymałość
nieznana. PETG ~25 MPa międzywarstwowo.

### Wysokość obiektywów nad osią okularów (`seat_above_eye` = 23, nie zmierzone; cel research/01: 0…+35)
| tilt | termo | Infra |
|---|---|---|
| 0° | 12,4 | 34,4 |
| 10° | 6,1 | 25,7 |
| 20° | 0,3 | 17,0 |

Infra jest o 0,5 wyżej niż w v0.4 (`cam_gap`). Przy `seat_above_eye` z zakresu 19–29 obie liczby przesuwają się o tyle
samo, więc po pomiarze M5 ustaw `axis_rel_seat`. Klatka **nie** jest gwarantowanie zgodna z fabryczną klamrą GoPro.

### Osłona przednia
- **Wnętrze osłony termo** = strefa widzenia z całej soczewki Ø16 (50 × 37,2°) + 0,5 mm; ścianki 1,6.
- **Tuba Infra:** Ø20 (szkło Ø19 + 0,5), kończy się 0,55 mm za szkłem Infra (x 18,55).
- **Daszek** 16 × 1,6 nad tubą; w dnie osłony termo odpływ 2 × 2.
- **ODSTĘPSTWO:** osłona termo kończy się w tej samej płaszczyźnie co tuba, czyli 11,25 mm przed szkłem termo
  (zlecenie: ≈5,3).
  - Osłonę drukuje się przodem w dół, więc przody osłony i tuby muszą leżeć na stole razem.
  - Ścianki rozchylają się zgodnie ze strefą widzenia, więc dłuższa osłona nie wchodzi w pole (test).
  - Na przodzie osłona ma 30,7 mm szerokości, czyli wystaje 2,4 mm poza każdy bok klatki.
- **Lejki:** z tyłu dwie osobne ramki z lejkami 45° (do szyjki termo i do tuby). Jedna ramka nad przewężeniem między
  obiektywami dawała w druku płaski nawis 22 × 11 mm.
- **Języki:** 1,2 mm, ze szczelinami jak w klatce (3 mm wzdłuż osi).

### Testy (wynik dla wersji w repo)
`test/run_clash.sh` — 80 zadań OpenSCAD ($fn 32):
- adapter (z belką, słupkami, podporami, blokami popychaczy) + gałka + M5 vs gogle przy przodzie 21,6/23,1/24,6 i
  yaw 0/±2°;
- klatka + osłona + kamery + przewody vs gogle oraz vs adapter/gałka/M5/popychacze/droga klucza przy tilt
  0/5/10/15/20 × przód 21,6/23,1/24,6;
- zapadki w rowkach przy 0/10/20 (z luzem szczeliny i z palcami dociśniętymi);
- gałka vs adapter/popychacze/klucz; osłona vs klatka i kamery; kamery vs klatka; przewody vs klatka i osłona;
- strefy widzenia:
  - termo 50 × 37,2° z całej soczewki Ø16;
  - Infra 96 × 72° z całego szkła Ø19;
  - obie od 0,5 mm za soczewką/szkłem, z osłoną, popychaczami, gałką, przewodami i goglami, tilt 0–20 × 3 przody;
- pomiar zakresu klamry kasku;
- model GrabCAD (`grabcad_check.py`, adapter też przy yaw ±2) i zasięg popychaczy (`pusher_reach.py`).

Kontrole pozytywne muszą trafić (trafiają):
- osłona z marginesem −0,5 → pole termo;
- wypustka przy tilt 5 (między rowkami, palce dociśnięte) → palec żeński;
- rowek bez luzu (`det_c` −0,1) → wypustka przy 0;
- gogle z przodem na 26,5 → adapter;
- GrabCAD z przodem na 40 → adapter.

**Wynik:**
```
pomiar: korpus klamry GoPro kasku wolny (vs adapter z belką, gałka, klatka tilt 10) przy kątach [°, 0 = do góry, + = do przodu]: -30 -15 0 15 30 45 60 75
zasięg popychacza: front_x 21.6, y ±17.75, z -9.5: ściana x 21.55 (pochylenie 4° od pionu), wysuw 14.05, wkręcenie 5.95
zasięg popychacza: front_x 23.1, y ±17.75, z -9.5: ściana x 23.05 (pochylenie 4° od pionu), wysuw 12.55, wkręcenie 7.45
zasięg popychacza: front_x 24.6, y ±17.75, z -9.5: ściana x 24.55 (pochylenie 4° od pionu), wysuw 11.05, wkręcenie 8.95
OK: brak kolizji (80 zadań OpenSCAD, $fn=32; kontrole pozytywne trafiają; GrabCAD sprawdzony (adapter też przy yaw ±2))
```
`test/export.sh` (PROFILE jak wyżej):
- wszystkie STL są manifold: 1 bryła, próbka 8 brył, 0 naprawionych krawędzi;
- `float_check.py` nie znajduje wysp bez podparcia;
- osłona i gałka nie mają nawisów > 45°;
- w osłonie i tubie nie ma brimu (`gcode_check.py`).

`overhang.py` wypisuje dla adaptera i klatki te same nawisy co dla STL v0.4: płaskie cięcie palców żeńskich pod
blatem, nogi do kasku, zderzaki kamer, mostki. Wyjątek: zniknął sufit pułapki nakrętki (41,6 mm²), bo pułapka jest
teraz otwarta ukośnie do przodu. Próbka nie ma nawisów > 45° (tak samo jak próbka v0.4).

PrusaSlicer zgłasza dla klatki „Collapsing overhang, Long bridging extrusions” (identycznie dla klatki v0.4). Dla
próbki zgłasza „Loose extrusions”, choć żaden z jej wycinków osobno nie daje ostrzeżenia. Można ją podzielić na
obiekty w slicerze.

### Do zmierzenia
- **S2 (przed drukiem adaptera):**
  - przednia ściana gogli przy y ±17,75 na wysokości z −8…−11 (`pad_z`): położenie, płaskość, czy nic tam nie wystaje;
  - `front_x` (M6);
  - wytrzymałość ściany pod jednym popychaczem.

  GrabCAD (oryginalne HDO, „wymiary niedokładne”) mówi, że zaokrąglenie krawędzi kończy się na z ≈ −10,4, a na −9,5
  ściana jest 0,05 mm za `front_x`.
- **M5:** wysokość blatu nad osią okularów (`seat_above_eye`) → `axis_rel_seat`.
- **M4:** pochylenie blatu (`seat_pitch`) — rowki zapadek i podziałka idą za nim.
- **M1/M2:** śruba wentylatora i to, co jest pod nią (`post_relief`).
- **Kamery suwmiarką:**
  - `th_*`, `ir_*`, położenie otworów M2;
  - długość obiektywów (osłona: 0,55 mm za szkłem Infra);
  - śruby M2 z zestawu (długość, łeb);
  - średnica przewodów (kanał Ø3,2 z wejściem 2,5; S5).
- **H1–H3 (kask):** `helm_z`, zakres kąta klamry (przy 90° dotyka belki).

**Próbka** (`coupon`, przed resztą):
1. Para szczelin składająca się ręką bez luzu → `gp_slit`.
2. Na wycinkach z gałką i M5×20:
   - czy klik na 0/10/20 jest wyczuwalny i czy wypustka siada w rowku;
   - moment poślizgu na sucho (waga bagażowa na wycinku klatki, ramię znane);
   - czy wypustka się ścina, czy rozgniata rowek;
   - czy nakrętka wchodzi ukośnie w pułapkę.

### Znane braki / otwarte
- Zapadki dają tylko 0/10/20 (patrz odstępstwo). Wypustka 0,2 mm na ścianie pionowej jest na granicy dokładności FDM,
  dlatego rozstrzyga próbka.
- Zapas przegubu do bezpiecznika zależy od μ (0,2 vs 0,35). To problem odziedziczony po v0.4, zapadki dokładają
  0,2–0,34 N·m.
- Popychacze mają wysuw 11–14 mm (M3×20 wystający w powietrzu). Oś wchodzi w blok dopiero na x 35,6, bo pod blatem
  wszystko musi rosnąć ze skosem 45° od płaszczyzny `keep_x`.
- Gałka siedzi między palcem a słupkiem +y. Słupek i podpora zasłaniają od boku pas ≈5 mm przez tylną część gałki,
  przód i dół są dostępne. Próba w rękawicach (P6).
- Podziałka −y jest widoczna tylko z prawej strony nad podporą, a przy założonych goglach w ogóle niewidoczna.
  Pozycję rozpoznaje się po kliknięciach i kącie klatki.
- Wiązka przewodów za klatką (poza 8 mm ogona w modelu) jest prowadzona ręcznie. Test sprawdza tylko odcinek przy klatce.
- Model GrabCAD to oryginalne HDO; HDO2 może mieć inny przód (S2).

---

## tactical_mount.scad — v0.5 PANCERZ+ — odrzucona 2026-11-06 (czop zamiast GoPro) — nie drukować, zostaje jako źródło pomysłów

> Adam 2026-11-06: przy kamerze zostaje przegub GoPro, więc czop i bezpiecznik PA66 odpadają. Popychacze i osłona
> przednia przeszły do `camera_mount.scad` v0.6 (wyżej). Opis niżej dotyczy v0.5 i nie był aktualizowany. Zdanie o
> v0.4 jako wersji zapasowej jest nieaktualne: `camera_mount.scad` to teraz v0.6, a v0.4 jest w historii git.


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
