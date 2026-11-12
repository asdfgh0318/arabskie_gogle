# cad/ — części drukowane

## camera_mount.scad — mocowanie kamer i gogli do kasku na HDO2 (v0.6, WERSJA ROBOCZA, 2026-11-06)
Decyzje Adama z 2026-11-06:
1. Przy kamerze zostaje przegub GoPro („wierzę, że mocowanie GoPro puści pierwsze”), więc czop i bezpiecznik PA66 z
   v0.5 odpadają.
2. Dodatkowe +12 g masy — zgoda.
3. Przewody z tyłu u góry klatki — zgoda.
4. Nowe: indeksowany kąt kamery na wypustkach — tak podaje nagłówek `camera_mount.scad`; wiersz z 2026-11-06 w tabeli
   decyzji (`ZALOZENIA.md` §4) zapisuje tylko punkty 1–3. Adam potwierdził 2026-11-12, że to było jego zlecenie (`ZALOZENIA.md` §4).

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
| Adapter (kamera z przodu, popychacze, nogi do kasku nad płytką) | `stl/print_adapter.stl` | tyłem w dół (stoi, 57 mm), brim 5 mm zewnętrzny | 56 min / 11,9 g |
| Osłona przednia | `stl/print_shroud.stl` | przodem w dół (stoi, 30 mm), brim 5 mm zewnętrzny | 26 min / 6,3 g |
| Gałka | `stl/print_knob.stl` | wierzchem w dół, gniazdem łba do góry | 5 min / 0,9 g |

Masa wszystkich części v0.6 (adapter, klatka, osłona, gałka): **28,1 g** (z brimem). To samo cięcie dla STL v0.4 daje adapter 9,3 g + klatka 9,0 g =
18,3 g, więc **v0.6 = +9,8 g** (zgoda była na +12). Przy 2 obwodach: 9,1 + 7,5 + 6,1 + 0,75 = 23,5 g.
Te 18,3 g to adapter v0.4 z brimem 5 mm (9,32 g) + klatka (8,99 g); bez brimu adapter waży 9,20 g, razem 18,2 g, i tę
liczbę podaje archiwalny opis v0.5 (STL v0.4 z commitu `6217b93` pocięte ponownie 2026-11-11, PrusaSlicer 2.7.2).
Profil: „Original Prusa MK4 Input Shaper 0.4 nozzle” + „0.20mm SPEED @MK4IS 0.4” + „Generic PETG @PGIS” (spłaszczony
`mk4_petg.ini`, ten sam co w projekcie Rotorwing), przy czym 4 obwody są ustawione z linii poleceń. **Tego pliku nie
ma w repo** — patrz „Pliki generowane i profil slicera” niżej.

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
./test/run_clash.sh                                          # kolizje (80 zadań; 2026-11-11: ok. 7 min w nightly, 17–20 min w OpenSCAD 2021.01, 8 zadań równolegle; wynik: OK, ten sam w obu)
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
  - Razem **1,51–1,66 N·m przy μ 0,2** i 2,50–2,65 N·m przy μ 0,35. To moment **na osi M5 (x 33,6)**, a nie w
    bezpieczniku.
  - Po takim uderzeniu wypustki mogą być ścięte. Wtedy przegub działa dalej na samo tarcie; przedruk klatki.
