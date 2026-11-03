# 05: Controller and power architecture (working draft)

Track 05 of the arabskie_gogle research. **`ZALOZENIA.md` is authoritative.** Where this report disagrees with it, ZALOZENIA governs.
Status: **working draft.** It depends on track 03 (camera control interface: what GPIO2, UART and the OSD port really do on the TR1-220SL). The controller section is final only after the bench checks in §8.
Verbatim quotes for every [V] tag are in `papers/extracts_controller.md` (C1…C28). An adversarial verification pass was run on this file (see **Verification** at the end); where the extracts file and this report disagree, the extracts (and behind them the source files in `papers/`) govern.
Tags: **[V]** = read at source. **[calc]** = my arithmetic on [V] numbers. **[A]** = assumption, not sourced; must be measured. **[design]** = engineering recommendation, not a sourced claim.

## TL;DR (recommendations for this build)
1. **One 3S1P Li-ion pack (3× Samsung 35E, ≈37.9 Wh) on the back of the helmet feeds both devices directly.** The HDO2 accepts 7–13 V and the camera 9–24 V, so 3S (9.0–12.6 V) fits both with no regulator. The pack also counterweights the front camera. Expect about 6 h in the mid case and about 4.4 h in the worst case with an assumed cold derating (both rest on [A] figures, §4.3). Use 3S2P for a full night. Note the cold limits: the TR1 is rated to −10 °C and the 35E discharges down to −10 °C (§1.2, §4.1).
2. **Controller: a Seeed XIAO ESP32-C3 (21 × 17.8 mm), or the XIAO nRF52840 if you want BLE without an external U.FL antenna.** Mount it in the printed button pod on the goggles. Power it from a Pololu D36V6F5 (13 × 10 × 3 mm, 0.5 g) through a Schottky into the 5 V pin. It drives camera GPIO2 directly and optionally the camera UART (115200). The 3.3 V level and 115200 baud are documented only for the sister Eclipse 004 Dual, not for the TR1 (§1.2).
3. **Buttons (glove-friendly, operated blind): one Alps EC11E09244BS encoder with push** (11 mm body, 18 detents, push switch) **plus two Omron B3S IP67 sealed 6×6 tactiles (1.57 N max operating force; 2.26 N B3S-1002 variant available).** Put 3D-printed oversized caps on the tactiles. The camera-switch button gets its own distinct shape.
4. **Low-battery warning must not rely on sight or on the HDO2 alarm.** Fat Shark says not to rely on its alarm on 3S; its threshold is 6.8 V (manual p.8), which on 3S is 2.27 V/cell, below the cell cut-off and far below the camera's 9 V floor, so on 3S it effectively never fires before the camera drops out [calc]. Instead, an ADC divider (100k/22k) feeds an ADC1 pin. Below 3.4 V/cell the MCU pulses a 10 mm vibration motor and (if the UART protocol works on the TR1) briefly flashes the image brightness.
5. **Goggle-to-helmet trunk has 5 conductors (VBAT, GND, CVBS, GPIO2, UART-TX) through a 5-pin magnetic pogo breakaway**, with JST-GH (1.25 mm, 1 A) inside the pods. Bench-test the pogo contacts for CVBS noise and for current first. Phase 0, no MCU, is also possible: a switch on GPIO2 plus, if compatible, the Caddx 5-way OSD board on the OSD/ADKEY wire (what that board controls on the TR1 is unknown). See §2a.

---

## 1. What we are powering and controlling (sourced facts)

### 1.1 HDO2
- Input range: "7 – 13V input voltage (2S – 3S Supply)"; consumption "320mA @ 7.5V input power (no RX module)", "770mA @ 7.5V input power (Rapid" [V: papers/FatShark_HDO2_Manual_RevC.pdf, p.11]. → **2.40 W without an RX module** [calc]. **Leave the receiver module out**: with the module the manual truncates as "(Rapid" (presumably a Rapidfire) the figure is 5.78 W at 7.5 V [calc].
- In Legacy Mode it powers on when a 7–13 V source is connected and powers off when the source is removed [V: …HDO2_Manual_RevC.pdf, p.6]. One master switch for the whole system therefore works.
- "Fan speed is proportional to the input voltage… we recommend lowering fan speed if using a 3S source." The low-battery alarm "is designed to work for a 2S source and may not provide much warning for a 3S source. We recommend not relying on the low battery indicator if you are using a 3S source" [V: …p.7]. The specs on p.8 give the threshold: "Audio warning if input voltage drops below 6.8V which only works well for a 2S power supply" [V: …p.8]. On 3S, 6.8 V = 2.27 V/cell, below the 35E's 2.50 V cut-off and below the camera's 9.0 V minimum [calc]. → **We need our own low-voltage warning.**
- OLED "power" setting: "can significantly increase power consumption. It is recommended to keep the OLED power setting at or below 75" [V: …p.8]. For night use the panel is mostly dark anyway, but a white-hot thermal image is not.
- 3.5 mm AV pinout drawing: "Gr ound Video AudR AuL" [V: …p.10]. The jack-pole order needs a meter check (§8). The manual calls the input only "Power input port" [V: …p.11]; its p.10 "Barrel connector cable…" refers to the optional 18650 case's cable, which plugs into that port, and a review says "the fan is now powered directly from the barrel connector" [V: papers/ctrl_hdo2_oscarliang.txt, L103]. So it is a barrel jack, but **no source gives its size or polarity**; measure it.
- Weight 206.8 g, 169.2 × 80 × 45.5 mm [V: …p.11]. A retailer page repeats the 7–13 V and 320 mA figures [V: papers/ctrl_hdo2_fpv24.txt, L187–189].

