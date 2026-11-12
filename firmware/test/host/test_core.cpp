// Testy logiki sterownika na komputerze: make -C test/host
#include <cstdio>
#include <cstring>
#include <string>
#include <vector>
#include "caddx.h"
#include "input.h"
#include "haptic.h"
#include "battery.h"
#include "ui.h"

static int fails = 0, checks = 0;
#define CHECK(c, msg) do { checks++; if (!(c)) { fails++; printf("BŁĄD: %s (%s:%d)\n", msg, __FILE__, __LINE__); } } while (0)

static std::string hex(const uint8_t* d, size_t n) { std::string s; char b[4]; for (size_t i = 0; i < n; i++) { snprintf(b, 4, i ? " %02X" : "%02X", d[i]); s += b; } return s; }

static void test_frames() {
  // ramki przykładowe z instrukcji Eclipse 004 Dual (research/03 §3 — CRC zgodne z wydrukiem)
  struct { const char* name; std::string got, want; } t[] = {
    {"wersja", "", "FF 5A 00 00 00 00 00 00 00 00 C7 57"},
    {"jasność 80", "", "FF 5A 00 01 00 00 01 00 00 00 50 EA A2"},
    {"kontrast 80", "", "FF 5A 00 01 00 01 01 00 00 00 50 EB 73"},
    {"paleta 5", "", "FF 5A 00 02 00 00 01 00 00 00 05 6A 88"},
    {"NUC", "", "FF 5A 00 03 00 00 00 00 00 00 F4 57"},
    {"auto-migawka wył.", "", "FF 5A 00 03 00 01 00 00 00 00 C9 97"},
    {"auto-migawka wł.", "", "FF 5A 00 03 00 02 00 00 00 00 8D 97"},
    {"hot-track wył. (wyliczone)", "", "FF 5A 00 04 00 00 00 00 00 00 82 97"},
    {"hot-track wł. (wyliczone)", "", "FF 5A 00 04 00 01 00 00 00 00 BF 57"},
  };
  uint8_t f[cx::MAX_FRAME];
  t[0].got = hex(f, cx::version(f)); t[1].got = hex(f, cx::brightness(f, 80)); t[2].got = hex(f, cx::contrast(f, 80));
  t[3].got = hex(f, cx::palette(f, 5)); t[4].got = hex(f, cx::nuc(f)); t[5].got = hex(f, cx::auto_shutter(f, false));
  t[6].got = hex(f, cx::auto_shutter(f, true)); t[7].got = hex(f, cx::hot_track(f, false)); t[8].got = hex(f, cx::hot_track(f, true));
  for (auto& x : t) { CHECK(x.got == x.want, (std::string("ramka ") + x.name + ": " + x.got).c_str()); }
  // paleta 0: research/03 podaje tylko końcówkę „… 00 AA 8B”
  std::string p0 = hex(f, cx::palette(f, 0));
  CHECK(p0.size() >= 8 && p0.substr(p0.size() - 8) == "00 AA 8B", ("paleta 0: " + p0).c_str());
  CHECK(hex(f, cx::brightness(f, 200)) == hex(f, cx::brightness(f, 100)), "jasność obcięta do 100");
}

static void test_encoder() {
  Encoder e(2, 2);   // 2 przejścia / ząbek, krok co 2 ząbki
  const bool cw[4][2] = {{0, 0}, {0, 1}, {1, 1}, {1, 0}};   // A, B
  int sum = 0; e.update(0, 0);
  for (int i = 1; i <= 16; i++) sum += e.update(cw[i % 4][0], cw[i % 4][1]);   // 16 przejść = 8 ząbków = 4 kroki
  // kierunek ustalony dla tej sekwencji (A,B): 00 → 01 → 11 → 10 = +1. Który to obrót gałki, zależy od podłączenia
  // A/B — tego test nie rozstrzyga (do sprawdzenia na części).
  CHECK(sum == 4, "sekwencja 00→01→11→10 ×4 = +4 kroki");
  sum = 0;
  for (int i = 15; i >= 0; i--) sum += e.update(cw[i % 4][0], cw[i % 4][1]);
  CHECK(sum == -4, "sekwencja odwrotna = −4 kroki");
  Encoder g(2, 2); g.update(0, 0); int s2 = 0;
  for (int i = 0; i < 10; i++) { s2 += g.update(0, 1); s2 += g.update(0, 0); }   // drganie na jednej linii
  CHECK(s2 == 0, "drgania jednej linii nie dają kroków");
}

