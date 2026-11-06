# 09 — HDO2 open items: what the web adds (fan, VRx bay, Protec helmet, front/top geometry)

**WORKING DRAFT, 2026-11-06.** Every claim comes from a file in `papers/hdo2_net/`. Verbatim quotes, line numbers and
image methods are in `papers/extracts_hdo2_net.md` (codes G, O, F, B, M, P, X). **Where this report and a source
disagree, the source governs. ZALOZENIA.md governs the design.**

This report waits on two things:
- Adam's 30-second faceplate check (U1);
- the GetFPV teardown images, which could not be downloaded (§5).

It does not replace any measurement in research/06 §3 or research/07b §6.

Tags:
- [V]: manufacturer or primary document, read at source;
- [V-comm]: forum, blog, video description or community repo, read at source;
- [img]: read off an image, with the method given;
- [STL]: bounding box measured on a downloaded mesh with my own script;
- [A]: assumption.

## TL;DR

1. **The HDO2 fan may sit on the clip-on faceplate rather than the shell. This needs checking before the camera
   mount is finalised.**
   - On the **HDO (v1)** the fan is "built into the face-plate" [V-comm O4]. Oscar Liang's photo shows the fan block
     coming away with the removed faceplate [img O3].
   - For the **HDO2** the evidence conflicts:
     - a forum post calls it "the fan on the faceplate" [V-comm F5];
     - but the fan is plugged into the HDO2 VIN board inside the shell [V-comm F5];
     - and a (160 × 90 px) video frame shows the black fan block **still on the body after the faceplate is
       removed** [img F2].
   - If the block belongs to the faceplate, the camera adapter would hang on a clip-retained part. That threatens the
     ≤0.5° yaw rule (ZALOZENIA item 2).
   - **Adam: unclip the faceplate (GetFPV: "gently unclipping the sides", G3) and see whether the fan cover stays on
     the white shell.**
2. **Fan-cover screws: four cross-recess (Phillips-type) pan heads** [img O5].
   - The thread, length and head size are still **not found** anywhere online, so M1 stays.
   - GetFPV's HDO2 teardown lists only a "Phillips screwdriver set" [V-comm G2].
3. **Fan:**
   - The HDO2 replacement that a YouTuber linked is a **12 V, 9500 rpm** goggle fan [V B1]. It has a square frame,
     four corner holes and a 2-wire lead with a small 2-pin plug [img B2].
   - Its size is not stated on the retrievable page.
   - A Polish repair video shows a square fan frame directly under the cover, with the rotor pulled out while the
     faceplate stays on [img F4].
   - 25 × 25 mm stays the working value from research/06 A4 (community covers). No new source confirms it.
4. **VRx bay connector: 9 pins, 2.54 mm pitch, single row.**
   - The goggles have a **female socket inside the bay**; the module carries **male pins standing 9 mm off its PCB**,
     pushed in until the housing "touches the RX bay back-wall" [V-comm M3, M4].
   - This holds for the Dominator-family module standard. HDO2 compatibility of that standard comes from SpeedyBee
     listing the HDO2 and describing a "female socket" [V M10].
   - Module PCB footprint: **42 × 25 mm** (Fat Shark module, [V M1]) to **43.2 × 27.9 mm** (skaman82 board, [V-comm M3]).
5. **Bay door envelopes (Dominator family, not HDO2-specific):**
   - face **45–51 × 33.5–34.5 mm**, 10.9–14.9 mm deep (bounding boxes), retained by **inward clip hooks** [STL M5–M8];
   - a Pro58 clip-on cover "reported to fit HDOs" measures 49.0 × 33.7 × 13.0 and has an Onshape source [V-comm/STL M6];
   - the HDO2 door wraps the front corner (research/07b §1.3), so these doors bound the module, not the HDO2 door;
   - the best HDO2 bound is still SpeedyBee's **51 × 34 × 17.8 mm** [V M10].
6. **New precedent for the right-side Expansion bay (07b fallback c-R):**
   - Printables 220634 is a printed module made for HDO bays that the author says also fits HDO2 [V-comm M9];
   - it carries a DC jack and switch and comes with **STEP files**;
   - its door envelope is 45.4 × 33.8 × 26.7 mm [STL M9].
