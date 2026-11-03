# 07a: Pod components, mechanical dimensions for CAD (WORKING DRAFT)

Track 07a of arabskie_gogle: the goggle "pod" (PETG, Prusa MK4) for the XIAO ESP32-C3, the D36V6F5 buck, the encoder,
two tactiles, the vibration motor and the JST-GH connectors. **None of the electronics are owned yet, so every number
here comes from datasheets, vendor CAD files or drawings.**

- **Status: working draft.** It is waiting on (a) the parts arriving, to measure the unknowns in §8, and (b) Adam
  choosing the encoder variant (§1.4).
- **Authority:** `ZALOZENIA.md` governs project decisions. For any number, the source files in `papers/` govern; the
  verbatim passages are in `papers/extracts_pod_components.md` (E1…E9). Where this report and the extracts disagree,
  the extracts govern.
- **Tags:** [V] read at source (text or a printed dimension); [V-file] value taken from a vendor CAD file (DXF/KiCad);
  [img] measured or interpreted from a drawing image, not printed as a number; [calc] my arithmetic on [V] values;
  [A] assumption; [design] engineering recommendation.

## TL;DR
1. **The Alps EC11E09244BS has no threaded bushing and no panel nut.** The shaft runs out of a smooth ø7 × 7 mm
   collar (E1.6, E2.7). The part cannot be panel-mounted with a nut, so "panel nut dims" and "max panel thickness" do
   not apply. It must be held by its two soldered mounting tabs (on a small PCB; plain 0.1″ perfboard does not fit the 14.5 mm row spacing or the 2.5 mm tabs, see §1.1) or captured in a printed
   cradle. Push force is **6 (+2.5/−2) N** and push-pull strength 100 N (E2.4, E2.5), so the cradle has to carry the
   push load from under the body.
2. **The shaft is 24.5 mm above the mounting surface** (4.5 body + 20 shaft). The current Alps catalog lists no
   shorter EC11E part number (E1.4). Alps does show a **15 mm flat shaft as a "product variety"** (LB 5 / flat 7 mm, or
   LB 7 / flat 5 mm), but only as a custom option (E2.7, E1.5), and the Alps page gives a factory minimum order unit
   of 1,200 pcs (E2.8), so treat it as unobtainable for one unit [design]. The shortest *standard ordering code* I
   found is the **Bourns PEC11R-4115F-S0018**: 15 mm flatted shaft measured from the bushing base (the body front,
   6.5 mm above the PCB, which Bourns labels the "mounting surface"), M7×0.75 × 5 mm bushing, nut and washer supplied,
   push switch, 18 detents. Its tip sits **21.5 mm** above the PCB [calc], 3 mm lower than the Alps (E4). Caveats:
   operating range only −30…+70 °C, and "Hand Soldering … Not recommended" (E4.13). For gloves, also consider the
   **EC11E09244AQ**: same body, 1.5 mm push travel instead of 0.5 (E1.3).
3. **Omron B3S-1000/1002:** body 6.0 × 6.6 mm, cover 3.4 mm, 4.3 mm overall; plunger ø3.3 standing only
   **~0.8–0.9 mm** proud [calc/img, see §2]; terminals 9.0 tip-to-tip at 4.5 mm pitch; general tolerance ±0.3 (E5). The
   printed caps need a stem that reaches down onto that sub-1 mm stub. The maximum plunger load is not in the
   datasheet (§8). Operating range −25…+70 °C (E5.8).
4. **XIAO ESP32-C3, from Seeed's DXF and KiCad files:** 20.955 × 17.78 mm, corner R 1.906, 2 × 7 pins at 2.54 mm
   pitch. **The USB-C receptacle overhangs the short edge by 1.52 mm** (9.0 mm wide, centred). BOOT, RESET and the
   U.FL socket sit at the opposite short edge (E6c–E6e). **Board thickness and component heights are not published:**
   the KiCad file says 1.6 mm, but that is probably KiCad's default (no stack-up section). The supplied FPC antenna's
   size is not published either. Measure all three (§8).
5. **Pololu D36V6F5:** 10.2 × 12.7 mm, PCB 1.02, parts ≤ 1.8 mm on top only (2.82 mm overall [calc]); 4 × ø1.02
   holes at 2.54 pitch, 1.27 mm from the edge; drill ±0.1, edge ±0.3 (E7b). The "13 × 10 × 3" on the product page is
   rounded.
6. **Adafruit 1201 motor:** ø10.0 ±0.1 × 2.7 ±0.2 housing, plus a 0.3 mm layer on top and a 0.15 mm layer below
   (3.15 mm envelope [calc]); the lead-exit tab reaches 10 mm from the centre; leads AWG32; total lead length not
   dimensioned. The datasheet warns **"Do not press the product with more than 0.5Kgf"** (E8b.4), so do not clamp it
   hard in the pod.
7. **JST-GH:** side-entry SM0xB-GHS-TB header is (n·1.25 + 3.25) wide × 4.05 deep (+0.8 leads) × 4.25 high. A **mated
   side-entry pair is (7.15) long × (4.35) high**, and a mated top-entry pair (7.3) high, before the wire bend. Wire
   is AWG30–26, insulation OD 0.76–1.0 (E9).

---

## 0. Coordinate conventions used in the tables
- **Encoder:** origin on the shaft axis at the **mounting surface** (the PCB plane, i.e. the underside of the body).
  +Z runs up the shaft. X runs through the two mounting tabs. +Y points to the D/E (switch) pin row; −Y to the A/C/B
  row.
- **B3S:** origin at the body centre on the PCB plane. X runs along the terminals (the 9.0 span). +Z up.
- **XIAO:** origin at the board corner, component side up (top view), **USB-C pointing +X**. X runs along the 20.955
  length, Y along the 17.78 width. Z = 0 at the PCB underside. In this frame the D0…D6 row is on Y = 17.78 and the
  5V/GND/3V3/D10…D7 row on Y = 0; D0 and 5 V are at the USB end (E6e.3, E6f).
- **Pololu:** origin at the board corner, X along the 10.2 edge that carries the 4 holes, Y along the 12.7 edge.

## 1. Rotary encoder

