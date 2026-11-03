# 04 — Fat Shark Dominator HDO2: mounting, power/AV integration, helmet mass and CoG

Track 04 of the research for `arabskie_gogle`. ZALOZENIA.md is the governing document; where this report
and ZALOZENIA.md disagree, ZALOZENIA.md wins. Verbatim quotes for every [V] tag are in
`papers/extracts_hdo2.md` (section letter in brackets, e.g. (A12)).

Evidence tags: **[V: file, p.X]** = read at source in a downloaded file. **[V-fig]** = value I read off a
plotted curve in a downloaded file (±~3 mm / ±~0.1 kg). **[V-comm]** = downloaded community source
(Printables/GitHub), not the manufacturer. **[calc]** = my arithmetic on [V] numbers. **[A]** = my
assumption, to be replaced by Adam's measurement. Status: 2026-11-03, working draft. Helmet mass, camera
mass and the HDO2 fan/front geometry are still unmeasured.

## TL;DR (recommendations for THIS build)

1. **One 3S Li-ion pack (3× 18650, e.g. Molicel P28A, ~165 g with holder) powers everything directly.** HDO2 takes 7–13 V and the camera takes 9–24 V, so the usable overlap is **9.0–12.6 V**, which is exactly 3S at 3.0–4.2 V/cell. **No LiHV** (4.35 V/cell gives 13.05 V, above the 13 V limit), no 4S without a buck, and the **stock Fat Shark 2S case cannot run the camera**. The HDO2 low-battery beep is useless on 3S, so the MCU must measure pack voltage and warn at about 10.2 V.
2. **Feed CVBS into the HDO2 3.5 mm AV jack.** It is a 4-pole plug: sleeve = GND, ring 2 = **Video**, ring 1 = Audio R, tip = Audio L. Switch the **RX module off or remove it**, otherwise the module video conflicts with the jack. Use Analog 4:3 mode.
3. **Put the battery at the back, in the HDO2 strap pocket or on the rear of the helmet, as the counterweight.** With an assumed 500 g helmet it brings the head-borne CoG from about +37 mm to about +14 mm ahead of the tragion, and the static pitch moment from 0.30 to 0.13 N·m [calc]. The total stays under 1 kg, far inside the USAARL aviation envelope (2.5 kg max, CoG between −20 and about +17 mm at 2.5 kg). Do not overshoot behind −20 mm.
4. **Keep the cameras, AI box, MCU and buttons on or just above the goggles' front, and keep them small** (about 105 g ahead of the face, [A] masses). Run the goggle strap around the helmet so the helmet, not your nose, carries that load. Make the camera bracket **break away** (a GoPro joint with a single M5 that can shear, no rigid PETG lever toward the face). This is an HMD frangibility principle, applied by me to falls.
5. **Option to verify on the bench: use the HDO2 VRx module bay as the integration port.** A dummy "module" PCB could take +5 V for the XIAO, inject the camera CVBS, and maybe read the goggle's own channel ▲/▼ buttons as camera-control buttons. The 9-pin bay pinout comes from a community schematic and is **not confirmed for HDO2**, so check it with a multimeter first.

---

## 1. HDO2 facts relevant to integration (official manual, Rev C)

