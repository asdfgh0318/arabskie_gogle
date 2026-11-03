# 03 — Caddx TR1-220SL Dual: control & electrical interface

Track 03 · 2026-11-03 · **working draft**. `ZALOZENIA.md` governs project objectives. Where this file
disagrees with `papers/extracts_camera.md`, the extracts (verbatim source text) govern.
The main open item: there is **no Caddx document for the TR1-220SL itself**. Every protocol claim comes
from the **Eclipse 004 Dual** Quick Start Guide. Its AI-box wiring drawing is label-for-label identical
to the TR1-220SL drawing BZB UAS publishes. **Caveat (verifier):** the two drawings are the same
artwork (same line work, wire colours, note box), so the match is equally consistent with the reseller
having reused Caddx's 004 Dual drawing for the TR1 page. It shows the drawing is shared, not that the
hardware is. Until Adam's bench tests (section 4) are done, treat the protocol as "plausible, not
confirmed".

## TL;DR (for this project)

1. **Switch cameras with one MCU pin.** Drive **GPIO2** on the 6-pin port with a 3.3 V push-pull output
   and share GND. The level selects the camera: HIGH is probably thermal and LOW Infra (B/W) (**medium**
   confidence), per the Betaflight PINIO recipe in the sister product's manual. Use a 1 kΩ series
   resistor (engineering choice). No PWM, no pulses. Caveat: the kit's GPIO cable is white + black, and
   in the drawing's colour code white = RX, not GPIO2 (green). Check which positions it uses (B1b).
2. **There is probably a 3.3 V UART at 115200** on the same 6-pin port (TX/RX), if the TR1 really uses
   the 004 Dual box. On the 004 Dual it uses a framed binary protocol (`FF 5A …`, CRC16/MODBUS) for
   **palette (pseudo-color), brightness, contrast, manual NUC/shutter, auto-shutter on/off and
   hot-tracking**. Bench step 1: send the 12-byte "get version" frame and look for a reply. It is a
   read-only query in the 004 Dual protocol, so it is low-risk, but on unknown firmware it is not risk-free.
3. **Not in any documented interface:** zoom, PiP/fusion, camera switch over UART. Zoom is documented
   only over **USB-UVC on the 005SL**. Don't design buttons for zoom.
4. **Recommended goggle buttons (3):** `CAM` (GPIO2 toggle) · `PAL` (cycle palette over UART; long
   press = manual NUC) · `BRT` (brightness/contrast step; long press = toggle hot tracking or reset).
   One XIAO (ESP32-C3/S3) covers it with 1 GPIO + 1 UART + 3 inputs.
5. **Power and connectors:** 12 V @ 120 mA (≈1.44 W) per the diagram, 9–24 V input. **4S Li-ion
   (10.0–16.8 V) works with no step-down. 3S Li-ion does not over its full discharge**: 3 × 2.5 V cutoff
   = 7.5 V, which is below the 9 V minimum. It only works with a ≥3.0 V/cell cutoff (= 9.0 V, zero
   margin). The **2-pin "OSD" port is probably ADKEY**, inferred from the 005SL's label at that position.
   "Resistor-ladder" is the usual meaning of ADKEY but no retrieved source says so. No menu board ships
   with the TR1 kit. Connector pitches are unknown; the only sourced figure is a "2pin 1.25mm" cable in
   the 005SL kit. **Photograph and caliper all four sockets before ordering pigtails.**

---

## 1. What the TR1-220SL is (identification)

- BZB UAS shows the TR1-220SL **AI box** with four connectors [V: papers/bzbuas_tr1-220sl_wiring_diagram.png, labels]:
  - a 3-pin port: `CVBS / GND / Power 9V~24V`, plus spare pads `Power 9V~24V / GND`
  - a 6-pin port: `GPIO2 (Connect TX of FC) / GPIO1 / GPIO0 / GND (Connect GND of FC) / RX / TX`
  - a 2-pin port labelled `OSD`
  - a 4-pin port: `DP / DN / GND / VBUS`