### 1.1 Alps EC11E09244BS (and the EC11E family drawing): catalog drawing No.2
EC11E09244AQ is identical except for 1.5 mm switch travel (drawing No.3, E1.8). Non-push parts (drawing No.1) have a
12 mm flat instead of 10 (E2.6, E2.7).

| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Body footprint X × Y | 11.7 × 12.0 (axis ±6) | not stated | E1.6 front view | [V] |
| Envelope at the PCB including mounting tabs (X) | tabs sit at X = ±6.25 (slot centres) in 1.5-wide slots, so they reach up to ±7.0, beyond the 11.7 body; the front view draws them protruding past the body sides | — | E1.6, E1.7 | [calc]/[img] |
| D/E terminals (+Y side) | drawn protruding past the +6 body edge (holes at Y = +7.0); extent not dimensioned | — | E1.6 front view | [img] |
| Body height above mounting surface | 4.5 | not stated | E1.6 | [V] |
| Collar (unthreaded) | ø7 × 7 long (LB) | not stated | E2.7 flat type, L1 = 20 row; E1.6 "7" | [V] |
| Thread / bushing / panel nut | **none** | — | E1.6 (no thread drawn), E2.7 | [V] |
| Shaft diameter | 6.0 | +0 / −0.05 | E1.6 | [V] |
| Shaft length above body top | 20 (reference) | — | E1.2, E1.6 | [V] |
| Shaft tip above mounting surface | 24.5 | not stated | E1.6 | [V] |
| D-flat length (from tip) | 10 | not stated | E1.6, E2.7 | [V] |
| Across-flat dimension | 4.5 | +0 / −0.1 | E1.6 | [V] |
| Section between collar and flat | 3 | — | 20 − 7 − 10 | [calc] |
| Tip chamfer | C1 | — | E1.6 | [V] |
| Push travel | 0.5 (AQ: 1.5) | ±0.3 (BS) | E2.5, E1.3 | [V] |
| Push operating force | 6 N | +2.5 / −2 | E2.5 | [V] |
| Push-pull strength (shaft) | 100 N | — | E2.4 | [V] |
| Detents / pulses | 18 / 9 | — | E1.2 | [V] |
| Terminal length below mounting surface | 3.5 | not stated | E1.6 | [V] |
| A, C, B holes | (−2.5, −7.5), (0, −7.5), (+2.5, −7.5) | ±0.1 | E1.7 | [V] |
| D, E (switch) holes | (−2.5, +7.0), (+2.5, +7.0) | ±0.1 | E1.7 | [V] |
| PCB hole diameter (5 holes) | 1.0 | +0.1 / 0 | E1.7 | [V] |
| Mounting-tab slots | 2 × 1.5 (X) × 2.6 (Y), centres at X = ±6.25, Y = 0 | slot +0.1/0; pitch 12.5 ±0.05 | E1.7 | [V] |
| Mounting-tab width | 2.5 (the tab seen edge-on on the shaft axis in the side view; it fits the 2.6 slot). Tab length below the mounting surface not separately dimensioned | not stated | E1.6 side view "2.5" | [V]/[img] (interpretation) |
| Terminal extent from axis (A/C/B side) | 7.5 max | max | E1.6 | [V] |
| Operating temperature | −40…+85 °C | — | E2.3 | [V] |
| Alps minimum order unit (factory) | 1,200 pcs (Japan) / 2,400 (export) | — | E2.8 | [V] |

Pitch note [calc]/[design] (corrected in verification): within a row the pins nearly fit 0.1″ perfboard (A–C–B 2.5 vs
2.54, D–E 5.0 vs 5.08, error ≤ 0.08 mm). **The rows do not:** D/E is at Y = +7.0 and A/C/B at Y = −7.5, so the rows are
14.5 mm apart, which is 5.71 grid pitches; the nearest grid spacing (15.24) is 0.74 mm off. The 2.5 mm-wide mounting tabs
also cannot enter ~ø1 perfboard holes. On perfboard, either bend one row of pins by ~0.74 mm and slot/drill the board
for the tabs, or skip the board and hold the encoder in a printed cradle with wires soldered to the pins. The same 14.5
row spacing applies to the PEC11R (7.0 + 7.5, E4.8).

### 1.2 Shorter-shaft options (≤ 15 mm)
| Option | Shaft above mounting surface | Mounting | Push | Status / source | Tier |
|---|---|---|---|---|---|
| Alps EC11E "Flat type" variety, L1 = 15 | 15 above the body top → 19.5 above the PCB [calc]; LB 5 / flat 7, or LB 7 / flat 5 (non-push 6) | same as above, no thread | yes | Shown as a product variety only, no part number; "Products other than those listed … contact us" (E2.7, E1.5); factory minimum order unit 1,200 (E2.8) | [V] |
| Alps EC11E "Slotted"/"Knurled" varieties | slotted 15/20/25, knurled 20/25 | no thread | — | knurled needs a knurled knob (E2.7) | [V] |
| **Bourns PEC11R-4115F-S0018** (code built from the ordering table) | L = 15 from the bushing base; body 6.5 → **tip 21.5 above the PCB** [calc] | **M7×0.75 bushing, LB 5**, nut + washer supplied | 0.5 ±0.3, **610 ±306 gf (≈6.0 ±3.0 N** [calc]**)** | Terminal "4 = PC Pin Horizontal / Rear Facing", "1 = 18 Detents (18 pulses)", "15 = 15.0 mm", "F", "S", "0018" (E4.5–E4.7). Stock and existence of this exact code not checked [A] | [V] |
| Bourns PEC11R-4115K-S0018 (knurled variant, same ordering table) | L = 15 from the bushing base, LB 5, knurl P 7, A 6 (18 teeth); tip 21.5 above the PCB [calc] | M7×0.75 bushing | 0.5 ±0.3 | Footnote 1: "Metal knurled shaft with push momentary switch is available in 15 and 20 mm shaft lengths" (E4.15). Takes a push-on knurled knob; stock not checked [A] | [V] |
| Shorten the Alps 20 mm shaft by cutting | e.g. cut 5 mm → 15 mm with a 5 mm flat left | — | — | not a vendor option | [design] |
| Alps EC11M (serrated 25 mm), EC111 (self-return switch, not an encoder), EC11B (discontinued) | — | — | — | not suitable (E3.1–E3.3) | [V] |

