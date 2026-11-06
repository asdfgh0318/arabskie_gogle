# Extracts for research/09 (HDO2 open items from the web)

Retrieved 2026-11-06. All files are in `papers/hdo2_net/` unless a path says otherwise. Quotes are verbatim; "l." is the
line in the saved .txt/.md (HTML converted to text with tags stripped, one text node per line). Tags: [V] read at source
(manufacturer or primary doc), [V-comm] community source read at source, [img] read off an image (method given),
[STL] measured on a downloaded mesh with my own script (bounding box from the vertex list).

## G. GetFPV "Fatshark Dust Removal" (HDO2 disassembly), author Lawrence Ro, GetFPV Learn
URL https://www.getfpv.com/learn/fpv-diy-repairs-and-mods/fatshark-dust-removal/ . Direct fetch and web.archive.org were
refused (Cloudflare 403; Wayback "suspected abusive bot traffic"). **Text** obtained through the r.jina.ai reader
rendering of the live URL: `getfpv_fatshark_dust_removal_via_jina.md`. **Images not obtained** (403); their URLs are in
that file and in research/09 §5.
- G1 (l.6) [V-comm]: "In this article, we'll go over how to remove dust from your Fatshark HDO2 goggles in a safe, reliable manner."
- G2 (l.16) [V-comm]: tool list "Phillips screwdriver set".
- G3 (l.23) [V-comm]: "The faceplate can be removed by gently unclipping the sides and then lifting the plastic piece away from the goggles. Be very careful here, because if you pull from the wrong angle, one of the clips securing the faceplate may break!"
- G4 (l.27) [V-comm]: "removing the two screws which are located between the headphone jack and HDMI port, and the screw next to the power button. A thinner screwdriver is needed for this, since the screws are set deeply in the goggle case."
- G5 (l.33) [V-comm]: "Now, remove the top shell (the one with the channel/volume buttons). … One difficulty I had in this was removing the shell around the receiver module. I found that the shell had to be pressed at a certain angle to allow the headers to be removed."
- G6 (l.29, image captions): "Fatshark HDO2 disassembly: emptry module bay" (`module-bay.jpg`); "Face plate, bay cover and and shell screws" (`faceplate.jpg`); "upper shell with electronics" (`inside_1.jpg`).
- Note: the text never mentions unplugging a fan when the faceplate comes off.

## O. Oscar Liang
- O1 `oscarliang_open_up_hdo.txt` l.49 [V-comm] (HDO v1): "The steps should be similar on all the Fatshark Dominator line-up because they all have the same housing, including Fatshark Dominator V2, V3, SE, HD2, HD3 and HDO."
- O2 same file l.56, l.60 [V-comm]: "Carefully remove the faceplate. You will hear cracking like cracked plastic…"; "Flip the goggles over, you should find three screws on the bottom that you should take out."
- O3 [img] `oscarliang_hdo_img/fatshark-fpv-goggles-hdo-remove-face-plate-take-apart-open-case-housing.jpg` (HDO v1, 1200×800): the removed black faceplate carries the ribbed fan block at its top centre; crop `annotated/oscar_hdo_faceplate_removed_fanblock_crop3x.png`. The white body, faceplate off, shows only a slot and a small hole at the top centre (`annotated/oscar_hdo_body_top_gap_crop4x.png`). Read by eye; no measurement.
- O4 `oscarliang_fan_controller_upgrade.txt` l.70, l.72, l.75 [V-comm]: "This fan controller should work on any Fatshark FPV goggles with a faceplate fan, such as the dominator V2, V3, HD2, HD3 and HDO."; "The fan in the Fatshark goggles is built into the face-plate. There is no electrical connection to the main board, that's why you have to power it separately with the balance lead."; "Remove the only screw under the velcro, the piece of plastic that is covering the fan controller will fall off."
- O5 [img] already in repo: `papers/hdo2_front_img/oscarliang/fatshark-hdo2-fpv-goggles-control-buttons-oled.jpg` (HDO2 close-up). The four screws in the fan cover have **cross-recess (Phillips-type) pan heads**. The black cover sits in a U-shaped cut-out of the white top shell and its rear edge meets the black faceplate rim. Read by eye.