- **Przegub a bezpiecznik** (ECHO `bezpiecznik`, [calc]; μ, τ, 25 MPa, moment ręki i docisk popychaczy to założenia):
  - Bezpiecznik to przekrój 10 × 8 mm na x 14: 10 × 8² / 6 × 25 MPa = **2,67 N·m**.
  - Siła na obiektywie działa na bezpiecznik na dłuższym ramieniu niż na przegub. Stosunek ramion dla siły
    **pionowej** przy tilt 0/10/20: soczewka termo 1,53 / 1,56 / 1,63, Infra 1,40 / 1,39 / 1,39. Dla siły czołowej:
    termo 1,42 / 1,27 / 1,20, Infra 0,61 / 0,66 / 1,74. Siła przechodząca przez oś M5 w ogóle nie obraca przegubu.
  - Docisk popychaczy (2 × 5–15 N × 14 mm = 0,14–0,42 N·m) też idzie przez bezpiecznik: dodaje się przy sile w górę
    na obiektywie, odejmuje przy sile w dół.
  - Moment w bezpieczniku w chwili poślizgu przegubu, siła pionowa na soczewce:

    | gałka | μ | poślizg na osi M5 | w bezpieczniku | z dociskiem popychaczy | wobec 2,67 N·m |
    |---|---|---|---|---|---|
    | 0,3 N·m | 0,2 | 1,51–1,66 | 2,10–2,70 | 1,68–3,12 | nierozstrzygnięte |
    | 0,3 N·m | 0,35 | 2,50–2,65 | 3,48–4,31 | 3,06–4,73 | bezpiecznik pęka pierwszy |
    | 0,4 N·m | 0,2 | 1,95–2,10 | 2,72–3,41 | 2,30–3,83 | nierozstrzygnięte |
    | 0,4 N·m | 0,35 | 3,27–3,42 | 4,55–5,56 | 4,13–5,98 | bezpiecznik pęka pierwszy |

  - 0,3 N·m to wartość, z której liczony jest docisk M5 (`F_m5`); 0,4 N·m to górna granica z opisu gałki
    (≈0,2–0,4 N·m [A]). Która obowiązuje — nieustalone.
  - **Wniosek: obliczenie nie potwierdza, że przegub puszcza przed bezpiecznikiem.** Poprzednia wersja tego opisu
    porównywała 1,51–1,66 N·m na osi M5 wprost z ≈2,6 N·m w bezpieczniku, bez ramienia i bez docisku popychaczy.
    Z ramieniem wynik jest nierozstrzygnięty przy μ 0,2 i odwrotny przy μ 0,35.
  - **Rozstrzyga dopiero próbka** (waga bagażowa na wycinku klatki, na sucho, z gałką dokręconą ręką) albo zmiana
    geometrii. `fuse_core` nie był zmieniany. **Adam 2026-11-12: zostaje przegub, geometria bez zmian**
    (`ZALOZENIA.md` §4) — kolejność trzeba więc sprawdzić na próbce przy pierwszym wydruku; do tego czasu jest
    niepotwierdzona.

### Bezpieczeństwo (kolejność zniszczenia — wyliczona, nie zmierzona i **nieustalona**)
Zamierzona kolejność: poślizg przegubu → **bezpiecznik w adapterze** (przewężenie za przednimi śrubami, 2,67 N·m
zginania [calc]) → nogi klatki (≈5 N·m). Pierwsze dwa kroki nie są potwierdzone: przegub puszcza przy 1,51–1,66 N·m
na osi M5 (gałka 0,3 N·m, μ 0,2, z zapadkami), co przy sile pionowej na soczewce daje w bezpieczniku 2,10–2,70 N·m,
a z dociskiem popychaczy 1,68–3,12 N·m (tabela wyżej). Przy μ 0,35 albo mocniej dokręconej gałce bezpiecznik może
pęknąć, zanim przegub się obróci. Decyzja Adama z 2026-11-06 („mocowanie GoPro puści pierwsze”) opiera się więc na
założeniu, którego to obliczenie nie potwierdza.

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

Błąd albo ostrzeżenie OpenSCAD w którymkolwiek zadaniu jest błędem testu („NIEZALICZONE”, kod wyjścia 1), także
gdy wynik przecięcia jest pusty. Część z modelem GrabCAD wymaga pliku lokalnego (poza repo); bez niego skrypt ją
pomija i pisze to w ostatniej linii.