### 1.2 Caddx TR1-220SL Dual (AI box + thermal + Infra)
- Supply "9-24V"; "Power Consumption <1.5W" listed separately under each camera [V: papers/bzbuas_tr1-220sl_product_page_en.txt, L82–83, L111–112, L128–129]. No separate figure is given for the AI box itself.
- "Working Temperature" "-10°C ~ 50°C" [V: same file, L84–85]. Below −10 °C the camera is out of spec regardless of the pack.
- The TR1-220SL wiring drawing says "Power Consumption: 12V@120mAh" [V: papers/bzbuas_tr1-220sl_wiring_diagram.png]. Reading "mAh" as a typo for mA, that is **1.44 W** [calc]. Caution: the Eclipse 004 Dual guide carries the identical note "Power Consumption: 12V@120mAh" [V: C6], so this may be copied boilerplate rather than a TR1 measurement. The store's two per-camera figures add up to <3.0 W, but the AI box's own draw is not listed, so 3.0 W is a store-derived high estimate, **not a sourced upper bound**. Both figures are used as the low and high case below. **Measure it** (§8).
- Control connector (6-pin): "GPIO2 (Connect TX of FC)", "GPIO1", "GPIO0", "GND (Connect GND of FC)", "RX", "TX". There is also a separate 2-pin "OSD" port and a 4-pin USB (DP/DN/GND/VBUS) [V: …wiring_diagram.png].
- The sister product Eclipse 004 Dual has the same connector labels and documents the following [V: papers/ctrl_caddx_eclipse004dual_ft483dual.pdf, sections "Switch Control", "Serial Communication Description"]:
  - camera switching by an FC **PINIO output** on GPIO2;
  - GPIO0/1/2 "3.3V level";
  - UART "3.3V level, baud rate default 115200bps", with commands for brightness, contrast, pseudo-colour, shutter (NUC) and hot tracking.
  - an external 5-way "OSD board", but on the 004 it only edits an on-screen text string: "customize the OSD string of the video display through an external menu board".
  **Not confirmed for the TR1-220SL**. That is track 03's job.
- The Eclipse 005SL drawing labels its 2-pin port "ADKEY / GND" and shows a 5-way "OSDMenu Board" (UP/DOWN/LEFT/RIGHT + middle). Its note says "Remove the OSD menu board after completing the settings" [V: papers/bzbuas_eclipse005sl_adkey_osd_menu_board.png]. The 005SL product page says its "OSD customization and ADKEY menu" "Allows full configuration of display parameters directly on the screen" [V: C28]. Whether the TR1's "OSD" port is the same ADKEY input, and whether its menu adjusts the image (as on the 005SL) or only a text string (as on the 004), is **not documented**.

**Electrical consequence (conditional):** if the TR1 matches the 004 Dual, every control signal is 3.3 V logic [V: C6, 004 Dual only]. The XIAO RP2040 and SAMD21 wikis state 3.3 V MCU working voltage [V: papers/ctrl_xiao_rp2040_wiki.txt, L238; papers/ctrl_xiao_samd21_wiki.txt, L232]; the ESP32-C3 and nRF52840 wikis retrieved here do not state an I/O voltage, so 3.3 V I/O on those is [A] (standard for both chips, but not sourced here). Until the TR1 lines are measured (§8), put a 1 kΩ series resistor in each MCU→camera line [design].

## 2. Controller options

### 2a. No MCU (Phase 0, bench first)
- **GPIO2 only:** a single SPDT/latching switch (or a momentary button with a printed toggle) selects the camera.
  - On the 004 Dual the FC drives this line from a Betaflight PINIO output [V: C6]. Betaflight configures PINIO as push-pull and, when not inverted, initialises it low [V: C27]. Because the FC actively drives both levels, the camera may have **no internal pull** on GPIO2 [design inference].
  - A switch to GND works only if the camera pulls the line up internally. Otherwise the switch needs a 3.3 V source. With no MCU there is no 3V3 rail, so add a Pololu **D36V6F3** (fixed 3.3 V member of the D36V6 family [V: papers/ctrl_pololu_D36V6F5.txt, L65]; size assumed equal to the F5/F9 13 × 10 × 3 mm [A]). Alternatively take 3.3 V from a divider, but that drifts with pack voltage [design].
  - **Bench:** measure the open-circuit voltage on GPIO2 first (§8).
- **OSD/ADKEY:** if the TR1's "OSD" port accepts the Caddx 5-way OSD board, mount that board itself in the goggle pod. You then get a 5-way control on **two wires** with no firmware. Caveats: Caddx's own advice is to remove the board after setup [V: C7]; it may load the line or cause false presses; and what the menu controls on the TR1 is unknown. On the 004 the board only edits an OSD text string [V: C6]; on the 005SL the ADKEY menu configures display parameters [V: C28]. Test it.
- **Verdict:** zero code and zero sleep current, but no low-battery logic, no macros (e.g. "long press = force thermal"), and no UART features [design].