static void test_button() {
  Button b(15, 800, 3000);
  std::vector<BtnEvent> ev;
  auto run = [&](bool p, uint32_t from, uint32_t to) { for (uint32_t t = from; t < to; t++) { auto e = b.update(p, t); if (e != BtnEvent::None) ev.push_back(e); } };
  run(false, 0, 100); run(true, 100, 105); run(false, 105, 300);              // drganie 5 ms → nic
  CHECK(ev.empty(), "drganie < debounce ignorowane");
  run(true, 300, 500); run(false, 500, 700);                                  // 200 ms → krótkie
  CHECK(ev.size() == 1 && ev[0] == BtnEvent::Short, "krótkie naciśnięcie");
  ev.clear(); run(true, 1000, 2200); run(false, 2200, 2400);                  // 1.2 s → LongArmed + Long
  CHECK(ev.size() == 2 && ev[0] == BtnEvent::LongArmed && ev[1] == BtnEvent::Long, "długie naciśnięcie");
  ev.clear(); run(true, 3000, 6500); run(false, 6500, 6700);                  // 3.5 s → LongArmed + VeryLong, bez Long
  CHECK(ev.size() == 2 && ev[0] == BtnEvent::LongArmed && ev[1] == BtnEvent::VeryLong, "bardzo długie naciśnięcie");
  // przepełnienie millis(): naciśnięcie 1.2 s zaczyna się 256 ms przed 2^32 i kończy po przejściu przez 0
  Button w(15, 800, 3000); ev.clear();
  uint32_t t = 0xFFFFFE00u;
  auto runw = [&](bool p, uint32_t ms) { for (uint32_t i = 0; i < ms; i++, t++) { auto e = w.update(p, t); if (e != BtnEvent::None) ev.push_back(e); } };
  runw(false, 256); runw(true, 1200); runw(false, 200);
  CHECK(t < 0x10000u && ev.size() == 2 && ev[0] == BtnEvent::LongArmed && ev[1] == BtnEvent::Long, "długie naciśnięcie przez przepełnienie millis()");
}

static void test_haptic() {
  Haptic h; h.pulse(2, 80, 120);
  int on = 0, edges = 0; bool prev = false;
  for (uint32_t t = 0; t < 1000; t++) { bool s = h.update(t); on += s; if (s && !prev) edges++; prev = s; }
  CHECK(edges == 2, "2 impulsy");
  CHECK(on >= 158 && on <= 162, "2 × 80 ms włączenia");
  // alarm baterii (5 × 200/150) przerwany w 500. ms przez potwierdzenie CAM (2 × 60/120) z 300 ms ciszy
  Haptic a; a.pulse(5, 200, 150);
  int onGap = 0, onAfter = 0, edgesAfter = 0; uint32_t firstOn = 0, lastOn = 0; prev = false;
  for (uint32_t t = 0; t < 3000; t++) {
    if (t == 500) { a.cancel(300); a.pulse(2, 60, 120); }
    bool s = a.update(t);
    if (t >= 500) {
      if (t < 800) onGap += s;
      else { onAfter += s; if (s && !prev) { edgesAfter++; if (!firstOn) firstOn = t; } if (s) lastOn = t; }
    }
    prev = s;
  }
  CHECK(onGap == 0, "przerwanie: silnik staje od razu, 300 ms ciszy");
  CHECK(edgesAfter == 2 && onAfter >= 118 && onAfter <= 122, "po przerwaniu gra tylko potwierdzenie 2 × 60 ms (reszta alarmu wyrzucona)");
  CHECK(firstOn == 800 && lastOn < 1050, "potwierdzenie zaczyna się 300 ms po naciśnięciu i kończy przed 1050. ms");
  Haptic idle; idle.cancel(300); idle.pulse(1, 60, 0);
  CHECK(idle.update(0), "przerwanie, gdy nic nie gra: bez dodatkowej ciszy");
  Haptic full; full.pulse(16, 200, 150); full.pulse(2, 60, 120);   // kolejka pełna: bez przerwania 2 impulsy przepadają
  edges = 0; prev = false;
  for (uint32_t t = 0; t < 8000; t++) { bool s = full.update(t); if (s && !prev) edges++; prev = s; }
  CHECK(edges == 16, "pełna kolejka (16) gubi dalsze impulsy — dlatego CAM przerywa zamiast dokładać");
}