**Wynik (2026-11-11, z lokalnym modelem GrabCAD, kod wyjścia 0):**
```
pomiar: korpus klamry GoPro kasku wolny (vs adapter z belką, gałka, klatka tilt 10) przy kątach [°, 0 = do góry, + = do przodu]: -30 -15 0 15 30 45 60 75
zasięg popychacza: front_x 21.6, y +17.75, z -9.5: ściana x 21.55 (pochylenie 4° od pionu), wysuw 14.05, wkręcenie 5.95
zasięg popychacza: front_x 21.6, y -17.75, z -9.5: ściana x 21.55 (pochylenie 4° od pionu), wysuw 14.05, wkręcenie 5.95
zasięg popychacza: front_x 23.1, y +17.75, z -9.5: ściana x 23.05 (pochylenie 4° od pionu), wysuw 12.55, wkręcenie 7.45
zasięg popychacza: front_x 23.1, y -17.75, z -9.5: ściana x 23.05 (pochylenie 4° od pionu), wysuw 12.55, wkręcenie 7.45
zasięg popychacza: front_x 24.6, y +17.75, z -9.5: ściana x 24.55 (pochylenie 4° od pionu), wysuw 11.05, wkręcenie 8.95
zasięg popychacza: front_x 24.6, y -17.75, z -9.5: ściana x 24.55 (pochylenie 4° od pionu), wysuw 11.05, wkręcenie 8.95
OK: brak kolizji (80 zadań OpenSCAD, $fn=32; kontrole pozytywne trafiają; GrabCAD sprawdzony (adapter też przy yaw ±2))
```
`test/export.sh` (PROFILE jak wyżej):
- render idzie do katalogu tymczasowego; błąd albo ostrzeżenie OpenSCAD kończy skrypt kodem 1 przed sprawdzaniem i
  bez ruszania `stl/`; plik w `stl/` jest podmieniany tylko wtedy, gdy zmieniła się geometria (`stl_same.py`);
- wszystkie STL są manifold: 1 bryła, próbka 8 brył, 0 naprawionych krawędzi;
- `float_check.py` nie znajduje wysp bez podparcia;
- osłona i gałka nie mają nawisów > 45°, mostów > 10 mm ani płaskich wsporników (`overhang.py`, tu wynik jest
  sprawdzianem);
- w osłonie i tubie nie ma brimu (`gcode_check.py`, tylko z PROFILE).

Ostatnia linia bez PROFILE (2026-11-11, kod wyjścia 0):
```
OK: render bez błędów, STL manifold, bez wysp w powietrzu, osłona i gałka bez nawisów > 45°, mostów > 10 mm i płaskich wsporników; adapter, klatka i próbka: 40 pozycji informacyjnych wyżej (nie są sprawdzianem)
```

**`overhang.py`** szuka trzech rzeczy w orientacji do druku: „nawis” (ściana w dół bardziej niż 45°, skupisko
≥ 1 mm²), „most” (płaski sufit podparty z dwóch stron, rozpiętość > 10 mm) i „wspornik płaski” (płaski sufit
podparty z jednej strony, wysięg > 1,35 mm i ≥ 1 mm²). Progi to założenia skryptu, nie wynik prób druku; raster
0,1 mm, więc wymiary ±0,2 mm; skrypt nie zna slicera. Własne kontrole: `overhang.py --selftest` (9 brył, 5 musi
być wykrytych, 4 muszą przejść). Dla adaptera, klatki i próbki lista jest **tylko informacyjna** (nie wpływa na kod
wyjścia `export.sh`), a wypisuje 40 pozycji (współrzędne wydruku):
- **adapter, 16 pozycji:**
  - 13 nawisów 1,9–15,5 mm² (z 0,2–4,4 oraz 23,5 i 24,4);
  - 3 płaskie wsporniki na z 38,1: dwa o suficie 4,4 × 3,0 mm (wysięg 4,4 mm, przy y 0,0 i 6,3) i jeden
    4,8 × 8,0 mm, 36,1 mm² (wysięg 4,8 mm, przy y −8,8).
