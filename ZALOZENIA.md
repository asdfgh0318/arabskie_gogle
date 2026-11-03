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
- Termo 50°H na ekranie HDO2 46° → powiększenie ~0,92× (bliskie 1:1) → świat „mniejszy i dalszy”, istotne przy chodzeniu (ocena odległości, stopnie).
- Noktowizja 120° na 37–46° = silne pomniejszenie (~0,3–0,4×), dystorsja szerokokątna.
- Zasilanie 9–24 V → nie 2S; 3S/4S Li-ion albo przetwornica; sprawdzić zakres zasilania gogli, czy da się jedną baterią.
- Sterownik: przynajmniej przełączanie kamer przez GPIO; reszta zależy od odkrytego interfejsu.

## 2. Cel (do potwierdzenia)
Widzieć w termowizji „na żywo” z głowy (chodzenie/jazda w nocy?), obraz z kamery na kasku
podawany do gogli, sterowanie kamerą (paleta, zoom, przełączanie kanałów, NUC…) przyciskami.

## 3. Otwarte pytania
- [x] Scenariusz użycia: **chodzenie w nocy / teren** (2026-11-03)
- [x] **Pełne zasłonięcie** w goglach — akceptowane (2026-11-03)
- [x] Wyjście wideo: analog CVBS PAL
- [ ] Sterowanie kamery: co robi kabel GPIO, czy jest UART/OSD menu — pomiary dopiero po dostawie elektroniki
- [ ] Zasilanie: napięcie kamery, gogli, z czego (wspólna bateria?)
- [ ] Pozycja kamery: oś oczu (paralaksa ~0) vs czoło vs szczyt kasku
- [ ] Waga i środek ciężkości na kasku, przeciwwaga z tyłu?
- [x] Przyciski: **na goglach, kompaktowo** (2026-11-03); liczba — zależy od interfejsu kamery
- [x] Elementy drukowane: **kompaktowe**
- [x] Model kasku — nieistotny (2026-11-03)
- [ ] Zakres zasilania HDO2 → jedna bateria dla gogli i kamery?

## 4. Decyzje
| Data | Decyzja |
|---|---|
| 2026-11-03 | Scenariusz: chodzenie w nocy / teren |
| 2026-11-03 | Gogle: zakładamy HDO2 |
| 2026-11-03 | Pełne zasłonięcie wzroku akceptowane |
| 2026-11-03 | Przyciski na goglach, kompaktowo; druki kompaktowe |
| 2026-11-03 | Repo publiczne: github.com/asdfgh0318/arabskie_gogle |
