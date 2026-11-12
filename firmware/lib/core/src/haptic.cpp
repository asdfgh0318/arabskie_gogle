#include "haptic.h"
void Haptic::pulse(uint8_t n, uint16_t onMs, uint16_t offMs) {
  for (uint8_t i = 0; i < n && count_ < 16; i++) {
    uint8_t k = (head_ + count_) % 16; onMs_[k] = onMs; offMs_[k] = offMs; count_++;
  }
}
void Haptic::cancel(uint16_t gapMs) {
  head_ = 0; count_ = 0;
  if (on_ || inGap_) { cut_ = true; cutGap_ = gapMs; }   // czas znany dopiero w update()
}
bool Haptic::update(uint32_t now) {
  if (cut_) { cut_ = false; on_ = false; inGap_ = true; t0_ = now; curOff_ = cutGap_; }
  if (on_) { if (now - t0_ >= curOn_) { on_ = false; inGap_ = true; t0_ = now; } return on_; }
  if (inGap_) { if (now - t0_ < curOff_) return false; inGap_ = false; }
  if (count_) { curOn_ = onMs_[head_]; curOff_ = offMs_[head_]; head_ = (head_ + 1) % 16; count_--; on_ = true; t0_ = now; }
  return on_;
}