- **klatka, 17 pozycji:**
  - 12 nawisów 3,1–4,7 mm² (z 0,1, 7,7 i 10,0);
  - **most 18,5 mm**: sufit 9,7 × 18,5 mm, 179,5 mm², na z 15,9;
  - 4 płaskie wsporniki 2,1 × 3,0 mm (wysięg 2,1 mm) na z 20,4.
- **próbka, 7 pozycji:** bez nawisów; 7 płaskich wsporników o tych samych wymiarach co w adapterze i klatce (4 ×
  2,1 × 3,0 na z 3,4; 2 × 4,4 × 3,0 i 1 × 4,8 × 8,0 na z 3,6).

Czy te mosty i wsporniki wydrukują się bez podpór, **nie jest sprawdzone** — części nie były zmieniane ani
drukowane. Do decyzji Adama: ocenić na pierwszym wydruku, dodać podpory w slicerze albo zmienić geometrię.

PrusaSlicer zgłasza dla klatki „Collapsing overhang, Long bridging extrusions” (identycznie dla klatki v0.4). Dla
próbki zgłasza „Loose extrusions”, choć żaden z jej wycinków osobno nie daje ostrzeżenia. Można ją podzielić na
obiekty w slicerze.

### Do zmierzenia
- **U1 (przed jakimkolwiek drukiem; `research/09_hdo2_net_open_items.md`, TL;DR 1 i §5):** odepnij przednią nakładkę
  gogli (faceplate) i sprawdź, czy osłona wentylatora zostaje na białej skorupie, czy schodzi razem z nakładką.
  - Research 09 nie rozstrzyga tego z sieci: w oryginalnym HDO wentylator jest w nakładce, a dla HDO2 źródła są
    sprzeczne.
  - Cały adapter zakłada gniazdo wentylatora na skorupie. Jeśli gniazdo jest na zatrzaskiwanej nakładce, adapter z
    kamerami i obciążeniem z kasku wisiałby na części trzymanej zatrzaskami, co zagraża regule kierunku ≤0,5°.
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
- **Kolejność przegub → bezpiecznik nie jest ustalona** (patrz „Przegub a bezpiecznik”): przy μ 0,2 obliczenie jest
  nierozstrzygnięte, przy μ 0,35 pierwszy pęka bezpiecznik. Zapadki dokładają do poślizgu 0,2–0,34 N·m.
- `overhang.py` wypisuje w klatce most 18,5 mm, a w adapterze, klatce i próbce płaskie wsporniki 2,1–4,8 mm
  (patrz „Testy”). Drukowalność bez podpór niesprawdzona.
- Popychacze mają wysuw 11–14 mm (M3×20 wystający w powietrzu). Oś wchodzi w blok dopiero na x 35,6, bo pod blatem
  wszystko musi rosnąć ze skosem 45° od płaszczyzny `keep_x`.
- Gałka siedzi między palcem a słupkiem +y. Słupek i podpora zasłaniają od boku pas ≈5 mm przez tylną część gałki,
  przód i dół są dostępne. Próba w rękawicach (P6).
- Podziałka −y jest widoczna tylko z prawej strony nad podporą, a przy założonych goglach w ogóle niewidoczna.
  Pozycję rozpoznaje się po kliknięciach i kącie klatki.
- Wiązka przewodów za klatką (poza 8 mm ogona w modelu) jest prowadzona ręcznie. Test sprawdza tylko odcinek przy klatce.
- Model GrabCAD to oryginalne HDO; HDO2 może mieć inny przód (S2).

---

## tactical_mount.scad — v0.5 PANCERZ+ — odrzucona 2026-11-06 — nie drukować

