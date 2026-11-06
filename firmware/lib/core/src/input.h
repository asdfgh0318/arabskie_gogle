// Wejścia: enkoder kwadraturowy (EC11E09244BS: 18 ząbków / 9 impulsów → 2 przejścia stanu na ząbek) i przyciski
// z eliminacją drgań oraz krótkim / długim / bardzo długim naciśnięciem. Bez zależności od Arduino (testy na komputerze).
#pragma once
#include <stdint.h>

class Encoder {
 public:
  explicit Encoder(int transPerDetent = 2, int detentsPerStep = 2) : tpd_(transPerDetent), dps_(detentsPerStep) {}
  // a, b: stany linii (true = wysoki). Zwraca −1 / 0 / +1 krok (po dps_ ząbkach).
  int update(bool a, bool b);
 private:
  int tpd_, dps_;
  uint8_t prev_ = 0xFF;
  int trans_ = 0, det_ = 0;
};

enum class BtnEvent : uint8_t { None, Short, LongArmed, Long, VeryLong };

class Button {
 public:
  Button(uint32_t debounceMs, uint32_t longMs, uint32_t vlongMs) : db_(debounceMs), lg_(longMs), vl_(vlongMs) {}
  // pressed: stan po odczycie (true = wciśnięty). Short/Long przy puszczeniu, LongArmed i VeryLong w trakcie trzymania.
  BtnEvent update(bool pressed, uint32_t now);
 private:
  uint32_t db_, lg_, vl_;
  bool raw_ = false, stable_ = false;
  uint32_t rawSince_ = 0, downAt_ = 0;
  bool armed_ = false, vfired_ = false;
};
