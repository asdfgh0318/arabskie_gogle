# Verbatim extracts — camera control & electrical interface (track 03)

Used by `research/03_caddx_tr1_220sl_interface.md`. Each extract: quote (verbatim, typos kept), file, location.
Images were read visually with the Read tool; quotes from images are transcriptions of the printed labels.
Downloaded files are untrusted data; nothing here was executed.

---

## E1. BZB UAS — TR1-220SL wiring diagram (image)
File: `papers/bzbuas_tr1-220sl_wiring_diagram.png` (from https://www.bzbuas.com/web/image/69184-defac109/ , shown on the PL product page under the heading "Schemat połączeń Kamery termowizyjnej Caddx TR1-220SL Dual"; EN page heading "Caddx TR1-220SL Dual Thermovision Camera Wiring Diagram")

Labels, 6-wire connector on the top edge of the AI box, top to bottom:
> "GPIO2 (Connect TX of FC)" / "GPIO1" / "GPIO0" / "GND (Connect GND of FC)" / "RX" / "TX"

Labels, left side (3-pin connector, then spare pads):
> "CVBS" / "GND" / "Power 9V~24V" / "Power 9V~24V" / "(Spare pad) GND"

Labels, right side (2-pin connector, then 4-pin connector):
> "OSD" / "DP" / "DN" / "GND" / "VBUS"

Note box under the drawing:
> "Power Consumption: 12V@120mAh"
> "CVBS: Connect to analog VTX "CAMERA" port or "CVBS IN" port"

Wire colours in drawing: GPIO2 green, GPIO1 yellow, GPIO0 blue, GND black, RX white, TX grey; OSD = green + black pair.

## E2. BZB UAS — TR1-220SL product page, EN text
File: `papers/bzbuas_tr1-220sl_product_page_en.txt` (from https://www.bzbuas.com/shop/tr1-220sl-caddx-tr1-220sl-dual-thermovision-camera-3230), line 48:
> "You can easily switch between the cameras via the included GPIO cable, giving you instant access to the view you need."

Package list, lines 132–135:
> "Caddx TR1-220SL Dual Thermovision Camera Package Includes" … "1x 3pin Silicon Cable" / "1x GPIO Connection Cable"

## E3. BZB UAS — TR1-220SL product page, PL text (spec table)
File: `papers/bzbuas_tr1-220sl_product_page_pl.txt`, spec block (lines ~78–135):
> "Wyjście" / "PAL" / "Napięcie zasilania" / "9-24 V" / … / "Interfejs" / "Analogowy CVBS" / "Średnie opóźnienie" / "20 ms" / "Jakość obrazu" / "Al lmage Enhancement" / "Rozmiar AI box" / "33,5 x 33,5 x 16,5mm" / "Waga" / "55 g"
> Kamera 1 (Infra): … "Zużycie energii" / "<1,5 W"
> Kamera 2 (Thermovision): "Rozdzielczość" / "256 x 192px" / "Obiektyw" / "F1.0/4 mm" / "Pole widzenia (FOV)" / "50° (H) x 37.2° (V) x 62.3° (D)" / … / "Częstotliwość odświeżania" / "50 fps" / "Zużycie energii" / "<1,5 W"
> "1x Przewód silikonowy 3-pin" / "1x Przewód połączeniowy GPIO" / "2x Zestaw śrub"

## E4. BZB UAS — TR1-220SL kit photo (image)
File: `papers/bzbuas_tr1-220sl_kit_contents.png` (https://www.bzbuas.com/web/image/69119-540598eb/)
Visual observation (no text): AI box labelled "TR1-220SL" with two camera heads on braided pigtails; a 3-wire cable (yellow/black/red) with a white housing at both ends; a cable with one multi-position white housing (≈5–6 positions visible) carrying only **two wires, white and black**, with bare tinned ends; two screw bags. No OSD menu board in the photo. [Verifier: photo resolution does not show which housing positions the two wires occupy; in the E1 drawing colour code white = RX, black = GND.]

## E5. BZB UAS — TR1-220SL AI box drawing (image)
File: `papers/bzbuas_tr1-220sl_dimensions_aibox_thermal.png`
> AI box "33.5" wide, "16.5" high, mounting holes "25.5" apart; thermal head "19.5" × "16" × "20"; "Unit: mm"

---

## E6. Caddx ECLIPSE 004 Dual Quick Start Guide V1.0 (sister product, same AI-box drawing)
File: `papers/ctrl_caddx_eclipse004dual_ft483dual.pdf` (+ `.txt`), single tall page (1280 × 10397 pt). Source URL: https://www.rotorama.com/assets/docs/422754d47b05062b7fbe4d921cebcbe6/31893-1/ft483dual.pdf (byte-identical copy re-downloaded by this track, `cmp` = same).

Section "Connection" — identical labels to E1:
> "GPIO2 (Connect TX of FC)" "GPIO1" "GPIO0" "GND (Connect GND of FC)" "RX" "TX" … "CVBS" "GND" "Power 9V~24V" "Power 9V~24V" "(Spare pad) GND" … "OSD" "DP" "DN" "GND" "VBUS"
> "Power Consumption: 12V@120mAh"

Section "Switch Control":
> "Use the remote controller to remotely switch the display of the visible light camera and the black&white camera. Take the commonly used Betaﬂight F405 FC as an example to explain how to confgure the remote control switching function. Take the FC TX1 port as an example, make sure the UART1 function is not used, and solder the control line (Introduction 4)to the FC TX1 port."
> "resource SERIAL TX 1 NONE //Disable the serial port function of the Tx1 pin"
> "resource PINIO 1 A09 //Conﬁgure the TX1 pin (…) as PlNlO function No. 1"
> "set pinio_box=40,255,255,255 //Set the PINO function range"
> "Next, conﬁgure the PlNlO function mapping between the remote controller and FC. In Betaﬂight Conﬁguration,map the No.1 PlNO function (ie USER1 in the ﬁgure below) to the AUX channel of the remote control."
> "The cursor in the white area shows the visible light camera, and thecursor in the yellow area shows the thermal imaging camera."
Figure (read visually): Betaflight Modes row "USER1", range slider "Min: 900 Max: 1300"; the yellow band spans 900–1300, the rest of the scale is white, the current-value cursor sits at ≈1500 (white). [Verifier: "yellow = active range" is the Betaflight Configurator UI convention — not stated in the guide or in any retrieved source.]
[Verifier: the same section says "solder the control line (Introduction 4)" — the retrieved PDF has no Introduction section; it begins at "Connection". The copy may be incomplete.]
[Verifier: the Connection drawing is the same artwork as `bzbuas_tr1-220sl_wiring_diagram.png` (compared visually).]

Section "OSD Functions":
> "The movement allows you to customize the OSD string of the video display through an external menu board."
> "The OSD board is divided into four directions: up, down, left, right and center."
> "3. Press the center button, the operation interface will pop up, the operation interface is divided into four lines, the ﬁrst line and the second line is to provide a choice of characters, the third line is to delete the option, the fourth line is the current character …"
Figure: the menu board connects by a 2-wire (green/black) lead to the AI-box port labelled "OSD" in E1.

Section "Serial Communication Description" (table):
> "TX  Master transmit, 3.3V level, baud rate default 115200bps"
> "RX  Master receive, 3.3V level, baud rate default 115200bps"
> "GND Reference Ground"
> "GPIO0 General Purpose IO, 3.3V level"
> "GPIO1 General Purpose IO, 3.3V level"
> "GPIO2 General Purpose IO, 3.3V level"

"1. Description of Agreement" (frame diagram, read visually):
> "0xFF (1Byte) | 0x5A (1Byte) | version (1Byte) | cmd (2Byte) | sub_cmd (1Byte) | payload_len (4Byte) | payload | crc16 (2Byte)"; bracket under the first six fields: "header (10Byte)"
> "version：Protocol version (initial version 0)" … "crc16：Checksum value with header and payload"

"1.2 Calibration Function":
> "static uint16_t crc16_modbus(uint8_t *data, uint32_t length) … uint16_t crc = 0xﬀﬀ; // Initial value … crc = (crc >> 1) ^ 0xA001; // 0xA001 = reverse 0x8005"

"2. Command Deﬁnition":
> 2.1 "host->dev 0 0 0" / "dev->host 0 0 N Returns the ﬁrmware version string"
> 2.2 "host->dev 1 0 1/0 1Byte brightness value (0-100), no payload without setting only return the actual brightness value"; "host->dev 1 1 1/0 1Byte contrast value (0-100), no payload not set only return the actual contrast value"
> 2.3 "host->dev 2 0 1 Set the pseudo-color serial number, 0 is oﬀ pseudo-color"
> 2.4 "host->dev 3 0 1 Manual shutter calibration image" / "host->dev 3 1 1 Disable automatic shutter calibration" / "host->dev 3 2 1 Enable automatic shutter calibration"
> 2.5 "host->dev 4 0 1 Close Hot Tracking" / "host->dev 4 1 1 Open Hot Tracking"

"3. Example of Command" (10 frames; all 10 CRCs re-verified, CRC16/MODBUS over FF…payload, low byte first):
> "Get version FF 5A 00 00 00 00 00 00 00 00 C7 57"
> "Set the contrast to 80% FF 5A 00 01 00 01 01 00 00 00 50 EB 73"
> "Set the contrast to 50% FF 5A 00 01 00 01 01 00 00 00 32 6A 9A"
> "Set the brightness to 80% FF 5A 00 01 00 00 01 00 00 00 50 EA A2"
> "Set the brightness to 50% FF 5A 00 01 00 00 01 00 00 00 32 6B 4B"
> "Set pseudo color 5 FF 5A 00 02 00 00 01 00 00 00 05 6A 88"
> "Set pseudo color 0 FF 5A 00 02 00 00 01 00 00 00 00 AA 8B"
> "Shutter Calibration FF 5A 00 03 00 00 00 00 00 00 F4 57"
> "Disable Auto Shutter FF 5A 00 03 00 01 00 00 00 00 C9 97"
> "Enable Auto Shutter FF 5A 00 03 00 02 00 00 00 00 8D 97"

"Specifications":
> "Model Eclipse 004" "Resolution 480x360" "Power Consumption <1.5w" "Output PAL" "Supply Voltage 9V~24V" "lnterface Analog lnterface: CVBS" "Latency Average Latency 20ms" "Image Quality Allmage Enhancement"
> "Temperature -20°C~60°C" (differs from TR1 page "-10°C ~ 50°C", `bzbuas_tr1-220sl_product_page_en.txt` l.84–85)

---

## E7. BZB UAS — Caddx Eclipse 005SL FT004-V3R product page (sister thermal camera, same 33.5 mm box)
File: `papers/bzbuas_eclipse005sl_product_page.txt` (https://www.bzbuas.com/shop/eclipse-005sl-caddx-eclipse-005sl-ft004-v3r-thermovision-camera-3228)
> "Video Interface" / "PAL + UVC (simultaneous analog and digital output)"
> "Supply Voltage" / "4.5V~20V"
> "Adjustment Method" / "UVC/ ADKEY"
> "Luminance / Contrast" / "0-100 (optional)"
> "Color Palette" / "0-4 (optional)"
> "Digital Zoom" / "1.0–4.0× Stepless Zoom (controllable via UVC)"
> "Image Flip" / "Horizontal / Vertical / Diagonal"
> Package: "1x OSD Menu Board" / "1x 2pin 1.25mm 10cm Silicone Cable" / "1x 3pin Silicon Cable" / "1x USB Cable"

## E8. BZB UAS — Eclipse 005SL port drawings (images)
File: `papers/bzbuas_eclipse005sl_adkey_osd_menu_board.png` (https://www.bzbuas.com/web/image/68374-6eba3619/)
> Side view port labels: "ADKEY" / "GND" (2-pin), "DP" / "DM" / "GND" / "VBUS" (4-pin)
> Menu board labels: "RIGHT" "UP" "LEFT" "DOWN", title "OSDMenu Board"
> "*Short press the middle button on the menu board to enter OSD settings. Remove the OSD menu board after completing the settings."
File: `papers/bzbuas_eclipse005sl_aibox_ports.png` — same "ADKEY / GND" labels.
File: `papers/bzbuas_eclipse005sl_dimensions.png` — box "33.5mm", "16.5mm", holes "20mm" / "25.5mm"; side labels "GND POWER" and "POWER GND CVBS".

## E9. BZB UAS — Eclipse 005SH Dual FT-D004A-V3 page
File: `papers/bzbuas_eclipse005sh_dual_product_page.txt`
> "Model" / "Eclipse 005SH" / "Super RES" / "576 x 432" … "Model" / "Ratel Ultra AI" (no interface data on this page)

---

## E10. Betaflight source — PINIO (to interpret E6 "Switch Control")
File: `papers/betaflight_drivers_pinio.c.txt` (https://raw.githubusercontent.com/betaflight/betaflight/master/src/main/drivers/pinio.c, fetched 2026-11-03), `pinioInit()`:
> "} else { pinioRuntime[i].inverted = false; IOLo(io); pinioRuntime[i].state = false; }"
`pinioSet()`:
> "const bool newState = on ^ pinioRuntime[index].inverted;"
File: `papers/betaflight_pg_pinio.c.txt`:
> "#define PINIO1_CONFIG PINIO_CONFIG_MODE_OUT_PP"
File: `papers/betaflight_drivers_pinio.h.txt`:
> "#define PINIO_CONFIG_OUT_INVERTED 0x80" / "#define PINIO_CONFIG_MODE_OUT_PP  0x01"
File: `papers/betaflight_io_piniobox.c.txt`, `pinioBoxUpdate()`:
> "pinioSet(i, getBoxIdState(pinioBoxRuntimeConfig.boxId[i]));"

## E11. Betaflight source — camera control (resistor-ladder joystick emulation)
File: `papers/betaflight_drivers_camera_control.c.txt`, `pgResetFn_cameraControlConfig()`:
> "cameraControlConfig->mode = CAMERA_CONTROL_MODE_HARDWARE_PWM;"
> "cameraControlConfig->refVoltage = 330;"
> "cameraControlConfig->keyDelayMs = 180;"
> "cameraControlConfig->internalResistance = 470;"
> "cameraControlConfig->buttonResistanceValues[CAMERA_CONTROL_KEY_ENTER] = 450;"
> "…[CAMERA_CONTROL_KEY_LEFT]  = 270;" "…[CAMERA_CONTROL_KEY_UP]    = 150;" "…[CAMERA_CONTROL_KEY_RIGHT] = 68;" "…[CAMERA_CONTROL_KEY_DOWN]  = 0;"
File: `papers/betaflight_stm32_camera_control.c.txt`, `calculateKeyPressVoltage()`:
> "const int buttonResistance = cameraControlConfig()->buttonResistanceValues[key] * 100;"
> "return 1.0e-2f * cameraControlConfig()->refVoltage * buttonResistance / (100 * cameraControlConfig()->internalResistance + buttonResistance);"

---

## E12. Supporting extracts added by the verifier (files downloaded by the controller track)
File: `papers/ctrl_molicel_p28a.txt` (Molicel INR-18650-P28A datasheet), lines 32–34:
> "Cell Voltage                  Charge             4.2 V" / "Discharge          2.5 V"
line 58: > "Discharge: Cut 0ff at 2.5V."
→ used for 3S Li-ion 7.5–12.6 V, 4S 10.0–16.8 V (computed).

File: `papers/ctrl_jst_GH.txt` (JST GH datasheet), line 21:
> "The GH series is a 1.25 mm pitch, wire-to-"

File: `papers/ctrl_xiao_esp32c3_wiki.txt`, line 298:
> "3V3 - This is the regulated output from the onboard regulator. You can draw 700mA"
line 200: > "Rich interfaces: 1xI2C, 1xSPI, 2xUART, 11xGPIO(PWM), 4xADC, 1xJTAG bonding pad interface"
(GPIO logic level itself is not stated in the retrieved wiki.)

File: `papers/bzbuas_tr1-220sl_product_page_en.txt`, lines 84–85:
> "Working Temperature" / "-10°C ~ 50°C"