7. **Protec helmet:**
   - **nothing public** on GoPro-base position, brim-to-goggle geometry or front curvature;
   - the only number is a retailer mass of **0.44 kg** for the Pro-Tec Classic Certified, with the retailer's own
     caveat [V P2]. research/04 assumed 500 g;
   - Pro-Tec's own store says the Classic has no visor (the Riot is the "Classic shape with added visor") [V P1].
8. **Front face / top deck:** no official drawing, dimensioned image or HDO2 body CAD was found. research/06 and 08
   remain the best geometry.

## 1. HDO2 top fan (research/06 M1–M4)

| # | Item | Value | Source | Tier | Conf. |
|---|---|---|---|---|---|
| 1.1 | Cover screws, type | 4 × cross-recess pan head | HDO2 close-up `papers/hdo2_front_img/oscarliang/fatshark-hdo2-fpv-goggles-control-buttons-oled.jpg` (O5); GetFPV tools "Phillips screwdriver set" (G2) | [img] + [V-comm] | high (type); size none |
| 1.2 | Cover screws, thread / length / head | **not found** | — | — | — |
| 1.3 | Fan type | square-frame axial fan with corner holes; 2-wire lead with a small 2-pin plug; replacement sold as "12V 9500RPM" anti-fog fan | Banggood 1235351 title (B1), images (B2), linked from TitanFPV's HDO2 video (F1) | [V] title, [img] | medium (it is the fan one user chose, not Fat Shark's part) |
| 1.4 | Fan size | **not confirmed online**. Keep 25 × 25 (06 A4). A seller page stating "25mm x 25mm … HDO2" came up in search, but its domain does not resolve (uksparesandrepairs.com), so no claim | — | — | — |
| 1.5 | Electrical | HDO2 fan plugs into the VIN board ("socket for the fan plug"); HDO v1 fan had "no electrical connection to the main board" | F5; O4 | [V-comm] | high |
| 1.6 | Fan on faceplate or shell | **HDO v1: faceplate** (O3, O4). **HDO2: conflicting.** The forum wording says faceplate (F5). A TitanFPV frame shows the black block staying on the body with the faceplate off (F2). The fan cable goes to the VIN board in the shell (F5). The FlyingTech "faceplate fan" controller "excluding the new HDO2" (F6) | O3, O4, F2, F5, F6 | [V-comm] + [img] low-res | **unresolved: U1** |
| 1.7 | What is under the cover | a square fan frame with corner screw positions; the rotor lifts out with the cover off and the faceplate on | DobreLoty video ≈5–8 min (F4) | [img] low-res | medium-low |
| 1.8 | What is under the fan (opening, PCB) | **not found**. GetFPV `inside_1.jpg` ("upper shell with electronics") would show it but could not be downloaded | G6 | — | — |
| 1.9 | Seat tilt vs optical axis (M4) | **no source** | — | — | — |
| 1.10 | Shell construction (context for a shell-mounted adapter) | faceplate clips on at the sides. The top shell (with CH/VOL buttons) is clipped and held by 3 screws: two "between the headphone jack and HDMI port" and one "next to the power button" | G3, G4, G5 | [V-comm] | high |

Disassembly sources found and downloaded:
- GetFPV HDO2 teardown text (G);
- Oscar Liang HDO v1 teardown and fan-controller articles plus 8 photos (O);
- two HDO2 fan-repair videos: descriptions, thumbnails and storyboards (F).

Video frames are only 160 × 90 px, so they show arrangement, not dimensions.

## 2. VRx module bay (research/07b P1/P2)

