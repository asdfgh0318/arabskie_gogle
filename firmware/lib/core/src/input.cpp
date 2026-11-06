#include "input.h"
// tablica przejść kwadratury: indeks (prev<<2)|cur, wartość −1/0/+1 (0 dla przejść nieprawidłowych / bez zmiany)
static const int8_t QT[16] = {0, +1, -1, 0, -1, 0, 0, +1, +1, 0, 0, -1, 0, -1, +1, 0};
int Encoder::update(bool a, bool b) {
  uint8_t cur = (a ? 2 : 0) | (b ? 1 : 0);
  if (prev_ == 0xFF) { prev_ = cur; return 0; }
  int d = QT[(prev_ << 2) | cur];
  prev_ = cur;
  if (!d) return 0;
  trans_ += d;
  if (trans_ >= tpd_) { trans_ = 0; det_++; } else if (trans_ <= -tpd_) { trans_ = 0; det_--; } else return 0;
  if (det_ >= dps_) { det_ = 0; return +1; }
  if (det_ <= -dps_) { det_ = 0; return -1; }
  return 0;
}
BtnEvent Button::update(bool pressed, uint32_t now) {
  if (pressed != raw_) { raw_ = pressed; rawSince_ = now; }
  if (raw_ != stable_ && now - rawSince_ >= db_) {
    stable_ = raw_;
    if (stable_) { downAt_ = now; armed_ = false; vfired_ = false; }
    else {
      uint32_t held = now - downAt_;
      if (vfired_) return BtnEvent::None;
      return held >= lg_ ? BtnEvent::Long : BtnEvent::Short;
    }
  }
  if (stable_) {
    uint32_t held = now - downAt_;
    if (!vfired_ && held >= vl_) { vfired_ = true; return BtnEvent::VeryLong; }
    if (!armed_ && held >= lg_) { armed_ = true; return BtnEvent::LongArmed; }
  }
  return BtnEvent::None;
}