### 1.3 Bourns PEC11R-4xxxF-Sxxxx dimensions (for the alternative)
| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Body | 12.5 × 13.4 | ±0.5 (both ≥ 10; general <10 ±0.3, ≥10 ±0.5) | E4.8, E4.12 | [V] |
| Overall width over the bent mounting tabs | 14.0 | ±0.5 | E4.14 | [V] |
| PCB ("MOUNTING SURFACE" in the drawing, i.e. the body rear) → bushing base / body front | 6.5 | ±0.3 | E4.8 | [V] |
| Pins / tabs below the mounting surface | 3.7; pin width 0.8 (5 places); tab width 2.5 | ±0.3 | E4.14 | [V] |
| Bushing | M7×0.75, LB = 5 (for L = 15) | ±0.3 | E4.10 | [V] |
| Shaft ø / across flat / flat length | 6.0 ±0.1 / 4.5 +0/−0.05 / F = 7 (for L = 15) | as given | E4.8, E4.10 | [V] |
| Nut | 10.0 across flats × 2.0 thick; across corners 11.55 [calc] (10.0 / cos 30°) | ±0.5 / ±0.2 | E4.11 | [V] (AF reading from the hex drawing: [img], confirmed: the hex is drawn point-up and the 10.0 spans the vertical flats) |
| Washer | OD 12.0, ID 7.1, 0.5 thick | ±0.3 | E4.11 | [V] |
| **Max panel thickness** | **2.5** = LB 5 − nut 2.0 − washer 0.5; use ≤ 2.0 to keep one thread of engagement margin | — | E4.10, E4.11 | [calc] / [design] |
| Mounting torque | 10.2 kgf·cm max | — | E4.2 | [V] |
| Pins | 5 × ø1.0 +0.1/0 holes: A/C/B row 7.5 from the axis, switch pins 7.0 from the axis, 5.0 spacing | ±0.3 | E4.8 | [V] |
| Tab slots | 2.6 +0.2/0 × 1.8 +0.2/0, 13.2 apart | — | E4.8 | [V] |
| Ingress | IP40 | — | E4.2 | [V] |
| Operating temperature | −30…+70 °C (Alps EC11E: −40…+85) | — | E4.13 | [V] |
| Hand soldering | "Not recommended" (wave solder 260 °C max, 3 ± 1 s) | — | E4.13 | [V] |
| Shaft side load (static) | 2.04 kgf (≈ 20 N [calc]) min. | — | E4.13 | [V] |

### 1.4 Decision for Adam
- **EC11E09244BS as chosen:** tallest (24.5), no nut, needs a PCB or a printed cradle, 0.5 mm push.
- **EC11E09244AQ:** same body, 1.5 mm push, so more travel to feel through a glove [design].
- **PEC11R-4115F-S0018:** 3 mm lower, nut-mounted through a ≤ 2 mm printed wall, push 6 ±3 N (wide spread), 18
  pulses per 18 detents (firmware differs from the Alps 9 pulses per 18 detents). Narrower temperature range
  (−30…+70 °C) and hand soldering "not recommended" by Bourns (E4.13); body 12.5 × 13.4 (14.0 over tabs) vs 11.7 × 12.

## 2. Omron B3S-1000 / B3S-1002 (no ground terminal)
| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Body X (terminal direction) × Y | 6.0 × 6.6 | ±0.3 | E5.4, E5.6 | [V] |
| Cover height | 3.4 (drawn from the cover top down to the *upper* of the two closely spaced base lines; see the 0.1 row) | ±0.3 | E5.4 | [V]/[img] |
| Overall height (plunger top) | 4.3 (to the *lower* base line, i.e. the PCB plane); the ground-terminal variant prints 4.3 ±0.2 | ±0.3 | E5.1, E5.4 | [V] |
| Plunger diameter | 3.3 | ±0.3 | E5.4 | [V] |
| Plunger above the cover | ≈ 0.8 if the 0.1 offset sits between cover datum and PCB (4.3 − 3.4 − 0.1), as drawn; 0.9 if 3.4 is taken from the PCB | — | 4.3 − 3.4 (− 0.1) | [calc]/[img] |
| Terminal span (tip to tip, X) | 9.0 | ±0.3 | E5.4 | [V] |
| Terminal width / pitch (Y) | 0.7 / 4.5 | ±0.3 | E5.4 | [V] |
| "0.1" under the side view | **meaning not certain; NOT terminal thickness.** It is a vertical offset between the two base lines (most likely terminal underside vs. body base); the ground-terminal variant prints it as "0.1±0.2", which a sheet thickness cannot be | (±0.2 in the ground variant) | E5.4 | [img] |
| PCB pads | outer span 9.5, inner span 6.4 (pad length 1.55 [calc]), width 1.3, pitch 4.5 | — | E5.5 | [V] |
| Pretravel | 0.25 | +0.2 / −0.1 | E5.3 | [V] |
| Operating force | 1.57 N max (‑1000) / 2.26 N max (‑1002) | — | E5.3 | [V] |
| Sealing | IEC IP67 | — | E5.2 | [V] |
| Mass | ≈ 0.3 g | — | E5.2 | [V] |
| Releasing force | 0.2 N min (‑1000) / 0.49 N min (‑1002) | — | E5.8 | [V] |
| Operating temperature | −25…+70 °C, no icing or condensation | — | E5.8 | [V] |
| Omron ordering unit | bags of 100 (B3S-1000), reels of 1,000 (‑P); distributor single-piece sales not checked | — | E5.8 | [V] |

There is no through-hole version in this datasheet; it is SMT (gull-wing). Without a PCB, the switch sits in a printed pocket with
wires soldered to the terminals [design].

## 3. Seeed XIAO ESP32-C3