| # | Item | Value | Source | Tier | Conf. |
|---|---|---|---|---|---|
| 2.1 | Connector | **9-pin single row, 2.54 mm pitch**. Female socket in the goggle, male pins on the module | skaman82 board `GOOGLE_IO` 1X09 (M3); "2.54 Pin header - long version" (M4); SpeedyBee "female socket" (M10); GetFPV "headers" between shell and module (G5) | [V-comm] + [V] | high (Dominator standard); HDO2 by compatibility |
| 2.2 | Pin length above module PCB | **9 mm**, set so "the module housing touches the RX bay back-wall" | M4 | [V-comm] | medium |
| 2.3 | Header position on the module PCB | along one 27.94 mm edge, centreline 1.27 mm in; pins 1.27…21.6 mm from one long edge; on the PCB underside | M3 (Eagle file parsed) | [V-comm] | medium (one design) |
| 2.4 | Module PCB footprint | 42 × 25 (Fat Shark race-band module); 43.18 × 27.94 (skaman82) | M1; M3 | [V]; [V-comm] | high |
| 2.5 | Module with casing, HDO2-compatible | 51 × 34 × 17.8 | M10 (already in 07b) | [V] | high |
| 2.6 | Dominator-family door envelopes | skaman82 door 45.3 × 34.5 (curved); OEM-door remix 50.6 × 34.1 × 10.9; RF covers 49.0 × 33.5; Pro58 covers 49.0 × 33.7 × 13.0 and 49.9 × 33.6 × 12.6 | M5–M8 | [STL] | high as modelled; **not HDO2 doors** |
| 2.7 | Retention | inward hooks on the door; "clips which will prevent it from falling out"; SpeedyBee "lock into place" | M6, M7, M10 | [V-comm]/[STL]/[V] | medium |
| 2.8 | Bay inner W × H × depth, HDO2 | **not found**. HDO v1 forum 44 × 32 × 13 stays (07b F1). The door heights above (33.5–34.5) agree with a ≈32 mm opening plus rim [A] | — | — | — |
| 2.9 | HDO2 door dimensions | **not found**. HDO v1 GrabCAD 42 × 38 (research/08) | — | — | — |
| 2.10 | Expansion (HT) bay precedent | printed DC-jack/switch module, "a design for the HDOs (Which will also fit, HD2, HD3, HDO2, Dominator etc)", STEP included; envelope 45.4 × 33.8 × 26.7 | M9 | [V-comm] + [STL] | medium (HDO2 fit per author) |

For the 07b pod, a pod with a 9-pin, 2.54 mm male header standing about 9 mm off its board engages the bay socket the
same way every commercial module does [V-comm]. The pinout still needs metering (P2).

## 3. Protec helmet front and GoPro base (research H1–H3)

| # | Item | Value | Source | Tier | Conf. |
|---|---|---|---|---|---|
| 3.1 | GoPro base position on Protec helmets relative to brim/goggles | **nothing found** | searches only | — | — |
| 3.2 | Front curvature radius / brim-to-strap geometry | **nothing found**. Pro-Tec publishes head-circumference size bands only (S 54–56 … XL 60–62 cm) | P1 | [V] | — |
| 3.3 | Visor on the Classic shape | none. The Riot is "Built around our Classic shape with added visor function" | P1 | [V] | high |
| 3.4 | Mass, Classic Certified | 0.44 kg (retailer, with caveat) | P2 | [V] retailer | medium |
| 3.5 | Camera mounting provisions | Ace Wake / Full Cut Water have a "Multi-use Rear Mount Strap … (Goggles, Head Light, Camera etc.)" at the rear, not the front | P1 | [V] | high |

So H1–H3 can only be measured on Adam's helmet.

## 4. Front face / top deck geometry beyond research/06 and 08

- No Fat Shark drawing, dimensioned image or HDO2 body CAD was found. The web search for HDO2 STEP, GrabCAD or
  Sketchfab models returned accessories only.
- **Side note on the power jack** (research/04 had it as a hint): "Fatshark barrel connector is 2.1mm x 5.5mm" [V-comm X1].
  The poster was talking about HDO and Dom3, not HDO2.
- **Side note on the model version, not verified:**
  - Retailer search snippets say the **HDO2.1** has a "new bottom shell" and revised IPD/focus buttons.
  - No page with that text could be downloaded (NextFPV 404, PhaserFPV served an unrelated page, GetFPV Cloudflare), so no claim.
  - Adam should check his label (HDO2 vs HDO2.1), because research/06 is based on HDO2 manual images.

