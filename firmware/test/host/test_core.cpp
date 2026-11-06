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
  CHECK(sum == 4 || sum == -4, "16 przejść w jedną stronę = 4 kroki");
  int dirA = sum > 0 ? 1 : -1; sum = 0;
  for (int i = 15; i >= 0; i--) sum += e.update(cw[i % 4][0], cw[i % 4][1]);
  CHECK(sum == -4 * dirA, "w drugą stronę = −4 kroki");
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
}

static void test_haptic() {
  Haptic h; h.pulse(2, 80, 120);
  int on = 0, edges = 0; bool prev = false;
  for (uint32_t t = 0; t < 1000; t++) { bool s = h.update(t); on += s; if (s && !prev) edges++; prev = s; }
  CHECK(edges == 2, "2 impulsy");
  CHECK(on >= 158 && on <= 162, "2 × 80 ms włączenia");
}

static void test_battery() {
  Battery b({10200, 9600, 150, 10000, 60000, 10000});
  bool alert; int alerts = 0; BatState st = BatState::Unknown;
  for (uint32_t t = 0; t <= 30000; t += 100) { st = b.update(11500, t, alert); alerts += alert; }
  CHECK(st == BatState::Ok && alerts == 0, "11.5 V = OK, bez alarmu");
  for (uint32_t t = 30100; t <= 50000; t += 100) { st = b.update(10000, t, alert); alerts += alert; }
  CHECK(st == BatState::Warn && alerts == 1, "10.0 V = WARN, jeden alarm");
  for (uint32_t t = 50100; t <= 70000; t += 100) { st = b.update(10300, t, alert); alerts += alert; }
  CHECK(st == BatState::Warn, "10.3 V w histerezie zostaje WARN");
  for (uint32_t t = 70100; t <= 100000; t += 100) { st = b.update(9400, t, alert); alerts += alert; }
  CHECK(st == BatState::Crit && alerts >= 3, "9.4 V = CRIT, alarmy co 10 s");
}

struct FakeIo : Io {
  std::vector<std::string> log; bool gpio = false; int buzzes = 0, saves = 0;
  void camGpio2(bool l) override { gpio = l; log.push_back(std::string("gpio2=") + (l ? "1" : "0")); }
  void uart(const uint8_t* d, size_t n) override { log.push_back("uart " + hex(d, n)); }
  void buzz(uint8_t n, uint16_t, uint16_t) override { buzzes += n; }
  void save() override { saves++; }
};

static void test_ui() {
  FakeIo io; Settings s; Ui ui(io, s, true, 6, 10, 10, true);
  ui.applyAll();
  CHECK(io.gpio == true, "start: termo = GPIO2 wysoki");
  CHECK(io.log.size() == 5, "start: GPIO2 + 4 ramki (jasność, kontrast, paleta, hot-track)");
  ui.onCam(BtnEvent::Short); CHECK(!s.thermal && io.gpio == false, "CAM krótko → Infra");
  ui.onCam(BtnEvent::Long);  CHECK(s.thermal && io.gpio == true, "CAM długo → zawsze termo");
  io.log.clear(); ui.onKnobTurn(+1);
  CHECK(s.bright == 60 && io.log.size() == 1 && io.log[0] == "uart FF 5A 00 01 00 00 01 00 00 00 3C " + io.log[0].substr(io.log[0].size() - 5),
        "obrót w trybie JASNOŚĆ → jasność 60");
  for (int i = 0; i < 10; i++) ui.onKnobTurn(+1);
  CHECK(s.bright == 100, "jasność max 100");
  ui.onKnobPress(BtnEvent::Short); CHECK(ui.mode() == Mode::Palette, "gałka krótko → tryb PALETA");
  ui.onKnobTurn(-1); CHECK(s.palette == 5, "paleta zawija 0 → 5");
  ui.onKnobPress(BtnEvent::Short); ui.onKnobPress(BtnEvent::Short); CHECK(ui.mode() == Mode::Bright, "3 tryby w kółko");
  io.log.clear(); ui.onKnobPress(BtnEvent::Long);
  CHECK(io.log.size() == 1 && io.log[0] == "uart FF 5A 00 03 00 00 00 00 00 00 F4 57", "gałka długo → NUC");
  ui.onKnobPress(BtnEvent::VeryLong); CHECK(s.hotTrack, "gałka b. długo → hot-track wł.");
  FakeIo io2; Settings s2; Ui ui2(io2, s2, false, 6, 10, 10, true);
  ui2.applyAll(); ui2.onKnobTurn(+1); ui2.onKnobPress(BtnEvent::Long);
  bool anyUart = false; for (auto& l : io2.log) anyUart |= l.rfind("uart", 0) == 0;
  CHECK(!anyUart, "USE_CAM_UART=0 → żadnych ramek, tylko GPIO2");
}

int main() {
  test_frames(); test_encoder(); test_button(); test_haptic(); test_battery(); test_ui();
  printf("%s: %d/%d sprawdzeń\n", fails ? "BŁĘDY" : "OK", checks - fails, checks);
  return fails ? 1 : 0;
}
