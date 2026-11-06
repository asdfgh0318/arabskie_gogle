// Logika sterowania (pod v0.2: enkoder + przycisk CAM; ZALOZENIA.md 2026-11-03):
//   CAM krótko        → przełącz termo / Infra (GPIO2), 1 impuls (termo) / 2 impulsy (Infra)
//   CAM długo         → wymuś termo (np. po zgubieniu orientacji), 3 krótkie
//   obrót gałki       → zmiana parametru bieżącego trybu (co DETENTS_PER_STEP ząbków), tik przy końcu zakresu
//   gałka krótko      → następny tryb: JASNOŚĆ → PALETA → KONTRAST (impulsy = numer trybu)
//   gałka długo       → NUC (ręczna kalibracja migawki), 1 długi
//   gałka b. długo    → śledzenie gorącego punktu wł./wył. (NIEZWERYFIKOWANE), 2 długie / 1 długi
// Wyjście przez interfejs Io — ta sama logika na płytce i w testach na komputerze.
#pragma once
#include <stddef.h>
#include <stdint.h>
#include "input.h"

struct Io {
  virtual void camGpio2(bool level) = 0;
  virtual void uart(const uint8_t* d, size_t n) = 0;
  virtual void buzz(uint8_t n, uint16_t onMs, uint16_t offMs) = 0;
  virtual void save() = 0;
  virtual ~Io() {}
};

enum class Mode : uint8_t { Bright = 0, Palette = 1, Contrast = 2, COUNT = 3 };

struct Settings {
  bool thermal = true;
  uint8_t bright = 50, contrast = 50, palette = 0;
  bool hotTrack = false;
};

class Ui {
 public:
  Ui(Io& io, Settings& s, bool useUart, uint8_t paletteCount, uint8_t brightStep, uint8_t contrastStep, bool gpio2Thermal)
      : io_(io), s_(s), uartOn_(useUart), palN_(paletteCount), bStep_(brightStep), cStep_(contrastStep), thLevel_(gpio2Thermal) {}
  void applyAll();                  // po starcie kamery: GPIO2 + zapisane ustawienia
  void onCam(BtnEvent e);
  void onKnobPress(BtnEvent e);
  void onKnobTurn(int step);
  void onBattery(bool crit);        // alarm baterii
  Mode mode() const { return mode_; }
 private:
  void setCamera(bool thermal);
  void sendParam(Mode m);
  Io& io_; Settings& s_;
  bool uartOn_; uint8_t palN_, bStep_, cStep_; bool thLevel_;
  Mode mode_ = Mode::Bright;
};
