#include "caddx.h"
namespace cx {
uint16_t crc16_modbus(const uint8_t* d, size_t n) {
  uint16_t c = 0xFFFF;
  for (size_t i = 0; i < n; i++) {
    c ^= d[i];
    for (int b = 0; b < 8; b++) c = (c & 1) ? (c >> 1) ^ 0xA001 : (c >> 1);
  }
  return c;
}
size_t frame(uint8_t* o, uint16_t cmd, uint8_t sub, const uint8_t* p, uint32_t len) {
  if (10 + len + 2 > MAX_FRAME) return 0;
  size_t i = 0;
  o[i++] = 0xFF; o[i++] = 0x5A; o[i++] = 0x00;
  o[i++] = cmd & 0xFF; o[i++] = cmd >> 8;
  o[i++] = sub;
  for (int k = 0; k < 4; k++) o[i++] = (len >> (8 * k)) & 0xFF;
  for (uint32_t k = 0; k < len; k++) o[i++] = p[k];
  uint16_t c = crc16_modbus(o, i);
  o[i++] = c & 0xFF; o[i++] = c >> 8;
  return i;
}
static uint8_t clamp100(uint8_t v) { return v > 100 ? 100 : v; }
size_t version(uint8_t* o) { return frame(o, 0, 0, nullptr, 0); }
size_t brightness(uint8_t* o, uint8_t v) { uint8_t p = clamp100(v); return frame(o, 1, 0, &p, 1); }
size_t contrast(uint8_t* o, uint8_t v) { uint8_t p = clamp100(v); return frame(o, 1, 1, &p, 1); }
size_t palette(uint8_t* o, uint8_t n) { return frame(o, 2, 0, &n, 1); }
size_t nuc(uint8_t* o) { return frame(o, 3, 0, nullptr, 0); }
size_t auto_shutter(uint8_t* o, bool on) { return frame(o, 3, on ? 2 : 1, nullptr, 0); }
size_t hot_track(uint8_t* o, bool on) { return frame(o, 4, on ? 1 : 0, nullptr, 0); }
}