### 2b. Seeed XIAO family (all 21 × 17.8 mm, USB-C; 3.3 V I/O stated in the RP2040/SAMD21 wikis only, see §1.2)
| Board | Radio | Size | Sleep figure (wiki) | Mounting | Notes for us |
|---|---|---|---|---|---|
| **XIAO ESP32-C3** | BLE 5 + Wi-Fi | 21 × 17.8 mm [V: C8 L170–171] | deep sleep 44 µA; BLE modem-sleep 27 mA [V: C8 L179–187] | single-sided SMD [V: C8 L147] | UART count conflicts on the same page: spec table "1x UART" (L163) vs feature list "2xUART" (L200); we need one. 4 ADC; **use ADC1 (A0–A2), not A3/ADC2** [V: C8 L200, L203]; Wi-Fi active 75 mA [V: C8 L182]; external antenna included [V: C8 L147]; 5 V pin input needs a series diode [V: C8 L297] |
| XIAO ESP32-S3 | BLE 5 + Wi-Fi | 21 × 17.8 mm [V: C9 L211–212] | deep sleep 14 µA (at 3.8 V supply); operating 5 V @ 19 mA [V: C9 L220, L251–254] | — | Overkill (dual-core, 8 MB PSRAM [V: C9 L175, L272]); U.FL antenna [V: C9 L276] |
| **XIAO nRF52840** | Bluetooth 5.0, **onboard antenna** [V: C10 L155] | 21 × 17.8 mm [V: C10 L169] | standby < 5 µA [V: C10 L164] | single-sided SMD [V: C10 L155] | 6 ADC [V: C10 L170]; best if a BLE remote or phone app matters and the pod must stay antenna-free |
| XIAO RP2040 | none | 21 × 17.8 mm [V: C11 L151] | — (not given) | castellated edges [V: C11 L165] | 4 ADC; fine if no BLE wanted; 5 V via VIN/5V pin [V: C11 L240] |
| XIAO SAMD21 | none | 21 × 17.8 mm [V: C12 L220] | — | — | 48 MHz M0+ [V: C12 L166]; "BAT Input: Not supported" on non-Plus [V: C12 L210–211] |

**Power is not a selection criterion here, provided Wi-Fi stays off** [calc]. The C3 wiki does not state the supply voltage for its current figures, so I take them at the 5 V pin [A]. BLE modem-sleep: 27 mA × 5 V = 0.135 W, about 2.5 % of a roughly 5.5 W system. Wi-Fi active is the largest figure listed: 75 mA × 5 V = 0.375 W, about 7 %, so keep Wi-Fi off in the field. The MCU stays awake whenever the goggles are on. Deep-sleep numbers matter only if the MCU stays powered while the rest is off. With one master switch, it doesn't.

**Pick:** **XIAO ESP32-C3** as the default. It is cheap, has at least one UART (the page gives both 1 and 2), and can do BLE later. Choose the **XIAO nRF52840** if you want BLE control (wrist or ring remote, phone) without an external antenna lead in the printed pod [design].

### 2c. Others
- **Waveshare RP2040-Zero:** castellated, "Low-power sleep and dormant modes" [V: C13 L106, L114]. VSYS is tied straight to VUSB, so external feed needs a diode [V: C13 L310]. Its dimensions appear only as an image on Waveshare's pages, so no number is quoted here. There is no advantage over the XIAO RP2040 for us.
- **ATtiny (e.g. tinyAVR-0/1):** the datasheet was not retrieved, so I make no claim. It is a plausible chip-down option only if you later design a custom PCB for the pod. For a one-off, the XIAO's USB-C programming wins [design].

## 3. Buttons (blind, gloved)
The user is **fully occluded**, so the controls are found and identified by touch only. Each control should differ by shape and position, and the most safety-critical action ("back to thermal") must be the easiest to find [design].

| Part | Key data [V] | Role (proposal) [design] |
|---|---|---|
| **Alps EC11E09244BS** encoder | 11 mm size; 20 mm flat shaft; 18 detents / 9 pulses; push switch, 0.5 mm travel; rating 10 mA 5 V DC; life 15,000 cycles [V: papers/ctrl_alps_EC11.txt] | Turn: brightness or palette (via UART if confirmed). Push: cycle mode. Long push: manual NUC |
| **Omron B3S-1000** ×2 | 6 × 6 mm SMT, 4.3 mm high, operating force 1.57 N max (B3S-1002: 2.26 N max); pretravel 0.25 +0.2/−0.1 mm; **IP67** (except the terminals); −25…+70 °C; bounce 5 ms max; 0.3 g [V: papers/ctrl_omron_B3S.pdf, p.1] | Button A (big, domed cap): toggle thermal/Infra (GPIO2); long press = force thermal. Button B (ridged cap): spare/OSD |
| alt. Omron B3F-4055 | 12 × 12 mm, projected-plunger type, 7.3 mm high, 2.55 N, takes B32 keytops; pretravel 0.3 +0.2/−0.1 mm; **IP00**; ≈0.85 g is given for the 12 × 12 *standard* types only [V: papers/ctrl_omron_B3F.pdf, p.1–3] | If you prefer a bigger, stiffer through-hole switch and seal it under a printed boot or TPU membrane |
| alt. Alps SKQUAAA010 (4-direction only, 0.35 mm travel) / SKQUCAA010 (centre-push only, 0.4 mm) | separate parts, not one 4-dir + centre switch; both 8.0 × 9.0 × 10.0 mm, 1.57 N; both flagged **"Not Recommended for New Designs"** [V: papers/ctrl_alps_SKQU.txt, .html] | Avoid, mainly for NRND status. Travel is not the argument: the recommended B3S has even less pretravel (0.25 mm) |

- Why the encoder over a 5-way joystick: detents give counted, blind feedback through a glove. A miniature 5-way risks diagonal mis-hits [design]. (All the tactiles above, including the B3S, also have sub-millimetre travel, so the printed caps, not the switch, must give the gloved finger something to find.) The Caddx OSD board (5-way) stays an option for menu-only use (§2a).
- Why higher force: 1.57–2.55 N (B3S-1000 1.57 N max, B3S-1002 2.26 N max, B3F-4055 2.55 N) rather than 0.98 N, so the button doesn't trigger when it brushes the helmet brim or the hand rests on the pod [design].
- Use a 10–20 ms firmware debounce. The B3S datasheet gives bounce ≤ 5 ms [V: C23].
- No sourced glove spacing standard was retrieved (MIL-STD-1472H is listed as MISSING). As a starting point, use caps ≥ 12 mm and centre spacing ≥ 18 mm [design], then **test with your own gloves**.

## 4. Power architecture