### 3.1 Outline and pins
| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Board L × W | 20.955 × 17.78 | not published; assume ±0.15 | E6c, E6e.2 | [V-file]; tol [A] |
| Corner radius | 1.906 | — | E6c (arc dim 2.994 = π/2 · 1.906) | [V-file]/[calc] |
| Pins | 2 rows × 7, pitch 2.54 | — | E6c, E6e.3 | [V-file] |
| Pin X centres | 2.8575 + k·2.54 (k = 0…6) per the dimensioning DXF (symmetric); the KiCad file gives 2.794 + k·2.54 measured from the U.FL end, i.e. 2.921 from the USB end (0.064 mm offset) | ±0.1 [A] | E6c, E6e.4, E6e.5 | [V-file] |
| Castellations | half-holes centred on the long edges Y = 0 and Y = 17.78; pads ø1.27, drill 0.7 (corrected) | — | E6e.5 | [V-file] |
| Header through-holes | Y = 1.27 and 16.51 (rows 15.24 apart), pads ø1.5, drill 0.85 | — | E6e.3, E6e.4, E6e.5 | [V-file] |
| Pin map | Y = 17.78 row: D0 (USB end) … D6/TX; Y = 0 row: 5V (USB end), GND, 3V3, D10, D9, D8, D7/RX | — | E6e.3, E6f | [V-file]/[img] |
| PCB thickness | **unknown.** KiCad `(general (thickness 1.6))`, but no stack-up, so probably the KiCad default | — | E6e.1 | [V-file], treat as [A] |
| Height of top components (RF shield / label, USB-C, buttons, U.FL) | **unknown** | — | not in any retrieved Seeed document | — |
| Bottom side | no components on B.Cu (only test pads, BAT/GND pads and a logo), so "single-sided" holds; but four USB-C shell legs (THT) and three locating-peg holes (USB-C: 2 × ø0.58 NPTH at X 16.213, Y 6.015 / 11.765; BOOT and RESET buttons: ø0.7 NPTH at their centres) pass through the board, and whether their pegs/legs protrude below is unknown | — | E6a.2, E6e.3, E6e.5 | [V-file]; protrusion unknown |

Dimension note: the dimensioning DXF also carries two vertical dimensions, 15.161 and 13.626, between pin features.
They do not match the KiCad hole rows (15.24). I could not tell which pad edges they reference; this is irrelevant for
a wired (not socketed) XIAO.

### 3.2 Components that matter for the enclosure (top side, XIAO frame)
| Feature | Position / size | Source | Tier |
|---|---|---|---|
| **USB-C receptacle** (silk outline) | X 15.113 … 22.463, Y 4.390 … 13.390 (7.35 × 9.0, centred on Y = 8.89) | E6e.3/E6e.4; Gerber DXF gives X 15.113 … 22.479 (E6d.1) | [V-file] |
| **USB-C overhang beyond the board edge** | **1.51–1.52** (KiCad 1.508; Gerber silk 1.524 for the 0.1524-wide outline, 1.506 for a second 0.127-wide outline in the same layer). These are silk outlines, a proxy for the receptacle body, not a mechanical dimension | E6d.1, E6e | [calc] (silk proxy) |
| USB-C shell legs (through-hole, drill 0.508) | X 15.684 and 19.875; Y 4.572 and 13.208 | E6e.3/E6e.4 | [V-file] |
| BOOT button | centre (1.524, 13.335); body outline 2.6 (X) × 3.0 (Y) | E6e.3/E6e.4, E6d.2 | [V-file] |
| RESET button | centre (1.524, 4.445); 2.6 × 3.0 | E6e.3/E6e.4, E6d.2 | [V-file] |
| U.FL socket (U.FL-R-SMT1) | centre (1.397, 8.890); courtyard 2.794 × 4.064; footprint name "U-FL3P-SMD-2.6X2.6X1.0MM" | E6a.3, E6e.3 | [V-file] (height in the name only: [A]) |
| Large silk rectangle (presumably the shield/label area [A]) | X 3.683 … 13.970, Y 2.667 … 15.113 (line centres, 0.508 wide) | E6d.4 | [V-file] |
| Charge LED | (20.333, 3.175) | E6e.3/E6e.4 | [V-file] |
| Bottom BAT / GND pads (2.03 × 1.02) | BAT (10.795, 13.335), GND (12.700, 13.335), given in the top-view frame (seen through the board) | E6e.3 | [V-file] |
| Supplied antenna | "Antenna x1"; **size and cable length not published**; Seeed: "connect the antenna at the vertical direction and do not drag at the horizontal direction" | E6b.3, E6b.4 | [V] |

Dimension conflict: the product page carries both "21 x 17.8mm" (current text) and "21 x 17.5mm" (an older copy of
the description in the same page). The DXF, KiCad and wiki all say 17.78/17.8, so use **17.78** (E6b.2).

Design consequences [design]:
- To reprogram in place, the pod needs a USB-C cut-out at least 9.0 + 2 × 0.5 wide in the end wall, with the board end
  pushed to that wall.
- The U.FL is at the far end, opposite the USB. Seeed's "connect vertically" advice means the pod needs vertical
  access above the U.FL, or the antenna has to be fitted before closing.
- Keep ≥ 1 mm under the USB end for the shell legs, and relief under the BOOT/RESET peg holes, until the
  protrusions are measured.

## 4. Pololu D36V6F5 (product 3792; drawing reg04b)
| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Board | 10.2 × 12.7 | ±0.3 (edge) | E7b.2, E7b.5 | [V] |
| PCB thickness | 1.02 | — | E7b.4 | [V] |
| Tallest component above the PCB (top only) | 1.8 | — | E7b.4 | [V] |
| Overall height | 2.82 | — | 1.02 + 1.8 | [calc] |
| Holes | 4 × ø1.02, pitch 2.54, along the 10.2 edge, centres 1.27 from that edge; first hole 1.27 from the side edge → X = 1.27, 3.81, 6.35, 8.89; Y = 1.27 | ±0.1 (drill location) | E7b.3, E7b.5 | [V]/[calc] |
| Pin order | SHDN – VIN – GND – VOUT along the edge (from the isometric view; which end is SHDN in the 2D view: read the board silk) | — | E7b.6, E7a.2 | [img] |
| Mass | 0.5 g | — | E7a.1 | [V] |