- The **Eclipse 004 Dual Quick Start Guide V1.0** has the same drawing, with the same labels and the same
  "Power Consumption: 12V@120mAh" note [V: papers/ctrl_caddx_eclipse004dual_ft483dual.pdf, "Connection"].
  Its spec block also matches the TR1 shop text on three items: "Supply Voltage 9V~24V", "Average
  Latency 20ms", "Allmage Enhancement" [V: same, "Specifications"; cf. papers/bzbuas_tr1-220sl_product_page_pl.txt
  "20 ms", "Al lmage Enhancement"]. It does **not** match on operating temperature: the 004 lists
  "Temperature -20°C~60°C", the TR1 page "-10°C ~ 50°C" [V: both files]. The match is partial.
  - **Inference (not stated by any source):** the TR1-220SL uses the same AI-box board and firmware family
    as the Eclipse 004 Dual. The difference is the camera heads: 256×192 thermal + Infra B/W, against
    480×360 thermal + Ratel Ultra AI visible. The camera-switch and UART descriptions below therefore
    probably carry over, and the palette list and firmware may differ.
- The 004 Dual guide says the cable switches "the display of the visible light camera and the
  black&white camera". Two paragraphs later it names the pair "the visible light camera" and "the thermal
  imaging camera" [V: ctrl_caddx_eclipse004dual_ft483dual.pdf, "Switch Control"]. "black&white camera"
  is therefore most plausibly the (greyscale) thermal image, not a second name for the visible camera.
  Either way the guide is loosely worded. On the TR1 the non-thermal slot holds the Infra B/W camera
  (inference).
- The guide refers to "the control line (Introduction 4)", but the retrieved PDF has **no Introduction
  section**. It starts at "Connection". The copy may be incomplete, so a full Caddx original could
  contain more (e.g. a cable description).
- The **Eclipse 005SL** has a different interface (no UART/GPIO port is labelled in its retrieved drawings). It takes 4.5–20 V, outputs PAL and UVC
  together, and is adjusted by "UVC/ ADKEY" [V: papers/bzbuas_eclipse005sl_product_page.txt]. Its AI-box
  side view labels the 2-pin port **"ADKEY / GND"** [V: papers/bzbuas_eclipse005sl_adkey_osd_menu_board.png].
  The TR1 drawing labels the port in the corresponding position, the 2-pin next to the 4-pin USB, "OSD"
  [V: bzbuas_tr1-220sl_wiring_diagram.png]. The 005SL labels USB D− as "DM" where the TR1 has "DN".

## 2. Interfaces, function by function

### 2.1 Camera switch: GPIO2 (the supplied "GPIO cable")
| Item | Finding | Tier / confidence |
|---|---|---|
| Purpose | The included cable switches cameras: "You can easily switch between the cameras via the included GPIO cable" | [V: bzbuas_tr1-220sl_product_page_en.txt l.48] |
| Pin | GPIO2, "(Connect TX of FC)"; the ground reference is the GND pin, "(Connect GND of FC)" | [V: wiring diagram; 004 Dual guide] |
| Logic level | "GPIO2 General Purpose IO, 3.3V level" | [V: 004 Dual guide, Serial Communication table] (applies to 004 Dual; TR1 **medium-high**, because the shared drawing may be reused artwork, see top) |
| Signal type | **Static level, not PWM and not UART.** The 004 Dual recipe frees the FC's TX pad from UART duty and remaps it as a Betaflight PINIO: "resource SERIAL TX 1 NONE", "resource PINIO 1 A09", "set pinio_box=40,…" | [V: 004 Dual guide, Switch Control] |
| PINIO electrical behaviour | Betaflight PINIO defaults to push-pull output (`PINIO_CONFIG_MODE_OUT_PP`). With no inversion it starts **LOW** (`IOLo`) and drives HIGH while the mode is active (`newState = on ^ inverted`) | [V: papers/betaflight_drivers_pinio.c.txt, betaflight_pg_pinio.c.txt, betaflight_io_piniobox.c.txt] |
| Polarity | The guide says "The cursor in the white area shows the visible light camera, and the cursor in the yellow area shows the thermal imaging camera". In the figure the yellow band spans 900–1300 on the USER1 row and the cursor sits at ≈1500 in the white part. In Betaflight Configurator the coloured band is the range where the mode is active. That is a UI convention, not stated in any retrieved source. Active = HIGH, so **HIGH → thermal, LOW → visible**. | Derived from [V] 004 Dual figure + Betaflight source + unsourced Configurator convention. **Medium** for TR1. Confirm on the bench (B3). |
| Pull-up/down inside the box, idle state, edge vs level | Not documented | **Unknown**, measure (B2, B3) |
| Kit cable | One multi-position housing (≈5–6 positions visible) with **two wires only, white + black**, bare ends | [V: bzbuas_tr1-220sl_kit_contents.png, visual]. Which two positions are populated is not resolvable at the photo's resolution. In the drawing's colour code black = GND and **white = RX** (GPIO2 is green). Do not assume white = GPIO2. Bench B1b. |

