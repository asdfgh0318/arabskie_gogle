// arabskie_gogle — konfiguracja sterownika (XIAO ESP32-C3). Źródła: research/03 (interfejs kamery), 05 (zasilanie,
// przyciski), 07c (ergonomia), ZALOZENIA.md. WERSJA ROBOCZA — elektronika jeszcze niekupiona, nic nie sprawdzone na stole.
#pragma once

// ---------- piny (XIAO ESP32-C3) ----------
// Omijamy piny startowe GPIO2 (D0), GPIO8 (D8), GPIO9 (D9) — wiki XIAO: „GPIO2, GPIO8 i GPIO9 to Strapping Pins”.
// Do ADC tylko ADC1 (A0–A2), A3 jest na ADC2 (wiki: „use ADC1 (A0/A1/A2) instead”).
#define PIN_VBAT_ADC   3    // D1 / A1  — dzielnik 100k/22k z VBAT (research/05 §4)
#define PIN_ENC_A      4    // D2
#define PIN_ENC_B      5    // D3
#define PIN_ENC_SW     6    // D4  — wciśnięcie gałki (do GND, pull-up wewnętrzny)
#define PIN_BTN_CAM    7    // D5  — przycisk CAM (B3S do GND, pull-up wewnętrzny)
#define PIN_CAM_TX    21    // D6  — UART TX → RX kamery (przez 1 kΩ)
#define PIN_MOTOR     20    // D7  — bramka FET silnika wibracyjnego (pull-down 100k na bramce)
#define PIN_CAM_GPIO2 10    // D10 — linia GPIO2 kamery (przełączanie termo/Infra, przez 1 kΩ)
// RX kamery nie jest podłączony (magistrala ma 5 żył: VBAT, GND, CVBS, GPIO2, UART-TX — research/05).

// ---------- kamera ----------
#define CAM_UART_BAUD     115200   // [V: Eclipse 004 Dual], dla TR1 nie potwierdzone
#define CAM_GPIO2_THERMAL 1        // poziom GPIO2 = termo (średnia pewność, research/03 §TL;DR 1) → sprawdzić na stole
#define CAM_BOOT_MS       3000     // [A] czas na start AI Boxa przed wysłaniem zapisanych ustawień
#define USE_CAM_UART      1        // 0 = tylko przełączanie GPIO2 (gdy UART TR1 nie odpowiada jak 004 Dual)

// ---------- interfejs ----------
#define DETENTS_PER_STEP  2        // 07c: 18 ząbków = 20°/ząbek < 30° MIL → krok co 2 ząbki
#define DEBOUNCE_MS       15       // B3S: drgania ≤ 5 ms [V], 10–20 ms w firmware (research/05)
#define LONG_PRESS_MS     800
#define VLONG_PRESS_MS    3000
#define BRIGHT_STEP       10
#define CONTRAST_STEP     10
#define PALETTE_COUNT     6        // [A] 0 = bez pseudokoloru („0 is off pseudo-color”), 1..5 → sprawdzić na stole

// ---------- bateria 3S ----------
#define VBAT_DIV          (122.0f / 22.0f)   // 100k + 22k
#define VBAT_CAL          1.000f             // korekta po pomiarze multimetrem
#define VBAT_WARN_MV      10200              // 3.4 V/ogniwo (research/05 §4)
#define VBAT_CRIT_MV      9600               // 3.2 V/ogniwo
#define VBAT_HYST_MV      150
#define VBAT_AVG_MS       10000
#define WARN_REPEAT_MS    60000
#define CRIT_REPEAT_MS    10000