## 5. Adafruit 1201 coin vibration motor (datasheet model 10B27.3018)
| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Housing diameter | 10.0 | ±0.1 | E8b.6 | [V] |
| Housing height | 2.7 | ±0.2 | E8b.6, E8a.1 | [V] |
| Layer on top / below the housing (not labelled; probably adhesive pad and FPC/backing [A]) | 0.3 / 0.15 | — | E8b.6 | [V] (identity [A]) |
| Envelope height | 3.15 | — | 2.7 + 0.3 + 0.15 | [calc] |
| Lead-exit tab | reaches 10 mm from the motor centre (5 mm past the rim); width ≈ 4.4 | width ±0.5 | E8b.6 | [V] / width [img] |
| Leads | UL AWM 1571 AWG32, red = +; stripped ends 5.0 ±0.5 | — | E8b.5, E8b.6, E8a.2 | [V] |
| Total lead length | **not dimensioned** | — | E8b.6 | — |
| Mass | 1.2 g (datasheet) vs 0.9 g (product page) | — | E8b.3, E8a.1 | [V] (conflict) |
| Max pressure on the motor | 0.5 kgf (≈ 4.9 N [calc]) | — | E8b.4 | [V] |
| Working temperature | −30…+70 °C | — | E8b.7 | [V] |
| Lower view: "7.1" (centre → end of the glued lead exit), "Ø9.0", and a vertical "…MAX" dimension cut off at the PDF page edge | value of the "MAX" dimension unreadable | — | E8b.6 | [img] |
| Rated voltage / range / current | 3.0 V / 2.5–3.8 V / ≤ 75 mA; start ≤ 120 mA | — | E8b.1, E8b.2 | [V] |

## 6. JST-GH (1.25 mm pitch)
| Feature | Value | Tol. | Source | Tier |
|---|---|---|---|---|
| Wire | AWG30–26, insulation OD 0.76–1.0; 1.0 A at AWG26 | — | E9.1 | [V] |
| Side-entry header SM0nB-GHS-TB | width B = 1.25·n + 3.25; depth 4.05 (+0.8 leads behind); height 4.25 (+0.1) | ref. | E9.5 | [V]/[calc] (formula) |
| Top-entry header BM0nB-GHS-TBT | width B as above; depth 4.25 (+0.7 leads); height 4.05 (+0.15) | ref. | E9.5 | [V] |
| Plug housing GHR-0nV-S | width B = 1.25·n + 1.25; thickness 4.15; length 5.7 | ref. | E9.4 | [V] |
| **Mated, side entry** | (7.15) long × (4.35) high above the PCB, then the wire bend | reference values | E9.3 | [V] |
| **Mated, top entry** | (7.3) high above the PCB, then the wire bend | reference values | E9.3 | [V] |
| PCB pads | signal 0.6 ±0.05 at 1.25 ±0.05; reinforcement pads 1 ±0.1 wide | ±0.05 / ±0.1 | E9.3 | [V] |
| Mounting | SMT headers only ("Wire-to-Board"); no in-line or panel variant in this catalog. 1.25 mm-pitch SMT pads cannot go on 0.1″ perfboard, so the GH headers need a small PCB (or an adapter board) in the pod | — | E9.1, E9.5 | [V] / [design] |
| Keyed housings | GHR-0nV-2P (keying A, purple) and GHR-0nV-3HD (keying B, dark grey) for n = 2, 4, 5; would stop two same-size plugs being swapped blind. The matching keyed headers were not checked | — | E9.6 | [V] / [design] |

| n | A (pin span) | Header B | Housing B |
|---|---|---|---|
| 2 | 1.25 | 5.75 | 3.75 |
| 3 | 2.50 | 7.00 | 5.00 |
| 4 | 3.75 | 8.25 | 6.25 |
| 5 | 5.00 | 9.50 | 7.50 |
| 6 | 6.25 | 10.75 | 8.75 |
(E9.4, E9.5, all [V].)

## 7. OpenSCAD parameter block
Paste into the pod `.scad`. The comment on each line gives tolerance, source (extracts id) and tier. Units are mm.
Clearances for printing are **not** included; add them in the model (`fit` variables at the end, [design]).

