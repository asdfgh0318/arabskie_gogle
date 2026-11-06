// Protokół UART Caddx w wersji z Eclipse 004 Dual (research/03 §3): ramka
//   FF 5A | version(1)=0 | cmd(2, LE) | sub_cmd(1) | payload_len(4, LE) | payload | crc16(2, LSB first)
// CRC16/MODBUS (init 0xFFFF, poly 0xA001 odwrócony) po bajtach od FF do końca payloadu.
// Dla TR1-220SL NIE POTWIERDZONE — pierwszy test na stole: cx_version().
#pragma once
#include <stddef.h>
#include <stdint.h>

namespace cx {
constexpr size_t MAX_FRAME = 16;
uint16_t crc16_modbus(const uint8_t* d, size_t n);
size_t frame(uint8_t* out, uint16_t cmd, uint8_t sub, const uint8_t* payload, uint32_t len);
size_t version(uint8_t* out);                  // cmd 0/0
size_t brightness(uint8_t* out, uint8_t pct);  // cmd 1/0, 0–100
size_t contrast(uint8_t* out, uint8_t pct);    // cmd 1/1, 0–100
size_t palette(uint8_t* out, uint8_t n);       // cmd 2/0, 0 = bez pseudokoloru
size_t nuc(uint8_t* out);                      // cmd 3/0, ręczna kalibracja migawki
size_t auto_shutter(uint8_t* out, bool on);    // cmd 3/2 (on) / 3/1 (off)
size_t hot_track(uint8_t* out, bool on);       // cmd 4/1 (on) / 4/0 (off), bez payloadu — NIEZWERYFIKOWANE (brak przykładu)
}