static void test_battery() {
  Battery b({10200, 9600, 150, 10000, 60000, 10000, 6000});
  bool alert; int alerts = 0; BatState st = BatState::Unknown;
  std::vector<uint32_t> at;   // chwile alarmów w fazie CRIT
  for (uint32_t t = 0; t <= 30000; t += 100) { st = b.update(11500, t, alert); alerts += alert; }
  CHECK(st == BatState::Ok && alerts == 0, "11.5 V = OK, bez alarmu");
  for (uint32_t t = 30100; t <= 50000; t += 100) { st = b.update(10000, t, alert); alerts += alert; }
  CHECK(st == BatState::Warn && alerts == 1, "10.0 V = WARN, jeden alarm");
  for (uint32_t t = 50100; t <= 70000; t += 100) { st = b.update(10300, t, alert); alerts += alert; }
  CHECK(st == BatState::Warn, "10.3 V w histerezie zostaje WARN");
  for (uint32_t t = 70100; t <= 111000; t += 100) { st = b.update(9400, t, alert); alerts += alert; if (alert) at.push_back(t); }
  // okno 10 s przy próbkach co 100 ms zamyka się co 10.1 s → alarm CRIT co 10.1 s. Pierwsze okno tej fazy (do 70.7 s)
  // miesza 10.3 V z 9.4 V i zostaje WARN, więc alarmy CRIT wypadają w 80.7, 90.8, 100.9 i 111.0 s.
  bool spaced = at.size() == 4 && at[0] == 80700; for (size_t i = 1; i < at.size(); i++) spaced = spaced && at[i] - at[i - 1] == 10100;
  CHECK(st == BatState::Crit && alerts == 5 && spaced, "9.4 V = CRIT, 4 alarmy dokładnie co 10.1 s");
  // powrót z histerezą (próg + 150 mV): CRIT trzyma do 9.75 V, WARN trzyma do 10.35 V
  int a2 = 0; uint32_t t = 111100;
  auto feed = [&](uint16_t mv, uint32_t ms) { for (uint32_t end = t + ms; t < end; t += 100) { st = b.update(mv, t, alert); a2 += alert; } };
  feed(9700, 20200);  CHECK(st == BatState::Crit, "9.7 V po CRIT: w histerezie zostaje CRIT");
  a2 = 0; feed(9800, 20200);  CHECK(st == BatState::Warn && a2 == 1, "9.8 V po CRIT → WARN, jeden alarm przy zmianie stanu");
  feed(10300, 20200); CHECK(st == BatState::Warn, "10.3 V po WARN: w histerezie zostaje WARN");
  a2 = 0; feed(10400, 30300); CHECK(st == BatState::Ok && a2 == 0, "10.4 V → OK, bez alarmu");

  // brak pakietu (stół, samo USB: dzielnik czyta ~0 V) — żadnego alarmu, stan Unknown
  Battery n({10200, 9600, 150, 10000, 60000, 10000, 6000});
  int an = 0; BatState sn = BatState::Ok;
  for (uint32_t u = 0; u <= 60000; u += 100) { sn = n.update(0, u, alert); an += alert; }
  CHECK(sn == BatState::Unknown && an == 0, "0 V (brak pakietu) = Unknown, bez alarmu");
  for (uint32_t u = 60100; u <= 90000; u += 100) { sn = n.update(5900, u, alert); an += alert; }
  CHECK(sn == BatState::Unknown && an == 0, "5.9 V < VBAT_ABSENT_MV = Unknown, bez alarmu");
  for (uint32_t u = 90100; u <= 111000; u += 100) { sn = n.update(6100, u, alert); an += alert; }
  CHECK(sn == BatState::Crit && an >= 1, "6.1 V ≥ VBAT_ABSENT_MV = CRIT z alarmem");
  for (uint32_t u = 111100; u <= 132000; u += 100) { sn = n.update(0, u, alert); }
  CHECK(sn == BatState::Unknown, "pakiet odłączony po CRIT → Unknown");

  // przepełnienie millis(): okno uśredniania i odstęp powtórki alarmu przechodzą przez 2^32.
  // Start 15 s przed zerem: 1. okno zamyka się po 10.0 s (5 s PRZED zerem) → CRIT, alarm, lastAlert_ sprzed zera;
  // 2. okno (10.1…20.1 s) obejmuje zero i zamyka się 5.1 s PO nim → powtórka liczona jako now - lastAlert_ przez 2^32.
  Battery wb({10200, 9600, 150, 10000, 60000, 10000, 6000});
  int aw = 0; BatState sw = BatState::Unknown; uint32_t tw = 0xFFFFFFFFu - 14999;
  std::vector<int> ai;   // numery próbek (co 100 ms), przy których był alarm
  for (int i = 0; i < 300; i++, tw += 100) { sw = wb.update(9400, tw, alert); aw += alert; if (alert) ai.push_back(i); }   // 30 s
  CHECK(tw < 0x10000u && sw == BatState::Crit && aw == 2 && ai.size() == 2 && ai[0] == 100 && ai[1] == 201,
        "CRIT przez przepełnienie millis(): alarm 10.0 s (przed zerem) i powtórka 20.1 s (po zerze)");
}