## F. Fan block on HDO2: shell or faceplate (video storyboards)
YouTube storyboards (sprite sheets of 160×90 px frames, 144 frames per video) from the player's storyboard spec;
`yt_storyboards/`. Video metadata verbatim in `youtube_hdo2_fan_videos.txt`.
- F1 [V-comm] TitanFPV, "Fatshark HDO2 Fan Repair", https://www.youtube.com/watch?v=GiXq9a81Ooc (285 s): "Easy in warranty fix for noisy fan in my Fatshark Dominator HDO 2s. Get the replacement fan here: https://www.banggood.com/custlink/GGmYImt29A". The link resolves to Banggood product 1235351, "Anti-Fog-Cooling-Fan-12V-9500RPM-For-FPV-Camera-Goggles-Pico-Projector".
- F2 [img, low resolution] `GiXq9a81Ooc_M3.jpg` tile row 3/col 4 (≈3:06), 6× enlargement `annotated/titanfpv_M3_r3c4_faceplate_off_rear_6x.png`: HDO2 seen from the face side **with the faceplate removed**. A black block remains at the top centre between the two button panels.
- F3 [img, low resolution] same sheet, row 2/col 3 (≈2:54), `annotated/titanfpv_M3_r2c3_shell_open_fan_6x.png`: shell opened; a small square fan with a red/black lead lies beside the opened shell.
- F4 [V-comm] DobreLoty, "#Fatshark #HDO2 - wentylator - fan repair", https://www.youtube.com/watch?v=3ZoWz2VKuyU (711 s). Sheets M2–M3 (≈5:00–8:10), `annotated/dobreloty_M2_faceplate_frames_4x.png`: the cover is removed with the faceplate still on. A square black frame with corner screw positions is exposed, and the rotor is pulled out of it.
- F5 [V-comm] `papers/hdo2_front_img/forums/intofpv_thread_25283.txt` l.36 (already in repo, re-read): "the original HDO2 VIN Board powers/controls the fan on the faceplate … doesn't have socket for the fan plug".
- F6 [V-comm] `flyingtech_fan_hub.txt` l.126: "It can be used with any of the Fat Shark FPV goggles with a Faceplate fan (excluding the new HDO2)."

## B. Replacement fan (Banggood 1235351)
`banggood_antifog_fan_p1235351.html/.txt`. The description loads by script and was not in the HTML; only the title is.
- B1 [V] title (l.59, PL locale): "Wentylator chłodzący zapobiegający parowaniu 12V 9500 obr/min dla gogli kamery FPV i projektora Pico". Meta description: "Ten wentylator 12 V działa z prędkością 9500 obr./min".
- B2 [img] `banggood_fan_img/montage.png`: a square-frame axial fan with four corner holes and a 2-wire red/black lead ending in a small white 2-pin plug. No scale reference, so no size.

## M. VRx module bay: modules and doors
- M1 [V] Fat Shark, `fatshark_site/fs_32ch-5g8-race-band-receiver-module.txt` l.17, l.25–26: "The 5.8 GHz Race Band RX Module for use with Fat Shark modular goggles …"; "Size: 42 x 25 mm"; "Weight: 8 g".
- M2 [V] `fatshark_site/fs_32ch-5-8gz-oled-receiver-module.txt` l.24: "Designed for use in the Dominator V2, V3, HD3 and Attitude V4 goggles" (HDO/HDO2 not listed).
- M3 [V-comm] skaman82 2.4 GHz Fat Shark module, https://github.com/skaman82/2.4GHz-Fatshark-Module (`skaman82_module/`). Eagle board `module_S-RX28_rev06_644.brd`, parsed with my own script:
  - board outline (layer 20) **43.18 × 27.94 mm**;
  - part `GOOGLE_IO`, package `1X09` (SparkFun), **9 pads at 2.54 mm pitch**, Ø1.016 drill. Placed mirrored, i.e. on the bottom side, at x = 38.1 (1.27 mm in from one 27.94 mm edge), pads y = 6.35…26.67.
