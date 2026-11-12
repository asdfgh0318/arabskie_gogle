# firmware/ — sterownik poda (Seeed XIAO ESP32-C3) — WERSJA ROBOCZA

Elektronika jeszcze niekupiona: **nic nie sprawdzone na sprzęcie** i **nie skompilowane dla ESP32** (brak PlatformIO
na laptopie). Logika jest w `lib/core` (czyste C++). Testy na komputerze: `make -C test/host`, wynik **60/60 OK**.
Testy sprawdzają między innymi ramki UART, których CRC zgadza się z przykładami z instrukcji Eclipse 004 Dual (research/03).
Liczba sprawdzeń mówi tylko, że te sprawdzenia przechodzą na komputerze, nie że logika jest pokryta w całości;
`src/main.cpp` (piny, UART, pamięć) nie jest objęty testami.
Gdzie ten opis różni się od kodu, rozstrzyga kod (`include/config.h`, `lib/core/src/ui.h`).

## Sterowanie (pod v0.2: gałka-enkoder + przycisk CAM)
| Akcja | Działanie | Wibracja |
|---|---|---|
| CAM krótko | termo ↔ Infra (linia GPIO2) | 1 impuls = termo, 2 = Infra |
| CAM długo (≥0,8 s, bez górnej granicy) | zawsze termo: przy puszczeniu, a przy trzymaniu ≥3 s samo po 3 s | 3 krótkie |
| obrót gałki | parametr bieżącego trybu, krok co 2 ząbki | tik; dłuższy na końcu zakresu |
| gałka krótko | tryb: JASNOŚĆ → PALETA → KONTRAST | liczba impulsów = numer trybu |
| gałka długo (≥0,8 s) | NUC (ręczna kalibracja migawki) | 1 długi |
| gałka ≥3 s | śledzenie gorącego punktu wł./wył. (ramka niezweryfikowana) | 2 długie / 1 długi |
| bateria < 13,6 V | ostrzeżenie co 60 s | 3 impulsy |
| bateria < 12,8 V | alarm co 10 s | 5 długich |
| bateria < 8,0 V (`VBAT_ABSENT_MV`) | uznane za brak pakietu / praca z samego USB: bez alarmu | — |

Progi baterii dotyczą średniej z 10 s; odstęp alarmów liczy się od zamknięcia okna średniej, więc w testach wychodzi
10,1 s zamiast 10 s. **Od 2026-11-12 progi są dla pakietu 4S Li-ion** (decyzja Adama, `ZALOZENIA.md` §4): 3,4 i
3,2 V/ogniwo × 4; wcześniej 3S (10,2 / 9,6 / 6,0 V). Próg 8,0 V to 2,0 V/ogniwo (8000 mV / 4), poniżej 10,0 V =
4 × 2,5 V odcięcia ogniwa (research/05 §4.1); to założenie [A], a jego skutek uboczny jest taki, że pakiet
rozładowany poniżej 8 V też nie daje alarmu. Testy na komputerze sprawdzają logikę klasy `Battery` na własnych
progach (wpisanych w teście, jeszcze z 3S), nie wartości z `config.h`.

Po ok. 0,8 s trzymania czuć krótki tik: puszczenie od tej chwili daje długie naciśnięcie. Ustawienia (kamera, jasność,
kontrast, paleta, hot-track) zapisują się w pamięci 5 s po ostatniej zmianie. Po starcie linia GPIO2 dostaje zapisany
poziom od razu, a po `CAM_BOOT_MS` do kamery idą jasność, kontrast i paleta oraz jedna ramka wersji. Ramka hot-track
idzie po starcie tylko wtedy, gdy hot-track jest zapisany jako włączony; przy wyłączonym firmware nie wysyła nic, więc
nie wymusza wyłączenia w kamerze.

Wibracje idą z kolejki (maks. 16 impulsów, nadmiar przepada). Każda wibracja przycisku CAM (tik, potwierdzenie)
przerywa to, co akurat gra, i czyści kolejkę; jeśli coś grało, potwierdzenie zaczyna się po 300 ms ciszy
(`HAPTIC_CUT_GAP_MS`, założenie [A]). Przerwany alarm baterii nie jest dogrywany, wraca przy następnym powtórzeniu
(10 s / 60 s). Samo przełączenie GPIO2 następuje od razu, bez czekania na wibracje. Alarm baterii, który wypadnie zaraz
po naciśnięciu CAM, dokłada się za potwierdzeniem.

