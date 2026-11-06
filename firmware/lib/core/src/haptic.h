// Wibracje: kolejka impulsów (włącz / przerwa) bez blokowania pętli.
#pragma once
#include <stdint.h>
class Haptic {
 public:
  // n impulsów po onMs z przerwą offMs; dokłada do kolejki (maks. 16 impulsów)
  void pulse(uint8_t n, uint16_t onMs = 80, uint16_t offMs = 120);
  bool update(uint32_t now);   // stan wyjścia silnika
  bool busy() const { return count_ > 0 || on_; }
 private:
  uint16_t onMs_[16] = {}, offMs_[16] = {};
  uint8_t head_ = 0, count_ = 0;
  bool on_ = false, inGap_ = false;
  uint32_t t0_ = 0; uint16_t curOn_ = 0, curOff_ = 0;
};
