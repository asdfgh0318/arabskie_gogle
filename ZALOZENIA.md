# Założenia projektowe — arabskie_gogle (WERSJA ROBOCZA)

> **Stan 2026-11-12.** Założenia nie są zamknięte, a projekt mimo to poszedł dalej: w repo są CAD v0.6
> (`cad/camera_mount.scad`), pod v0.2.1 (`cad/pod.scad`) i firmware v0.1 (`firmware/`). Pierwotny warunek „do
> zamknięcia przed jakimkolwiek CAD/firmware” nie został więc dotrzymany. **Nic nie zostało zmierzone ani uruchomione
> na sprzęcie**; nic nie było drukowane. Otwarte punkty są w §3 — pierwszy z nich (U1) trzeba zamknąć przed
> jakimkolwiek drukiem.
>
> **Który dokument rozstrzyga.** Dla faktów i liczb rozstrzygają notatki w `research/`, a za nimi wyciągi
> (`papers/extracts_*.md`) i źródła w `papers/`. O decyzjach rozstrzyga §4 tego pliku. Skrót w §1b/§1c ustępuje
> notatkom research tam, gdzie się różnią. Późniejszy pomiar na sprzęcie rozstrzyga nad jednym i drugim.

## 1. Sprzęt posiadany
| Element | Model | Status |
|---|---|---|
| Gogle | **Zakładamy Fat Shark Dominator HDO2** (1280×960 OLED, FOV 46°, AV + HDMI) — decyzja Adama 2026-11-03. Geometria w CAD nie pochodzi z pomiaru: przód HDO2 ze zdjęć i modeli społeczności (`research/06`), a bryła w testach kolizji z modelu GrabCAD **oryginalnego HDO, nie HDO2** (`research/08`) | posiadane |
| Kamera | Caddx TR1-220SL Dual ([BZB UAS](https://www.bzbuas.com/pl/shop/tr1-220sl-kamera-termowizyjna-caddx-tr1-220sl-dual-3230)) | **jeszcze nie dostarczona** (odpowiedź Adama 2026-11-12: „not yet”; wpis „posiadana” z 2026-11-03 był błędny) |
| Kask | Protec — model nieistotny (mocowanie przez GoPro VHB) | posiadany |
| Mocowania | GoPro VHB (płaskie/zakrzywione?) | posiadane |
| Sterownik | ~~ESP32 / Seeed XIAO (ESP32-C3/S3?) — do wyboru~~ → **Seeed XIAO ESP32-C3**: propozycja 1c.7 (`research/05`), pod nią napisane są `cad/pod.scad` i `firmware/` | brak, elektronika niekupiona |

### 1a. Caddx TR1-220SL Dual — dane ze strony sklepu (nie z instrukcji producenta)
- Wyjście: analog CVBS, **PAL**; średnie opóźnienie 20 ms (wg sklepu)
- Zasilanie **9–24 V**; każda kamera < 1,5 W; temp. pracy −10…50 °C
- AI Box 33,5×33,5×16,5 mm; waga 55 g (nie wiadomo, czy cały zestaw)
- Kamera 1 „Infra” (noktowizja): czarno-biała, 1500 TVL, **FOV 120°**, M16 2,8 mm F1.0, 0 lux, 50/60 fps, 20×20,5×34,5 mm
- Kamera 2 termo: VOx 256×192, 4 mm F1.0, **FOV 50°H × 37,2°V** (62,3° D), IFOV 3,43 mrad, 50 fps, 19,5×19,5×20 mm
- W zestawie: kabel 3-pin, **kabel GPIO** (przełączanie między kamerami — sygnał nieopisany na stronie sklepu; patrz 1c.5)
- Wg Adama: system = moduł termo z rodziny **Caddx Eclipse (najniższa rozdzielczość, 256×192)** + druga kamera (Infra) w jednym AI Boxie → szukać dokumentacji sterowania Eclipse.
- ~~**Brak danych:** protokół sterowania (UART?), pinout, palety, zoom, PiP, instrukcja → zdjęcia złącz + pomiar, ew. support@caddxfpv.com~~ → `research/03` (skrót w 1c.5): dokumentu Caddx dla samego TR1-220SL nadal nie ma; prawdopodobny interfejs pochodzi z instrukcji siostrzanego Eclipse 004 Dual i **czeka na potwierdzenie na stole** (`research/03` §4). Zoom i PiP — brak w udokumentowanym interfejsie.

### 1b. Wnioski z dopasowania (do weryfikacji)
- Obraz PAL CVBS → wejście AV gogli bezpośrednio; HDMI niepotrzebne.
- ~~Termo 50°H na HDO2 46° → ~0,92×~~ **BŁĄD** (porównanie przekątnej z poziomem). HDO2 46° to przekątna → ekran ≈37,5°H × 28,6°V → termo **≈0,75×** (25% pomniejszenia) — `research/02` §1.2 → świat „mniejszy i dalszy”, istotne przy chodzeniu (ocena odległości, stopnie).
- Noktowizja 120° → **≈0,38×** + dystorsja; PAL przenosi max ≈390 TVL, więc „1500 TVL” nie dociera do gogli — `research/02`
- Zasilanie — **decyzja Adama 2026-11-12: pakiet 4S Li-ion (12,0–16,8 V), tak jak Adam zasila swoje HDO** (§4). To jest **powyżej zakresu z instrukcji HDO2** (7–13 V, Rev C p.11; `research/04` §1.2 i `research/05` §4 przewidują dla 4S przetwornicę do gogli) — Adam opiera się na własnej praktyce, nie na dokumencie; ryzyko po stronie gogli jest jego świadomym wyborem. Kamera (9–24 V) mieści się w 4S bez regulatora. Wniosek sprzed decyzji: HDO2 **7–13 V**, kamera 9–24 V → wspólny zakres **9,0–12,6 V = 3S Li-ion** bez regulatora, pod warunkiem odcięcia ≥3,0 V/ogniwo. 4S przekracza 13 V gogli, LiHV też (13,05 V). Alarm baterii HDO2 (6,8 V) na 3S bezużyteczny → własny pomiar napięcia — `research/04`, `05`
- Sterownik: przynajmniej przełączanie kamer przez GPIO; reszta zależy od odkrytego interfejsu (dziś: 1c.5, `research/03`).

### 1c. Wnioski z researchu 2026-11-03 — status każdego punktu wg tabeli decyzji (§4)
Źródło: `research/01`–`05` (wersje robocze, zweryfikowane adwersarialnie; tam cytaty i poziomy pewności). To jest
skrót: co do faktów i liczb ustępuje notatkom research (reguła w nagłówku).

Statusy: **PRZYJĘTE** = §4 zapisuje akceptację; **ZASTĄPIONE** = §4 zapisuje inną decyzję; **PROPOZYCJA** = §4 nie
zapisuje akceptacji, także wtedy, gdy CAD albo firmware zostały już pod ten punkt napisane. Punkty 1–5, 7 i 9 Adam
przyjął 2026-11-12 („ok”, §4); akceptacja dotyczy kierunku — liczby i interfejsy dalej czekają na pomiar i próbę
na sprzęcie (§3).

1. **PRZYJĘTE** 2026-11-12 (miejsce doprecyzowane decyzjami §4 z 2026-11-03: adapter na gnieździe wentylatora na górze gogli, kamery przed przednią ścianą; `cad/camera_mount.scad` v0.6 jest pod ten punkt zbudowany). **Pozycja kamery:** na froncie HDO2, w osi między oczami, termo możliwie na wysokości oczu (0…+35 mm), Infra **nad** termo (nie obok). Nie na szczycie kasku. Offset do przodu tani, w górę drogi; w bok — unikać, choć nie zmierzono go osobno (Mullins 2008: +17,8 cm do przodu → +2,9% czasu; w górę → +14,2% czasu, +14,3% błędów; w górę i w bok razem → +16,1% czasu, +19,9% błędów; istotna statystycznie jest różnica czasu). — `01`
2. **PRZYJĘTE** 2026-11-12 (v0.6 ma pod ten punkt popychacze yaw; zagraża mu otwarty punkt U1, §3). **Zbieżność w poziomie (yaw) ≤0,5°** między kamerą a goglami (inaczej „chodzenie po łuku”; źródło wtórne Rash 2009 → Melzer & Moffitt 2007) → mocowanie sztywne, kluczowane, kamera na skorupie gogli, nie na kasku. — `01`
3. **PRZYJĘTE** 2026-11-12. **Domyślna kamera: termo** (≈0,75×), Infra pod przyciskiem jako „szeroki rzut”. 1:1 nieosiągalne bez cropu 1,33× — nie gonić w v1. — `02`
4. **PRZYJĘTE** 2026-11-12 (v0.6 ma zapadki 0/10/20° — zlecenie Adama, §4). **Pochylenie kamery w dół ≈10° (regulowane 0–20°):** przy poziomej kamerze najbliższy widoczny grunt ≈4,9 m, przy 10° ≈3,0 m (obiektyw na wysokości 1,65 m — założenie, nie pomiar; d = h / tan(18,6° + pochylenie)). — `02` §1.5
5. **PRZYJĘTE** 2026-11-12 jako założenie robocze (firmware v0.1 jest pod ten punkt napisany; nic niepotwierdzone na stole). **Sterowanie kamerą (prawdopodobne, z siostrzanego Eclipse 004 Dual — do potwierdzenia na stole):** GPIO2 3,3 V = przełączanie kamer; UART 3,3 V 115200 (ramki `FF 5A…`, CRC16/MODBUS): paleta, jasność, kontrast, NUC, hot-tracking. Zoom/PiP — brak w udokumentowanym interfejsie. — `03`
6. **ZASTĄPIONE** decyzją „Pod v0.2” z 2026-11-03 (§4): **enkoder + 1 przycisk CAM**; co robi obrót, krótkie i długie wciśnięcie — `firmware/README.md` (rozstrzyga kod). ~~**Przyciski na goglach (3):** CAM (GPIO2) · PAL (paleta; długie = NUC) · BRT (jasność; długie = hot-tracking). Propozycja: enkoder Alps EC11 z push + 2× Omron B3S IP67 z drukowanymi nakładkami.~~ — `03`, `05`
7. **PRZYJĘTE** 2026-11-12 co do typu płytki i przetwornicy (firmware v0.1 i pod są napisane pod XIAO ESP32-C3); miejsce **ustalone** decyzją z 2026-11-03: pod w lewej zatoce modułu VRx (§4). **Sterownik:** XIAO ESP32-C3 (21×17,8 mm) w pudełku z przyciskami na goglach; 5 V z Pololu D36V6F5. — `05`
8. **ZASTĄPIONE co do liczby ogniw** decyzją z 2026-11-12 (§4): **pakiet 4S Li-ion, ten sam, którym Adam zasila gogle** („4s liion i power hdos”). Progi w firmware przeliczone na 4S: ostrzeżenie 13,6 V, alarm 12,8 V (te same 3,4 / 3,2 V na ogniwo). Typ ogniw, miejsce pakietu (tył kasku jako przeciwwaga?) i czas pracy na 4S bez przetwornicy — nieustalone i niepoliczone. Dotychczasowa propozycja (3S), dla zapisu: **Bateria:** 3S Li-ion (3×18650) **z tyłu kasku jako przeciwwaga**; ostrzeżenie wibracją przy ≈10,2 V (3,4 V/ogniwo), alarm krytyczny przy ≈9,6 V (3,2 V/ogniwo) — tak w `04`, `05` i w firmware. Ogniwo niewybrane: `04` liczy na Molicel P28A (≈4–5 h), `05` na Samsung 35E (≈6 h w przypadku średnim, 4,4 h w najgorszym z zimnem); do decyzji Adama energię i czas pracy rozstrzyga `05`. Wszystko na założeniach, bez pomiaru. — `04`, `05`
9. **PRZYJĘTE** 2026-11-12 (wyjęcie modułu RX wynika już z decyzji o podzie w zatoce VRx, §4). **Wideo:** CVBS do gniazda AV 3,5 mm HDO2 (tulejka = GND, pierścień 2 = Video); moduł RX wyjąć/wyłączyć; tryb Analog 4:3. — `04`
10. **PRZYJĘTE** 2026-11-06 („decyzja 1c.10 obowiązuje”, §4). **Bezpieczeństwo:** mocowanie kamery ma się odłamać przy upadku (jedna śruba M5 w przegubie GoPro, bez sztywnej dźwigni w twarz). — `04`. **Zastrzeżenie (2026-11-11):** obliczenie w `cad/README.md` („Przegub a bezpiecznik”) nie potwierdza, że przegub GoPro puści przed bezpiecznikiem adaptera. Adam 2026-11-12: zostaje przegub, bez zmian geometrii (§4); kolejność pozostaje niesprawdzona do próby na próbce.

## 2. Cel (do potwierdzenia)
Widzieć w termowizji „na żywo” z głowy podczas **chodzenia w nocy w terenie** (decyzja 2026-11-03), przy pełnym
zasłonięciu wzroku przez gogle. Obraz z kamery zamocowanej na goglach (decyzje 2026-11-03, §4) idzie do gogli;
kamerą steruje się z gogli gałką i przyciskiem: przełączanie termo ↔ Infra, paleta, jasność, kontrast, NUC.
Pierwotny zapis celu wymieniał też **zoom**; udokumentowany interfejs zoomu nie daje (1c.5 — interfejs z siostrzanej
kamery, niepotwierdzony na stole). Czy zoom zostaje w celu, Adam nie rozstrzygnął — §3. Ten akapit jest przeredagowany
2026-11-11 pod decyzje z §4 (scenariusz, miejsce kamery, pod); w całości Adam go nie potwierdził. Pierwotny zapis
(„chodzenie/jazda w nocy?”, „kamera na kasku”, „zoom”) jest w historii git.

## 3. Otwarte punkty
### Zamknięte
- [x] Scenariusz użycia: **chodzenie w nocy / teren** (2026-11-03)
- [x] **Pełne zasłonięcie** w goglach — akceptowane (2026-11-03)
- [x] Wyjście wideo: analog CVBS PAL
- [x] Przyciski: **na goglach, kompaktowo** (2026-11-03); liczba: **enkoder + 1 przycisk CAM** (decyzja „Pod v0.2”, §4)
- [x] Elementy drukowane: **kompaktowe**
- [x] Model kasku — nieistotny (2026-11-03)
- [x] Zakres zasilania wg dokumentów: HDO2 7–13 V, kamera 9–24 V (§1b; nie z pomiaru). Decyzja 2026-11-12: pakiet 4S Li-ion (§4) — poza zakresem gogli z instrukcji, wybór Adama.
- [x] Miejsce kamery: na adapterze w gnieździe wentylatora, kamery przed przednią ścianą gogli (decyzje 2026-11-03 i 2026-11-06, §4). Otwarte zostają wysokość i kierunek (1c.1, 1c.2) oraz U1 — niżej.

### Przed jakimkolwiek drukiem
- [ ] **U1 — czy gniazdo wentylatora HDO2 jest na skorupie, czy na zatrzaskiwanej nakładce przedniej (faceplate).** Odpiąć nakładkę i zobaczyć, czy osłona wentylatora zostaje na białej skorupie (ok. 30 s). `research/09_hdo2_net_open_items.md` (TL;DR 1, §5) nie rozstrzyga tego z sieci: w oryginalnym HDO wentylator jest w nakładce, dla HDO2 źródła są sprzeczne. Decyzje z 2026-11-03 (§4) i cały adapter zakładają gniazdo na skorupie. Jeśli jest na nakładce, kamery i obciążenie z kasku wisiałyby na części trzymanej zatrzaskami, co zagraża regule ≤0,5° (1c.2) — mocowanie trzeba by przemyśleć od nowa. Zapisane też w `cad/README.md` („Do zmierzenia”) i `research/06` §3.

### Decyzje Adama
- [ ] **Potwierdzić cel (§2)** w obecnym brzmieniu; **zoom** — zostaje w celu czy poza nim (udokumentowany interfejs go nie daje, 1c.5).
- [x] **Przegub czy bezpiecznik — Adam 2026-11-12: „hinge”.** Zostaje przegub GoPro jako element, który ma puścić; geometrii bezpiecznika nie zmieniamy (tak odczytana odpowiedź). Kolejność zniszczenia nadal **nie jest potwierdzona** — sprawdzić na próbce przy pierwszym wydruku („Pomiary i próby”, niżej). Treść punktu sprzed decyzji: Decyzja z 2026-11-06 opiera się na założeniu, że przegub GoPro puści pierwszy; obliczenie tego nie potwierdza (nierozstrzygnięte przy μ 0,2, odwrotnie przy μ 0,35). Możliwości: zmierzyć na próbce przed drukiem adaptera, powiększyć przekrój bezpiecznika, ograniczyć moment gałki albo przyjąć, że dla części kierunków pierwszy pęka bezpiecznik; do tego która wartość momentu gałki obowiązuje w opisie (0,3 czy 0,2–0,4 N·m). — `cad/README.md` „Przegub a bezpiecznik”, „Bezpieczeństwo”
- [x] **Indeksowany kąt kamery (zapadki 0/10/20° w v0.6)** — Adam potwierdził 2026-11-12, że to było jego zlecenie (§4).
- [x] **Akceptacja propozycji 1c.1–1c.5, 1c.7, 1c.9** — „ok”, 2026-11-12 (§4). 1c.8 (bateria) — następny punkt (4S).
- [x] **Bateria (1c.8): 4S Li-ion, pakiet Adama od gogli** (2026-11-12, §4). Zostaje otwarte: gdzie pakiet jest noszony (waga/CoG, przeciwwaga), jakie ma ogniwa i zabezpieczenie, czas pracy. Uwaga: 4S jest ponad 13 V z instrukcji HDO2 (§1b). Dotychczasowy zapis sprzed decyzji: jeden wspólny pakiet 3S Li-ion dla gogli i kamery, z tyłu kasku — czeka na akceptację (§4 nie zapisuje decyzji o 3S). **Ogniwo:** Molicel P28A czy Samsung 35E — `research/04` §1.2, `research/05` §4.1.
- [ ] **AI Box na prawym boku** (`cad/aibox_mount.scad` v0.1) — propozycja z 2026-11-03, czeka na akceptację.
- [ ] Złącze rozłączne w przewodzie zasilania kask ↔ gogle (w przyjętym układzie tylko VBAT i GND): bez złącza czy 2 styki — `research/05` §5.
- [ ] Drukowalność bez podpór: most 18,5 mm w klatce i płaskie wsporniki 2,1–4,8 mm w adapterze, klatce i próbce — ocenić na pierwszym wydruku, dodać podpory albo zmienić geometrię. — `cad/README.md` „Testy”
- [x] Szczeliny i nogi przegubu GoPro (`gp_slit` i próbka wobec `research/06` D2/D3) oraz wysokość kamery Infra `ir_h` 20,5 czy 20,0 — Adam 2026-11-12: „ok”, czyli wartości w `cad/camera_mount.scad` zostają (`gp_slit` 3,3, `ir_h` 20,5; tak odczytana odpowiedź); `gp_slit` rozstrzygnie próbka, `ir_h` pomiar kamery po dostawie.
- [ ] Firmware — zachowania przyjęte jako założenia: próg „brak pakietu” 6,0 V (poniżej niego nie ma alarmu), przerwanie wibracji przez CAM i 300 ms ciszy, wymuszenie termo po 3 s trzymania CAM, brak ramki hot-track po starcie przy ustawieniu „wyłączone”. — `firmware/README.md`, `firmware/include/config.h`
- [x] Repo: licencja — **MIT** (plik `LICENSE`, 2026-11-12; Adam: „open source”, wybór konkretnej licencji wykonawcy — do zmiany, jeśli Adam woli inną). Adres e-mail w commitach: od 2026-11-12 adres `noreply` GitHuba; 20 wcześniejszych commitów ma stary adres (zmiana wymagałaby przepisania historii publicznego repo — niezrobione).
- [ ] Repo, pozostałe: czy STL (w tym sześć `tac_*` odrzuconej v0.5) zostają w repo w tej postaci; czy dodać profil slicera; zapis, skąd i jak powstał lokalny model GrabCAD. — `cad/README.md` „Pliki generowane i profil slicera”, `scene_all.scad`; `cad/web/lib/README.md`; `papers/README.md`
- [ ] 07c: zostawić jako zapis z blokiem statusu czy wyciąć zastąpione części — `research/07c_pod_ergonomics_mount.md`, blok „Status”.

### Pomiary i próby na sprzęcie
- [ ] **Przegub przed bezpiecznikiem** — przy pierwszym wydruku sprawdzić na próbce, co puszcza pierwsze; obliczenie tego nie rozstrzyga (`cad/README.md` „Przegub a bezpiecznik”).
- [ ] **Sterowanie kamery** (otwarte od początku): co robi kabel GPIO, czy TR1 mówi protokołem `FF 5A` — po dostawie elektroniki. Lista: `research/03` §4, `firmware/README.md` „Niezweryfikowane”, `research/05` §8.
- [ ] **Gogle, kamery, kask pod mocowanie kamer:** S2 (przednia ściana pod popychaczami), M5 (`seat_above_eye`), M4, M1/M2, kamery suwmiarką, H1–H3 oraz próbka przegubu — `cad/README.md` „Do zmierzenia”, `research/06` §3.
- [ ] **Zatoka VRx pod pod:** P1 (wymiary zatoki — w `pod.scad` są zastępcze), P2 (liczba i raster pinów gniazda: 9 × 2,54 mm pochodzi z jednego projektu społeczności, niepotwierdzone dla HDO2 — `research/09` TL;DR 4), P5, P6 — `research/07b` §6, `cad/README.md` (pod).
- [ ] **AI Box:** rozstaw otworów 25,5 (rysunek wymiarowy) czy 25 (grafika z wymiarami) — przed drukiem uchwytu; długość przewodów, położenie złącza — `cad/README.md` (aibox).
- [ ] **Wysokość obiektywu termo nad ziemią** po założeniu (w 1c.4 przyjęto 1,65 m) — `research/02` §1.5.
- [ ] **Parowanie okularów bez wentylatora** (wentylator usunięty decyzją z 2026-11-03; nie sprawdzano) — `research/04` Q11.
- [ ] Czas pracy i próg wyłączenia kamery na prawdziwym pakiecie — `research/04` (Q10), `research/05` §8.
- [ ] Odniesienie boczne przodu gogli (krawędzie drzwiczek 62,7 mm po obu stronach czy 65,4 / 60,0 mm) — dotyczy tylko wariantu zapasowego z podem na przedniej ścianie; `research/07b` §0.
- [ ] Rzeczywista średnica otworu GoPro (modele dzielą się na ok. 5,0–5,1 i ok. 5,5 mm; nie blokuje) — `research/06` D6.

Źródła, których nie udało się pobrać (do ręcznego pobrania przez Adama, jeśli chce): `papers/README.md` „Nie pobrane”.

## 4. Decyzje
Kolejność wg daty (w obrębie dnia wg commitów). Przekreślone = zastąpione późniejszym wierszem.

| Data | Decyzja |
|---|---|
| 2026-11-03 | Scenariusz: chodzenie w nocy / teren |
| 2026-11-03 | Gogle: zakładamy HDO2 |
| 2026-11-03 | Pełne zasłonięcie wzroku akceptowane |
| 2026-11-03 | Przyciski na goglach, kompaktowo; druki kompaktowe |
| 2026-11-03 | Repo publiczne: github.com/asdfgh0318/arabskie_gogle |
| 2026-11-03 | **Wentylator HDO2 usunięty** — mocowanie kamer wchodzi na jego miejsce (gogle nie będą szczelne do twarzy, wentylacja zbędna). Miejsce doprecyzowane w następnym wierszu. Parowanie bez wentylatora niesprawdzone (§3) |
| 2026-11-03 | Research 06: wentylator jest **na górze** gogli (nie z przodu) → adapter = płytka na 4 śrubach 20×20 + ramię do przodu, kamery wiszą przed przednią ścianą (`cad/`, v0.2). Otwarte od 2026-11-06: czy to gniazdo jest na skorupie, czy na zatrzaskiwanej nakładce (U1, §3) |
| 2026-11-03 | **Pod sterownika w lewej zatoce modułu VRx** (zamiast drzwiczek, moduł RX wyjęty); obsługa **lewą ręką**, **cienkie rękawice** — research 07b/07c, `cad/pod.scad` (wtedy v0.1; dziś v0.2.1) |
| 2026-11-03 | Pod v0.2: **enkoder + 1 przycisk CAM** (AUX usunięty po przeglądzie; PAL/BRT/NUC na obrocie i krótkim/długim wciśnięciu enkodera) — `cad/README.md`. Zastępuje propozycję 1c.6. Dokładne przypisanie funkcji: `firmware/README.md` |
| 2026-11-03 | **Gogle do kasku też przez gniazdo wentylatora, w tej samej części co kamera**: adapter ma z przodu przegub kamery, nad płytką 2 nogi GoPro do klamry na **podstawce VHB z przodu kasku** (`cad/camera_mount.scad`, wtedy v0.4; dziś v0.6 z tym samym układem) |
| 2026-11-03 | PROPOZYCJA (do akceptacji, nadal otwarta — §3): **AI Box na prawym boku** przy gnieździe AV/zasilania, uchwyt na VHB (`cad/aibox_mount.scad`) |
| 2026-11-04 | ~~Wersja taktyczna **v0.5 „PANCERZ+”** (`cad/tactical_mount.scad`, spec `cad/spec/v05_tactical_spec.md`) obok v0.4. Do akceptacji: zastąpienie decyzji 1c.10 (przegub GoPro przy kamerze → czop + bezpiecznik PA66), popychacze na przedniej ścianie (pomiar S2 przed drukiem FORK), +12 g masy~~ → odrzucona 2026-11-06 (następny wiersz); nie drukować. Opis archiwalny: `cad/spec/v05_tactical_README.md` |
| 2026-11-06 | Odpowiedzi Adama na v0.5: (1) **przy kamerze zostaje przegub GoPro** — „wierzę, że mocowanie GoPro puści pierwsze” → czop i bezpiecznik PA66 z v0.5 odrzucone, decyzja 1c.10 obowiązuje; (2) +12 g masy — **tak**; (3) przewody z tyłu u góry klatki — **tak**. Dalej: v0.6 = przegub GoPro (v0.4) + elementy v0.5 zgodne z nim. *Uwaga 2026-11-11: założenie z (1) nie jest potwierdzone obliczeniem — §3, `cad/README.md` „Przegub a bezpiecznik”* |
| 2026-11-06 | **CAD v0.6 wykonany** (`cad/camera_mount.scad`, commit `e5086a6`): przegub GoPro przy kamerze, popychacze yaw i osłona przednia z v0.5, gałka M5, zapadki pochylenia 0/10/20° (nagłówek pliku i `cad/README.md` podają indeksowany kąt jako nowe zlecenie Adama z 2026-11-06; wiersz wyżej go nie zapisuje — do potwierdzenia, §3). Wg `cad/README.md` +9,8 g wobec v0.4 (zgoda była na +12). Niedrukowany |
| 2026-11-06 | Research 08 (commit `7ffa7e0`): wymiary z modelu GrabCAD **oryginalnego HDO** jako druga ocena obok `research/06`; nie pomiar |
| 2026-11-06 | Research 09 (commit `0c1ad3b`): otwiera sprawdzenie **U1** (gniazdo wentylatora na skorupie czy na nakładce) — nierozstrzygnięte, §3 |
| 2026-11-06 | **Firmware v0.1** sterownika dla XIAO ESP32-C3 (commit `9c16c1f`): enkoder + CAM, protokół `FF 5A` wg 1c.5. Testy logiki na komputerze; nieskompilowany dla ESP32, nieuruchomiony na sprzęcie |
| 2026-11-12 | Odpowiedzi Adama na listę otwartych decyzji: (a) przegub czy bezpiecznik — **„hinge”**: zostaje przegub GoPro, geometria bez zmian; kolejność zniszczenia dalej niepotwierdzona (§3); (b) propozycje 1c.1–1c.5, 1c.7, 1c.9 — **przyjęte** („ok”); (c) bateria — **4S Li-ion, pakiet, którym Adam zasila HDO** („power from goggles…”, doprecyzowane: „4s liion i power hdos”); zastępuje 3S z 1c.8; ponad 13 V z instrukcji HDO2 — wybór Adama z praktyki; firmware przeliczony na 4S (13,6 / 12,8 V, dzielnik 100k/15k); (d) `gp_slit` i `ir_h` — **bez zmian** („ok”); (e) indeksowany kąt kamery 0/10/20° — **tak, zlecenie Adama**; (f) kamera — **jeszcze nie dostarczona**; (g) repo: **bez prywatnego adresu e-mail** w commitach, licencja **open source → MIT** |
