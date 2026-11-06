// arabskie_gogle — sterownik poda (Seeed XIAO ESP32-C3, Arduino). WERSJA ROBOCZA: nic nie sprawdzone na sprzęcie.
// Logika w lib/core (testy: make -C test/host). Tu tylko piny, UART, NVS i pętla.
#include <Arduino.h>
#include <Preferences.h>
#include "config.h"
#include "caddx.h"
#include "input.h"
#include "haptic.h"
#include "battery.h"
#include "ui.h"

static HardwareSerial CamSerial(1);
static Preferences prefs;
static Haptic haptic;
static Settings settings;
static uint32_t dirtyAt = 0;      // zapis do NVS z opóźnieniem (mniej zapisów flash przy kręceniu gałką)
static bool dirty = false;

struct BoardIo : Io {
  void camGpio2(bool level) override { digitalWrite(PIN_CAM_GPIO2, level ? HIGH : LOW); }
  void uart(const uint8_t* d, size_t n) override { CamSerial.write(d, n); }
  void buzz(uint8_t n, uint16_t onMs, uint16_t offMs) override { haptic.pulse(n, onMs, offMs); }
  void save() override { dirty = true; dirtyAt = millis(); }
} io;

static Ui ui(io, settings, USE_CAM_UART, PALETTE_COUNT, BRIGHT_STEP, CONTRAST_STEP, CAM_GPIO2_THERMAL);
static Encoder enc(2, DETENTS_PER_STEP);
static Button btnCam(DEBOUNCE_MS, LONG_PRESS_MS, VLONG_PRESS_MS);
static Button btnKnob(DEBOUNCE_MS, LONG_PRESS_MS, VLONG_PRESS_MS);
static Battery bat({VBAT_WARN_MV, VBAT_CRIT_MV, VBAT_HYST_MV, VBAT_AVG_MS, WARN_REPEAT_MS, CRIT_REPEAT_MS});
static bool applied = false;

static void loadSettings() {
  prefs.begin("gogle", true);
  settings.thermal = prefs.getBool("th", true);
  settings.bright = prefs.getUChar("br", 50);
  settings.contrast = prefs.getUChar("ct", 50);
  settings.palette = prefs.getUChar("pa", 0) % PALETTE_COUNT;
  settings.hotTrack = prefs.getBool("ht", false);
  prefs.end();
}
static void saveSettings() {
  prefs.begin("gogle", false);
  prefs.putBool("th", settings.thermal); prefs.putUChar("br", settings.bright); prefs.putUChar("ct", settings.contrast);
  prefs.putUChar("pa", settings.palette); prefs.putBool("ht", settings.hotTrack);
  prefs.end();
}

void setup() {
  Serial.begin(115200);                       // USB: diagnostyka
  pinMode(PIN_MOTOR, OUTPUT); digitalWrite(PIN_MOTOR, LOW);
  pinMode(PIN_CAM_GPIO2, OUTPUT);
  pinMode(PIN_ENC_A, INPUT_PULLUP); pinMode(PIN_ENC_B, INPUT_PULLUP);
  pinMode(PIN_ENC_SW, INPUT_PULLUP); pinMode(PIN_BTN_CAM, INPUT_PULLUP);
  analogReadResolution(12);
  CamSerial.begin(CAM_UART_BAUD, SERIAL_8N1, -1, PIN_CAM_TX);   // tylko TX
  loadSettings();
  io.camGpio2(settings.thermal ? CAM_GPIO2_THERMAL : !CAM_GPIO2_THERMAL);   // przełącznik od razu, UART po starcie boxa
  haptic.pulse(1, 150, 0);                    // sygnał „włączony”
}

void loop() {
  uint32_t now = millis();
  if (!applied && now >= CAM_BOOT_MS) {
    applied = true;
    ui.applyAll();
    if (USE_CAM_UART) { uint8_t f[cx::MAX_FRAME]; CamSerial.write(f, cx::version(f)); }   // test na stole (analizator / RX)
  }
  ui.onKnobTurn(enc.update(digitalRead(PIN_ENC_A), digitalRead(PIN_ENC_B)));
  BtnEvent e;
  if ((e = btnCam.update(!digitalRead(PIN_BTN_CAM), now)) != BtnEvent::None) ui.onCam(e);
  if ((e = btnKnob.update(!digitalRead(PIN_ENC_SW), now)) != BtnEvent::None) ui.onKnobPress(e);

  static uint32_t lastAdc = 0;
  if (now - lastAdc >= 100) {
    lastAdc = now;
    uint32_t mv = uint32_t(analogReadMilliVolts(PIN_VBAT_ADC) * VBAT_DIV * VBAT_CAL);
    bool alert; BatState st = bat.update(uint16_t(mv > 65535 ? 65535 : mv), now, alert);
    if (alert) { ui.onBattery(st == BatState::Crit); Serial.printf("bateria %u mV\n", bat.avgMv()); }
  }
  digitalWrite(PIN_MOTOR, haptic.update(now) ? HIGH : LOW);
  if (dirty && now - dirtyAt > 5000) { dirty = false; saveSettings(); }
}