**MCU signal:** a GPIO in push-pull output mode at 3.3 V into GPIO2 through about 1 kΩ (current limit if the
box is unpowered), with MCU GND tied to AI-box GND. Toggle the level on each button press and keep it
there. Never apply 5 V: the only rating given is 3.3 V level [V: 004 Dual guide], and 5 V tolerance is
not stated anywhere. The XIAO ESP32-C3/S3 runs from its onboard 3V3 regulator ("3V3 - This is the
regulated output from the onboard regulator" [V: papers/ctrl_xiao_esp32c3_wiki.txt l.298]). The
retrieved wikis do not state the GPIO output level as such. 3.3 V logic is expected, so the connection
should be direct; confirm with a meter.

### 2.2 UART: TX/RX on the 6-pin port
| Item | Finding | Tier / confidence |
|---|---|---|
| Electrical | "TX Master transmit, 3.3V level, baud rate default 115200bps"; "RX Master receive, 3.3V level, baud rate default 115200bps" | [V: 004 Dual guide]. TR1 **medium-high**. Frame format (8N1?) **not stated**. Assume 8N1 and verify. |
| Direction naming | "Master" is ambiguous. The diagram's FC hints apply only to GPIO2/GND. **Assumption:** box TX goes to MCU RX and box RX to MCU TX. If they are swapped, two outputs may fight (TX against TX). That is usually survivable at 3.3 V but not guaranteed (unsourced). Put ≈1 kΩ in series with the MCU/adapter TX during bench tests. | Not stated, bench B4 |
| Frame | `0xFF 0x5A | version(1) | cmd(2) | sub_cmd(1) | payload_len(4) | payload | crc16(2)`, 10-byte header, "version … initial version 0" | [V: 004 Dual guide §1] |
| Byte order / CRC | CRC16/MODBUS (init 0xFFFF, poly 0xA001 reflected) over header + payload. Multi-byte fields are **little-endian** and the CRC is sent **low byte first**. | Source gives the C code [V: §1.2]. **Derived by this track:** (a) the field byte order is read from the printed frames. cmd 1 appears as `01 00` and payload_len 1 as `01 00 00 00`, so both are LE. (b) The CRC is computed over all bytes from `FF` through the payload and sent low byte first. Recomputing it over all **10** example frames in §3 of the guide matches the printed values in every case. The researcher wrote "9"; the verifier re-ran it independently. |

Commands documented for the Eclipse 004 Dual [V: 004 Dual guide §2–3]:

| Function | cmd | sub | payload | Example frame (from the guide unless marked) |
|---|---|---|---|---|
| Get firmware version (reply = version string) | 0 | 0 | — | `FF 5A 00 00 00 00 00 00 00 00 C7 57` |
| Brightness 0–100 (no payload = query) | 1 | 0 | 1 B | 80 %: `FF 5A 00 01 00 00 01 00 00 00 50 EA A2` |
| Contrast 0–100 (no payload = query) | 1 | 1 | 1 B | 80 %: `FF 5A 00 01 00 01 01 00 00 00 50 EB 73` |
| Pseudo-color N ("0 is off pseudo-color") | 2 | 0 | 1 B | 5: `FF 5A 00 02 00 00 01 00 00 00 05 6A 88`; 0: `… 00 AA 8B` |
| Manual shutter calibration (NUC) | 3 | 0 | — | `FF 5A 00 03 00 00 00 00 00 00 F4 57` |
| Disable auto shutter | 3 | 1 | — | `FF 5A 00 03 00 01 00 00 00 00 C9 97` |
| Enable auto shutter | 3 | 2 | — | `FF 5A 00 03 00 02 00 00 00 00 8D 97` |
| Hot tracking off / on | 4 | 0 / 1 | ? | *No example in the guide.* Computed by this track: off `FF 5A 00 04 00 00 00 00 00 00 82 97`, on `FF 5A 00 04 00 01 00 00 00 00 BF 57` (len 0). Alternative with 1-byte payload: off `FF 5A 00 04 00 00 01 00 00 00 00 2A A1`, on `FF 5A 00 04 00 01 01 00 00 00 01 EA B0`. **Unverified** against a device. The CRCs are arithmetically correct (verifier re-check). The payload values 00/01 are a guess. |

Caveats:
- The command table lists payload_len "1" for shutter and hot-tracking, but the shutter example frames
  use payload_len 0 [V: §2.4 vs §3]. Try len 0 first because it matches the printed examples, then len 1.
- **Number of palettes on the TR1: unknown.** The 004 Dual example uses index 5. The 005SL lists
  "Color Palette 0-4 (optional)" [V: bzbuas_eclipse005sl_product_page.txt]. On the 004, 0 = "off
  pseudo-color", i.e. presumably plain grey/white-hot. Which index is black-hot is **not documented**.
  Sweep 0…N on the bench and record the result (B6).
- The TR1 shop page says the thermal image is "white hot" [V: bzbuas_tr1-220sl_product_page_en.txt l.48],
  which is consistent with palette 0 = greyscale. This is an inference only.
- **Absent from the 004 Dual protocol:** zoom, image flip, camera select, PiP/fusion, OSD on/off,
  save-to-flash. Whether settings sent over UART survive a power cycle is **not documented**, so the
  MCU should re-send its state after boot (B7).
- Nothing says whether these commands go to the thermal core, the AI box, or both, or what they do to
  the Infra image.

**MCU signal:** UART1 on the ESP32 at 115200 8N1 and 3.3 V, TX→box RX, RX←box TX, common GND. No level
shifter. Wait until there is video after power-up before sending (no boot time is documented), and
re-send the stored palette, brightness and contrast.

### 2.3 GPIO0 / GPIO1
Documented only as "General Purpose IO, 3.3V level" [V: 004 Dual guide]. No function is given.
**No claim.** Leave them unconnected. Probing them for hidden functions such as PiP is possible, but
there is no evidence any exists.

### 2.4 "OSD" 2-pin port: probably ADKEY (inferred from the 005SL label)
- On the 005SL the same-position port is labelled "ADKEY / GND". Its menu board is a 5-way
  (UP/DOWN/LEFT/RIGHT + centre) and connects with a green/black 2-wire lead. Instructions: "Short press
  the middle button on the menu board to enter OSD settings. Remove the OSD menu board after completing
  the settings" [V: bzbuas_eclipse005sl_adkey_osd_menu_board.png]. The 005SL kit ships "1x OSD Menu
  Board" and "1x 2pin 1.25mm 10cm Silicone Cable" [V: bzbuas_eclipse005sl_product_page.txt]. That
  this 2-pin cable is the menu-board/ADKEY lead is an inference, since the page doesn't say what it is for.
- On the **004 Dual** the only documented use of the same port and board is to "customize the OSD
  string of the video display", i.e. an on-screen text label [V: 004 Dual guide, OSD Functions]. Nothing
  documents the menu board reaching palette or contrast on that box. Those settings are documented only
  in the UART protocol. (Absence of documentation, not a stated limitation.)
- The TR1 kit has **no menu board**: the package lists the 3-pin cable, GPIO cable and screws only
  [V: bzbuas_tr1-220sl_product_page_pl.txt; kit photo].
- The Caddx resistor-ladder values and voltage thresholds are **not documented anywhere retrieved**.
- **Betaflight "camera control" compatibility: unverified.** By default Betaflight emulates a 5-key
  ladder assuming a 47 kΩ internal pull-up and 3.3 V. Key resistors are ENTER 45 k, LEFT 27 k, UP 15 k,
  RIGHT 6.8 k, DOWN 0 Ω, with key voltage = Vref·Rb/(Rint+Rb) [V: betaflight_drivers_camera_control.c.txt,
  betaflight_stm32_camera_control.c.txt]. That gives ≈1.61 / 1.20 / 0.80 / 0.42 / 0 V (computed;
  verifier re-check: 3.3·45/92 = 1.614, 3.3·27/74 = 1.204, 3.3·15/62 = 0.798, 3.3·6.8/53.8 = 0.417).
  The source calls the 47 k value "internalResistance". Reading it as a pull-up to Vref follows from the
  divider formula, and the source does not say it. Nothing links these defaults to Caddx ADKEY. (The
  earlier "RunCam-style" label had no retrieved source and has been removed.) The values live in a
  Betaflight parameter group (`cameraControlConfig`). The CLI names used to change them were not
  retrieved. For a stand-alone MCU the same divider method applies: a PWM pin into an RC filter, or
  switched resistors to GND.
- **For this project:** ADKEY is worth using only if B5 shows the TR1's ADKEY menu offers something the
  UART lacks. Otherwise it's a fallback if the UART turns out dead on TR1 firmware.

### 2.5 USB 4-pin (DP/DN/GND/VBUS)
The TR1/004 Dual drawings only label the pins. Their function is **not stated**. On the 005SL, USB is UVC
video ("PAL + UVC (simultaneous analog and digital output)") and digital zoom is "controllable via UVC"
[V: bzbuas_eclipse005sl_product_page.txt]. **No claim for the TR1.** It could be UVC, firmware update,
or both (B8). This matters only if UVC turns out to carry zoom and the project decides to want zoom.
Whether a small MCU can act as the UVC host was not assessed by this track (no source).

### 2.6 Power
- "Power Consumption: 12V@120mAh" (the unit should read mA) [V: wiring diagram; 004 Dual guide]. That
  is ≈1.44 W (12 × 0.120) for the system. That note sits on the drawing shared with the 004 Dual, so it
  may describe the 004 Dual. The shop lists "<1,5 W" per camera head [V: bzbuas_tr1-220sl_product_page_pl.txt]
  and gives no AI-box figure. Budget **≥3 W** (two heads at their upper bound) until measured (B9). This
  is not a hard ceiling, because the AI box's own draw is unknown.
- Input "9-24 V" [V: shop spec; 004 Dual "9V~24V"]. Li-ion cell limits from the Molicel P28A datasheet:
  "Charge 4.2 V", "Discharge 2.5 V" [V: papers/ctrl_molicel_p28a.txt l.32–34]. So **4S Li-ion =
  10.0–16.8 V**, entirely inside 9–24 V. **3S Li-ion = 7.5–12.6 V**: it falls below 9 V for the last part
  of the discharge. 3S needs a ≥3.0 V/cell low-voltage cutoff (= 9.0 V, no margin) or a boost/buck-boost.
  `ZALOZENIA.md` lists "3S/4S Li-ion" as an option, and this rules plain 3S out for direct feed. Battery
  selection belongs to another track.
- The MCU should get its own 5 V/3.3 V buck from the pack. Join grounds at the AI box. Don't power the
  MCU from the camera's VBUS pin: its direction is unknown.

## 3. Controllable functions and MCU signals (summary)

| # | Function | Interface | Exact MCU signal | Confidence for TR1 |
|---|---|---|---|---|
| 1 | Thermal ↔ Infra switch | GPIO2 | 3.3 V push-pull static level, HIGH = thermal (expected), LOW = Infra | **High** that it works; **medium** on polarity |
| 2 | Palette / pseudo-color | UART | `cmd 2 sub 0 len 1 [idx]` | **Medium** (sister-product protocol) |
| 3 | Manual NUC / shutter | UART | `FF 5A 00 03 00 00 00 00 00 00 F4 57` | **Medium** |
| 4 | Auto-shutter on/off | UART | `… 03 00 02 …8D 97` / `… 03 00 01 …C9 97` | **Medium** |
| 5 | Brightness, contrast 0–100 | UART | `cmd 1 sub 0/1 len 1 [0–100]` | **Medium** |
| 6 | Hot tracking on/off | UART | `cmd 4 sub 1/0` (frame computed, len uncertain) | **Low–medium** |
| 7 | Firmware version | UART | `FF 5A 00 00 00 00 00 00 00 00 C7 57` | Medium. **First bench test.** |
| 8 | OSD menu (unknown items on TR1) | "OSD" 2-pin (probably ADKEY) | presumed analog ladder; values unknown | **Low** until B5 |
| 9 | Zoom | none documented (UVC on 005SL only) | — | **Not available** as far as known |
| 10 | PiP / fusion | none documented | — | **No evidence** |

Suggested button map (ergonomics belong to the controller track; this map only shows that 3 buttons cover
everything that is known to work): `CAM` short = toggle GPIO2. `PAL` short = next palette, long (>1 s) =
manual NUC. `BRT` short = brightness/contrast step, long = toggle hot tracking. The MCU stores state in
NVS and re-sends it after boot.

When walking, **keep auto-shutter enabled**. Manual NUC on a button helps when the image smears after a
fast temperature change. That is an engineering judgement, not sourced.

## 4. Open questions / bench measurements for Adam

Do these in order. Use a bench PSU at 12 V with a current limit of about 300 mA. Tools: multimeter, a
USB-UART adapter (3.3 V!) or a XIAO, and calipers.

- **B0 Photos:** close-ups of all four AI-box sockets and of both ends of the supplied GPIO cable and the
  3-pin cable, plus the label and any version sticker. Note the wire colour at each housing position.
- **B1 Connector pitch:** caliper the pin pitch of each socket. 1.0 mm = JST SH, 1.25 mm = JST GH or Molex
  PicoBlade (tell them apart by the latch), 1.5 mm = ZH. Count pins. Of these, only JST GH's pitch is
  sourced here ("The GH series is a 1.25 mm pitch" [V: papers/ctrl_jst_GH.txt l.21]); the SH/PicoBlade/ZH
  pitches are catalogue values from memory and not retrieved. The only sourced Caddx figure is a "2pin
  1.25mm" cable in the 005SL kit (purpose not stated).
- **B1b GPIO cable:** identify which two of the 6 positions the white and black wires occupy. Expected:
  GPIO2 and GND. **Alternative to rule out:** by the drawing's colour code white = RX and black = GND,
  which would mean the TR1 "GPIO cable" actually lands on RX. Beep the housing positions against the
  socket pin order before assuming.
- **B2 Idle voltages** (box powered, nothing connected, measured to GND): GPIO0, GPIO1, GPIO2, TX, RX, OSD,
  VBUS. TX idle ≈3.3 V would confirm a UART. A GPIO2 reading near 3.3 V means an internal pull-up.
  0 V means a pull-down or floating, so check it again through 100 kΩ to 3.3 V.
- **B3 Switch polarity:** tie GPIO2 to GND through 1 kΩ, then to 3.3 V through 1 kΩ, and note which image
  appears each time. Check whether the switch happens on the level or on an edge, i.e. does holding it
  keep it there. Also check the switch latency and whether the image glitches or loses sync. The HDO2
  may blank on a sync loss (unsourced possibility).
- **B4 UART alive?** Connect 115200 8N1, box TX → adapter RX, box RX → adapter TX, common GND. Listen at
  boot first, since the box may print a banner. Then send `FF 5A 00 00 00 00 00 00 00 00 C7 57` and
  expect a frame starting `FF 5A` with a version string. Put ≈1 kΩ in series with the adapter TX. If
  nothing comes back, swap TX/RX, then try 9600/57600/230400.
- **B5 ADKEY:** measure the OSD-pin open voltage and its resistance to GND with the box unpowered. Only if
  B2 shows it idling pulled up (consistent with a ladder input, not an output) put resistors from the set {0, 6.8 k, 15 k, 27 k, 45 k (47 k or 43 k from E24 also fine)} between OSD and GND (powered) and see whether a
  menu appears and what it contains on the TR1. If Caddx sells the menu board separately, measuring its
  resistors settles it. Recording the menu screens is useful.
- **B6 Palettes:** send pseudo-color 0…10 and screenshot each. Note which index is black-hot, which ones
  are colour, and where the camera stops accepting.
- **B7 Persistence:** set palette 3 and brightness 80, power-cycle, then read back with cmd 1 sub 0 (no
  payload) and look at the image.
- **B8 USB:** connect DP/DN/GND/VBUS to a PC and run `lsusb` and `v4l2-ctl --list-devices`. If UVC
  appears, `v4l2-ctl -l` lists the controls; look for zoom. Don't feed 5 V into VBUS while 12 V is also
  applied until B2 shows what VBUS is.
- **B9 Current:** current at 12 V and at the planned pack voltage, Infra selected against thermal
  selected, plus the inrush peak and the peak during a shutter click.
- **B10 Boot time:** time from power to stable video, and when UART commands are first accepted.
- **Ask Caddx** (support@caddxfpv.com): a TR1-220SL manual, confirmation that the Eclipse 004 Dual serial
  protocol applies, the palette list, the ADKEY resistor values, and the USB function.

## 5. Retrieved (read at source)

| File | Source | Used for |
|---|---|---|
| papers/bzbuas_tr1-220sl_wiring_diagram.png | https://www.bzbuas.com/web/image/69184-defac109/ | pinout, power |
| papers/bzbuas_tr1-220sl_product_page_pl.txt / .html | https://www.bzbuas.com/pl/shop/tr1-220sl-kamera-termowizyjna-caddx-tr1-220sl-dual-3230 | specs, kit |
| papers/bzbuas_tr1-220sl_product_page_en.txt | https://www.bzbuas.com/shop/tr1-220sl-caddx-tr1-220sl-dual-thermovision-camera-3230 | GPIO = camera switch |
| papers/bzbuas_tr1-220sl_kit_contents.png | bzbuas image 69119 | GPIO cable has 2 wires, no menu board |
| papers/bzbuas_tr1-220sl_dimensions_aibox_thermal.png, _dimensions_infra.png, _product_render.png | bzbuas images 69133, 69135, template 3230 | geometry |
| papers/ctrl_caddx_eclipse004dual_ft483dual.pdf / .txt | https://www.rotorama.com/assets/docs/422754d47b05062b7fbe4d921cebcbe6/31893-1/ft483dual.pdf (downloaded first by the controller track; re-downloaded here, byte-identical) | UART protocol, GPIO levels, PINIO recipe, OSD board |
| papers/bzbuas_eclipse005sl_product_page.txt, _adkey_osd_menu_board.png, _aibox_ports.png, _dimensions.png | https://www.bzbuas.com/shop/eclipse-005sl-caddx-eclipse-005sl-ft004-v3r-thermovision-camera-3228 | ADKEY label, UVC zoom, palettes 0–4, 1.25 mm |
| papers/bzbuas_eclipse005sh_dual_product_page.txt | https://www.bzbuas.com/shop/005sl-dual-caddx-eclipse-005sh-dual-ft-d004a-v3-thermovision-camera-3226 | identification only |
| papers/betaflight_*.txt (6 files) | raw.githubusercontent.com/betaflight/betaflight/master/src/... (fetched 2026-11-03) | PINIO polarity, camera-control ladder |

## 6. MISSING (not retrieved, no claim made)

- caddxfpv.com product and download pages for TR1-220SL / Eclipse 005SL / 004 Dual. HTTP 429 on every
  attempt (curl and WebFetch, retried with backoff). https://caddxfpv.com/
- Caddx Eclipse 002 manual with "Serial Commands" (manuals.plus, blocked by a bot challenge, 403):
  https://manuals.plus/m/f461c0ac55da8b8ec844e0856adacaaf20dcf0f7230f0be54a679e5dc1b7932e. **This is the
  most valuable missing item**: a second, independent copy of the serial protocol.
- Caddx Eclipse 006HD manual (mentions 005SL firmware versions), manuals.plus 403:
  https://manuals.plus/caddxfpv/006hd-camera-eclipse-thermal-kit-manual
- Caddx Eclipse 009HD manual (ADKEY menu items), manuals.plus 403: https://manuals.plus/ae/1005010729144159
- GetFPV Eclipse 005SL spec page, 403: https://www.getfpv.com/eclipse-005sl-thermal-analog-camera-system.html
- Unmanned Tech Shop pages (the first and the 005SH product page returned 429; the other two were not attempted because the domain was rate-limiting):
  https://www.unmannedtechshop.co.uk/blogs/knowledge-base/caddx-phynan-thermal-fpv-camera-buying-guide ,
  https://www.unmannedtechshop.co.uk/blogs/knowledge-base/caddx-eclipse-005sl-vs-005sl-dual-which-thermal-camera ,
  https://www.unmannedtechshop.co.uk/products/caddx-eclipse-005sh-dual-thermal-visible-light-fpv-camera-ft-d004a-v3
- No intofpv, rcgroups, reddit or GitHub source on the Caddx thermal UART protocol turned up in searching.
  GitHub code search found no reverse-engineering of `FF 5A`.

Adam: if you can open the manuals.plus Eclipse 002 / 006HD / 009HD pages in a browser and save them as
PDF into `papers/`, sections 2.2 and 2.4 can be cross-checked. The Unmanned Tech Shop and caddxfpv pages
would help as well.

## 7. Verification (adversarial pass, 2026-11-03)

Method: every claim was re-checked against the files in `papers/`. Text sources were read with
pdftotext/cat and grep, and images were viewed directly. Crops of the 004 Dual PDF (Connection,
Switch Control, the USER1 figure) were rendered with pdftoppm and compared with the BZB UAS PNG. CRCs
were recomputed with an independent CRC16/MODBUS implementation. All derived numbers were recomputed.

**Checked and confirmed (quote present verbatim, supports the claim):**
- All TR1 pin labels, wire colours and the "12V@120mAh" note (PNG, viewed). The same labels are in the
  004 Dual PDF, text l.6–30, and its figure.
- The GPIO-cable purpose sentence (EN page l.48), "white hot" (l.48), package list (l.132–136), PL spec
  values (9-24 V, 20 ms, <1,5 W ×2, 256×192, 50°×37.2°, 3,43 mrad).
- 004 Dual: Switch Control text and CLI lines (l.48–65), polarity sentence (l.70–71), figure (USER1,
  Min 900 / Max 1300, yellow band 900–1300, cursor ≈1500 in white), Serial table (l.102–107), frame
  layout and 10-byte header (l.113–118), CRC code (l.137–153), command tables §2.1–2.5 (l.161–226),
  10 example frames (l.233–242), spec block (l.269–288).
- CRC16/MODBUS: all 10 printed example frames match (init 0xFFFF, poly 0xA001, CRC over `FF`…payload,
  low byte first). The 4 track-computed hot-tracking frames are arithmetically correct.
- Betaflight: PINIO default `PINIO_CONFIG_MODE_OUT_PP`, `IOLo` at init when not inverted,
  `newState = on ^ inverted`, `pinioSet(i, getBoxIdState(...))`. Camera-control defaults 330/470/
  450/270/150/68/0 and the voltage formula are verbatim. Key voltages 1.614/1.204/0.798/0.417/0 V are
  correct.
- 005SL: "4.5V~20V", "UVC/ ADKEY", "0-100", "0-4", zoom "controllable via UVC", package list. The
  ADKEY/GND and DP/DM/GND/VBUS labels and the OSDMenu Board note are on the PNGs.
- Power 12 V × 0.120 A = 1.44 W. Kit photo: 3-pin cable yellow/black/red, GPIO cable white + black only,
  no menu board.

**Changed:**
1. "all 9 example frames" → **10** (the guide prints 10). The endianness wording was split into
   field-order (read from the frames) and CRC byte order (confirmed by recomputation).
2. Added the caveat that the TR1 and 004 Dual drawings are the **same artwork**, so the match may be
   reseller reuse rather than proof of identical hardware. Confidence was lowered accordingly: "very
   likely" → "plausible/probably"; GPIO 3.3 V level for TR1 high → medium-high.
3. TL;DR polarity "very likely" → **medium** (it now matches the table). The yellow = active reading is
   marked as an unsourced Betaflight Configurator UI convention.
4. **Power:** "3S/4S works with no step-down" was wrong for 3S Li-ion. With the Molicel P28A 2.5 V
   cutoff, 3S = 7.5–12.6 V, below the 9 V minimum. 4S = 10.0–16.8 V is fine, now sourced from
   `ctrl_molicel_p28a.txt`. Also noted that the 1.44 W note may describe the 004 Dual, and that the
   ≥3 W budget excludes the AI box.
5. GPIO-cable colours: in the drawing white = RX, not GPIO2. Added as an alternative hypothesis for B1b.
6. "black&white camera" was re-read. The guide's own later sentence pairs visible with thermal, so the
   claim that it is a second name for the visible camera was withdrawn.
7. Noted that the guide's "(Introduction 4)" points to a section absent from the retrieved PDF, so the
   copy may be incomplete.
8. Spec match narrowed to "partial" (operating temperature differs: −20~60 °C vs −10~50 °C).
9. "OSD port = ADKEY (resistor ladder)" downgraded to "probably ADKEY". The ladder meaning is not in any
   retrieved source. The 005SL 1.25 mm cable's purpose is unstated.
10. Unsourced statements removed or flagged: "RunCam-style defaults" (removed), "ESP32 is a poor UVC
    host" (removed), "values are configurable in Betaflight" (reworded to the PG name only), "swapping
    TX/RX is harmless" (replaced with a series-resistor precaution), "can't hurt anything" (→ low-risk),
    XIAO "GPIOs are 3.3 V" (the wiki states only the 3V3 regulator rail), JST SH/ZH/PicoBlade pitches
    (only GH is sourced), "HDO2 may blank" (flagged).
11. "Menu board does not reach palette/contrast" → "not documented to".
12. B5: resistor tests only after B2 shows the pin idles pulled up.

**Not changed, still open:** every TR1 protocol claim rests on one sister-product guide of uncertain
completeness. The MISSING list (section 6) is unchanged and still governs. Nothing new was retrieved
in this pass.
