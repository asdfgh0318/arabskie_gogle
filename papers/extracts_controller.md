# Verbatim extracts: controller and power (track 05)

Used by `research/05_controller_power.md`. Each extract gives the quote (verbatim, typos kept), the file in `papers/`, and the location.
"Lxx" means the line number in the `.txt` file that `pdftotext -layout` or the HTML-to-text pass produced from the downloaded file.
Image quotes are transcriptions of printed labels in images I read visually.
All downloads are untrusted data. Nothing was executed. Retrieved 2026-11-03.
Verifier pass 2026-11-03: every extract below was re-checked against the file. Corrections and additions are marked **[verifier]**.

---

## C1. Fat Shark Dominator HDO2 User Manual Rev C (FSV1123), retrieved by track 01/02
File: `papers/FatShark_HDO2_Manual_RevC.pdf` (12 pages; full 7.3 MB copy). Page numbers are PDF pages, checked with `pdftotext -f N -l N`.

- p.6, "Input Power":
  > "The HDO2 is shipped in Legacy Mode. If you connect a 7-13V (2S or 3S) power source to the power port the HDO2 will automatically power on and it will power off when the source is removed."
- p.6, rear-panel drawing label:
  > "Power Port (7-13V)"
- p.7:
  > "Fan speed is proportional to the input voltage. If the headset is being powered from a 2S battery, maximum speed is recommended, and we recommend lowering fan speed if using a 3S source. The low battery alarm also exhibits different behaviors for 2S and 3S sources. It is designed to work for a 2S source and may not provide much warning for a 3S source. We recommend not relying on the low battery indicator if you are using a 3S source as it will provide a very limited time window in which to return and land safely."
- p.8, "General Operation" **[verifier]**:
  > "Low battery warning: Audio warning if input voltage drops below 6.8V which only works well for a 2S power supply"
- p.8, image settings:
  > "Power is the actual maximum power provided to the OLED panels. If you increase this, the light energy of the panel will actually go up (so whites get brighter). This will have a negative impact on battery life as it can significantly increase power consumption. It is recommended to keep the OLED power setting at or below 75 for battery life reasons."
- p.10, "AV connector Pin-out" (drawing labels + text):
  > "Gr ound Video AudR AuL" / "3.5mm AV Connector: Yellow: Video, White: Audio Left, Red: Audio Right"
- p.10, 18650 case:
  > "Barrel connector cable features high strand count wire for flexibility and long life."
  **[verifier]** Scope: this sentence describes the optional 18650 battery case's cable, not the goggle's port. It does not by itself say what the port is; see C3 L103.
- p.11, "Specifications", "Electrical":
  > "Power Supply: 7 – 13V input voltage (2S – 3S Supply)"
  > "Power Consumption: 320mA @ 7.5V input power (no RX module)" / "770mA @ 7.5V input power (Rapid"
  > "Battery: 7.4V, 1.8A 18650 Battery Case (optional))"
  > "Interface: 3.5mm AV in/out port" / "Power input port"
  > "Dimensions: 169.2 x 80 x 45.5 mm" / "Weight: 206.8 g"