### 4.1 Pack options
| Option | Voltage window | Camera (9–24 V) | HDO2 (7–13 V) | Extra parts | Verdict |
|---|---|---|---|---|---|
| **3S Li-ion (1P or 2P)** | 9.0–12.6 V at 3.0–4.2 V/cell [calc] | direct; **the 9 V floor = 3.0 V/cell** | direct | 5 V buck for MCU only | **Recommended** |
| 4S Li-ion | 12.0–16.8 V [calc] | direct | **over 13 V → needs a regulator**: Pololu D36V6F9 (9.2–50 V in, 600 mA, 13 × 10 × 3 mm, 0.5 g) [V: papers/ctrl_pololu_D36V6F9.txt, L77–85] | +1 cell (≤ 50 g [V: C18]) + regulator | Only if you want +33 % energy at 1P |
| Separate packs (HDO2 on its own 2S 18650 case + camera pack) | — | needs ≥ 9 V pack | 2S case "7.4V, 1.8A 18650 Battery Case" [V: C1 p.11] | 2 packs, 2 chargers, 2 warnings | Not recommended |

**3S caveat:** a Li-ion cell rated to 2.5 V cut-off [V: C18 p.2; C19] would take the pack to 7.5 V. The camera is out of its 9–24 V spec below 9.0 V (3.0 V/cell), long before that [calc]; where it actually browns out is unknown (§8 item 11). The tail of the capacity below 3.0 V/cell is unusable. I estimate 90 % usable [A, read the discharge curve or measure]. That is why the warning thresholds below sit at 3.4 / 3.2 V/cell.

**Cell choice:** for about 0.5 A pack current (≈ 0.15 C), use an energy cell, not a power cell [calc].
- Samsung **35E**: 3450 mAh typ, 12.62 Wh at 0.2C, ≤ 50 g, Ø ≤ 18.5 × 65.25 mm, discharge −10…60 °C [V: papers/ctrl_samsung_35E_rapid.pdf, p.2–3].
- Molicel P28A (power cell) only gives 10.3 Wh [V: papers/ctrl_molicel_p28a.pdf, p.1], but its rated discharge range is −40…60 °C versus −10…60 °C for the 35E [V: C18, C19]. Below −10 °C that is a real argument for it, though the camera itself is rated only to −10 °C [V: C5].
- Use a **3S BMS (protection) board** and a balance lead (JST-XH) so the pack charges on your normal FPV balance charger [design].
- Winter: 35E discharge is rated down to −10 °C [V: C18]. Keep the pack inside a printed or insulated shell on the helmet rear, or in a jacket pocket on a longer lead [design].

### 4.2 Regulators
| Part | In | Out | Size / mass | Note |
|---|---|---|---|---|
| **Pololu D36V6F5** (rec.) | 5.2–50 V | 5 V ±4 %, 600 mA | 13 × 10 × 3 mm, 0.5 g | Iq < 0.1 mA; EN < 2 µA; **no reverse-polarity protection** [V: papers/ctrl_pololu_D36V6F5.txt, L74–85] |
| Pololu D24V5F5 | up to 36 V | 5 V, 500 mA | 13 × 10 × 3 mm | 80–93 % eff., 200 µA Iq [V: papers/ctrl_pololu_D24V5F5.txt, L80–85] |
| Pololu D24V10F5 | up to 36 V | 5 V, 1 A | 18 × 13 × 3.5 mm | Pololu warns of LC spikes: >20 V in caused >36 V spikes [V: papers/ctrl_pololu_D24V10F5.txt, L86, L107] |
| Mini560 (5 V) | "5V – 20V" | 5 V | **conflicting**: 29 × 18 × 5.4 mm vs 15 × 12 × 4 mm on the same page | JW5068A; "5A" only in the listing title; retailer-only data, "99%" claim [V: papers/ctrl_mini560_domoticx.txt, L118, L145–159] |

Mini560 works on 3S (max 12.6 V < 20 V) but is sold as a 5 A part (listing title only) with unreliable specs, for a load of about 30 mA. Use the D36V6F5 [design].
Feed the XIAO **5 V pin through a Schottky diode**, as Seeed requires, so plugging in USB-C during debugging does not back-feed the buck [V: C8 L297].
Add a reverse-polarity guard on the pack input, because the Pololu boards have none [V: C14]. Use a P-FET or Schottky, plus a 1 A fuse or polyfuse at the pack [design].

### 4.3 Runtime math [calc on V figures; A where marked]
Loads at the pack:
- HDO2: 0.320 A × 7.5 V = **2.40 W** [V: C1 p.11]. Pessimistic **3.0 W** for 3S fan speed and a bright white-hot image [A].
- Camera system: **1.44 W** (12 V × 0.120 A, drawing, possibly boilerplate copied from the 004 Dual) … **3.0 W** (2 × <1.5 W, store; AI box draw not listed, so not a true ceiling) [V: C4, C5, C6].
- MCU: 27 mA (ESP32-C3, BLE modem-sleep) [V: C8 L186] × 5 V at the 5 V pin [A] = 0.135 W. Through the buck at an assumed 80 % [A] that is **0.17 W**. (Wi-Fi active, 75 mA, would be 0.47 W; keep it off.) Vibration motor: 100 mA @ 5 V only during alarms [V: C25], negligible on average.

| Case | Load | 3S1P 35E (37.9 Wh × 0.9 = 34.1 Wh) | 3S1P, cold ×0.8 [A] | 3S2P 35E (68.2 Wh) | 3S1P P28A (27.8 Wh) | 4S1P 35E + D36V6F9 @ 88 % [A] (45.4 Wh) |
|---|---|---|---|---|---|---|
| Best | 2.40 + 1.44 + 0.17 = **4.01 W** | **8.5 h** | 6.8 h | 17.0 h | 6.9 h | 2.73+1.44+0.17 = 4.34 W → 10.5 h |
| Mid | 2.40 + 3.0 + 0.17 = **5.57 W** | **6.1 h** | 4.9 h | 12.2 h | 5.0 h | 2.73+3.0+0.17 = 5.90 W → 7.7 h |
| Worst (of the figures used) | 3.0 + 3.0 + 0.17 = **6.17 W** | **5.5 h** | 4.4 h | 11.1 h | 4.5 h | 3.41+3.0+0.17 = 6.58 W → 6.9 h |

