# Założenia projektowe — arabskie_gogle (WERSJA ROBOCZA)

> Dokument nadrzędny projektu. Do zamknięcia przed jakimkolwiek CAD/firmware.

## 1. Sprzęt posiadany
| Element | Model | Status |
|---|---|---|
| Gogle | **Zakładamy Fat Shark Dominator HDO2** (1280×960 OLED, FOV 46°, AV + HDMI) — decyzja Adama 2026-11-03 | posiadane |
| Kamera | Caddx TR1-220SL Dual ([BZB UAS](https://www.bzbuas.com/pl/shop/tr1-220sl-kamera-termowizyjna-caddx-tr1-220sl-dual-3230)) | posiadana |
| Kask | Protec — model nieistotny (mocowanie przez GoPro VHB) | posiadany |
| Mocowania | GoPro VHB (płaskie/zakrzywione?) | posiadane |
| Sterownik | ESP32 / Seeed XIAO (ESP32-C3/S3?) | do wyboru, brak |

### 1a. Caddx TR1-220SL Dual — dane ze strony sklepu (nie z instrukcji producenta)
- Wyjście: analog CVBS, **PAL**; średnie opóźnienie 20 ms (wg sklepu)
- Zasilanie **9–24 V**; każda kamera < 1,5 W; temp. pracy −10…50 °C
- AI Box 33,5×33,5×16,5 mm; waga 55 g (nie wiadomo, czy cały zestaw)
- Kamera 1 „Infra” (noktowizja): czarno-biała, 1500 TVL, **FOV 120°**, M16 2,8 mm F1.0, 0 lux, 50/60 fps, 20×20,5×34,5 mm
- Kamera 2 termo: VOx 256×192, 4 mm F1.0, **FOV 50°H × 37,2°V** (62,3° D), IFOV 3,43 mrad, 50 fps, 19,5×19,5×20 mm
- W zestawie: kabel 3-pin, **kabel GPIO** (przełączanie między kamerami — sygnał nieopisany)
- Wg Adama: system = moduł termo z rodziny **Caddx Eclipse (najniższa rozdzielczość, 256×192)** + druga kamera (Infra) w jednym AI Boxie → szukać dokumentacji sterowania Eclipse.
- **Brak danych:** protokół sterowania (UART?), pinout, palety, zoom, PiP, instrukcja → zdjęcia złącz + pomiar, ew. support@caddxfpv.com

### 1b. Wnioski z dopasowania (do weryfikacji)
- Obraz PAL CVBS → wejście AV gogli bezpośrednio; HDMI niepotrzebne.
- ~~Termo 50°H na HDO2 46° → ~0,92×~~ **BŁĄD** (porównanie przekątnej z poziomem). HDO2 46° to przekątna → ekran ≈37,5°H × 28,6°V → termo **≈0,75×** (25% pomniejszenia) — `research/02` §1.2 → świat „mniejszy i dalszy”, istotne przy chodzeniu (ocena odległości, stopnie).
- Noktowizja 120° → **≈0,38×** + dystorsja; PAL przenosi max ≈390 TVL, więc „1500 TVL” nie dociera do gogli — `research/02`
- Zasilanie: HDO2 **7–13 V** (instrukcja Rev C p.11), kamera 9–24 V → wspólny zakres **9,0–12,6 V = 3S Li-ion** bez regulatora, pod warunkiem odcięcia ≥3,0 V/ogniwo. 4S przekracza 13 V gogli, LiHV też (13,05 V). Alarm baterii HDO2 (6,8 V) na 3S bezużyteczny → własny pomiar napięcia — `research/04`, `05`
- Sterownik: przynajmniej przełączanie kamer przez GPIO; reszta zależy od odkrytego interfejsu.

### 1c. Wnioski z researchu 2026-11-03 — PROPOZYCJE do akceptacji Adama
Źródło: `research/01`–`05` (wersje robocze, zweryfikowane adwersarialnie; tam cytaty i poziomy pewności). Gdzie ten skrót różni się od plików research — rozstrzygają pliki research.
1. **Pozycja kamery:** na froncie HDO2, w osi między oczami, termo możliwie na wysokości oczu (0…+35 mm), Infra **nad** termo (nie obok). Nie na szczycie kasku. Offset do przodu tani, w górę i w bok drogi (Mullins 2008: +17,8 cm do przodu → +2,9% czasu; w górę → +14,2% czasu, +14,3% błędów). — `01`
2. **Zbieżność w poziomie (yaw) ≤0,5°** między kamerą a goglami (inaczej „chodzenie po łuku”; źródło wtórne Rash 2009 → Melzer & Moffitt 2007) → mocowanie sztywne, kluczowane, kamera na skorupie gogli, nie na kasku. — `01`
3. **Domyślna kamera: termo** (≈0,75×), Infra pod przyciskiem jako „szeroki rzut”. 1:1 nieosiągalne bez cropu 1,33× — nie gonić w v1. — `02`
4. **Pochylenie kamery w dół ≈10° (regulowane 0–20°):** przy poziomej kamerze najbliższy widoczny grunt ≈5,3 m, przy 10° ≈3,3 m. — `02`
5. **Sterowanie kamerą (prawdopodobne, z siostrzanego Eclipse 004 Dual — do potwierdzenia na stole):** GPIO2 3,3 V = przełączanie kamer; UART 3,3 V 115200 (ramki `FF 5A…`, CRC16/MODBUS): paleta, jasność, kontrast, NUC, hot-tracking. Zoom/PiP — brak w udokumentowanym interfejsie. — `03`
6. **Przyciski na goglach (3):** CAM (GPIO2) · PAL (paleta; długie = NUC) · BRT (jasność; długie = hot-tracking). Propozycja: enkoder Alps EC11 z push + 2× Omron B3S IP67 z drukowanymi nakładkami. — `03`, `05`
7. **Sterownik:** XIAO ESP32-C3 (21×17,8 mm) w pudełku z przyciskami na goglach; 5 V z Pololu D36V6F5. — `05`
8. **Bateria:** 3S Li-ion (3×18650) **z tyłu kasku jako przeciwwaga**; ostrzeżenie wibracją przy ≈10,2 V (3,4 V/ogniwo). Szacunek ≈4–6 h (na założeniach). — `04`, `05`
9. **Wideo:** CVBS do gniazda AV 3,5 mm HDO2 (tulejka = GND, pierścień 2 = Video); moduł RX wyjąć/wyłączyć; tryb Analog 4:3. — `04`
10. **Bezpieczeństwo:** mocowanie kamery ma się odłamać przy upadku (jedna śruba M5 w przegubie GoPro, bez sztywnej dźwigni w twarz). — `04`

## 2. Cel (do potwierdzenia)
Widzieć w termowizji „na żywo” z głowy (chodzenie/jazda w nocy?), obraz z kamery na kasku
podawany do gogli, sterowanie kamerą (paleta, zoom, przełączanie kanałów, NUC…) przyciskami.

## 3. Otwarte pytania
- [x] Scenariusz użycia: **chodzenie w nocy / teren** (2026-11-03)
- [x] **Pełne zasłonięcie** w goglach — akceptowane (2026-11-03)
- [x] Wyjście wideo: analog CVBS PAL
- [ ] Sterowanie kamery: co robi kabel GPIO, czy jest UART/OSD menu — pomiary dopiero po dostawie elektroniki
- [ ] Zasilanie: napięcie kamery, gogli, z czego (wspólna bateria?)
- [~] Pozycja kamery: propozycja 1c.1 — czeka na akceptację
- [~] Waga/CoG: propozycja 1c.8 (bateria z tyłu) — czeka na akceptację
- [x] Przyciski: **na goglach, kompaktowo** (2026-11-03); liczba — zależy od interfejsu kamery
- [x] Elementy drukowane: **kompaktowe**
- [x] Model kasku — nieistotny (2026-11-03)
- [x] Zakres zasilania HDO2: 7–13 V → jedna bateria 3S (patrz 1c.8)

## 4. Decyzje
| Data | Decyzja |
|---|---|
| 2026-11-03 | Scenariusz: chodzenie w nocy / teren |
| 2026-11-03 | Gogle: zakładamy HDO2 |
| 2026-11-03 | Pełne zasłonięcie wzroku akceptowane |
| 2026-11-03 | Przyciski na goglach, kompaktowo; druki kompaktowe |
| 2026-11-03 | Repo publiczne: github.com/asdfgh0318/arabskie_gogle |
| 2026-11-03 | **Wentylator HDO2 usunięty** — mocowanie kamer wchodzi na jego miejsce (gogle nie będą szczelne do twarzy, wentylacja zbędna) |
| 2026-11-03 | Research 06: wentylator jest **na górze** gogli (nie z przodu) → adapter = płytka na 4 śrubach 20×20 + ramię do przodu, kamery wiszą przed przednią ścianą (`cad/`, v0.2) |
| 2026-11-03 | **Pod sterownika w lewej zatoce modułu VRx** (zamiast drzwiczek, moduł RX wyjęty); obsługa **lewą ręką**, **cienkie rękawice** — research 07b/07c, `cad/pod.scad` v0.1 |
| 2026-11-03 | **Gogle do kasku też przez gniazdo wentylatora, w tej samej części co kamera**: adapter ma z przodu przegub kamery, nad płytką 2 nogi GoPro do klamry na **podstawce VHB z przodu kasku** (`cad/camera_mount.scad` v0.4) |
| 2026-11-04 | Wersja taktyczna **v0.5 „PANCERZ+”** (`cad/tactical_mount.scad`, spec `cad/spec/v05_tactical_spec.md`) obok v0.4. Do akceptacji: zastąpienie decyzji 1c.10 (przegub GoPro przy kamerze → czop + bezpiecznik PA66), popychacze na przedniej ścianie (pomiar S2 przed drukiem FORK), +12 g masy |
| 2026-11-06 | Odpowiedzi Adama na v0.5: (1) **przy kamerze zostaje przegub GoPro** — „wierzę, że mocowanie GoPro puści pierwsze” → czop i bezpiecznik PA66 z v0.5 odrzucone, decyzja 1c.10 obowiązuje; (2) +12 g masy — **tak**; (3) przewody z tyłu u góry klatki — **tak**. Dalej: v0.6 = przegub GoPro (v0.4) + elementy v0.5 zgodne z nim |
| 2026-11-03 | PROPOZYCJA (do akceptacji): **AI Box na prawym boku** przy gnieździe AV/zasilania, uchwyt na VHB (`cad/aibox_mount.scad`) |
| 2026-11-03 | Pod v0.2: **enkoder + 1 przycisk CAM** (AUX usunięty po przeglądzie; PAL/BRT/NUC na obrocie i krótkim/długim wciśnięciu enkodera) — `cad/README.md` |