Adam 2026-11-06: przy kamerze zostaje przegub GoPro, więc czop i bezpiecznik PA66 odpadają. Popychacze i osłona
przednia przeszły do `camera_mount.scad` v0.6 (wyżej). Pełny opis v0.5 (części, montaż, testy, przegląd R1, erraty
specyfikacji) jest w archiwum: [`spec/v05_tactical_README.md`](spec/v05_tactical_README.md), specyfikacja w
[`spec/v05_tactical_spec.md`](spec/v05_tactical_spec.md). Oba pliki nie są aktualizowane.

W repo zostają jako źródło pomysłów: `tactical_mount.scad`, `test/tactical_clash.scad`, `test/run_tactical_clash.sh`,
`test/export_tactical.sh`, `stl/tac_*.stl` (6 plików) i `img/tac_*.png` (4 pliki). **Żadnego z nich nie drukować.**
`test/export_tactical.sh` ma teraz kończyć się „NIEZALICZONE” (płaskie wsporniki w BASE wykrywane przez nowy
`overhang.py`); tak zostaje, bo wersja jest odrzucona — do decyzji Adama, czy to zmienić.

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

**Sterowanie (v0.2):** enkoder + przycisk **CAM**; co robi obrót, krótkie i długie wciśnięcie — `firmware/README.md`
(rozstrzyga kod). Przycisk AUX z v0.1 usunięty: nie dawał się wydrukować, nie miał skoku i leżał na drodze
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
`cad/test/run_pod_clash.sh` sprawdza 40 zadań OpenSCAD: 37 par części i atrap elektroniki, w tym wsuwanie płytki
od spodu (16 mm) i ruch nakładki CAM do ogranicznika (czy nie dotyka wieka), oraz 3 kontrole pozytywne, które muszą
trafić: nakładka 1,6 mm za ogranicznikiem → wieko, wsuwanie płytki przesuniętej o 1,5 mm w x → obudowa, gałka
opuszczona o 1 mm w wieko → obudowa. Błąd albo ostrzeżenie OpenSCAD jest błędem testu („NIEZALICZONE”, kod
wyjścia 1), a nie wynikiem „czysto”. Wynik 2026-11-11 (ok. 5 s w nightly, ok. 3 min w OpenSCAD 2021.01, 8 zadań równolegle):
```
OK: brak kolizji w podzie (40 zadań OpenSCAD: w tym wsuwanie płytki i ruch CAM do ogranicznika; 3 kontrole pozytywne trafiają)
```
Podgląd: `img/pod_assembly.png` (pod z gałką i nakładką CAM), `img/pod_inside.png` (wnętrze od spodu, z atrapami elektroniki) —
obrazy z commitu poda v0.2 (`086686f`), nieodświeżane po v0.2.1.

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
AI Box ma 33,5×33,5×16,5 mm i otwory 25,5×25,5 (rysunek wymiarowy BZB, „Unit: mm”). Grafika z wymiarami z tego
samego zestawu podaje dla tych otworów „25mm”; w pliku zostaje `hole = 25.5` do pomiaru (piloty Ø1,8 pod M2, więc
0,5 mm ma znaczenie). Stoi na prawym boku, przed gniazdem AV, bo:
- tam są gniazdo AV i zasilania HDO2, więc przewody CVBS i zasilania są krótkie;
- równoważy masę poda po lewej.

Płytka 38×37 mm na taśmie VHB 5952, 4 dystanse M2 o wysokości 5 mm (miejsce na złącze kamer na spodzie boxa),
szczeliny na opaskę przy przedniej krawędzi. Płytka zasłania drzwiczki Expansion Bay.

Do sprawdzenia po dostawie:
- **rozstaw otworów AI Boxa (25,5 czy 25) — przed drukiem uchwytu**;
- długość przewodów kamera ↔ box (z przodu do prawego boku to ok. 80–100 mm);
- położenie złącza kamer;
- pomiar P3 (07b).