| Item | Fact | Source |
|---|---|---|
| Input voltage | "7 – 13V input voltage (2S – 3S Supply)" | [V: FatShark_HDO2_Manual_RevC.pdf, p.11] (A12) |
| Power draw | "320mA @ 7.5V input power (no RX module)" → **2.4 W** [calc]; "770mA @ 7.5V input power (Rapid" (line truncated in the PDF; the module name is cut off) → the headset drew **450 mA ≈ 3.4 W more** with that module fitted [calc]. How much of that the module itself consumed is not stated. | [V: p.11] (A12) |
| Power-on behaviour | Ships in **Legacy Mode**: it powers on when power is applied and off when power is removed. A jumper behind the Expansion Bay door selects Button Mode. | [V: p.6] (A1, A2) |
| Fan | "Fan speed is proportional to the input voltage". On 3S, lower the fan speed. | [V: p.7] (A4) |
| Low-battery alarm | Below 6.8 V, "only works well for a 2S power supply". On 3S, "not relying on the low battery indicator" | [V: p.7, p.8] (A5, A6) |
| OLED power | Setting up to 100. Recommended ≤75 for battery life, because it "can significantly increase power consumption" | [V: p.8] (A13) |
| Video modes | Analog 4:3, Analog 16:9, HDMI; "NTCS/PAL auto selecting" | [V: p.8, p.11] (A8, A12) |
| AV jack | "3.5mm AV in/out port"; plug drawing (sleeve→tip): **Ground, Video, AudR, AuL**; cable colours Yellow = Video, White = Audio L, Red = Audio R | [V: p.10, p.11] (A10, A12) |
| AV vs RX module | "If a module is inserted, but desired video source is via the AV cable; the RX module needs to be turned off to avoid image conflict." | [V: p.9] (A9) |
| Ports layout | The power port, the AV jack and the Expansion Bay door are on one side of the headset; the Antenna Port and the VRx Modular Bay are on the other. | [V: p.6, figure] (A3) |
| Other interfaces | "3.5mm 3p earphone port" (do not confuse it with the AV jack), Mini HDMI, MicroSD, "RF Module Bay", "HT connector 3 pin internal connection" | [V: p.11] (A12, A14) |
| External power-out or data port | **None listed for HDO2.** The HDO v1 had a "MiniDIN4 data port (head tracking)" and a "PS/2 Data Port". The HDO2 only lists an *internal* 3-pin HT connector. | [V: p.11] vs [V: FatShark_HDO_FSV1122_Manual_RevB.pdf, specs] (B1, B2) |
| Size and mass | 169.2 × 80 × 45.5 mm; **206.8 g** (whether the strap is included is not stated) | [V: p.11] (A12) |
| Battery accessory | Stock "7.4V, 1.8A 18650 Battery Case (optional)", which "seats securely in the headset strap pocket" | [V: p.10, p.11] (A11, A12) |
| Controls on top | HT button, DVR 5-way, Volume, Display 5-way, Channel ▲/▼ (top shell); Power/Fan button, Receiver on/off (underside) | [V: p.5, figure] (A14) |

