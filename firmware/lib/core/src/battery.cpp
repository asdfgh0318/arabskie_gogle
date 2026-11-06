#include "battery.h"
BatState Battery::update(uint16_t mv, uint32_t now, bool& alert) {
  alert = false;
  if (!n_) winStart_ = now;
  sum_ += mv; n_++;
  if (now - winStart_ < c_.avgMs) return st_;
  avg_ = sum_ / n_; sum_ = 0; n_ = 0; have_ = true;
  BatState prev = st_;
  switch (st_) {
    case BatState::Unknown:
    case BatState::Ok:   st_ = avg_ < c_.critMv ? BatState::Crit : avg_ < c_.warnMv ? BatState::Warn : BatState::Ok; break;
    case BatState::Warn: st_ = avg_ < c_.critMv ? BatState::Crit : avg_ > c_.warnMv + c_.hystMv ? BatState::Ok : BatState::Warn; break;
    case BatState::Crit: st_ = avg_ > c_.critMv + c_.hystMv ? (avg_ > c_.warnMv + c_.hystMv ? BatState::Ok : BatState::Warn) : BatState::Crit; break;
  }
  uint32_t rep = st_ == BatState::Crit ? c_.critRepeatMs : c_.warnRepeatMs;
  if ((st_ == BatState::Warn || st_ == BatState::Crit) && (st_ != prev || now - lastAlert_ >= rep)) { alert = true; lastAlert_ = now; }
  return st_;
}
