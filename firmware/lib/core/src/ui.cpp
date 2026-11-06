#include "ui.h"
#include "caddx.h"

void Ui::setCamera(bool thermal) {
  s_.thermal = thermal;
  io_.camGpio2(thermal ? thLevel_ : !thLevel_);
}
void Ui::sendParam(Mode m) {
  if (!uartOn_) return;
  uint8_t f[cx::MAX_FRAME]; size_t n = 0;
  switch (m) {
    case Mode::Bright:   n = cx::brightness(f, s_.bright); break;
    case Mode::Palette:  n = cx::palette(f, s_.palette); break;
    case Mode::Contrast: n = cx::contrast(f, s_.contrast); break;
    default: break;
  }
  if (n) io_.uart(f, n);
}
void Ui::applyAll() {
  setCamera(s_.thermal);
  if (!uartOn_) return;
  sendParam(Mode::Bright); sendParam(Mode::Contrast); sendParam(Mode::Palette);
  uint8_t f[cx::MAX_FRAME]; size_t n = cx::hot_track(f, s_.hotTrack); io_.uart(f, n);
}
void Ui::onCam(BtnEvent e) {
  if (e == BtnEvent::Short) {
    setCamera(!s_.thermal); io_.buzz(s_.thermal ? 1 : 2, 60, 120); io_.save();
  } else if (e == BtnEvent::Long) {
    setCamera(true); io_.buzz(3, 40, 80); io_.save();
  } else if (e == BtnEvent::LongArmed) {
    io_.buzz(1, 20, 0);   // krótki „tik”: puść teraz = długie naciśnięcie
  }
}
void Ui::onKnobPress(BtnEvent e) {
  uint8_t f[cx::MAX_FRAME];
  switch (e) {
    case BtnEvent::Short:
      mode_ = Mode((uint8_t(mode_) + 1) % uint8_t(Mode::COUNT));
      io_.buzz(uint8_t(mode_) + 1, 50, 120);
      break;
    case BtnEvent::LongArmed: io_.buzz(1, 20, 0); break;
    case BtnEvent::Long:
      if (uartOn_) io_.uart(f, cx::nuc(f));
      io_.buzz(1, 300, 0);
      break;
    case BtnEvent::VeryLong:
      s_.hotTrack = !s_.hotTrack;
      if (uartOn_) io_.uart(f, cx::hot_track(f, s_.hotTrack));
      io_.buzz(s_.hotTrack ? 2 : 1, 300, 150); io_.save();
      break;
    default: break;
  }
}
static uint8_t stepPct(uint8_t v, int dir, uint8_t step, bool& clamped) {
  int nv = int(v) + dir * int(step);
  clamped = nv < 0 || nv > 100;
  return uint8_t(nv < 0 ? 0 : nv > 100 ? 100 : nv);
}
void Ui::onKnobTurn(int dir) {
  if (!dir) return;
  bool clamped = false;
  switch (mode_) {
    case Mode::Bright:   s_.bright = stepPct(s_.bright, dir, bStep_, clamped); break;
    case Mode::Contrast: s_.contrast = stepPct(s_.contrast, dir, cStep_, clamped); break;
    case Mode::Palette:  s_.palette = uint8_t((int(s_.palette) + dir + palN_) % palN_); break;
    default: break;
  }
  sendParam(mode_);
  io_.buzz(1, clamped ? 120 : 15, 0);   // tik na każdy krok, dłuższy na końcu zakresu
  io_.save();
}
void Ui::onBattery(bool crit) {
  if (crit) io_.buzz(5, 200, 150); else io_.buzz(3, 100, 150);
}