"Worst" is the worst of the figures used here, not a guaranteed floor: the camera's high case is not a sourced ceiling (AI box draw unlisted), and the 3.0 W HDO2 and 0.9/0.8 factors are assumptions. The "Mid" row was called "Nominal" in the first draft; it combines the HDO2 datasheet figure with the camera's *high* estimate, so it is not a nominal in the datasheet sense.

Pack current at the 35E's nominal 3.60 V/cell (10.8 V for 3S) [V: C18 p.2]: 5.57 / 10.8 ≈ **0.52 A ≈ 0.15 C** on a 3.45 Ah pack [calc]. That is below the 0.2C at which the 12.62 Wh/cell was measured, so (at room temperature) the datasheet energy should be a fair basis; the datasheet does not test below 0.2C [A]. Mass of the 3S1P cells is ≤ 150 g; for 3S2P it is ≤ 300 g [V: C18 ×3/×6].

### 4.4 Voltage monitoring and warning
- **Divider:** 100 kΩ (top) / 22 kΩ (bottom) gives 12.6 V → 2.27 V and 9.0 V → 1.62 V; static draw 12.6 / 122 kΩ ≈ 0.10 mA [calc]. Add 100 nF across the bottom resistor. Use **A0/A1/A2 (ADC1)** on the ESP32-C3 [V: C8 L203]. Seeed's own battery example uses a 1/2 divider (200k) into A0 [V: C8 L355]. Ours scales 1/5.5 because the input is 3S [calc]. Calibrate once against a multimeter. The ESP32-C3 ADC attenuation range was not retrieved, so the 2.3 V ceiling is a conservative choice [A].
- **Thresholds [design]:** WARN at 10.2 V (3.4 V/cell, average over 10 s): 3 short buzzes every 60 s. CRITICAL at 9.6 V (3.2 V/cell): continuous pattern every 10 s, roughly "minutes left". Below 9.0 V the camera is out of spec (3.0 V/cell, §4.1); the real dropout point is to be measured (§8 item 11).
- **Output channels, given full occlusion:**
  1. **Haptic**, primary: a 10 mm coin vibration motor, 10 mm Ø × 2.7 mm, 0.9 g, 100 mA @ 5 V, switched by a small transistor [V: papers/ctrl_adafruit_1201_vibration_motor.txt, L114–122]. Note Adafruit gives the **rated** voltage as 2.5–3.8 V and says only that "it vibrates from 2V up to 5V" [V: same file, L113]; driving it from 5 V is outside the rated range, so either accept that for short alarm pulses or drop it to ~3.3 V with PWM or a series resistor [design]. Put it in the goggle pod against the forehead foam [design].
  2. **Visual**, if the UART works on the TR1: the MCU sends brightness 80 % → 50 % → back, using the documented frame format "FF 5A 00 01 00 00 01 00 00 00 50 EA A2" [V: C6]. That should produce a visible "blink" without switching cameras [design]. Unknown: on the 004 the protocol belongs to the thermal core, so the blink may only show while the thermal view is selected; check on the bench (§8 item 3). (The CRC16-Modbus checksums of this frame and the 50 % and Get-version frames were recomputed with the guide's own routine and match, low byte first [calc].) Do **not** use camera switching as an alarm, because it swaps FOV 50°↔120° while you are walking [design].
  3. The HDO2's own beeper: its 6.8 V threshold [V: C1 p.8] is below the 3S pack's useful range, so on 3S it is effectively useless [calc; C1 p.7].

## 5. Cabling and quick-disconnect
Proposal [design]: the MCU, buttons, buck and vibration motor sit in one printed pod on the goggles. The camera, AI box and pack sit on the helmet. One trunk runs helmet ↔ goggles.

| Conductor | Purpose |
|---|---|
| VBAT (3S) | HDO2 barrel plug + pod buck (+ ADC divider sees pack voltage at goggle end) |
| GND | common ground (power, video, logic) |
| CVBS | AI box video → HDO2 3.5 mm AV jack (Video pole) |
| GPIO2 | MCU → AI box camera select |
| UART-TX | MCU → AI box RX (brightness/palette/NUC), if confirmed |
| (opt.) UART-RX, ADKEY | read-back / OSD menu; makes it 6–7 conductors |

- Trunk breakaway: Adafruit DIY magnetic pogo connector, available in **3/4/5 contacts**, 0.1″ pitch, polarity-keyed by magnet repulsion [V: papers/ctrl_adafruit_5358_magnetic_connector.txt, L105–125]. **The page states no current rating**, so bench-test it at 1 A, and test CVBS through pogo contacts for noise and dropout while you shake your head [A].
- Inside each pod: JST-GH, 1.25 mm pitch, 1.0 A at AWG26, −40…+105 °C, positive lock [V: papers/ctrl_jst_GH.pdf, p.1]. Total pack current is about 0.5 A [calc], so AWG26 is adequate. Run CVBS as a twisted pair with its own GND, or as a thin coax, kept away from UART/PWM [design].
- On the ADC reading at the goggle end: the trunk's IR drop makes it read low. That is conservative for a warning, and you calibrate it out [design].

## 6. Recommended BOM (per helmet)
| # | Item | Qty | Size / mass | Source tag |
|---|---|---|---|---|
| 1 | Seeed XIAO ESP32-C3 (alt. XIAO nRF52840) | 1 | 21 × 17.8 mm | [V: C8/C10] |
| 2 | Pololu D36V6F5 5 V 600 mA buck | 1 | 13 × 10 × 3 mm, 0.5 g | [V: C14] |
| 3 | Schottky diode (buck → XIAO 5 V pin), e.g. SOD-123 | 1 | — | [V: C8 L297] for need; part [design] |
| 4 | Alps EC11E09244BS encoder with push + printed knob ≥ 20 mm Ø | 1 | 11 mm body, 20 mm shaft | [V: C20] |
| 5 | Omron B3S-1000 (IP67, 1.57 N max; or B3S-1002, 2.26 N max) + printed caps ≥ 12 mm | 2 | 6 × 6 × 4.3 mm, 0.3 g | [V: C23] |
| 6 | 10 mm coin vibration motor + NPN/N-FET + flyback diode (rated 2.5–3.8 V, see §4.4) | 1 | 10 Ø × 2.7 mm, 0.9 g | [V: C25] |
| 7 | Divider 100 k / 22 k (0603) + 100 nF | 1 set | — | [calc] |
| 8 | 3S1P pack, Samsung INR18650-35E ×3, 3S BMS, XT30 + JST-XH balance | 1 | cells ≤ 3 × 50 g, Ø18.5 × 65.25 mm each | [V: C18]; BMS/XT30 [design] |
| 9 | Reverse-polarity P-FET or Schottky + 1 A fuse/polyfuse at pack | 1 | — | [design] |
| 10 | Master switch (inline, ≥ 2 A) | 1 | — | [design] |
| 11 | Magnetic pogo connector, 5-contact | 1 pair | 0.1″ pitch | [V: C26] (no current rating) |
| 12 | JST-GH 4–6 pin pigtails, AWG26 | 3–4 | 1.25 mm pitch | [V: C24] |
| 13 | HDO2 barrel plug (size TBD) + 3.5 mm 4-pole AV plug | 1+1 | measure | [V: C1 p.10–11; C3 L103] (size not given) |
| 14 | (opt.) Pololu D36V6F3 3.3 V for the no-MCU Phase 0 | 1 | ≈13 × 10 × 3 mm [A] | [V: C14 L65] |
| 15 | (opt.) Pololu D36V6F9 for a 4S pack → HDO2 | 1 | 13 × 10 × 3 mm, 0.5 g | [V: C15] |
| 16 | (opt.) Caddx OSD menu board (5-way, ADKEY) | 1 | — | [V: C7] (compatibility with TR1 unconfirmed) |

## 7. Wiring block diagram
```
 HELMET (rear)                     HELMET (front)                         GOGGLES (HDO2 + printed pod)
 ┌────────────────────┐            ┌──────────────────────────┐
 │ 3S1P 35E + 3S BMS  │            │ Caddx TR1-220SL AI box   │
 │ 9.0–12.6 V         │            │  Power 9V~24V ◄──VBAT    │
 └──┬─────────────────┘            │  GND ◄──────────GND      │
    │XT30                          │  CVBS ───────────┐       │
 [1A fuse]─[rev-pol FET]─[SW]──VBAT┤  GPIO2 ◄────┐    │       │
    │                              │  RX    ◄──┐ │    │       │
    GND────────────────────────────┤  GND      │ │    │       │
                                   └───────────┼─┼────┼───────┘
                                               │ │    │
          VBAT, GND ───────────────────────────┼─┼────┼──┐
                                               │ │    │  │
                 ═══════ 5-pin magnetic breakaway (VBAT, GND, CVBS, GPIO2, TX) ═══════
                                               │ │    │  │
                                               │ │    │  ├──► HDO2 power port (7–13 V, barrel)
                                               │ │    └──┼──► HDO2 3.5 mm AV jack (Video + Ground)
                                               │ │       │
                                   ┌───────────┼─┼───────┼───────────────────────────┐
                                   │ POD       │ │       ├─► D36V6F5 ─►|─ 5V  XIAO    │
                                   │           │ └─ GPIO out (camera select)  ESP32-C3│
                                   │           └─── TX (UART1, 3.3 V, 115200)        │
                                   │  VBAT─100k─┬─22k─GND ; mid ──► A0 (ADC1)        │
                                   │  EC11E (A,B,SW) ──► 3 GPIO (internal pull-ups)  │
                                   │  B3S #1, #2 ──► 2 GPIO                          │
                                   │  GPIO ─► FET ─► 10 mm vibration motor (5 V)     │
                                   └─────────────────────────────────────────────────┘
```
GPIO budget on the ESP32-C3 (11 GPIO, 4 ADC [V: C8 L200]): encoder 3 + buttons 2 + GPIO2 out 1 + TX 1 + ADC 1 + motor 1 = **9** [calc]. That leaves 2 spare, e.g. RX for read-back.

## 8. Open questions / bench measurements for Adam
1. **GPIO2 behaviour:** open-circuit voltage (pull-up/pull-down/floating?). Then check whether it is level-controlled (high = thermal, as the Eclipse 004 "yellow area shows the thermal" figure suggests [V: C6], given that a non-inverted Betaflight PINIO idles low and goes high when its mode is active [V: C27]) or edge-toggled. Scope the line while toggling with a 3.3 V source through 1 kΩ.
2. **GPIO0/GPIO1:** any effect (palette? zoom?) when driven high/low? This is not documented.
3. **UART:** does the TR1 answer "Get version" `FF 5A 00 00 00 00 00 00 00 00 C7 57` at 115200 baud [V: C6] (8N1 framing is my assumption; the guide does not state it [A])? If yes, the encoder can drive brightness, palette and NUC.
4. **OSD port:** is it ADKEY like the 005SL? Measure its idle voltage and the resistance ladder of a Caddx OSD board, if you get one.
5. **Camera current** at 9.0 / 11.1 / 12.6 V, for thermal and Infra each selected. Is it 1.44 W or up to 3 W?
6. **HDO2 current at 3S** (11.1 V and 12.6 V), fan low vs high, OLED power 50/75, black vs white-hot full-screen image.
7. **HDO2 barrel size** and polarity; AV jack pole order (meter: which ring is Video).
8. **Usable capacity** of your 3S pack to 9.0 V at about 0.5 A, at room temperature and at 0 °C (a fridge test). This replaces the 0.9 × and 0.8 × assumptions.
9. **Magnetic pogo connector:** contact resistance at 1 A; CVBS image stability while you shake your head; pull-off force versus goggle strap tension.
10. **Gloves:** your actual winter gloves on printed cap prototypes: minimum cap size and spacing; can you find button A blind in under 1 s?
11. Whether the camera browns out (9 V min) under a cold pack. Does the AI box survive a dip, or reboot (and how long does the reboot take)?

## Retrieved (in `papers/`, read at source)
- `FatShark_HDO2_Manual_RevC.pdf` (+.txt). Downloaded by another track; read by me, 12 pp.
- `ctrl_hdo2_fpv24.html/.txt`, `ctrl_hdo2_oscarliang.html/.txt`
- `bzbuas_tr1-220sl_product_page_en.txt`, `bzbuas_tr1-220sl_wiring_diagram.png`, `bzbuas_eclipse005sl_adkey_osd_menu_board.png`. Downloaded by track 03; read and viewed by me.
- `ctrl_caddx_eclipse004dual_ft483dual.pdf/.txt`
- `bzbuas_eclipse005sl_product_page.txt` (track 03), `betaflight_drivers_pinio.c.txt`, `betaflight_pg_pinio.c.txt` (track 03 copies of Betaflight source; read by the verifier, cited as C27/C28)
- `ctrl_xiao_esp32c3_wiki.*`, `ctrl_xiao_esp32s3_wiki.*`, `ctrl_xiao_nrf52840_wiki.*`, `ctrl_xiao_rp2040_wiki.*`, `ctrl_xiao_samd21_wiki.*`
- `ctrl_waveshare_rp2040zero_wiki.*`, `ctrl_waveshare_rp2040zero_product.*` (no numeric dimensions in text)
- `ctrl_pololu_D36V6F5.*`, `ctrl_pololu_D36V6F9.*`, `ctrl_pololu_D24V5F5.*`, `ctrl_pololu_D24V10F5.*`
- `ctrl_mini560_domoticx.*` (retailer only)
- `ctrl_samsung_35E_rapid.pdf/.txt`, `ctrl_molicel_p28a.pdf/.txt`
- `ctrl_alps_EC11.*`, `ctrl_alps_SKQU.*`, `ctrl_omron_B3F.pdf/.txt`, `ctrl_omron_B3S.pdf/.txt`
- `ctrl_jst_GH.pdf/.txt`, `ctrl_adafruit_1201_vibration_motor.*`, `ctrl_adafruit_5358_magnetic_connector.*`

## MISSING (not retrieved, no claim made)
- **Fat Shark HDO2 barrel connector size and polarity.** Not in the manual. Measure.
- **ESP32-C3 datasheet (Espressif)**, for ADC attenuation range and accuracy. https://www.espressif.com/sites/default/files/documentation/esp32-c3_datasheet_en.pdf (not attempted in this pass; needed before finalising the divider).
- **Microchip ATtiny212/412 datasheet** DS40001911. https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny212-412-DS40001911B.pdf returned an HTML page. (The file `papers/ctrl_attiny412_ds.pdf` is that 400-byte HTML response, not a datasheet; ignore it.)
- **Waveshare RP2040-Zero dimension drawing.** Image only on https://www.waveshare.com/wiki/RP2040-Zero.
- **Mini560 / JW5068A manufacturer datasheet** (Joulwatt). Only retailer data found; https://aws.robu.in/wp-content/uploads/2023/07/DE077-DE080.pdf did not download.
- **C&K KSC6 IP67 tactile datasheet.** https://www.ckswitches.com/media/1972/ksc6.pdf returned HTML.
- **Alps SKRH (SMD multi-direction) page.** https://tech.alpsalpine.com/e/products/category/multi-control-devices/sub/01/series/skrh/ returned "AccessDenied".
- **MIL-STD-1472H** (human engineering: pushbutton size and spacing for gloved hands). everyspec download URL 404; get it from https://quicksearch.dla.mil (ASSIST).
- **DTIC ADA256894, "Gloved Operator Performance Study"** (button spacing with gloves). https://apps.dtic.mil/sti/pdfs/ADA256894.pdf returned HTML (blocked).
- **Li-ion low-temperature capacity data** for the 35E (only the rated −10…60 °C range was found). The 0.8 × cold factor above is an assumption.
- **IntoFPV thread on the HDO2 6.8 V alarm** (https://intofpv.com/printthread.php?tid=24767). Search snippet only; not used. Not needed either: the 6.8 V threshold is in the manual itself (p.8, C1).

## Verification (adversarial pass, 2026-11-03)

Method: every [V] citation was re-checked against the file in `papers/` (`pdftotext -layout -f N -l N` for PDFs, `sed -n` on the stated line of the `.txt` copies, `grep` on the `.html` for table status flags, and visual reading of the three PNG drawings). Every [calc] was recomputed (Python, CRCs with the guide's own CRC16-Modbus routine). Claims were also checked for scope (sister product vs TR1, typical vs max, rated vs "works").

**Confirmed as quoted and correctly scoped (no change):** HDO2 7–13 V, 320/770 mA @ 7.5 V, Legacy Mode power-on, fan/3S and alarm warnings (p.7), OLED power ≤ 75 (p.8), AV pin-out (p.10), weight/dimensions (p.11); TR1 9–24 V and per-camera <1.5 W (L82–83, L111–112, L128–129); wiring-diagram labels and "12V@120mAh"; 005SL ADKEY drawing and its "Remove the OSD menu board" note; 004 Dual PINIO switching, 3.3 V levels, 115200 baud and the command table; all XIAO size/ADC/diode/sleep figures cited; RP2040-Zero VSYS/VUSB note; Pololu D36V6F5/F9/D24V5F5/D24V10F5 figures and line numbers; Mini560 size conflict; 35E p.2/p.3/p.6 figures; P28A p.1 figures; EC11E09244BS row (and its supply status "Standard" in the HTML); B3S IP67/−25…+70 °C/5 ms/0.3 g; B3F p.1–3; JST-GH ratings; Adafruit 1201 and 5358 data. Arithmetic: 2.40 W, 5.78 W, 37.86 Wh, 34.1/27.3/68.2/27.8/45.4 Wh, divider 2.27 V / 1.62 V / 0.10 mA / 1:5.55, thresholds 10.2/9.6 V, GPIO budget 9 of 11, cell masses ≤150/≤300 g. The three example UART frames (brightness 80 %, 50 %, Get version) carry CRCs that match the published routine.

**Changed:**
1. Section references: the bench list is §8, not §7 (four places).
2. HDO2 alarm: the manual's p.8 gives the threshold (6.8 V). Added it with the consequence (2.27 V/cell on 3S, below cell cut-off and camera floor). The MISSING entry for the IntoFPV thread now says the figure is in the manual.
3. HDO2 barrel connector: the p.10 "Barrel connector cable" quote is about the 18650 case's cable, not the goggle port. Re-sourced to "Power input port" (p.11) plus Oscar Liang L103.
4. FPV24 retailer citation: lines are L187–189, not L254–256.
5. "Rapidfire module": the manual is truncated at "(Rapid"; now flagged as an interpretation.
6. Camera power: "12V@120mAh" appears identically in the 004 Dual guide, so it may be boilerplate. The 3.0 W case is not an upper bound (AI box draw unlisted). Both now stated; "bounds" softened to low and high case.
7. Added TR1 working temperature −10…50 °C (product page L84–85), which caps the cold-weather use regardless of the pack.
8. 3.3 V logic: sourced only for the 004 Dual and stated as 3.3 V MCU voltage only in the RP2040 and SAMD21 wikis. The report had presented it as a TR1 fact and as true "for every XIAO"; now conditional, with a 1 kΩ series resistor recommended until measured. Same correction in TL;DR item 2.
9. GPIO2 push-pull: C6 does not say push-pull. Re-sourced to the Betaflight PINIO source (new C27); the "no internal pull" consequence is labelled as an inference.
10. OSD board: on the 004 it only edits a text string (C6). On the 005SL the ADKEY menu configures display parameters (new C28). The no-MCU option and TL;DR now say what it controls on the TR1 is unknown.
11. ESP32-C3: the wiki gives both "1x UART" (spec table, L163) and "2xUART" (features, L200). "Has 2 UARTs" is softened.
12. MCU power: the wiki gives no supply voltage for its C3 current figures, so the draft's "× 3.8 V" was unsupported. The draft also called 27 mA "the worst awake figure", but Wi-Fi active is 75 mA (L182). Recomputed at 5 V [A]: 0.17 W at the pack. Wi-Fi must stay off.
13. Runtime table recomputed with 0.17 W MCU load: 8.5 / 6.1 / 5.5 h (3S1P); cold 6.8 / 4.9 / 4.4 h; 3S2P 17.0 / 12.2 / 11.1 h; P28A 6.9 / 5.0 / 4.5 h; 4S 10.5 / 7.7 / 6.9 h. Changes ≤ 0.1 h. "Nominal" row renamed "Mid", and "Worst" qualified.
14. Pack current: the 35E's nominal voltage is 3.60 V/cell (10.8 V for 3S), not 11.1 V. Recomputed: 0.52 A ≈ 0.15 C.
15. "The camera loses power at 9.0 V" is a spec minimum, not a measured dropout. Reworded in three places.
16. Alps SKQU: SKQUAAA010 is 4-direction only and SKQUCAA010 is centre-push only. They are not a combined "4-dir + centre" part; both are NRND (HTML `data-supply-status="deprecated"`). The "tiny throw" argument was inconsistent, because the recommended B3S has 0.25 mm pretravel (B3S p.1) and the B3F 12×12 has 0.3 mm (p.3). The rationale is now NRND status only.
17. B3S force is "1.57 N max" (operating force is a max). Added the 2.26 N B3S-1002 variant. B3F weight (≈0.85 g) applies to the 12×12 *standard* types, not explicitly to the projected B3F-4055.
18. Vibration motor: Adafruit rates it at 2.5–3.8 V. "2–5 V" is only where "it vibrates" (L113). Added the caveat for 5 V drive.
19. Mini560 "5 A" comes only from the listing title (L118); now cited.
20. Cold: added that the P28A is rated to discharge down to −40 °C, against −10 °C for the 35E.
21. UART framing "8N1" is not in the guide; marked [A].
22. Noted that `papers/ctrl_attiny412_ds.pdf` is a 400-byte HTML error page, not a datasheet.
23. Visual (brightness) alarm: added the caveat that on the 004 the protocol belongs to the thermal core, so the blink may not show in Infra view.

**Still unverified (unchanged, correctly tagged in the text):** every [A] (90 % usable capacity, 0.8× cold factor, 80 %/88 % regulator efficiencies, 3.0 W HDO2 on 3S, D36V6F3 size, ESP32-C3 ADC range and I/O voltage, 5 V basis for the C3 current); every [design] item; and the transfer of 004 Dual / 005SL behaviour to the TR1-220SL, which track 03 and the §8 bench checks must settle. **This report remains a working draft until then.**
