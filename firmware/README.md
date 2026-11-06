# firmware/ — sterownik poda (Seeed XIAO ESP32-C3) — WERSJA ROBOCZA

Elektronika jeszcze niekupiona: **nic nie sprawdzone na sprzęcie** i **nie skompilowane dla ESP32** (brak PlatformIO
na laptopie). Logika jest w `lib/core` (czyste C++). Testy na komputerze: `make -C test/host`, wynik **36/36 OK**.
Testy sprawdzają między innymi ramki UART, których CRC zgadza się z przykładami z instrukcji Eclipse 004 Dual (research/03).
Gdzie ten opis różni się od kodu, rozstrzyga kod (`include/config.h`, `lib/core/src/ui.h`).

## Sterowanie (pod v0.2: gałka-enkoder + przycisk CAM)
| Akcja | Działanie | Wibracja |
|---|---|---|
| CAM krótko | termo ↔ Infra (linia GPIO2) | 1 impuls = termo, 2 = Infra |
| CAM długo (≥0,8 s) | zawsze termo | 3 krótkie |
| obrót gałki | parametr bieżącego trybu, krok co 2 ząbki | tik; dłuższy na końcu zakresu |
| gałka krótko | tryb: JASNOŚĆ → PALETA → KONTRAST | liczba impulsów = numer trybu |
| gałka długo (≥0,8 s) | NUC (ręczna kalibracja migawki) | 1 długi |
| gałka ≥3 s | śledzenie gorącego punktu wł./wył. (ramka niezweryfikowana) | 2 długie / 1 długi |
| bateria < 10,2 V | ostrzeżenie co 60 s | 3 impulsy |
| bateria < 9,6 V | alarm co 10 s | 5 długich |

Po ok. 0,8 s trzymania czuć krótki tik: puszczenie od tej chwili daje długie naciśnięcie. Ustawienia (kamera, jasność,
kontrast, paleta, hot-track) zapisują się w pamięci 5 s po ostatniej zmianie i wracają do kamery po starcie
(`CAM_BOOT_MS`).

## Piny (XIAO ESP32-C3)
Piny startowe GPIO2/8/9 (D0, D8, D9) celowo nieużywane (wiki XIAO: „Strapping Pins”). ADC tylko na ADC1.

| Pin | GPIO | Funkcja |
|---|---|---|
| D1 / A1 | 3 | VBAT przez dzielnik 100k/22k + 100 nF |
| D2 | 4 | enkoder A |
| D3 | 5 | enkoder B |
| D4 | 6 | wciśnięcie gałki (do GND) |
| D5 | 7 | przycisk CAM (do GND) |
| D6 | 21 | UART TX → RX kamery, przez 1 kΩ |
| D7 | 20 | bramka FET silnika wibracyjnego, pull-down 100k |
| D10 | 10 | GPIO2 kamery, przez 1 kΩ |
| 5V | — | z Pololu D36V6F5 przez diodę Schottky'ego (wymóg Seeed) |

RX kamery nie jest podłączony, bo magistrala ma 5 żył: VBAT, GND, CVBS, GPIO2, UART-TX (research/05).

## Niezweryfikowane (sprawdzić na stole, research/03 §bench)
1. Który poziom GPIO2 to termo (`CAM_GPIO2_THERMAL`). Pewność średnia.
2. Czy TR1 w ogóle mówi protokołem `FF 5A`. Na stole podłącz RX przez przejściówkę USB-UART i wyślij ramkę wersji;
   firmware wysyła ją raz po starcie. Jeśli kamera nie odpowiada, ustaw `USE_CAM_UART 0`: zostaje samo przełączanie
   kamer.
3. Zakres palet (`PALETTE_COUNT`).
4. Ramka hot-track: brak przykładu w instrukcji, CRC wyliczone.
5. Czas startu AI Boxa (`CAM_BOOT_MS`).
6. Kalibracja dzielnika (`VBAT_CAL`, porównać z multimetrem).

## Budowanie
```
make -C test/host          # testy logiki (g++)
pio run                    # ESP32-C3: wymaga PlatformIO (pip install platformio) — jeszcze nie robione
pio run -t upload          # wgranie przez USB-C (przy kłopotach: BOOT + podłączenie)
```