## scene_all.scad — wszystko na HDO2 (podgląd)
Domyślnie (`hdo_model = false`, działa po świeżym klonie) gogle to bryła zastępcza z wymiarów (research/04, 06,
07b), nie model producenta; położenie zatok, gniazd AV i drzwiczek jest przybliżone. Pełnego modelu HDO2 nie
znaleziono: na Printables są tylko akcesoria i przednie skorupy Walksnail/Dominator.

Opcjonalnie zamiast bryły zastępczej można wczytać model GrabCAD **oryginalnego HDO** (nie HDO2; autor pisze, że
wymiary są niedokładne). To plik lokalny w `papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/`, którego nie ma
w repo:
```
openscad scene_all.scad                                                   # bryła zastępcza
openscad -D hdo_model=true scene_all.scad                                 # model GrabCAD, podgląd F5 (niesprawdzony z wiersza poleceń)
openscad -D hdo_model=true -D 'which="hdo2"' -o hdo.stl scene_all.scad    # sam model
```
Pełny render z modelem GrabCAD (F6 albo `-o plik.stl`) kończy się „ERROR: The given mesh is not closed!” i eksportem
bez gogli, bo siatka modelu nie jest zamknięta (wg nagłówka `scene_all.scad`; tu nie powtarzane). Z bryłą zastępczą
render całości (`openscad -o all.stl scene_all.scad`) przechodzi bez błędów i ostrzeżeń (2026-11-11: ok. 4 min w OpenSCAD 2021.01, 2 s w nightly). `scene_all.scad` ustawia teraz `$fn = 64` sam: `use` nie przenosi `$fn` z `camera_mount.scad`, przez co wycięcie strefy widzenia w osłonie było w podglądzie całości liczone z `nan` (nightly zgłasza to ostrzeżeniem, 2021.01 milczał); części do druku i `web/index.html` nie były tym dotknięte. Przy `hdo_model = true` pod i AI Box stoją na współrzędnych zatok z modelu GrabCAD.

Plik `hdo_grabcad_goggle_frame.stl` jest już przeliczony na układ gogli (research/08). **Skryptu ani zapisu tego
przeliczenia (STEP → STL, przesunięcie i obrót) nie ma w repo**, a `test/grabcad_check.py` i `test/pusher_reach.py`
mają przód modelu wpisany na stałe (21,7). Jeśli lokalny plik zginie, części testu kolizji z modelem GrabCAD nie da
się odtworzyć z samego repo; bez pliku `run_clash.sh` tę część pomija.

### Podgląd w przeglądarce (`web/`)
`cd cad/web && python3 -m http.server 8765`, potem http://127.0.0.1:8765/ (bez internetu). `web/index.html` pokazuje
**tylko mocowanie kamer v0.6** (adapter, gałka, śruby, klatka, osłona, kamery, początek przewodów) na prostopadłościanie
zastępczym gogli (`hdo2_ghost()` z `camera_mount.scad`), przy pochyleniu 10°. Poda i AI Boxa w nim nie ma.
Przebudowa: `python3 cad/web/build_viewer.py` (z dowolnego katalogu, wymaga `openscad`); przy błędzie eksportu
którejkolwiek części plik nie jest zapisywany. Z lokalnym modelem GrabCAD ten sam skrypt buduje też `web/full.html`,
który jest w `.gitignore`. Biblioteki three.js: `web/lib/README.md`.