## 5. Still unresolved, and what Adam can open in a browser

**U1 (most important, 30 s on the bench).** Unclip the faceplate. Does the fan cover stay on the white shell or come
away with the faceplate? This decides whether the camera adapter sits on the shell (good for yaw) or on a clip-on part.

Measurements still open from earlier tracks: research/06 M1–M5 and research/07b P1–P2.

Pages blocked to automated fetching. Save each from a browser, with images, into `papers/hdo2_net/`:

1. **GetFPV HDO2 teardown images** (Cloudflare 403; text already saved). The most useful are:
   - https://www.getfpv.com/learn/wp-content/uploads/2020/11/inside_1.jpg (upper shell with electronics, i.e. under the fan)
   - https://www.getfpv.com/learn/wp-content/uploads/2020/11/faceplate.jpg ("Face plate, bay cover and shell screws", which answers U1)
   - https://www.getfpv.com/learn/wp-content/uploads/2020/11/module-bay.jpg (empty HDO2 module bay, for P1)
   - https://www.getfpv.com/learn/wp-content/uploads/2020/11/faceplate_removed.jpg
   - also `inside_2.jpg`, `bottom_shell.jpg`, `power_board_top_view.jpg` in the same folder.
2. **RC Groups HDO2 thread**, the post by "Greg" on the fan plug:
   https://www.rcgroups.com/forums/showthread.php?3443485-Fatshark-Dominator-HDO2/page2#post43065531 . Automated access
   is routed to a paid gateway (TollBit), so I did not follow it.
3. **YouTube, watch at full resolution:**
   - https://www.youtube.com/watch?v=GiXq9a81Ooc at ≈2:50–3:10 (shell open, faceplate off);
   - https://www.youtube.com/watch?v=3ZoWz2VKuyU at ≈5:00–8:10 (cover off: screw heads, fan frame).
   Automatic captions were not downloadable.
4. **Banggood fan specification** (the description loads by script):
   https://www.banggood.com/Anti-Fog-Cooling-Fan-12V-9500RPM-For-FPV-Camera-Goggles-Pico-Projector-p-1235351.html .
   Look for the frame size and thickness.
5. **Onshape source of the HD3/HDO Pro58 clip-on cover**, which has clip geometry you could export:
   https://cad.onshape.com/documents/a2967962b5a508897639f347/w/459fd354f5bb73a3797ccf08/e/fb2a5abfa35e43e2f6d2cb4c
6. **Matek VRX-1G3-V2 (board "43*27mm" per a search snippet)**: http://www.mateksys.com/?portfolio=vrx-1g3-v2 . The
   site returned a Google page instead of the product page; not used.
7. **ImmersionRC rapidFIRE**: https://www.immersionrc.com/?p=5781 now reads "ImmersionRC has ceased trading". No
   dimension source remains. Retailer "8.5 × 9.5 × 3.5 cm" figures are packaging and were not used.
8. **Thingiverse** (all 403): 1498439 (OEM Dominator door), 3839719, 1236390 (module protector V2), 5801747 (HDO 1/2
   Walksnail fan mount).

## 6. Retrieved / not retrieved

**Retrieved and read** (all under `papers/hdo2_net/`):
- GetFPV text (`getfpv_fatshark_dust_removal_via_jina.md`, via the r.jina.ai reader);
- Oscar Liang HDO teardown and fan-controller pages, plus 8 photos (`oscarliang_*`);
- YouTube metadata, thumbnails and 12 storyboard sheets (`youtube_hdo2_fan_videos.txt`, `yt_*`);
- Banggood fan page and 3 images;
- FlyingTech fan-hub page;
- 4 Fat Shark product pages (`fatshark_site/`);
- skaman82 board, door STLs, wiki and images (`skaman82_module/`);
- 7 Printables bay models with metadata and images (`printables_bay/`);
- Pro-Tec official product JSON and a Kunstform retailer page (`protec/`);
- IntoFPV barrel-connector thread.

Renders and crops are in `annotated/`.

**Not retrieved:** see §5. An image-proxy attempt for the GetFPV images was refused by the permission system and not
retried.