```openscad
// ===== 07a pod components: WORKING DRAFT, 2026-11-03. Sources: papers/extracts_pod_components.md =====

// --- Alps EC11E09244BS (frame: origin = shaft axis at mounting surface, +Z up shaft) ---
ec11_body_x        = 11.7;   // tol n/s            E1.6   [V]
ec11_body_y        = 12.0;   // axis +-6           E1.6   [V]
ec11_body_h        = 4.5;    // mount surf->body top E1.6 [V]
ec11_collar_d      = 7.0;    // UNTHREADED, tol n/s E2.7  [V]
ec11_collar_h      = 7.0;    // LB                 E2.7   [V]
ec11_shaft_d       = 6.0;    // +0/-0.05           E1.6   [V]
ec11_shaft_above_body = 20;  // reference          E1.2   [V]
ec11_tip_z         = 24.5;   // mount surf->tip    E1.6   [V]
ec11_flat_len      = 10;     // from tip           E1.6   [V]
ec11_flat_ab       = 4.5;    // across flat +0/-0.1 E1.6  [V]
ec11_tip_chamfer   = 1.0;    // C1                 E1.6   [V]
ec11_push_travel   = 0.5;    // +-0.3 (AQ variant 1.5) E2.5/E1.3 [V]
ec11_push_force_N  = 6;      // +2.5/-2            E2.5   [V]
ec11_pushpull_max_N= 100;    //                    E2.4   [V]
ec11_pin_len       = 3.5;    // below mount surf   E1.6   [V]
ec11_hole_d        = 1.0;    // +0.1/0             E1.7   [V]
ec11_ACB_y         = -7.5;   // x = -2.5, 0, +2.5; +-0.1 E1.7 [V]
ec11_DE_y          = 7.0;    // x = -2.5, +2.5; +-0.1  E1.7 [V]
ec11_pin_pitch     = 2.5;    //                    E1.7   [V]
ec11_tab_pitch     = 12.5;   // +-0.05             E1.7   [V]
ec11_tab_slot      = [1.5, 2.6]; // +0.1/0 each    E1.7   [V]
ec11_tab_w         = 2.5;    // side-view dim      E1.6   [V]/[img]
ec11_tab_env_x     = 7.0;    // tabs reach +-7.0 at PCB (6.25 + 1.5/2) > body +-5.85 E1.7 [calc]
ec11_row_gap       = 14.5;   // D/E row to A/C/B row: NOT on 0.1in grid (15.24) [calc]
ec11_term_extent_y = 7.5;    // max, A/C/B side    E1.6   [V]
ec11_has_thread    = false;  // no bushing, no nut E1.6/E2.7 [V]

// --- Bourns PEC11R-4115F-S0018 (alternative; origin = shaft axis at PCB, +Z up) ---
pec_body           = [12.5, 13.4]; // +-0.5 (both >=10) E4.8/E4.12 [V]
pec_tab_span       = 14.0;   // over bent tabs, +-0.5 E4.14 [V]
pec_pin_len        = 3.7;    // below PCB plane, +-0.3 E4.14 [V]
pec_body_h         = 6.5;    // PCB ("mounting surface") -> bushing base +-0.3 E4.8 [V]
pec_bush_thread    = "M7x0.75"; //                 E4.8   [V]
pec_bush_len       = 5;      // LB for L=15        E4.10  [V]
pec_shaft_L        = 15;     // from bushing base  E4.10  [V]
pec_flat_len       = 7;      //                    E4.10  [V]
pec_shaft_d        = 6.0;    // +-0.1              E4.8   [V]
pec_flat_ab        = 4.5;    // +0/-0.05           E4.8   [V]
pec_tip_z          = pec_body_h + pec_shaft_L; // 21.5 [calc]
pec_nut_af         = 10.0;   // +-0.5              E4.11  [V]/[img]
pec_nut_ac         = pec_nut_af / cos(30); // 11.55 across corners [calc]
pec_nut_t          = 2.0;    // +-0.2              E4.11  [V]
pec_washer         = [12.0, 7.1, 0.5]; // OD, ID, t; +-0.3 E4.11 [V]
pec_max_panel      = pec_bush_len - pec_nut_t - pec_washer[2]; // 2.5 [calc]; design <= 2.0
pec_push_force_N   = 6.0;    // 610+-306 gf        E4.4   [V]/[calc]

// --- Omron B3S-1000/1002 (origin = body centre on PCB plane, X along terminals) ---
b3s_body           = [6.0, 6.6]; // +-0.3          E5.4   [V]
b3s_cover_h        = 3.4;    // +-0.3, measured to the upper base line E5.4 [V]/[img]
b3s_h              = 4.3;    // +-0.3, to PCB plane E5.1  [V]
b3s_plunger_d      = 3.3;    // +-0.3              E5.4   [V]
b3s_base_offset    = 0.1;    // meaning uncertain (0.1+-0.2 in gnd variant) E5.4 [img]
b3s_plunger_proud  = b3s_h - b3s_cover_h - b3s_base_offset; // 0.8 (0.9 if offset is 0) [calc]/[img]
b3s_term_span      = 9.0;    // tip-tip, +-0.3     E5.4   [V]
b3s_term_w         = 0.7;    //                    E5.4   [V]
b3s_term_pitch     = 4.5;    //                    E5.4   [V]
b3s_pretravel      = 0.25;   // +0.2/-0.1          E5.3   [V]

// --- Seeed XIAO ESP32-C3 (origin = board corner, USB-C toward +X, Z=0 at PCB underside) ---
xiao_L             = 20.955; // tol not published (assume +-0.15) E6c [V-file]
xiao_W             = 17.78;  //                    E6c    [V-file]
xiao_corner_r      = 1.906;  //                    E6c    [V-file]
xiao_pcb_t         = 1.6;    // UNVERIFIED (KiCad default?) E6e.1 [A] -> MEASURE
xiao_top_h         = undef;  // max component height above PCB: UNKNOWN -> MEASURE
xiao_pin_pitch     = 2.54;   //                    E6c    [V-file]
xiao_pin_x0        = 2.8575; // first pin centre (KiCad: 2.794) E6c/E6e.4 [V-file]
xiao_hole_row_y    = [1.27, 16.51]; // header holes, drill 0.85 E6e.3 [V-file]
xiao_usb_x         = [15.113, 22.463]; // silk outline E6e.4 [V-file]
xiao_usb_y         = [4.390, 13.390];  //            E6e.4  [V-file]
xiao_usb_overhang  = 1.51;   // beyond x = xiao_L (1.508..1.524) E6d.1/E6e [calc]
xiao_usb_legs_x    = [15.684, 19.875]; // THT shell legs, y = 4.572 / 13.208 E6e.4 [V-file]
xiao_boot_xy       = [1.524, 13.335]; // body 2.6 x 3.0 E6e.4/E6d.2 [V-file]
xiao_reset_xy      = [1.524, 4.445];  // body 2.6 x 3.0 E6e.4/E6d.2 [V-file]
xiao_btn_body      = [2.6, 3.0]; //                E6d.2  [V-file]
xiao_ufl_xy        = [1.397, 8.890]; // courtyard 2.794 x 4.064 E6e.4 [V-file]
xiao_ufl_h         = 1.0;    // from footprint NAME only E6e.3 [A] -> MEASURE (+ mated plug)
xiao_shield_x      = [3.683, 13.970]; // silk rect, line centres E6d.4 [V-file]
xiao_shield_y      = [2.667, 15.113]; //           E6d.4  [V-file]
xiao_led_xy        = [20.333, 3.175]; //           E6e.4  [V-file]

// --- Pololu D36V6F5 (origin = board corner, holes along X edge) ---
pololu_L           = 10.2;   // +-0.3 (edge)       E7b.2  [V]
pololu_W           = 12.7;   // +-0.3              E7b.2  [V]
pololu_pcb_t       = 1.02;   //                    E7b.4  [V]
pololu_comp_h      = 1.8;    // top side only      E7b.4  [V]
pololu_h           = pololu_pcb_t + pololu_comp_h; // 2.82 [calc]
pololu_hole_d      = 1.02;   //                    E7b.3  [V]
pololu_hole_x      = [1.27, 3.81, 6.35, 8.89]; // +-0.1 E7b.3 [V]/[calc]
pololu_hole_y      = 1.27;   // +-0.1              E7b.3  [V]

// --- Adafruit 1201 vibration motor ---
vib_d              = 10.0;   // +-0.1              E8b.6  [V]
vib_h              = 2.7;    // +-0.2              E8b.6  [V]
vib_h_env          = 3.15;   // +0.3 top, +0.15 bottom layers E8b.6 [calc]
vib_tab_reach      = 10.0;   // centre -> tab end  E8b.6  [V]
vib_tab_w          = 4.4;    // +-0.5              E8b.6  [img]
vib_lead_awg       = 32;     //                    E8b.5  [V]
vib_max_press_N    = 4.9;    // 0.5 kgf            E8b.4  [V]/[calc]

// --- JST-GH ---
function gh_hdr_w(n)  = 1.25*n + 3.25;  // SM/BM0nB header width E9.5 [V]/[calc]
function gh_plug_w(n) = 1.25*n + 1.25;  // GHR-0nV-S width   E9.4 [V]/[calc]
gh_side_hdr        = [4.05, 4.25]; // depth (+0.8 leads), height (+0.1) E9.5 [V]
gh_top_hdr         = [4.25, 4.05]; // depth (+0.7 leads), height (+0.15) E9.5 [V]
gh_plug            = [4.15, 5.7];  // thickness, length E9.4 [V]
gh_mated_side      = [7.15, 4.35]; // length, height (ref) E9.3 [V]
gh_mated_top_h     = 7.3;          // (ref)          E9.3   [V]
gh_wire_od         = [0.76, 1.0];  // AWG30..26      E9.1   [V]

// --- print fits (placeholders, NOT sourced) ---
fit_slide          = 0.25;   // [design] per side, PETG on MK4, tune with test coupons
fit_press          = 0.10;   // [design]
```