## Piny (XIAO ESP32-C3)
Piny startowe GPIO2/8/9 (D0, D8, D9) celowo nieużywane (wiki XIAO: „Strapping Pins”). ADC tylko na ADC1.

| Pin | GPIO | Funkcja |
|---|---|---|
| D1 / A1 | 3 | VBAT przez dzielnik 100k/15k + 100 nF (4S: 16,8 V → 2,19 V; zakres ADC do sprawdzenia przed lutowaniem) |
| D2 | 4 | enkoder A |
| D3 | 5 | enkoder B |
| D4 | 6 | wciśnięcie gałki (do GND) |
| D5 | 7 | przycisk CAM (do GND) |
| D6 | 21 | UART TX → RX kamery, przez 1 kΩ |
| D7 | 20 | bramka FET silnika wibracyjnego, pull-down 100k |
| D10 | 10 | GPIO2 kamery, przez 1 kΩ |
| 5V | — | z Pololu D36V6F5 przez diodę Schottky'ego (wymóg Seeed) |

Firmware v0.1 tylko nadaje do kamery: linia zwrotna (TX kamery → RX sterownika) nie jest podłączona i nie ma dla niej
pinu (`CamSerial.begin(…, -1, PIN_CAM_TX)` w `src/main.cpp`). Wcześniej jako powód stała tu 5-żyłowa magistrala kask ↔
gogle z research/05; ten układ jest tam oznaczony jako zastąpiony (research/05 §5: przy kamerze na goglach między
kaskiem a goglami idą tylko VBAT i GND). Czy w przyjętym układzie dołożyć linię zwrotną — otwarte, nierozstrzygnięte.

## Niezweryfikowane (sprawdzić na stole, research/03 §bench)
1. Który poziom GPIO2 to termo (`CAM_GPIO2_THERMAL`). Pewność średnia.
2. Czy TR1 w ogóle mówi protokołem `FF 5A`. Na stole podłącz RX przez przejściówkę USB-UART i wyślij ramkę wersji;
   firmware wysyła ją raz po starcie. Jeśli kamera nie odpowiada, ustaw `USE_CAM_UART 0`: zostaje samo przełączanie
   kamer.
3. Zakres palet (`PALETTE_COUNT`).
4. Ramka hot-track: brak przykładu w instrukcji, CRC wyliczone. Tabela w instrukcji podaje dla tej komendy długość
   payloadu 1, firmware wysyła ramkę bez payloadu (research/03 §2.2). Żaden krok B0–B9 w research/03 tego nie obejmuje.
5. Czas startu AI Boxa (`CAM_BOOT_MS`).
6. Kalibracja dzielnika (`VBAT_CAL`, porównać z multimetrem).
7. Ryzyko, niepotwierdzone źródłem w `papers/`: TX kamery jest na D6 = GPIO21 = U0TXD (wiki XIAO), a ESP32-C3 przy
   każdym resecie może wypisywać na UART0 log startowy, czyli paczkę tekstu na linię sterującą kamery, zanim firmware
   przejmie pin. Sprawdzić analizatorem na D6 przy włączaniu zasilania (przy okazji B4) i zobaczyć, czy kamera na to
   reaguje. Wszystkie piny poza startowymi są zajęte, więc przeniesienie TX nie jest darmowe.
8. Czy `Serial` to na pewno USB-CDC. Flagi `ARDUINO_USB_MODE=1` i `ARDUINO_USB_CDC_ON_BOOT=1` są ustawione jawnie
   w `platformio.ini`, ale nic nie było kompilowane; gdyby `Serial` trafił na UART0, zająłby GPIO21/20.
9. Kolejność na linii GPIO2 przy starcie: `main.cpp` zapisuje poziom przed i po przełączeniu pinu na wyjście. Czy
   zapis przed `pinMode` działa w użytej wersji arduino-esp32, nie sprawdzono; zmierzyć linię przy starcie.
10. Kierunek obrotu gałki: testy ustalają znak dla sekwencji A/B, ale który to kierunek na prawdziwej części, zależy
    od podłączenia A/B.
11. Czy wibracje (tiki 15–20 ms, 300 ms ciszy przed potwierdzeniem CAM) są czytelne na silniku.

## Budowanie
```
make -C test/host          # testy logiki (g++)
pio run                    # ESP32-C3: wymaga PlatformIO (pip install platformio) — jeszcze nie robione
pio run -t upload          # wgranie przez USB-C (przy kłopotach: BOOT + podłączenie)
```