struct FakeIo : Io {
  std::vector<std::string> log; bool gpio = false; int buzzes = 0, saves = 0, cancels = 0, lastBuzz = 0;
  bool cancelBeforeLastBuzz = false, cancelPending = false;
  void camGpio2(bool l) override { gpio = l; log.push_back(std::string("gpio2=") + (l ? "1" : "0")); }
  void uart(const uint8_t* d, size_t n) override { log.push_back("uart " + hex(d, n)); }
  void buzz(uint8_t n, uint16_t, uint16_t) override { buzzes += n; lastBuzz = n; cancelBeforeLastBuzz = cancelPending; cancelPending = false; }
  void buzzCancel() override { cancels++; cancelPending = true; }
  void save() override { saves++; }
};

static void test_ui() {
  FakeIo io; Settings s; Ui ui(io, s, true, 6, 10, 10, true);
  ui.applyAll();
  CHECK(io.gpio == true, "start: termo = GPIO2 wysoki");
  bool noHot = true; for (auto& l : io.log) noHot = noHot && l.rfind("uart FF 5A 00 04", 0) != 0;
  CHECK(io.log.size() == 4 && noHot, "start, hot-track wył.: GPIO2 + 3 ramki (jasność, kontrast, paleta), bez ramki hot-track");
  ui.onCam(BtnEvent::Short); CHECK(!s.thermal && io.gpio == false, "CAM krótko → Infra");
  CHECK(io.lastBuzz == 2 && io.cancelBeforeLastBuzz, "CAM krótko → Infra: 2 impulsy, poprzedzone przerwaniem kolejki");
  ui.onCam(BtnEvent::Long);  CHECK(s.thermal && io.gpio == true, "CAM długo → zawsze termo");
  ui.onBattery(true); CHECK(io.lastBuzz == 5 && !io.cancelBeforeLastBuzz, "alarm baterii niczego nie przerywa (dokłada do kolejki)");
  io.log.clear(); ui.onKnobTurn(+1);
  // pełna ramka; CRC „EA 8F” policzone osobno w Pythonie (CRC16/MODBUS, init 0xFFFF, poly 0xA001), nie kodem z lib/core
  CHECK(s.bright == 60 && io.log.size() == 1 && io.log[0] == "uart FF 5A 00 01 00 00 01 00 00 00 3C EA 8F",
        "obrót w trybie JASNOŚĆ → jasność 60, pełna ramka");
  for (int i = 0; i < 10; i++) ui.onKnobTurn(+1);
  CHECK(s.bright == 100, "jasność max 100");
  ui.onKnobPress(BtnEvent::Short); CHECK(ui.mode() == Mode::Palette, "gałka krótko → tryb PALETA");
  ui.onKnobTurn(-1); CHECK(s.palette == 5, "paleta zawija 0 → 5");
  ui.onKnobPress(BtnEvent::Short); ui.onKnobPress(BtnEvent::Short); CHECK(ui.mode() == Mode::Bright, "3 tryby w kółko");
  io.log.clear(); ui.onKnobPress(BtnEvent::Long);
  CHECK(io.log.size() == 1 && io.log[0] == "uart FF 5A 00 03 00 00 00 00 00 00 F4 57", "gałka długo → NUC");
  ui.onKnobPress(BtnEvent::VeryLong); CHECK(s.hotTrack, "gałka b. długo → hot-track wł.");
  FakeIo io3; Settings s3; s3.hotTrack = true; Ui ui3(io3, s3, true, 6, 10, 10, true);
  ui3.applyAll();
  CHECK(io3.log.size() == 5 && io3.log[4] == "uart FF 5A 00 04 00 01 00 00 00 00 BF 57", "start, hot-track zapisany jako wł.: GPIO2 + 4 ramki, ostatnia hot-track wł.");
  FakeIo io2; Settings s2; Ui ui2(io2, s2, false, 6, 10, 10, true);
  ui2.applyAll(); ui2.onKnobTurn(+1); ui2.onKnobPress(BtnEvent::Long);
  bool anyUart = false; for (auto& l : io2.log) anyUart |= l.rfind("uart", 0) == 0;
  CHECK(!anyUart, "USE_CAM_UART=0 → żadnych ramek, tylko GPIO2");
}

