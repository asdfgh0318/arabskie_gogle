// Napięcie pakietu (progi w config.h; od 2026-11-12 pakiet 4S): średnia z okna, stany OK / WARN / CRIT z histerezą, powtarzane alarmy (research/05 §4).
// Średnia poniżej absentMv = brak pakietu / błąd pomiaru (np. praca z samego USB): stan Unknown, bez alarmu.
#pragma once
#include <stdint.h>
enum class BatState : uint8_t { Unknown, Ok, Warn, Crit };
struct BatCfg { uint16_t warnMv, critMv, hystMv; uint32_t avgMs, warnRepeatMs, critRepeatMs; uint16_t absentMv; };
class Battery {
 public:
  explicit Battery(const BatCfg& c) : c_(c) {}
  // próbka napięcia pakietu [mV]; zwraca stan, alert = true gdy trzeba teraz zasygnalizować
  BatState update(uint16_t mv, uint32_t now, bool& alert);
  uint16_t avgMv() const { return avg_; }
 private:
  BatCfg c_;
  uint32_t sum_ = 0, n_ = 0, winStart_ = 0, lastAlert_ = 0;
  uint16_t avg_ = 0;
  bool have_ = false;
  BatState st_ = BatState::Unknown;
};