**Not in the manual (no claim):** the power-jack barrel size, the fan location and the front-shell dimensions.
A community 18650 holder for "Fatshark FPV goggles" uses an "Angled DC jack ID2.2mm OD5.5" [V-comm:
printables_hdo2_models.txt, #43244] (H5). That is a hint for 5.5/2.1 mm, not confirmed for HDO2. Measure it.

### 1.1 AV wiring (camera → HDO2)

- Camera 3-pin: CVBS / GND / 9–24 V (see track 03, `research/03_caddx_tr1_220sl_interface.md`).
- To the HDO2 jack: **CVBS → ring 2 (Video), camera GND → sleeve**. Leave tip and ring 1 (audio) open
  [V: p.10] (A10). Do not trust a random "3.5 mm AV cable" colour code (4-pole AV pinouts differ between
  makers; this is general practice, not a sourced claim). Ring it out on the bench (Q1).
- Common ground: the AV sleeve and the power-jack negative will both tie to pack negative. Keep the CVBS
  ground return in the AV cable and do not rely on the power lead, to avoid a ground loop through the
  thin 3.5 mm contact.
- The jack is labelled in/out, and the RX switch note says module video and AV video conflict (A9). In
  practice: **RX switch OFF, or no module fitted** → the jack is an input.

### 1.2 Power architecture [calc on V numbers]

| Pack | Range | HDO2 7–13 V | Camera 9–24 V | Verdict |
|---|---|---|---|---|
| 2S Li-ion (stock case) | 6.0–8.4 V | yes, above 7 V | **no** (<9 V) | needs a boost for the camera |
| **3S Li-ion** | 9.0–12.6 V (cut at 3.0 V/cell for the camera) | yes | yes | **direct, recommended** |
| 3S LiHV | up to 13.05 V | **over 13 V when full** | yes | avoid |
| 4S Li-ion | 12.0–16.8 V | **no** | yes | buck needed for HDO2 |

Budget: HDO2 2.4 W (no RX, manual figure at 7.5 V; higher with a high OLED power setting, and the fan speed
rises with input voltage, A4) + 2 × <1.5 W camera heads [V: bzbuas_tr1-220sl_product_page_en.txt] (I1) +
MCU/buck ~0.3 W [A] ≈ **5.7 W for the loads that have a figure**. **The AI box has no power figure on the
shop page** (I1), so its draw is not in this sum and the total is a floor, not a ceiling. A 3S P28A pack
holds 3 × 10.3 Wh = 30.9 Wh typical [V: ctrl_molicel_p28a.pdf] (I2); 30.9 Wh / 5.7 W ≈ 5.4 h before any
losses [calc]. Stopping at 9.0 V instead of the cell's 2.5 V cut-off leaves some capacity unused, and the AI
box adds an unknown load, so treat **about 4–5 h as an estimate only** and measure it (Q10). Mass: 3 × 46 g =
138 g of cells [V] (I2) + holder and lead ≈ 165 g [A].
Cold: the cell discharges down to −40 °C, but the camera is specified only to **−10 °C** [V] (I1, I2).

MCU supply: a small buck from 3S to 5 V/3.3 V. Pack sense through a divider into the XIAO ADC. Warn at about
10.2 V (3.4 V/cell) and urgently at about 9.3 V, before the camera drops out at 9 V. These thresholds are
my design choice. The HDO2 itself will not warn on 3S (A5).

### 1.3 VRx module bay as an integration port (hypothesis, bench-verify)

An open-source Fat Shark-bay RX module (skaman82) draws its goggle connector "GOOGLE_IO" as: **1 = 5V,
2 = n/c, 3 = GND, 4 = A_R, 5 = A_L, 6 = VIDEO, 7 = CH3/TXD0, 8 = CH2/RXD0, 9 = CH1**
[V-comm: skaman82_fatshark_module_schematic_rev06.png] (G1). Its firmware offers "Fatshark button
control", which uses the goggle's channel buttons [V-comm: README] (G2). The HDO2 accepts bay modules
("VRx Modular Bay", "RF Module Bay", A3, A12), and with one fitted the headset drew about 3.4 W more
[calc on A12; the module's name is truncated in the PDF]. **Not confirmed:** that HDO2 uses
this same 9-pin bay pinout, that the 5 V rail is current-limited and how hard, and how the CH lines
behave (a static 3-bit channel code or pulses). If it checks out, one printed "dummy module" gives:
- 5 V for the XIAO, switched by the goggle's own Receiver on/off switch,
- the video path into the goggle with no external AV cable,
- possibly the two Channel ▲/▼ buttons as camera inputs (decode the change in CH1–3), which saves printed buttons.
Bench test: Q6.

## 2. Mounting on the HDO2 front and existing printable parts

- **No HDO2 CAD or drawing from Fat Shark was found.** The community parts on Printables are:
  #262727 HDO2 antenna support, which includes a part named `fan.stl` (a square frame with a 2-prong tab,
  bounding box 29 × 43 × 6 mm); #1073216 Walksnail VRx support for HDO2, a plate of 44.3 × 28.1 × 7 mm with a
  3-finger hinge, which the author says keeps the VRx "more parallel to the front of the goggles" (translated); #215826 HDZero VRx adapter; #356617 HDMI cable
  retainer, which uses an M5 × 25 screw and an M5 heat-set insert; #95633 lens cover; #43244 and #384249
  18650 and strap battery holders [V-comm: printables_hdo2_models.txt; STLs in papers/printables_stl/] (H1–H6).
  **Measured from the STLs (my measurement, H7):** both `262727_fan.stl` and the #1073216 support carry
  **four holes on the same 20 × 20 mm square** (Ø2.0 mm and Ø1.5–1.6 mm) around a central opening of
  about 24–25 mm (fan.stl: square opening ≈25 mm between the frame walls; #1073216: round hole Ø24.0 mm).
  **My inference, not stated by the authors:** two independent HDO2 accessories screw onto the same
  20 × 20 mm 4-hole pattern on the goggle, and the part name `fan.stl` suggests it is the fan's. The manual's
  photos (p.5 top view, p.6 side views) show an unlabelled black vented block on the top centre of the
  shell; the manual does not say what it is. If that is the fan, it is the de facto accessory anchor, and a
  camera bracket there must **not block the fan's airflow**. Open the STLs next to the goggles to confirm (Q3).
- Fogging: an occluded headset worn while walking at night in cold air needs the fan. On 3S, the manual says
  to lower the fan speed (A4).

## 3. Helmet: head-supported mass (HSM) and CoG

### 3.1 What the literature gives

- The head is 4–4.5 kg, with its CoG "at or about the tragion notch". The neck extensors counter a
  forward tipping moment [V: USAARL_HMD2009 Ch.17, p.827] (C1, C2).
- **USAARL curves (McEntire & Shanahan 1998)** are referenced from the tragion, for helicopter vibration
  plus survivable crash. They are the "de facto standard" for rotary-wing HMDs [V: Ch.17, p.829] (C3).
  Read from Fig. 17-11 [V-fig: Ch.17, p.830] (C5):
  - Longitudinal: up to 2.5 kg is allowed between **−20 mm and about +17 mm**. The allowed mass then falls
    to about 1.8 kg at +30 mm, 1.5 kg at +40 mm, 1.15 kg at +60 mm, 0.9 kg at +80 mm and 0.8 kg at the
    right-hand boundary (≈ +95 mm). **The rear boundary is fixed at −20 mm.** (Values digitised from the
    300-dpi page render; see C5.)
  - Vertical: CoG ≤ about 52 mm above the tragion up to about 1.75 kg, falling to 0 mm at 2.5 kg.
- **Knox-box refinement (USAF fixed-wing, origin = occipital condyles):** ≤2.5 kg; z +13…+38 mm;
  x +13 mm forward … −20 mm aft (threshold) or +5 … −20 mm (objective); y ±4 mm
  [V: Ch.17, p.830–831] (C6). This is an ejection criterion and much stricter than we need.
- **For walking or dismounted use, no criteria existed** as of 2018 ("No HSM criteria exist for mounted or
  dismounted Ground Soldiers") [V: Shivers_2018_NDIA_HSM.pdf, slide 4] (D1); "Recommendations for dismounted
  Warfighters are … less well-defined" [V: Ch.17, p.831] (C7). USAARL's dismounted test conditions were
  1.5 kg at −14 mm (baseline ACH), 2.5 kg neutral, and **2.5 kg at +40 mm** [V: Shivers, slide 7] (D3).
  For walking, fatigue and not acute injury is the issue: "Low to moderate acceleration with longer
  duration and/or greater frequency may contribute more to muscle fatigue" [V: Shivers, slide 15] (D4).
- **Direction of CoG offset:** an anterior HSM CoG and higher mass degraded visual-tracking performance
  (Fraser et al. 2006, cited in [V: Ch.17, p.829] (C4)). In frontal crash sleds, a more anterior and
  inferior CoG raised the neck extension moment, while a posterior and superior CoG raised the flexion
  moment [V: Merkle_2005_APL_HSM.pdf, p.82] (E2). So pushing the CoG far back does not help either.
- **Frangibility:** HMD parts are designed to break free and "shed" mass. The ANVIS NVG mount separates
  at 10–15 G [V: Ch.17, p.831] (C8).

### 3.2 Mass budget and CoG for this build [A + calc]

Coordinates: x is forward of the tragion. Every row marked [A] needs a measurement (section 5).

| Item | Mass | x | Basis |
|---|---|---|---|
| Protec helmet | **500 g** | 0 mm | [A]. No mass source was retrieved, so weigh it |
| HDO2 | 207 g | +90 mm | mass [V] (A12); x [A] |
| 2 camera heads + AI box + bracket + GoPro joint | 80 g | +115 mm | [A]. Shop lists "Weight 55g" under the AI box spec, scope unclear (I1) |
| XIAO + buck + 2–3 buttons + wiring | 25 g | +90 mm | [A] |
| 3S 18650 pack + holder | 165 g | −100 mm (rear) / +90 / off-head | 138 g of cells [V] (I2) + 27 g [A] |

| Scenario | Head-borne mass | CoG x | Static pitch moment (fwd +) | vs USAARL curve |
|---|---|---|---|---|
| A: battery off-head (belt or pocket, cable to head) | 812 g | +37 mm | +0.30 N·m | inside (≈1.6 kg allowed at +37 mm) |
| **B: battery at rear (strap pocket or helmet back)** | 975 g | **+14 mm** | **+0.13 N·m** | inside, within the 2.5 kg plateau (−20…+17 mm) |
| C: battery on the front or goggles | 975 g | +46 mm | +0.44 N·m | inside (≈1.4 kg allowed at +46 mm), but the largest forward moment |
| Ref: USAARL baseline ACH (1.5 kg, −14 mm) (D3) | 1500 g | −14 mm | −0.21 N·m | [calc] |
| Ref: USAARL "forward" condition (2.5 kg, +40 mm) (D3) | 2500 g | +40 mm | +0.98 N·m | [calc] |

Formula for re-running with measured values: x_CoG = Σ mᵢxᵢ / Σ mᵢ; M_pitch = g · Σ mᵢxᵢ.

**Recommendation: scenario B.** It more than halves the forward moment (0.30 → 0.13 N·m) for +165 g, and the battery sits where the
HDO2 already expects a battery (strap pocket, A11). A larger pack would push the CoG toward −20 mm, so check
the rear limit. Scenario A (battery on the body) gives the lowest head mass and suits long walks, but it adds
a cable across the neck. All three scenarios sit well inside even the aviation curve, which was built for a
harsher exposure (vibration plus crash). **The practical limits here are face load and stability, not neck
injury.** About 312 g sits in front of the face (+96 mm, +0.30 N·m about the tragion from the front stack
alone). Run the HDO2 strap around the helmet, add a strap or bracket between the goggle and the helmet if
the goggles drop when you look down, and keep the front stack compact.

## 4. GoPro mount geometry and adhesive

- **I found no GoPro-published mount geometry.** The de facto dimensions from a community parametric
  library [V-comm: gopro_ridercz_GoPro.scad.txt, l.8–13, l.31, l.59; README] (F3):
  finger ("leg") thickness **3.0 mm**; slot **3.5 mm including print tolerance**; finger outer diameter
  **15 mm**; hole **M5** (5.0 mm + 0.5 mm print tolerance); joined by **M5 screw + square nut**. Base depth
  is 9.5 mm for the 2-finger male and 19 mm for the 3-finger female including the 3 mm nut guard (from the
  code, l.31 and l.59); M5 × 50 for the thumbscrew. Before printing, check one of Adam's real GoPro bases
  with calipers (Q8); the real moulded parts may differ from the library values by an amount I have no
  source for.
- PETG on the MK4: print the fingers flat, with the hole axis vertical, for interlayer strength in the
  clamp direction. This is my practice note, not a sourced claim.
- **Adhesive mount application (GoPro):** "Apply mount to a clean, smooth surface (non-porous and non-textured) and
  let it sit at room temperature for at least 24 hours" [V: gopro_AACFT-011_universal_adhesive_page.txt,
  l.154] (F1). Removal is by heating the bond [V: gopro_AACFT-001_product_page.txt] (F2). GoPro calls the
  tape "industrial-strength adhesive" and does not name 3M or VHB on either page.
  **The Curved + Flat set page gives no curvature radius or adhesive grade** (F2). Pick the base by fitting
  it to the shell, and check that the matte Protec finish is not textured, since GoPro asks for a
  non-textured surface.

## 5. Open questions / bench measurements for Adam

Q1. **AV jack:** use a 4-pole plug or the Fat Shark cable to confirm sleeve = GND and ring 2 = Video
    (inject CVBS with RX off and look for an image). Note which cable colour lands where.
Q2. **Power jack:** barrel OD/ID (5.5/2.1 mm?), centre polarity, and whether it latches.
Q3. **Front shell:** the fan location (front? top?) and its intake/exhaust direction; the fan grille
    diameter and its outline (photo plus calipers); open the Printables `262727_fan.stl` and
    `1073216_*.stl` against the goggles to see what they clamp. Usable flat area on the front:
    W × H × curvature.
Q4. Real HDO2 mass with and without the strap; the strap pocket's inside dimensions (for a 3S 18650 holder).
Q5. Distance from the eye/lens plane to the front of the shell (camera parallax for track 02/03), and
    the x position of the goggle CoG relative to your tragion when worn (a ruler from the ear notch).
Q6. **Module bay:** pinout with a multimeter, compared with GOOGLE_IO (1 = 5V, 3 = GND, 6 = VIDEO, 7–9 = CH
    lines). Measure the 5 V rail voltage with the Receiver switch on and off. Log the CH1–3 levels while
    pressing Channel ▲/▼. Measure the bay's slot dimensions for a dummy-module PCB.
Q7. **Helmet:** Protec model and mass (kitchen scale); shell curvature at the front and rear mount spots
    (radius gauge or profile gauge); finish (gloss/matte/textured); whether there is a visor.
Q8. One GoPro curved base and one flat base: finger thickness, gap, Ø15 boss, hole, base footprint,
    adhesive pad thickness.
Q9. Camera set real masses: AI box, Infra head, thermal head, cable lengths AI box ↔ heads (this decides
    whether the AI box can sit on the goggles or must go on the helmet).
Q10. Current on 3S at 12.6 V and 10 V: HDO2 alone (OLED power 50/75/100, fan low/high), then plus the
     camera. Confirms the 4–5 h runtime estimate.
Q11. Whether the HDO2 fan keeps the lenses clear at the night temperatures you will walk in, with the
     fan at the 3S "lowered" speed.

## Retrieved (read at source)

- `papers/FatShark_HDO2_Manual_RevC.pdf` (+ .txt) — Fat Shark HDO2 manual, FSV1123 Rev C, official help-centre copy
- `papers/FatShark_HDO_FSV1122_Manual_RevB.pdf` (+ .txt) — HDO v1 manual, used for contrast only
- `papers/FatShark_1071_DominatorHD_Spec_RevB.pdf` (+ .txt) — Dominator HD spec; sibling model, downloaded but **not cited** for any claim
- `papers/USAARL_HMD2009_Section-26-Chapter-17-Guidelines-for-HMD-design.pdf` (downloaded by a parallel track; read here, pp.827–831)
- `papers/Shivers_2018_NDIA_HSM.pdf` (+ .txt) — USAARL dismounted HSM slides
- `papers/Merkle_2005_APL_HSM.pdf` (+ .txt) — JHU APL Tech Digest 26(1)
- `papers/gopro_AACFT-011_universal_adhesive_page.html/.txt`, `papers/gopro_AACFT-001_product_page.html/.txt` — GoPro product pages
- `papers/gopro_ridercz_GoPro.scad.txt`, `papers/gopro_ridercz_README.md.txt` — GoProScad library (community)
- `papers/skaman82_fatshark_module_schematic_rev06.png`, `papers/skaman82_fatshark_module_README.md.txt`, `papers/skaman82_fatshark_module_hardware.h.txt` — Fat Shark-bay RX module (community)
- `papers/printables_hdo2_models.txt` + `papers/printables_stl/*.stl` (7 STLs from #262727, #1073216, #215826) — Printables community models
- Used from parallel tracks: `papers/bzbuas_tr1-220sl_product_page_en.txt`, `papers/ctrl_molicel_p28a.pdf`

## MISSING (not retrieved, no claim made)

- McEntire B.J. & Shanahan D.F. (1998), *Mass Requirements for Helicopter Aircrew Helmets*, USAARL Report 98-14.
  Primary source of the USAARL curves (used here only via Ch.17, Fig. 17-11). No DTIC accession found.
- Butler B.P. & Alem N.M. (1997), *Long-Duration Exposure Criteria for Head-Supported Mass*, USAARL 97-34 —
  https://apps.dtic.mil/sti/pdfs/ADA329484.pdf (DTIC returned "Under Maintenance"; no Wayback copy).
- Knox F.S. et al. (1991), the USAF "Knox box" criteria. Used only via Ch.17.
- USAARL TM 2019-11, *Preliminary HSM Performance Guidance for Dismounted Soldier Environments*. Limited release, not obtainable.
- Fat Shark official HDO2 module-bay pinout and expansion-bay/HT 3-pin pinout. None found.
- Fat Shark HDO2 mechanical drawing or STEP. None found. Fan location is not documented in the manual.
- Protec helmet mass (official spec sheet). No retailer listing was retrieved either.
- IntoFPV thread(s) claiming the HDO2 3.5 mm jack only *outputs* video (search snippet only; intofpv.com blocked curl).
  The official manual says "AV in/out" and describes using "the AV in", so this report follows the manual.
- Thingiverse and Cults HDO2 models: not searched via API (Thingiverse requires a token; Cults was not attempted).
  Only Printables was enumerated.

## Verification (adversarial check, 2026-11-03)

Method: every quoted passage was grepped in the `pdftotext` output of the cited file (or the saved page
text). The figures were checked on rendered pages: HDO2 manual pp.5, 6, 10, 11 and Ch.17 Fig. 17-11. The
Fig. 17-11 curve was re-digitised at 300 dpi. The STLs were measured with vertex circle fits. All
arithmetic was recomputed. Status after the check: still a **working draft**, waiting on the
measurements Q1–Q11. Where this report and the extracts disagree, the downloaded source governs.

**Confirmed verbatim and correctly used:** A1, A2, A4–A14 (HDO2 manual Rev C; the "(Rapid" truncation is
real in the PDF, p.11), B1–B2, C1–C8 (Ch.17 pp.827–831; reference-list entries for McEntire & Shanahan 1998
USAARL 98-14, Butler & Alem 1997 USAARL 97-34 and Knox et al. 1991 confirmed on the chapter's reference list,
txt l.1643, 1765, 1796), D1–D4 (slide numbers match), E1–E2 (p.76, p.82; frontal sled at 30/40 ft/s), F1–F3,
G1 (schematic viewed: GOOGLE_IO pins 1–9 as stated), H1–H6, I1–I2. AV plug drawing: Ground is next to the
plug body, so the order is sleeve = GND, ring 2 = Video, ring 1 = AudR, tip = AuL, as the report says.

**Arithmetic re-checked:** 320 mA × 7.5 V = 2.40 W; (770 − 320) mA × 7.5 V = 3.38 W; 3 × 4.35 V = 13.05 V;
3 × 10.3 Wh = 30.9 Wh; 3 × 46 g = 138 g; scenario sums 812 g / 975 g; CoG +37.0 / +13.9 / +46.1 mm; moments
0.295 / 0.133 / 0.441 N·m; front stack 312 g at +96.4 mm; reference cases −0.21 and +0.98 N·m. All correct
except the scenario-B moment.

**Changed:**
1. Scenario-B pitch moment: 0.14 → **0.13 N·m** (13 580 g·mm × g = 0.133 N·m), in the TL;DR, table and text.
   "Halves" changed to "more than halves".
2. Ports layout: the Expansion Bay is on the **same** side as the power port and AV jack (p.6 photo), not on
   the VRx-bay side.
3. Power-draw row and §1.3: "the bay delivered ≈3.4 W to an RX module" overstated what the source supports.
   The manual gives only the headset's total draw with a module, and the module name is truncated. Reworded
   to "the headset drew 450 mA ≈ 3.4 W more", and the "Rapidfire" name is no longer asserted.
4. Power budget: **the AI box has no power figure** in any retrieved source, so the "≤6 W" total and the
   4–5 h runtime were presented as firmer than they are. Restated as 5.7 W for the loads with a figure
   (a floor), 5.4 h before losses, and 4–5 h as an estimate pending Q10. Added that the fan speed rises with
   input voltage (A4).
5. Fig. 17-11 read-off: +40 mm is **≈1.5 kg**, not 1.6 kg. Added +30 mm ≈ 1.8 kg. Scenario A's
   comment now gives the allowance at its own CoG (≈1.6 kg at +37 mm) instead of the +95 mm value.
   Scenario C's comment now gives ≈1.4 kg at +46 mm.
6. Printables inference: `fan.stl` is a **square** frame (not a ring) and its tab is a 2-prong fork (not
   hinge fingers). The shared feature is a **20 × 20 mm 4-hole pattern** around a ≈24–25 mm opening, not a
   "round feature of roughly 20–25 mm". The fan identification is still only an inference (H7, Q3).
   Added the manual's unlabelled black vented block on top of the shell as a lead, with no claim about
   what it is.
7. Removed the unsourced claim that the Fat Shark AV order "does not match CTIA/OMTP". Removed the
   unsourced "±0.1–0.2 mm" moulding tolerance for GoPro fingers. Removed "retailer figures disagree"
   for the Protec mass, since no retailer page was retrieved.
8. GoPro base depths (9.5 / 19 mm incl. nut guard) are now cited to the `.scad` code (l.31, l.59), where
   they are actually derived. "GoPro does not publish" was softened to "I found no GoPro-published
   geometry". The heading and bullet no longer call the GoPro tape "VHB", because GoPro's pages say
   "industrial-strength adhesive" and do not name 3M or VHB.
9. 2S row: the HDO2 runs on 2S only "above 7 V" (a 2S pack goes down to 6.0 V).
10. Extracts file: corrected the G2 transcription ("GOGGLE CONTROL", not "GOOGLE CONTROL"), updated C5 with
    the re-digitised values, added the F2 adhesive wording, added the F3 code lines and added H7 (STL
    measurements).

**Kept, but flagged as inference or advice (no source claimed):** the ground-loop advice in §1.1, the
pack-voltage warning thresholds, the PETG print orientation, the battery-at-rear recommendation, the
frangible bracket idea and "pushing the CoG far back does not help either", which is an inference from E2.
These are design judgement and are labelled as such.

**Not verifiable here (left in MISSING):** USAARL TM 2019-11; the IntoFPV "output-only jack" thread; an
official HDO2 bay pinout, drawing or fan location; the Protec mass. No claim in the report rests on them.
The Fat Shark 1071 spec sheet is still downloaded but uncited.