// Button → Ui::onCam razem, tak jak w pętli main.cpp (start w Infra)
struct CamRig {
  FakeIo io; Settings s; Ui ui; Button b; std::vector<BtnEvent> ev;
  CamRig() : ui(io, s, true, 6, 10, 10, true), b(15, 800, 3000) { s.thermal = false; ui.applyAll(); io.buzzes = 0; io.saves = 0; }
  void run(bool p, uint32_t from, uint32_t to) { for (uint32_t t = from; t < to; t++) { auto e = b.update(p, t); if (e != BtnEvent::None) { ev.push_back(e); ui.onCam(e); } } }
};

static void test_cam_hold() {
  { CamRig r; r.run(false, 0, 100); r.run(true, 100, 3600); r.run(false, 3600, 3800);   // 3.5 s
    CHECK(r.ev.size() == 2 && r.ev[1] == BtnEvent::VeryLong, "CAM 3.5 s: Button daje LongArmed + VeryLong");
    CHECK(r.s.thermal && r.io.gpio == true, "CAM trzymany 3.5 s z Infra → termo (GPIO2 wysoki)");
    CHECK(r.io.buzzes == 1 + 3 && r.io.lastBuzz == 3 && r.io.saves == 1, "CAM trzymany 3.5 s: tik + 3 impulsy potwierdzenia, zapis"); }
  { CamRig r; r.run(false, 0, 100); r.run(true, 100, 1300); r.run(false, 1300, 1500);   // 1.2 s
    CHECK(r.s.thermal && r.io.gpio == true && r.io.buzzes == 1 + 3, "CAM trzymany 1.2 s z Infra → termo, tik + 3 impulsy"); }
  { CamRig r; r.run(false, 0, 100); r.run(true, 100, 10100); r.run(false, 10100, 10300);   // 10 s
    CHECK(r.s.thermal && r.io.buzzes == 1 + 3 && r.io.saves == 1, "CAM trzymany 10 s → termo, jedno potwierdzenie"); }
  { CamRig r; r.s.thermal = true; r.run(false, 0, 100); r.run(true, 100, 300); r.run(false, 300, 500);   // 0.2 s
    CHECK(!r.s.thermal && r.io.gpio == false && r.io.lastBuzz == 2, "CAM 0.2 s z termo → Infra, 2 impulsy"); }
}

int main() {
  test_frames(); test_encoder(); test_button(); test_haptic(); test_battery(); test_ui(); test_cam_hold();
  printf("%s: %d/%d sprawdzeń\n", fails ? "BŁĘDY" : "OK", checks - fails, checks);
  return fails ? 1 : 0;
}