## 8. Unknowns (measure on arrival, or source)
1. **XIAO PCB thickness.** The KiCad "1.6" is probably a default (E6e.1). Measure with calipers.
2. **XIAO maximum component height:** RF shield/label, USB-C receptacle, BOOT/RESET tact switches (TD1183SA),
   U.FL socket, and the U.FL plug when mated. No Seeed document retrieved gives heights.
3. **USB-C shell-leg protrusion** below the XIAO PCB, and whether the BOOT/RESET and USB-C locating pegs protrude.
4. **U.FL heights:** the Hirose catalog was not retrievable (§10). The footprint name suggests a 1.0 mm high body;
   that is not a datasheet value.
5. **Supplied FPC antenna:** size, cable length and adhesive. Not published on the wiki or product page.
6. **Alps EC11E:** tolerances of the body, collar and length dimensions are not stated in the catalog. Whether the
   15 mm "variety" can be bought in small quantity is also unknown.
7. **Bourns PEC11R-4115F-S0018:** whether this exact code is stocked. I built it from the ordering table and did not
   check distributor stock.
8. **B3S maximum plunger load / overtravel.** Not in the datasheet; it points to Omron's common tactile-switch
   precautions, which I did not fetch. This matters for a gloved fist hitting the cap, so add a hard stop in the cap
   [design].
9. **Vibration motor:** total lead length; what the 0.3 / 0.15 layers are; real mass (1.2 vs 0.9 g); the "…MAX"
   dimension cut off at the edge of datasheet p.12.
9a. **B3S "0.1" base offset** and hence whether the plunger stands 0.8 or 0.9 mm proud: measure on arrival.
10. **Pololu pin order** relative to the 2D drawing orientation (check the board silk).
11. **JST-GH:** minimum bend radius of AWG28–26 GH pigtails, and the actual lengths of ready-made pigtails (not
    sourced).
12. Print fits (`fit_*`) are placeholders until test coupons are printed on the MK4.

## 9. Sources (all in `papers/`)
| File | What | Used for |
|---|---|---|
| `pod_alps_EC11E_catalog.pdf/.txt` | Alps EC11E catalog, Update 2510 | E1 |
| `pod_alps_EC11E09244BS_detail.html/.txt` + `pod_alps_EC11E09244BS_detail_dimensions.png`, `_mounting_holes.png`, `pod_alps_EC11E_shaft_varieties.png` | Alps product detail page and its figures | E2 |
| `pod_alps_EC11M_catalog.pdf/.txt`, `pod_alps_EC111_catalog.pdf/.txt`, `pod_alps_EC11{B,G,J,K,M,N}_series_page.html`, `pod_alps_EC111_series_page.html`, `pod_alps_encoders_metal_shaft_list.html` | other 11 mm Alps series and their supply status | E3 |
| `pod_bourns_PEC11R.pdf/.txt` | Bourns PEC11R datasheet, REV. D04/26 | E4 |
| `ctrl_omron_B3S.pdf/.txt` (track 05) | Omron B3S datasheet | E5 |
| `ctrl_xiao_esp32c3_wiki.txt` (track 05), `pod_seeed_xiao_esp32c3_product_page.html/.txt` | Seeed wiki and product page | E6a, E6b |
| `pod_seeed_xiao_esp32c3_v1.2_dimensioning_DXF.zip`, `pod_seeed_xiao_esp32c3_DXF.zip`, `pod_seeed_xiao_esp32c3_v1.3_kicad.zip`, `pod_seeed_xiao_esp32c3_front_pinout.png` | Seeed CAD files and pinout | E6c–E6f |
| `ctrl_pololu_D36V6F5.txt` (track 05), `pod_pololu_D36V6x_dimensions.pdf/.txt`, `pod_pololu_D36V6F5_resources_page.html`, `pod_pololu_D36V6x_drill_DXF.zip` | Pololu page and dimension drawing | E7 |
| `ctrl_adafruit_1201_vibration_motor.txt` (track 05), `pod_adafruit_1201_P1012_datasheet.pdf/.txt` | Adafruit page and motor datasheet | E8 |
| `ctrl_jst_GH.pdf/.txt` (track 05) | JST GH catalog | E9 |
| `pod_render_*.png` | my renders/crops of the drawings above, used for the [drawing] reads | — |

## 10. Retrieved / not retrieved
**Retrieved and read at source:** everything in §9.
- `pod_alps_EC11E_catalog.pdf` is byte-identical to `pod_Alps_EC11E_catalog_2510.pdf`, which another track saved.
- Not parsed further: the Pololu drill DXF (the PDF gives the same numbers) and the XIAO schematic. The schematic was
  downloaded to scratch but not used or saved.