- M4 [V-comm] wiki `skaman82_module/Home.md` l.46: "1x 2.54 Pin header - long version". `5.-Final-assembly.md` l.34: "The standard pin header is sadly too short, so we have to use the long version … They have to be 9 mm long. … Push carefully down until the module housing touches the RX bay back-wall."
- M5 [STL] skaman82 `Cover/Module_door_V2.stl` (same bbox as V1): **45.27 × 34.53 mm** face, curved in plan (sag ≈ 33 mm incl. internal plate). OLED window, SMA hole and button hole. Render `annotated/skaman82_door_V2_views.png`.
- M6 [V-comm + STL] Printables 360094, "Eachine PRO58 Fatshark Dominator HD3/HD2/HDO clip-on cover" (`printables_bay/360094…/printables_meta.txt` l.9, l.15): "It has clips which will prevent it from falling out of your fatsharks while you fly." / "I designed it for the Dominator HD3s, but it was also reported to fit HDOs". Onshape (l.20): https://cad.onshape.com/documents/a2967962b5a508897639f347/w/459fd354f5bb73a3797ccf08/e/fb2a5abfa35e43e2f6d2cb4c . STL bbox **49.0 × 33.7 × 13.0 mm**; render `annotated/p360094_pro58_clipon_views.png`.
- M7 [STL] Printables 641776 "Fatshark Dominator Module Door Bubbles" (remix of the OEM door, Thingiverse 1498439): **50.64 × 34.12 × 10.85 mm**, two inward hooks; render `annotated/p641776_dominator_oem_door_views.png`.
- M8 [STL] Printables 34883 "Fatshark RF Module Cover": 49.03 × 33.5 × 14.9 (left), 48.8 × 33.5 × 12.2 (right). Printables 430309 "Fatshark hd2 / hd3 Module Pro58 cover": 49.91 × 33.61 × 12.58.
- M9 [V-comm + STL] Printables 220634 "HD Zero Switch Module - Fatshark & Skyzone" (`printables_meta.txt` l.11): "Currently I have a design for the HDOs (Which will also fit, HD2, HD3, HDO2, Dominator etc)". Files include STEP. `Fatshark_Switch_Mod_C03.STL` bbox **45.43 × 33.8 × 26.7 mm** (curved door with clip tabs); render `annotated/p220634_fatshark_switch_mod_views.png`. Photos img1–img3 show it next to the goggles' barrel power jack, i.e. it replaces the **head-tracker/Expansion-bay door**, not the VRx door [img].
- M10 [V] already in repo, SpeedyBee goggles receiver manual (`papers/pod_place/…`, extracts_pod_placement S1–S4): HDO2 listed; "51x34x17.8"; "Align the receiver's pins with the female socket inside the goggles receiver compartment".

## P. Pro-Tec helmet
- P1 [V] official store JSON https://protecbrand.com/products.json?limit=250 (`protec/protecbrand_products.json`; selected texts in `protec/protecbrand_selected_texts.txt`). l.9: "Built around our Classic shape with added visor function, the Riot features …". l.13: "Multi-use Rear Mount Strap on Red, Orange, Blue helmets only. (Goggles, Head Light, Camera etc.)" (Ace Wake). Size bands, e.g. "S: 54-56cm | M: 56-58cm | L: 58-60cm | XL: 60-62cm".
- P2 [V, retailer] Kunstform, ProTec "Classic Certified", `protec/kunstform_protec_classic_certified_p17664.txt` l.1609: "0.44kg / 0.97lbs", with the retailer's own caveat (l.1616) that "weight specifications for BMX parts can vary and may not always be precise". l.1687: "combines an ABS outer shell with a with EBS foam".
- Nothing found on GoPro base position, brim-to-goggle geometry or shell curvature.

## X. Other
- X1 [V-comm] `intofpv_t-fat-shark-barrel-connector.txt` l.95 (voodoo614, 11 Oct 2020): "Fatshark barrel connector is 2.1mm x 5.5mm." (Same poster mentions HDO and Dom3. HDO2 not named.)