## C2. FPV24 HDO2 product page (retailer, matches C1)
File: `papers/ctrl_hdo2_fpv24.html` / `.txt` (https://www.fpv24.com/en/fatshark/fatshark-dominator-hdo2-fpv-video-glasses)
- L187–189 **[verifier: the draft said L254–256; the text is at L187–189]**: > "Power supply: 7 - 13V input voltage (2S - 3S supply)" / "Power consumption: 320 mA at 7.5 V input power (no RX module)" / "770mA at 7.5V input voltage (Rapid)"

## C3. Oscar Liang, HDO2 review (secondary)
File: `papers/ctrl_hdo2_oscarliang.html` / `.txt` (https://oscarliang.com/fatshark-hdo2-fpv-goggles/)
- L103 (used for: the HDO2 power input is a barrel connector) **[verifier]**: > "the fan is now powered directly from the barrel connector (no longer need to plug in the 2S balance port), and the fan turns on as soon as you plug in the battery."

## C4. Caddx TR1-220SL wiring diagram (BZB UAS image), retrieved by track 03
File: `papers/bzbuas_tr1-220sl_wiring_diagram.png` (I read it visually)
- 6-pin connector labels: > "GPIO2 (Connect TX of FC)" / "GPIO1" / "GPIO0" / "GND (Connect GND of FC)" / "RX" / "TX"
- Left: > "CVBS" / "GND" / "Power 9V~24V" / "Power 9V~24V" / "(Spare pad) GND"
- Right: > "OSD" (2-pin) / "DP" / "DN" / "GND" / "VBUS"
- Note: > "Power Consumption: 12V@120mAh" / "CVBS: Connect to analog VTX "CAMERA" port or "CVBS IN" port"

## C5. BZB UAS TR1-220SL product page (EN), retrieved by track 03
File: `papers/bzbuas_tr1-220sl_product_page_en.txt`
- L48: > "You can easily switch between the cameras via the included GPIO cable, giving you instant access to the view you need."
- L82–83: > "Input voltage" / "9-24V"
- L111–112 (Infra camera block) and L128–129 (thermal block): > "Power Consumption" / "<1.5W"
- L134–135: > "1x 3pin Silicon Cable" / "1x GPIO Connection Cable"
- L84–85 **[verifier]**: > "Working Temperature" / "-10°C ~ 50°C"
- **[verifier]** No power figure is given for the AI box itself; only the two camera blocks carry "<1.5W".

## C6. Caddx ECLIPSE 004 Dual Quick Start Guide (sister product; same AI-box connector labels as C4)
File: `papers/ctrl_caddx_eclipse004dual_ft483dual.pdf` / `.txt` (1 tall page, 1280 × 10397 pt; https://www.rotorama.com/assets/docs/422754d47b05062b7fbe4d921cebcbe6/31893-1/ft483dual.pdf)
- "Connection": > "Power Consumption: 12V@120mAh"  (**[verifier]** identical wording to the TR1 drawing, C4)
- "Switch Control": > "Use the remote controller to remotely switch the display of the visible light camera and the black&white camera. Take the commonly used Betaﬂight F405 FC as an example to explain how to confgure the remote control switching function. Take the FC TX1 port as an example, make sure the UART1 function is not used, and solder the control line (Introduction 4)to the FC TX1 port."
  > "resource PINIO 1 A09 //Conﬁgure the TX1 pin (…) as PlNlO function No. 1"
  > "The cursor in the white area shows the visible light camera, and thecursor in the yellow area shows the thermal imaging camera."
- "Serial Communication Description":
  > "TX Master transmit, 3.3V level, baud rate default 115200bps"
  > "RX Master receive, 3.3V level, baud rate default 115200bps"
  > "GPIO0 General Purpose IO, 3.3V level" / "GPIO1 General Purpose IO, 3.3V level" / "GPIO2 General Purpose IO, 3.3V level"
- "2.2 Image Adjustment": > "1Byte brightness value (0-100), no payload without setting only return the actual brightness value"
- "3. Example of Command": > "Set the brightness to 80% FF 5A 00 01 00 00 01 00 00 00 50 EA A2" / "Set the brightness to 50% FF 5A 00 01 00 00 01 00 00 00 32 6B 4B"
- "2.3 Pseudo-Color": > "Set the pseudo-color serial number, 0 is oﬀ pseudo-color"
- "2.4 Shutter Control": > "Manual shutter calibration image"
- "OSD Functions": > "The movement allows you to customize the OSD string of the video display through an external menu board." **[verifier]** / "The OSD board is divided into four directions: up, down, left, right and center."
- "Specifications" (Eclipse 004): > "Power Consumption <1.5w" / "Supply Voltage 9V~24V"

## C7. Caddx Eclipse 005SL port drawing (BZB UAS image), retrieved by track 03
File: `papers/bzbuas_eclipse005sl_adkey_osd_menu_board.png` (I read it visually)
- > "ADKEY" / "GND" (2-pin port); > "DP" / "DM" / "GND" / "VBUS"
- > "RIGHT" "UP" "LEFT" "DOWN", "OSDMenu Board"
- > "*Short press the middle button on the menu board to enter OSD settings. Remove the OSD menu board after completing the settings."

## C8. Seeed Studio XIAO ESP32C3 wiki
File: `papers/ctrl_xiao_esp32c3_wiki.html` / `.txt` (https://wiki.seeedstudio.com/XIAO_ESP32C3_Getting_Started/)
- L147: > "It has excellent radio frequency performance, supporting IEEE 802.11 b/g/n WiFi , and Bluetooth 5 (BLE) protocols. This board comes included with an external antenna to increase the signal strength for your wireless applications. It also has a small and exquisite form-factor combined with a single-sided surface-mountable design ."
- L170–171: > "Dimensions" / "21 x 17.8mm"
- L173–174: > "Max 3.3V Output Current: 500mA" / "Test Condition: BAT Pin Input @ 3.8V"
- L177: > "Input voltage (VIN): 5V"
- L179–187: > "Deep Sleep Mode: 44 μA" … "Modem-sleep Mode: 25 mA" / "Light-sleep Mode: 4 mA" … "BLE Enabled Power Consumption" / "Modem-sleep Mode: 27 mA" / "Light-sleep Mode: 10 mA"
- L181–182 **[verifier]**: > "Wi-Fi Enabled Power Consumption" / "Active Mode: 75 mA"
- **[verifier]** No supply voltage is stated for these current figures. "Test Condition: BAT Pin Input @ 3.8V" (L174) belongs to the "Max 3.3V Output Current: 500mA" line above it.
- L162–163 (spec table) **[verifier]**: > "Interface" / "1x UART"  (conflicts with "2xUART" at L200 on the same page)
- L188–189 **[verifier]**: > "Working Temperature" / "-40°C ~ 85°C"
- L200: > "Rich interfaces: 1xI2C, 1xSPI, 2xUART, 11xGPIO(PWM), 4xADC, 1xJTAG bonding pad interface"
- L203: > "*A3(GP105) - Uses ADC2, which may become inoperative due to false sampling signals. For reliable analog reads, use ADC1(A0/A1/A2) instead."
- L297: > "5V - This is 5v out from the USB port. You can also use this as a voltage input but you must have some sort of diode (schottky, signal, power) between your external power source and this pin with anode to battery, cathode to 5V pin."
- L355: > "The basic operating idea is: The battery voltage was divided by 1/2 with 200k and connected to the A0 port so that the voltage could be monitored."

## C9. Seeed Studio XIAO ESP32S3 wiki
File: `papers/ctrl_xiao_esp32s3_wiki.html` / `.txt` (https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/)
- L211–212: > "Dimensions" / "21 x 17.8mm"
- L216–221: > "Input voltage (Type-C): 5V" / "Input voltage (BAT): 3.7V" … "- Type-C: 5V@19mA" / "- BAT: 3.8V@22mA"
- L252–254 (XIAO ESP32-S3 column): > "Modem-sleep Mode: 27mA" / "Light-sleep Mode: 2mA" / "Deep Sleep Mode: 14μA"
- L276: > "support 100m+ remote communication when connected with U.FL antenna"
- L250–251 **[verifier]** (heading of the sleep figures): > "Low Power Consumption Model(Typ.)" / "(Supply Power: 3.8V)"
- L175, L272 **[verifier]**: > "On-chip 8MB PSRAM & 8MB Flash" / "Incorporate the ESP32S3 32-bit, dual-core, Xtensa processor chip operating up to 240 MHz"

## C10. Seeed Studio XIAO nRF52840 wiki
File: `papers/ctrl_xiao_nrf52840_wiki.html` / `.txt` (https://wiki.seeedstudio.com/XIAO_BLE/)
- L155: > "…Nordic nRF52840 MCU which integrates Bluetooth 5.0 connectivity. … The single-sided surface-mountable design and the onboard Bluetooth antenna can greatly facilitate the rapid deployment of IoT projects."
- L164: > "Ultra-Low Power: Standby power consumption is less than 5μA"
- L169: > "Ultra Small Size: 21 x 17.8mm, Seeed Studio XIAO series classic form-factor for wearable devices"
- L170: > "11xGPIO(PWM), 6xADC in XIAO nRF52840 (Sense)"

## C11. Seeed Studio XIAO RP2040 wiki
File: `papers/ctrl_xiao_rp2040_wiki.html` / `.txt` (https://wiki.seeedstudio.com/XIAO-RP2040/)
- L151: > "Its 11 digital I/O pins are PWM-capable, with four also supporting analog input. The board provides I2C, UART, SPI, and SWD interfaces in a compact 21 × 17.8 mm form factor."
- L165: > "Flexible assembly options: Breadboard-friendly common pins combined with castellated edges and SMD-compatible pads for custom carrier boards"
- L238: > "Working voltage of MCU is 3.3V. Voltage input connected to general I/O pins may cause chip damage if it's higher than 3.3V."
- L240: > "The built-in DC-DC converter circuit able to change 5V voltage into 3.3V allows to power the device with a 5V supply via VIN-PIN and 5V-PIN."

## C12. Seeed Studio XIAO SAMD21 wiki
File: `papers/ctrl_xiao_samd21_wiki.html` / `.txt` (https://wiki.seeedstudio.com/Seeeduino-XIAO/)
- L166: > "Powerful MCU: Microchip ATSAMD21G18A Arm® Cortex®-M0+ processor at 48 MHz, with 256 KB Flash, 32 KB SRAM, and native USB support."
- L210–211: > "Input Voltage (Type-C): 5 V" / "BAT Input: Not supported"
- L220: > "21 × 17.8 mm"
- L232: > "Working voltage of MCU is 3.3V. Voltage input connected to general I/O pins may cause chip damage if it' higher than 3.3V ."

## C13. Waveshare RP2040-Zero wiki
File: `papers/ctrl_waveshare_rp2040zero_wiki.html` / `.txt` (https://www.waveshare.com/wiki/RP2040-Zero)
- L106: > "Using castellated processing technology, it can be welded onto your custom board"
- L114: > "Low-power sleep and dormant modes"
- L310–311: > "The VSYS pin of the RP2040 is connected to the VUSB pin directly in RP2040-zero (named Pin23 ), If you want to connect the battery directly to the VSYS pin, you need to add a diode to avoid backflow." / "RP2040 zero itself has no battery protection function"
- (Dimensions appear only as an image on both Waveshare pages, so no number is quoted.)

## C14. Pololu D36V6F5 (5 V, 600 mA)
File: `papers/ctrl_pololu_D36V6F5.html` / `.txt` (https://www.pololu.com/product/3792)
- L77–85: > "Input voltage: 5.2 V to 50 V (minimum input subject to dropout voltage considerations; see the dropout voltage section for details)" / "Output voltage: 5 V with 4% accuracy" / "Maximum output current: 600 mA" / "High-voltage enable input can put the board into a low-power state where it draws less than 2 μA (typical)" / "Low quiescent current: < 0.1 mA" / "Small size: 0.5″ × 0.4″ × 0.1″ (13 mm × 10 mm × 3 mm)" / "Weight: 0.5 g"
- L74: > "The boards do not have reverse-voltage protection."
- L65–73 (family list): > "D36V6F3: Fixed 3.3V output" / "D36V6F5: Fixed 5V output" / "D36V6F9: Fixed 9V output" / "D36V6F12: Fixed 12V output"

## C15. Pololu D36V6F9 (9 V, 600 mA)
File: `papers/ctrl_pololu_D36V6F9.html` / `.txt` (https://www.pololu.com/product/3795)
- L77: > "Input voltage: 9.2 V to 50 V (minimum input subject to dropout voltage considerations; see the dropout voltage section for details)"
- L79: > "Maximum output current: 600 mA"
- L84–85: > "Small size: 0.5″ × 0.4″ × 0.1″ (13 mm × 10 mm × 3 mm)" / "Weight: 0.5 g"

## C16. Pololu D24V5F5 and D24V10F5
Files: `papers/ctrl_pololu_D24V5F5.*` (https://www.pololu.com/product/2843), `papers/ctrl_pololu_D24V10F5.*` (https://www.pololu.com/product/2831)
- D24V5F5 L80–85: > "Maximum output current: 500 mA" / "Typical efficiency of 80% to 93%" / "200 μA typical no-load quiescent current" / "Small size: 0.5″ × 0.4″ × 0.1″ (13 mm × 10 mm × 3 mm)"
- D24V10F5 L86: > "Small size: 0.7″ × 0.5″ × 0.14″ (18 mm × 13 mm × 3.5 mm)"
- D24V10F5 L107: > "In our tests with typical power leads (~30″ test clips), input voltages above 20 V caused spikes over 36 V."

## C17. Mini560 5 V (DomoticX retailer page; no manufacturer datasheet found)
File: `papers/ctrl_mini560_domoticx.html` / `.txt`
- L118 (listing title) **[verifier]**: > "Spanningsregelaar module step-down max. 20V naar 5V DC-DC 5A mini560 JW5068A"
- L145–154: > "Chip: JW5068A" / "Voltage Input: 5V – 20V" / "Voltage Output: 5V" / "Conversion efficiency: 99% (maximum)" / "Module size: 29*18*5.4mm"
- L158–159 (same page, shop table): > "Afmetingen" / "15 × 12 × 4 mm"  (this contradicts the 29 × 18 mm figure above)

## C18. Samsung SDI INR18650-35E technical report (June 2015, marked "Tentative Specification")
File: `papers/ctrl_samsung_35E_rapid.pdf` / `.txt` (https://static.rapidonline.com/pdf/10-5181_v1.pdf)
- p.2: > "Capacity (0.2C) Typical 3450mAh" / "Min. 3350mAh" / "Nominal Voltage (0.2C) 3.60V" / "Charging Voltage 4.20V" / "Discharging Cut-off Voltage 2.50V" / "Discharging Current (Not for cycle) Max. 8000mA" / "Weight Max. 50.0g" / "Operating Temperature Charge 0 ~ 45 ℃" / "Discharge -10 ~ 60 ℃" / "Φ max 18.50 mm" / "Max 65.25 mm"
- p.3 "Standard Capacity_0.2C": > "capacity (mAh) 3,482" / "Energy (Wh) 12.62"
- p.6 "Room Temperature Discharge (23℃)": > "3.5A 7.0A 10.0A" / "Capacity (mAh) 3,468 3,429 3,379" / "Energy (Wh) 11.94 11.37 10.98"

## C19. Molicel INR-18650-P28A product data sheet
File: `papers/ctrl_molicel_p28a.pdf` / `.txt` (https://www.rosebatteries.com/hubfs/INR18650P28A-V2-80093.pdf)
- p.1: > "Typical 2800 mAh" / "10.3 Wh" / "Minimum 2700 mAh" / "9.56 Wh" / "Nominal 3.6 V" / "Charge 4.2 V" / "Discharge 2.5 V" / "Discharge Current Maximum 35 A" / "Discharge -40°C to 60°C" / "Gravimetric 219 Wh/kg"

## C20. Alps Alpine EC11E series (rotary encoder)
File: `papers/ctrl_alps_EC11.html` / `.txt` (https://tech.alpsalpine.com/e/products/category/encorders/sub/01/series/ec11e/)
- > "Output : Incremental (Two phase A and B) ･ Size : 11mm size ･ Number of detent : 18 / 30 / 36 ･ Number of pulse (Positions) : 9 / 15 / 18 ･ Operating life : 15,000 cycles ･ Rating (max.) : 10mA 5V DC"
- Table row: > "EC11E09244BS" / "Vertical" / "Flat" / "20mm" / "18" / "9" / "With" / "0.5mm" / "11mm size"
- **[verifier]** In `ctrl_alps_EC11.html` the row is `data-supply-status="standard"`, i.e. "mass-produced and recommended for new designs".

## C21. Alps Alpine SKQU series (4-direction + centre push, snap-in)
File: `papers/ctrl_alps_SKQU.html` / `.txt`
- > "Not Recommended for New Designs" … "Operation feeling : Soft feeling ･ Mount type : Snap-in ･ Dimensions (W×D×H) : 8.0×9.0×10.0mm"
- > "SKQUAAA010" "1.57N" "4-direction" "0.35mm" … "SKQUCAA010" "1.57N" "Center-push" "0.4mm"
- **[verifier]** These are two separate parts: AAA010 is 4-direction only, CAA010 centre-push only. Both rows carry `data-supply-status="deprecated"` in `ctrl_alps_SKQU.html` (L1066, L1100), which is "Not Recommended for New Designs".

## C22. Omron B3F (THT tactile, 6×6 and 12×12)
File: `papers/ctrl_omron_B3F.pdf` / `.txt` (https://omronfs.omron.com/en_US/ecb/products/pdf/en-b3f.pdf)
- p.1: > "Extended mechanical/electrical durability: 10 x 106 operations for 12 x 12 mm type and 1 x 106 operations for the 6 x 6 mm type" / "B32-series Key Tops mount to models with projected plungers."
- p.2, 12 × 12 mm table: > "Projected type 7.3 mm 1.27 N {130 gf} lvory B3F-4050" / "2.55 N {260 gf} Yellow B3F-4055"
- p.1, 6 × 6 mm table: > "9.5 mm 0.98 N {100 gf} Black B3F-1070" / "2.55 N {260 gf} Orange B3F-1075"
- p.3: > "12 × 12 mm models (standard types): approx. 0.85 g" / "Degree of protection IEC IP00"  (**[verifier]** the weight is for *standard* types; B3F-4055 is a projected type)
- p.3 **[verifier]**: > "Pretravel (PT) 0.25+0.2/–0.1 mm" (6 × 6) / "Pretravel (PT) 0.3+0.2/–0.1 mm" (12 × 12)

## C23. Omron B3S (SMT sealed tactile 6×6)
File: `papers/ctrl_omron_B3S.pdf` / `.txt` (https://omronfs.omron.com/en_US/ecb/products/pdf/en-b3s.pdf)
- p.1: > "Sealed construction conforming to IP67 (IEC-60529) provides high contact reliability in locations exposed to dust or water. (* Excluding the terminal section.)"
- p.1: > "B3S-1000 Silver 4.3 mm 1.57 N Ivory" … "2.26 N Yellow B3S-1002"
- p.1 **[verifier]**: > "Operating force (OF) 1.57 N {160 gf} max. 2.26 N {230 gf} max." / "Pretravel (PT) 0.25 +0.2/–0.1 mm"
- p.1: > "Ambient operating temperature -25°C to +70°C at 60%RH max. (with no icing or condensation)" / "Bounce time 5 ms max." / "Weight Approx. 0.3 g" / "Degree of protection IEC IP67"

## C24. JST GH connector
File: `papers/ctrl_jst_GH.pdf` / `.txt` (https://www.jst-mfg.com/product/pdf/eng/eGH.pdf)
- p.1: > "1.25 mm pitch/Wire-to-Board connectors/Crimp style and Mating style" / "Current rating: 1.0 A AC/DC（AWG #26）" / "Voltage rating: 50 V AC/DC" / "Temperature range: ‑40 ℃ to +105 ℃" / "Conductor size/ AWG #30 to AWG #26" / "board connector with a secure locking function."

## C25. Adafruit 1201 vibration motor (10 mm disc)
File: `papers/ctrl_adafruit_1201_vibration_motor.html` / `.txt` (https://www.adafruit.com/product/1201)
- L118–122: > "Dimension: 10mm diameter, 2.7mm thick" / "Voltage: 2V - 5V" / "5V current draw: 100mA, 4V current draw: 80mA, 3V current draw: 60mA, 2V current draw: 40mA" / "11000 RPM at 5V" / "Weight: 0.9 gram"
- L114: > "For full power control, a small PN2222 transistor can control a motor easily"
- L113 **[verifier]**: > "The rated voltage is 2.5 to 3.8V and for many projects, we found it vibrates from 2V up to 5V, higher voltages result in more current draw but also a stronger vibration."

## C26. Adafruit 5358 DIY magnetic connector
File: `papers/ctrl_adafruit_5358_magnetic_connector.html` / `.txt` (https://www.adafruit.com/product/5358)
- L105–111: > "3 Contact Pins - Right Angle" / "4 Contact Pins - Right Angle" / "5 Contact Pins - Right Angle" / "5 Contact Pins - Straight"
- L124–125: > "with four 0.1" spaced contact pogo pins and a right angle solderable connection to your PCB." / "If you try to connect the contacts backwards, they will repel!"
- (No current rating on the page.)

## C27. Betaflight PINIO source (added by verifier) [verifier]
Files: `papers/betaflight_drivers_pinio.c.txt`, `papers/betaflight_pg_pinio.c.txt` (track 03 copies of https://raw.githubusercontent.com/betaflight/betaflight/master/src/main/..., see `extracts_camera.md`)
- `betaflight_pg_pinio.c.txt` L57: > "#define PINIO1_CONFIG PINIO_CONFIG_MODE_OUT_PP"
- `betaflight_drivers_pinio.c.txt` L52–70 (`pinioInit()`): > "case PINIO_CONFIG_MODE_OUT_PP:" … "IOConfigGPIO(io, IOCFG_OUT_PP);" … "} else {" / "pinioRuntime[i].inverted = false;" / "IOLo(io);"
  (Default PINIO is a push-pull output. When not inverted it starts low.)

## C28. BZB UAS Eclipse 005SL product page (added by verifier) [verifier]
File: `papers/bzbuas_eclipse005sl_product_page.txt` (track 03)
- L74–75: > "OSD customization and ADKEY menu:" / "Allows full configuration of display parameters directly on the screen."
- L101–102: > "Adjustment Method" / "UVC/ ADKEY"