**Not retrieved (so no claim is made from them):**
- Hirose U.FL catalog (U.FL-R-SMT-1 and mated plug heights):
  https://www.hirose.com/en/product/document?clcode=&productname=&series=U.FL&documenttype=Catalog&lang=en&documentid=D31688_en
  returned an HTML auth page. https://www.mouser.com/datasheet/2/185/U.FL_catalog-939761.pdf and
  https://www.hirose.co.jp/cataloge_hp/e32119372.pdf returned bot-check pages. **Adam: please drop the U.FL catalog PDF
  into `papers/` if the heights are needed before the parts arrive.**
- Seeed's supplied FPC antenna drawing: no document found on the wiki or product page.
- Omron "safety precautions common to all Tactile Switches" (B3S plunger load limits): not fetched.
- TD1183SA tact-switch datasheet (XIAO buttons): not searched.

## Verification
**Author's self-check (original draft):** every number in the tables and the OpenSCAD block was checked against
`papers/extracts_pod_components.md` and the rendered drawings; unsettled interpretations tagged [img].

**Adversarial verification pass (2026-11-03, separate agent).** I re-rendered the source PDFs myself (Alps EC11E
p.2 at 300/800 dpi, Bourns PEC11R pp.1–3 at 250–500 dpi, Omron B3S p.2 at 400–1200 dpi, Pololu reg04b p.1, Adafruit
P1012 p.12, JST GH pp.2–3), re-parsed the three Seeed CAD archives with my own scripts (DXF DIMENSION entities, the
Gerber-export DXF polylines, and every pad of the KiCad v1.3 footprints converted to the report frame), checked every
quoted text line in the `.txt` files, and re-ran the OpenSCAD block (it parses; echo gives pec_tip_z 21.5,
pec_max_panel 2.5, pololu_h 2.82, gh_hdr_w(2/6) 5.75/10.75, gh_plug_w(5) 7.5, USB overhang 1.508). Scripts and renders:
`/tmp/claude-1000/pod_research/verify-components/`.

Confirmed unchanged: all EC11E drawing No.2/No.3 values (24.5, 4.5, (20), 7, 10, 3.5, 11.7, 6+6, 7.5 max, 9.2,
12.5±0.05, 7/7.5, 5/5, 1.5/2.6 slots, ø1 holes, ±0.1); shaft-variety tables; product-page specs; PEC11R ordering
code construction, shaft table, nut/washer, tab slots 2.6 × 1.8 / 13.2, 0.5 ±0.3 travel, 610 ±306 gf; B3S body,
plunger, terminal span/pitch, pads, forces, pretravel; all XIAO coordinates except the castellation pad size; Pololu
board, holes, profile, tolerances; motor Ø10/2.7/0.3/0.15/10/5.0 and tab width ≈ 4.3–4.4 (re-measured: 244 px over
56.2 px/mm = 4.34); all JST GH values and the n-tables.

Changes made:
1. **Encoder perfboard claim was wrong** (§1.1). It checked only the in-row pitch; the D/E and A/C/B rows are 14.5 mm
   apart, which is 0.74 mm off the nearest 0.1″ spacing, and the 2.5 mm tabs do not fit perfboard holes. Rewritten.
2. **EC11E envelope:** added that the mounting tabs reach ±7.0 in X beyond the 11.7 body, and that the D/E terminals
   protrude past the +6 edge (§1.1, OpenSCAD `ec11_tab_env_x`, `ec11_row_gap`).
3. **Alps minimum order unit 1,200 pcs** (product page, E2.8) added; it makes the custom 15 mm Alps variety
   impractical for one unit (TL;DR 2, §1.2).
4. **PEC11R "mounting surface" mislabelled.** In the drawing the "MOUNTING SURFACE" leader points to the body rear
   (PCB plane); L is measured from the bushing base, 6.5 above it. The numbers (21.5 tip) were right; the wording in
   TL;DR 2 and §1.3 was wrong and is fixed.
5. **PEC11R body tolerance** corrected from ±0.3 to ±0.5 (both 12.5 and 13.4 fall in the "≥10 = ±0.5" class), in
   §1.3 and the OpenSCAD comment.
6. **PEC11R omissions added** (all printed in the datasheet): 14.0 over the bent tabs, 3.7 pin length, 0.8 pin width,
   operating −30…+70 °C, "Hand Soldering … Not recommended", shaft side load 2.04 kgf min; nut across-corners 11.55
   [calc]. Added the knurled PEC11R-4115K-S0018 as a same-family alternative.
7. **B3S "0.1" was not terminal thickness.** The ground-terminal variant prints it as "0.1±0.2", which cannot be a sheet
   thickness; it is a vertical offset between the two base lines. Re-tagged as uncertain, and the plunger stand-proud
   value widened from 0.9 to 0.8–0.9 (TL;DR 3, §2, OpenSCAD `b3s_plunger_proud` now 0.8).
8. **B3S omissions added:** operating −25…+70 °C, releasing force, Omron ordering units (bags of 100).
9. **XIAO castellation pads corrected:** the half-holes on the edges are ø1.27 / drill 0.7; ø1.5 / drill 0.85 belongs
   to the inner header holes (§3.1).
10. **XIAO bottom side:** added the three locating-peg NPTHs (USB-C 2 × ø0.58, BOOT/RESET ø0.7) as possible
    protrusions; the KiCad pin offset is now said to be measured from the U.FL end.
11. **USB-C overhang** re-tagged as a silk-outline proxy (a second 0.127-wide outline in the same Gerber gives 1.506).
12. **Motor:** added working temperature −30…+70 °C, and the "…MAX" dimension cut off at the page edge (unreadable).
13. **JST GH:** added that the catalog has SMT wire-to-board headers only (so they need a small PCB, not perfboard),
    and the keyed housings (patterns A/B) as an anti-swap option.
14. Extracts: added E2.8, E4.13–E4.15, E5.8, E6e.5, E8b.7, E9.6; fixed E1.6, E4.8, E5.4 and the §-reference in E6c.

Still unresolved (not settled by any retrieved source): the B3S "0.1" meaning; PEC11R-4115F/K-S0018 stock; the Alps
tab length below the mounting surface; the XIAO PCB thickness and component heights; the U.FL heights (Hirose catalog
still not retrieved); the motor's cut-off "MAX" dimension and lead length; the Pololu pin-order end. Not searched: other
low-profile encoders (e.g. side-actuated or thumbwheel types) and other sealed through-hole tactiles that might suit
gloved, blind use better. The report remains a **working draft** until the parts arrive.