## Pliki generowane i profil slicera
- **`stl/*.stl` (17 plików, ASCII, ok. 12 MB) i `web/index.html` (ok. 1 MB) to pliki generowane, trzymane w repo**,
  żeby dało się drukować i oglądać model bez OpenSCAD. Źródłem są pliki `.scad`: gdzie STL i `.scad` się różnią,
  rozstrzyga `.scad`, a STL trzeba wyeksportować ponownie.
  - `print_*.stl`, `coupon.stl`: `./test/export.sh` (v0.6). Skrypt podmienia plik tylko przy zmienionej geometrii.
  - `tac_*.stl`: `./test/export_tactical.sh` — odrzucona v0.5, **nie drukować**.
  - `pod_*.stl`: eksport z `pod.scad` (`-D 'part="print_…"'`); osobnego skryptu eksportu poda nie ma.
  - `web/index.html`: `python3 cad/web/build_viewer.py`.
  - Żaden test nie sprawdza automatycznie, czy pliki w `stl/` odpowiadają bieżącym `.scad`; pewność daje tylko
    ponowny eksport.
  - Czy STL i `tac_*` mają zostać w repo w tej postaci (ASCII, razem z bieżącymi), to decyzja Adama — nie podjęta.
- **Profil slicera `mk4_petg.ini` jest poza repo** (leży w innym projekcie Adama i może być tam zmieniany). Bez niego
  z klonu nie da się odtworzyć: czasów i mas z tabel w tym pliku (m.in. 28,1 g, +9,8 g, 23,5 g), kontroli brimu w
  osłonie (`gcode_check.py`) ani ostrzeżeń PrusaSlicera. Z plikiem w stanie z 2026-11-11 i PrusaSlicerem 2.7.2
  liczby v0.6 się powtarzają (adapter 56 min 23 s / 11,89 g, klatka 35 min 1 s / 8,99 g, osłona 26 min 21 s /
  6,34 g, gałka 5 min 16 s / 0,87 g, próbka 1 h 7 min 48 s / 18,13 g); po zmianie profilu albo wersji slicera
  nie muszą. `export.sh` bez PROFILE pomija te kroki i mówi
  tylko o geometrii. Ustawienia, które skrypt podaje sam: 4 obwody (i 2 dla porównania), bez podpór, brim zewnętrzny
  5 mm dla adaptera i osłony. Reszta (prędkości, szerokości ścieżek, gęstość filamentu itd.) pochodzi z profilu;
  ten plik zapisuje z niej tylko nazwy trzech presetów, warstwę 0,2 mm i 15% wypełnienia. Wersje presetów nie
  zostały zapisane. Dodanie profilu do repo — do decyzji Adama.
- **Pliki pomocnicze testów:** `test/render_lib.sh` (wspólny render do katalogu tymczasowego), `test/stl_same.py`
  (porównanie geometrii dwóch STL niezależnie od kolejności ścian i od siatki), `test/scad_bin.sh` (wybór OpenSCAD).
- **Którym OpenSCAD (od 2026-11-11):** skrypty w `test/` i `web/build_viewer.py` biorą `openscad-nightly`, jeśli jest
  w PATH (sprawdzone z wersją 2026.11.06, backend Manifold), a inaczej zwykły `openscad`; zmienna `SCAD=…` wymusza
  program. Na częściach v0.6 nightly daje ten sam prostopadłościan otaczający i objętość zgodną do ok. 0,1 mm³
  co OpenSCAD 2021.01, w 1–2 s zamiast 20–100 s na część. Różnice, które skrypty uwzględniają:
  - siatka ma inną liczbę trójkątów, w tym kilkanaście–kilkaset o zerowym polu. `export.sh` je wypisuje, ale błędem
    siatki jest tylko zła liczba brył albo krawędź do naprawy; `stl_same.py` uznaje taką siatkę za tę samą bryłę
    (prostopadłościan do 1e-4 mm, objętość do 2e-5, pole do 1e-4), więc **pliki w `stl/` pozostały te z OpenSCAD
    2021.01** i nie są podmieniane;
  - części stykające się płaszczyznami dają w Manifold niepusty wynik o zerowej objętości (CGAL dawał pusty), więc
    w testach kolizji kolizją jest objętość > 0,001 mm³;
  - `web/index.html` został przebudowany z nightly (inna siatka, ta sama bryła); dwa kolejne buildy są identyczne.
  Nightly nie jest częścią repo: to AppImage na komputerze autora.
