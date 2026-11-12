# papers/ — źródła researchu

Pliki źródłowe (PDF, zapisane strony, obrazy) są **tylko lokalnie** (`.gitignore`) — repo jest publiczne.
W repo są cytaty `extracts_*.md` (cytat + plik + strona) dla każdego tagu [V] w `research/`.
Wersjonowane są wyłącznie `extracts_*.md` i ten indeks.

## Stan katalogu (2026-11-11)

Indeks odtworzony z katalogu: 761 plików, z tego 221 bezpośrednio w `papers/` (w tym 10 `extracts_*.md` i ten plik)
oraz 540 w dziewięciu podkatalogach. Każdy dokument (PDF, zapisana strona, tekst) został otwarty
(pierwsza strona PDF, tytuł HTML, pierwsze linie tekstu) i opisany według tego, co zawiera. Obrazy i modele 3D są
policzone na katalog, bez wyliczania plików.

Konwencja: jeśli nie zaznaczono inaczej, obok każdego `.pdf`, `.html` i `.xml` leży plik `.txt` o tej samej nazwie —
tekst wyciągnięty z tego dokumentu; do niego odnoszą się numery linii w cytatach. Wyjątki są wypisane przy plikach.

Ten indeks jest pochodną katalogu i notatek w `research/`. Przy rozbieżności rozstrzygają one, nie indeks.

## Pliki, które nie są tym, co sugeruje nazwa

Sprawdzone 2026-11-11: `file` na wszystkich plikach (wtedy 762 z pustym `.gitkeep`, który został potem usunięty; dziś 761), `pdfinfo` na 58 PDF, test archiwów ZIP/3MF (11), otwarcie
252 obrazów, długość binarnych STL względem nagłówka, znacznik końca w plikach STEP.

| Plik | Co to jest naprawdę |
|---|---|
| `ctrl_attiny412_ds.pdf` | **Nie jest PDF-em.** 400 bajtów HTML, strona „Access Denied” serwera microchip.com. Karty katalogowej ATtiny212/412 nie ma (patrz „Nie pobrane”, research/05). |
| `hdo2_net/yt_storyboards/*.jpg` (12 plików) | Dane w formacie WebP z rozszerzeniem `.jpg`. Otwierają się poprawnie. |
| `hdo2_net/immersionrc_rapidfire_p5781.txt` | 214 bajtów: komunikat „ImmersionRC has ceased trading”, nie strona produktu rapidFIRE. |
| `hdo2_body_models/grabcad_fatshark-hdo-goggles-1/page.html` | Ogólna strona biblioteki GrabCAD (tytuł „Free CAD Designs, Files & 3D Models”); słowo „fatshark” w niej nie występuje. Dane modelu są w `api_model.json`, `api_files.json`, `comments.json`. Bez `.txt`. |
| `FatShark_HDO_FSV1122_Manual_RevB.pdf` | Instrukcja Dominator HDO (FSV1122). Nazwa pliku i tytuł w metadanych PDF mówią „RevB”, strona tytułowa — „Revision A 04/23/2018”. |
| `hdo2_body_models/measure/` | Pusty katalog. |

Kopie tego samego pliku (ta sama suma md5):
`pod_alps_EC11E_catalog.pdf` = `pod_Alps_EC11E_catalog_2510.pdf` = `pod_place/alps_product_catalog_ec_01_ec11e_en_611f078659.pdf`;
`pod_alps_EC11E09244BS_detail.html` = `pod_place/alps_EC11E09244BS_detail.html`;
cztery `render_<hash>.jpg` w katalogu GrabCAD = cztery `RENDERS/HDO RENDERING 0x.JPG` z archiwum.

Fałszywe alarmy `file`: `bzbuas_tr1-220sl_product_page_pl.html` i `hdo2_net/protec/kunstform_protec_classic_certified_p17664.html`
są rozpoznawane jako „JavaScript source”, ale to zwykłe strony HTML z tytułem. Kilka `.txt` wyciągniętych z PDF jest
rozpoznawanych jako „data” (znaki sterujące z `pdftotext`); są czytelne.

Nie znaleziono: plików zerowej długości, uszkodzonych PDF-ów, archiwów ani obrazów, uciętych STL/STEP.

## Mapa: plik cytatów → notatka

Według odwołań w `research/*.md` (grep `extracts_`, 2026-11-11).

| Plik cytatów | Notatka |
|---|---|
| `extracts_placement.md` | `research/01_camera_placement_parallax_latency.md` |
| `extracts_fov.md` | `research/02_fov_magnification_locomotion.md` |
| `extracts_camera.md` | `research/03_caddx_tr1_220sl_interface.md` |
| `extracts_hdo2.md` | `research/04_hdo2_helmet_mounting.md`; odwołuje się do niego też `research/06a_hdo2_front_images.md` |
| `extracts_controller.md` | `research/05_controller_power.md` |
| `extracts_gopro_dims.md` | `research/06c_gopro_dimensions.md` |
| `extracts_pod_components.md` | `research/07a_pod_components.md` |
| `extracts_pod_placement.md` | `research/07b_pod_placement.md` |
| `extracts_pod_ergonomics_mount.md` | `research/07c_pod_ergonomics_mount.md` |
| `extracts_hdo2_net.md` | `research/09_hdo2_net_open_items.md` |

Bez własnego pliku cytatów (żadnego `extracts_*.md` nie wymieniają): `research/06_hdo2_front_and_gopro.md`
(podsumowanie 06a–c), `research/06b_hdo2_front_models.md` (opisy autorów modeli są w `models_hdo2/<id>/printables_meta.txt`)
i `research/08_grabcad_hdo_measurements.md` (pomiar modelu skryptem `cad/test/grabcad_measure.py`).

## Pliki bezpośrednio w papers/

### Percepcja, przesunięcie kamery, opóźnienie, pole widzenia (research/01, 02)

| Plik | Co to jest |
|---|---|
| `Balachandran_2024_Auckland_MEng_HMD_gait_thesis.pdf` | B. K. Balachandran, „Navigating Virtual Realms: Discovering the Impact of Head-Mounted Displays on Human Gait…”, praca magisterska, University of Auckland, 2024 (107 s.) |
| `Bonnen_2021_SciRep_binocular_vision_foot_placement.pdf` | Bonnen i in., „Binocular vision and the control of foot placement during walking in natural terrain”, Scientific Reports (12 s.) |
| `CreemRegehr2003_restricted_viewing_distance_UUCS-03-016.pdf` | Creem-Regehr i in., „The Influence of Restricted Viewing Conditions on Egocentric Distance Perception”, raport UUCS-03-016, University of Utah, 2003 |
| `CuQlock-Knapp_2001_ARL-TR-2407_NVG_viewpoint_offset_grenade.pdf` | CuQlock-Knapp i in., „The Effects of Viewpoint Offsets of Night Vision Goggles on Human Performance in a Simulated Grenade-Throwing Task”, ARL-TR-2407, marzec 2001 |
| `Edwards_Rolland_Keller_1993_video_see-through_design.pdf` | Edwards, Rolland, Keller, „Video See-through Design for Merging of Real and Virtual Environments” (IEEE VRAIS 1993 wg metadanych PDF) |
| `Jansen2011_multiple_obstacle_VF_limitation_ExpBrainRes_PMC3127014.xml` | Jansen, Toet, Werkhoven, „Human locomotion through a multiple obstacle environment: strategy changes as a result of visual field limitation”, Exp Brain Res; XML z PMC |
| `Jerald_2010_latency_perception_thresholds_HMD_UNC_dissertation.pdf` | J. J. Jerald, „Scene-Motion- and Latency-Perception Thresholds for Head-Mounted Displays”, rozprawa doktorska, UNC Chapel Hill, 2010 (207 s.) |
| `Kuhl2008_VSS_poster.pdf` | Kuhl, Thompson, Creem-Regehr, „Angle of declination manipulations and their effects on distance judgments in virtual environments”, plakat (1 s.) |
| `Luo_Peli_2007_collision_judgment_minified_HMD_SPIE.pdf` | Luo, Lichtenstein, Peli, „Collision judgment when viewing minified images through a HMD visual field expander” |
| `McLean2023_minification_discomfort_wearable_optics_JVis_PMC10414133.xml` | McLean i in., „The contribution of image minification to discomfort experienced in wearable optics”, Journal of Vision; XML z PMC |
| `Mullins_2008_ADA505752_indirect_view_viewpoint_offset.pdf` | L. Mullins (ARL), „Development of Indirect View Sensor Systems: Effects of Viewpoint Offset on Human Performance” |
| `Park_2008_hand-eye_video_see-through_camera_displacement.pdf` | Park i in., „Hand-Eye Coordination Using a Video See-Through Augmented Reality System”, The Ergonomics Open Journal 2008, 1, 46–53 |
| `Penner_2026_arXiv2603.15796_low-latency_passthrough_requirements.pdf` | Penner i in. (Meta Reality Labs), „Perceptual Requirements for Low-Latency Head-Mounted Displays” (37 s.) |
| `Rolland_Biocca_1995_quantification_adaptation_virtual_eye.pdf` | Rolland, Biocca, „Quantification of Adaptation to Virtual-Eye Location in See-Thru Head-Mounted Displays”, VRAIS '95 |
| `Toet2008_FOV_human_locomotion_SPIE.pdf` | Toet i in., „Effects of Field of View on Human Locomotion”, Proc. SPIE 6955-16, 2008 |
| `Toet2008_FOV_manoeuvring_3D_Ergonomics.pdf` | Toet, Jansen, Delleman, „Effects of field-of-view restriction on manoeuvring in a 3-D environment”, Ergonomics |
| `Zhang2012_minification_distance_HMD_TAP.pdf` | Zhang i in., „Minification affects verbal and action-based distance judgments differently in head-mounted displays”, wersja autorska, ACM TAP 2012 |
| `USAARL_HMD2009_Section-10-Chapter-4-Visual-Helmet-Mounted-Displays.pdf` | Rash i in., rozdz. 4 „Visual Helmet-Mounted Displays” (66 s.) |
| `USAARL_HMD2009_Section-20-Chapter-12-Visual-Perceptual-Conflicts-and-Illusions.pdf` | Temme i in., rozdz. 12 „Visual Perceptual Conflicts and Illusions” (88 s.) |
| `USAARL_HMD2009_Section-24-Chapter-16-Perceptual-and-Cognitive-Effects-Due-to-Operational-Factors.pdf` | Rash i in., rozdz. 16 „Perceptual and Cognitive Effects Due to Operational Factors” (128 s.) |
| `USAARL_HMD2009_Section-26-Chapter-17-Guidelines-for-HMD-design.pdf` | Melzer i in., rozdz. 17 „Guidelines for HMD Design” (44 s.) |

### Termowizja i sygnał wideo (research/02, 03)

| Plik | Co to jest |
|---|---|
| `Axis_thermal_technology_glossary.pdf` | Axis, „Thermal technology glossary”, czerwiec 2018 (9 s.) |
| `Dahua_thermal_range_performance_DRI_V2.pdf` | Dahua, „Range Performance for DRI and IVS”, Thermal Imaging Technology Guide, V2.0, 2020.11 |
| `Mobotix_Johnson_criteria.pdf` | Mobotix, tabela zasięgów sensorów termowizyjnych wg kryteriów Johnsona (1 s.) |
| `ITU-R_BT.470-6_TV_systems.pdf` | Zalecenie ITU-R BT.470-6 „Conventional television systems” (36 s.) |
| `ITU-R_BT.601-7_digital_TV_studio.pdf` | Zalecenie ITU-R BT.601-7 (03/2011), parametry kodowania studyjnego TV cyfrowej (20 s.) |

### Kamera Caddx TR1-220SL / Eclipse i jej sterowanie (research/03)

| Plik | Co to jest |
|---|---|
| `ctrl_caddx_eclipse004dual_ft483dual.pdf` | Caddx „ECLIPSE 004 Dual”: schemat podłączenia i opis komunikacji szeregowej (1 s.) |
| `bzbuas_tr1-220sl_product_page_pl.html` | Strona produktu „Kamera termowizyjna Caddx TR1-220SL Dual”, BZB UAS (wersja polska) |
| `bzbuas_tr1-220sl_product_page_en.txt` | Tekst strony „Caddx TR1-220SL Dual Thermovision Camera”, BZB UAS (bez HTML) |
| `bzbuas_eclipse005sl_product_page.txt` | Tekst strony „Caddx Eclipse 005SL FT004-V3R Thermovision Camera”, BZB UAS (bez HTML) |
| `bzbuas_eclipse005sh_dual_product_page.txt` | Tekst strony „Caddx Eclipse 005SH Dual FT-D004A-V3 Thermovision Camera”, BZB UAS (bez HTML) |
| `bzbuas_*.png` (8 plików) | Obrazy z tych stron: wymiary, schemat połączeń, zawartość zestawu, porty, płytka ADKEY/OSD, render |
| `betaflight_*.txt` (6 plików) | Pliki źródłowe C z projektu Betaflight zapisane jako tekst (nagłówek „This file is part of Betaflight”): sterowanie kamerą (`camera_control`, 2 pliki), `pinio` (3 pliki), `piniobox` |

### Gogle Fat Shark HDO2 i moduł w zatoce (research/04, 05)

| Plik | Co to jest |
|---|---|
| `FatShark_HDO2_Manual_RevC.pdf` | Fat Shark Dominator HDO2, model FSV1123, instrukcja, Revision C 10/26/2019 (12 s.) |
| `FatShark_HDO_FSV1122_Manual_RevB.pdf` | Fat Shark Dominator HDO, model FSV1122, instrukcja (16 s.); rozbieżność rewizji — patrz wyżej |
| `FatShark_1071_DominatorHD_Spec_RevB.pdf` | „DominatorHD Specification Document Rev B 05/09/14” (1 s.) |
| `ctrl_hdo2_oscarliang.html` | Oscar Liang, „Review: Fatshark HDO2 FPV Goggles” |
| `ctrl_hdo2_fpv24.html` | FPV24.com, strona sklepu „FatShark Dominator HDO2 FPV Videobrille” |
| `skaman82_fatshark_module_README.md.txt` | README repozytorium skaman82/2.4GHz-Fatshark-Module (moduł RX28 do zatoki Fat Shark) |
| `skaman82_fatshark_module_hardware.h.txt` | Plik `hardware.h` z tego repozytorium (definicje pinów) |
| `skaman82_fatshark_module_schematic_rev06.png` | Schemat modułu, rev06 (obraz) |
| `printables_hdo2_models.txt` | Zrzut metadanych modeli Printables do HDO2 (ID, autor, URL, opis) |
| `printables_stl/` | 7 plików STL z Printables #262727, #1073216, #215826 |

### Masa na głowie (research/04)

| Plik | Co to jest |
|---|---|
| `Merkle_2005_APL_HSM.pdf` | Merkle, Kleinberger, Uy, „The Effects of Head-Supported Mass on the Risk of Neck Injury in Army Personnel”, Johns Hopkins APL Technical Digest 26(1), 2005 |
| `Shivers_2018_NDIA_HSM.pdf` | Shivers i in. (USAARL), „Preliminary Characterization of Head-Supported Mass Exposure in a Simulated Dismounted Operating Environment”, Army S&T Symposium and Showcase, 22.08.2018 (18 s.) |

### Uchwyt GoPro (research/04, 06c)

| Plik | Co to jest |
|---|---|
| `gopro_AACFT-001_product_page.html` | GoPro, strona produktu „Curved + Flat Adhesive Mounts” |
| `gopro_AACFT-011_universal_adhesive_page.html` | GoPro, strona produktu „Universal Adhesive Mount” |
| `gopro_ridercz_GoPro.scad.txt` | Biblioteka OpenSCAD „Altair's GoPro mounts library” 1.2.2 (ridercz/GoProScad), źródło jako tekst |
| `gopro_ridercz_README.md.txt` | README tej biblioteki |

Więcej źródeł GoPro jest w `gopro_dims/` (niżej).

### Sterownik i zasilanie — `ctrl_*` (research/05), 49 plików

| Plik | Co to jest |
|---|---|
| `ctrl_xiao_esp32c3_wiki.html` | Seeed Studio Wiki, „Getting Started with Seeed Studio XIAO ESP32C3” |
| `ctrl_xiao_esp32s3_wiki.html` | Seeed Studio Wiki, XIAO ESP32-S3 |
| `ctrl_xiao_nrf52840_wiki.html` | Seeed Studio Wiki, XIAO nRF52840 |
| `ctrl_xiao_rp2040_wiki.html` | Seeed Studio Wiki, XIAO RP2040 |
| `ctrl_xiao_samd21_wiki.html` | Seeed Studio Wiki, XIAO SAMD21 |
| `ctrl_waveshare_rp2040zero_product.html` | Waveshare, strona produktu RP2040-Zero |
| `ctrl_waveshare_rp2040zero_wiki.html` | Waveshare Wiki, RP2040-Zero |
| `ctrl_attiny412_ds.pdf` | **Strona błędu, nie karta katalogowa** (patrz wyżej); bez `.txt` |
| `ctrl_pololu_D24V5F5.html` | Pololu, przetwornica step-down 5 V 500 mA D24V5F5, strona produktu |
| `ctrl_pololu_D24V10F5.html` | Pololu, przetwornica step-down 5 V 1 A D24V10F5 |
| `ctrl_pololu_D36V6F5.html` | Pololu, przetwornica step-down 5 V 600 mA D36V6F5 |
| `ctrl_pololu_D36V6F9.html` | Pololu, przetwornica step-down 9 V 600 mA D36V6F9 |
| `ctrl_mini560_domoticx.html` | DomoticX, strona sklepu: moduł step-down mini560 (JW5068A), 5 V 5 A |
| `ctrl_molicel_p28a.pdf` | Molicel INR-18650-P28A, karta produktu (1 s.) |
| `ctrl_samsung_35E_rapid.pdf` | Samsung SDI, „Technical Report of INR18650-35E”, czerwiec 2015 (9 s.) |
| `ctrl_jst_GH.pdf` | JST, złącze GH 1,25 mm, karta katalogowa (6 s.) |
| `ctrl_omron_B3F.pdf` | Omron B3F, przycisk tact przewlekany, karta katalogowa (9 s.) |
| `ctrl_omron_B3S.pdf` | Omron B3S, uszczelniony przycisk tact SMT, karta katalogowa (3 s.) |
| `ctrl_alps_EC11.html` | Alps Alpine, strona serii enkoderów EC11E |
| `ctrl_alps_SKQU.html` | Alps Alpine, strona serii przełączników SKQU |
| `ctrl_adafruit_1201_vibration_motor.html` | Adafruit #1201 „Vibrating Mini Motor Disc”, strona produktu |
| `ctrl_adafruit_5358_magnetic_connector.html` | Adafruit #5358 „DIY Magnetic Connector - Right Angle Four Contact Pins”, strona produktu |

### Pod sterownika: elementy, ergonomia, mocowanie — `pod_*` (research/07a, 07b, 07c), 70 plików

Dokumenty:

| Plik | Co to jest |
|---|---|
| `pod_alps_EC11E_catalog.pdf` | Alps Alpine, katalog serii EC11E, update 2510 (2 s.) |
| `pod_Alps_EC11E_catalog_2510.pdf` | Ten sam plik (identyczna suma md5), zapisany przez inny wątek |
| `pod_alps_EC111_catalog.pdf` | Alps Alpine, katalog serii EC111, update 2510 (2 s.) |
| `pod_alps_EC11M_catalog.pdf` | Alps Alpine, katalog serii EC11M, update 2510 (2 s.) |
| `pod_alps_EC11E09244BS_detail.html` | Alps Alpine, strona produktu EC11E09244BS |
| `pod_alps_EC111_series_page.html`, `pod_alps_EC11B_series_page.html`, `pod_alps_EC11G_series_page.html`, `pod_alps_EC11J_series_page.html`, `pod_alps_EC11K_series_page.html`, `pod_alps_EC11M_series_page.html`, `pod_alps_EC11N_series_page.html` | Alps Alpine, strony serii enkoderów EC111/EC11B/G/J/K/M/N (wg adresu kanonicznego; strony bez tytułu); bez `.txt` |
| `pod_alps_encoders_metal_shaft_list.html` | Alps Alpine, lista enkoderów z metalową osią; bez `.txt` |
| `pod_bourns_PEC11R.pdf` | Bourns, „PEC11R Series - 12 mm Incremental Encoder”, karta katalogowa (4 s.) |
| `pod_adafruit_1201_P1012_datasheet.pdf` | Specyfikacja silnika wibracyjnego, model 10B27.3018, chińsko-angielska, 2011 (12 s.) |
| `pod_pololu_D36V6x_dimensions.pdf` | Pololu, rysunek wymiarowy przetwornic D24V3Fx / D24V6Fx / D36V6Fx (2 s.) |
| `pod_pololu_D36V6F5_resources_page.html` | Pololu D36V6F5, zakładka z zasobami; bez `.txt` |
| `pod_pololu_D36V6x_drill_DXF.zip` | Pololu, szablony wierceń DXF (`reg04a-drill.dxf`, `reg04b-drill.dxf`) |
| `pod_seeed_xiao_esp32c3_product_page.html` | Seeed Studio, strona produktu XIAO ESP32C3 |
| `pod_seeed_xiao_esp32c3_DXF.zip` | Seeed, DXF płytki (`top.dxf`, `bottom.dxf`) |
| `pod_seeed_xiao_esp32c3_v1.2_dimensioning_DXF.zip` | Seeed, „XIAO ESP32C3 v1.2 Dimensioning.dxf” |
| `pod_seeed_xiao_esp32c3_v1.3_kicad.zip` | Seeed, schemat i PCB XIAO ESP32C3 v1.3 (KiCad) |
| `pod_MIL-STD-1472H_2020_human_engineering.pdf` | MIL-STD-1472H, „Design Criteria Standard: Human Engineering”, 15.09.2020 (456 s., kopia z everyspec.com) |
| `pod_NASA_HIDH_SP-2010-3407_Rev1.pdf` | NASA/SP-2010-3407 Rev 1, „Human Integration Design Handbook”, 05.06.2014 (1301 s.) |
| `pod_3M_VHB_5952_TDS_2022-10.pdf` | 3M VHB Tape 5952, karta techniczna, październik 2022 (9 s.) |
| `pod_3M_VHB_5952_TDS_2024-08_digikey.pdf` | 3M VHB Tape 5952, karta techniczna, sierpień 2024 (5 s.) |
| `pod_3M_VHB_5952_TDS_2019-04_startsafety.pdf` | 3M VHB Tape 5952, karta techniczna, kwiecień 2019 (9 s.) |
| `pod_3M_VHB_4910_TDS_2018-08_tbp.pdf` | 3M VHB Specialty Tape 4910, karta techniczna w wydaniu TBP Converting (10 s.) |
| `pod_3M_VHB_SGT_B23F_G23F_TDS_2014.pdf` | 3M VHB Structural Glazing Tapes B23F / G23F, dane techniczne, sierpień 2014 (4 s.) |
| `pod_3M_VHB_cold_temperature_bulletin_2002.pdf` | 3M, biuletyn „VHB Tape Cold Temperature Performance”, styczeń 2002 (2 s.) |
| `pod_3M_VHB_tape_design_guide.pdf` | 3M, „VHB Tape Design Guide” (20 s.) |
| `pod_Prusament_PETG_TDS_v1.1_2022.pdf` | Prusa Polymers, karta techniczna Prusament PETG, wersja 1.1, 16.02.2022 (3 s.) |
| `pod_Bayer_SnapFit_Joints_for_Plastics_2005.pdf` | Bayer, „Snap-Fit Joints for Plastics” (26 s.; pierwsza strona to sam obraz) |

Obrazy (17 PNG): `pod_render_*.png` (13) — wyrenderowane strony i rysunki z powyższych kart (Alps, Bourns, JST GH,
Omron B3S, Pololu, Adafruit 1201, DXF XIAO); `pod_alps_EC11E09244BS_detail_dimensions.png`,
`pod_alps_EC11E09244BS_detail_mounting_holes.png`, `pod_alps_EC11E_shaft_varieties.png` — rysunki ze stron Alps;
`pod_seeed_xiao_esp32c3_front_pinout.png` — pinout ze strony Seeed.

## Podkatalogi

| Katalog | Plików | Rozmiar | Notatka | Zawartość |
|---|---|---|---|---|
| `gopro_dims/` | 90 | 27 MB | 06c | 48 txt, 16 STL, 6 JPG, 4 STEP/STP, 3 3MF, 3 HTML, 2 F3D, 1 SLDPRT, 1 PDF, 1 JSON, 4 skrypty .py (+ 1 .pyc) |
| `hdo2_front_img/` | 90 | 22 MB | 06a | 68 obrazów, 9 HTML, 9 txt, 3 JSON, 1 PDF |
| `models_hdo2/` | 95 | 35 MB | 06b | 14 katalogów modeli Printables + `README.md` |
| `models_hdo2_measure/` | 15 | 4 MB | 06b | 9 skryptów .py, 4 PNG, 2 STL |
| `hdo2_body_models/` | 87 | 236 MB | 08 | 27 katalogów `printables_*`, model GrabCAD, metadane Onshape, `sources.txt` |
| `pod_place/` | 17 | 3,3 MB | 07b | 2 PDF, 3 HTML, 5 txt, 6 GIF, 1 PNG |
| `pod_ergo_img/` | 9 | 1,8 MB | 07c | 9 PNG |
| `hdo2_net/` | 130 | 60 MB | 09 | 8 podkatalogów + 15 plików |
| `printables_stl/` | 7 | 0,4 MB | 04 | 7 STL (wymienione wyżej) |

### gopro_dims/ (research/06c)

Źródła wymiarów uchwytu GoPro. Cytaty: `extracts_gopro_dims.md`.

- Kod OpenSCAD z GitHuba zapisany jako tekst (`*.scad.txt`, `*_README.md.txt`): j-h-a (`jha_*`, 10 plików),
  MoonCactus (2), mbugert (2), connector-foundry (3), justcoding (2), leonardchrist (1), lucasgelfond (1).
- `printables_<id>.txt` (21 plików) — metadane modeli Printables (ID, autor, URL, licencja, opis);
  `printables_93976_gopro-size.txt` — plik z modelu #93976; pliki modeli (STL/3MF/STEP/STP/F3D/SLDPRT) dla 13 z nich.
- `patent_US9423673B2.html`, `patent_US10642133B2.html` — patenty GoPro „Quick-release ball-and-socket joint camera mount”.
- `instructables_3D-Printed-GoPro-Mount.json` + `.txt` — artykuł Instructables „3D Printed GoPro Mount”;
  `instructables_freeza36_sketches/` — 6 zdjęć odręcznych szkiców z wymiarami.
- `briandorey_gopro-mounts.pdf` — rysunek „GoPro Handlebar Mount for 31.8mm handlebars” (1 s.); bez `.txt`.
- `web_www_multitronic_fi_en_products_1454591.html` — strona sklepu Multitronic „Rollei Safety Pad”.
- `measurements_raw.txt` — surowe wyniki własnych pomiarów siatek (rzutowanie promieni); `_measure_tools/` — skrypty
  pomiarowe (`mesh.py`, `curvefit.py`, `render.py`, `run_all.py`).

### hdo2_front_img/ (research/06a)

- `manual/` — 17 PNG: strony i obrazy wyciągnięte z `FatShark_HDO2_Manual_RevC.pdf`.
- `fatshark/` — strony fatshark.com „HDO2” i „Black Fan-Equipped Face Plate” (2 HTML, bez `.txt`), 6 zdjęć produktu,
  `media_list.txt` (lista pobranych obrazów).
- `oscarliang/` — 12 obrazów z recenzji HDO2 Oscara Lianga, `urls.txt` (adresy obrazów).
- `forums/` — 6 wątków IntoFPV w wersji do druku (HTML + txt): 9760 „Goggles Fatshark HDO2”, 11158 „HDO fan doesn't
  work”, 17022 „Fan speed of DJI Goggles V2”, 22535 „Fatshark HD3 gray-ish screen”, 25283 „Burned MOSFET on Fatshark
  HDO2”, 25541 „Can FS HD3's be repaired?”.
- `printables/` — 28 zdjęć modeli Printables i 3 odpowiedzi API (`api_<id>.json`: #1073216, #215826, #262727).
- `fan_ref/` — `SameSky_CFM-25CF_datasheet.pdf` (Same Sky / CUI Devices, seria CFM-25CF, wentylator osiowy 25 × 25 mm,
  6 s.), strona produktu CFM-2507CF-0100-240-20 (HTML, bez `.txt`), 1 PNG.
- `annotated/` — 4 PNG: własne opisane kadry (widok z góry, z przodu, z tyłu).

### models_hdo2/ i models_hdo2_measure/ (research/06b)

`models_hdo2/README.md` jest manifestem (tytuł, autor, URL, lista plików z md5). 14 katalogów `<id>_<nazwa>/`, w każdym
`printables_meta.txt` (metadane i opis autora), pliki modelu i pierwsze zdjęcia; razem 24 STL, 4 STEP/STP/IGES, 1 3MF,
1 SCAD, 48 obrazów. Modele: #1028925, #1073216, #1179662, #182674, #215826, #21863, #21866, #262727,
następnie #279676, #370383, #472353, #569776, #570569 i #96977. Dwa katalogi mają `SOURCES.txt` (#182674, #96977 — odsyłacze do pierwowzorów na
Thingiverse).

`models_hdo2_measure/` — własne narzędzia i wyniki: 9 skryptów .py (wczytywanie siatek, przekroje, promienie, pobieranie
z API Printables, konwersja STEP→STL), 2 STL po konwersji (`1179662_sleeve.stl`, `569776_antenna_mod.stl`), 2 arkusze
renderów, 2 opisane kadry strony 5 instrukcji.

### hdo2_body_models/ (research/08)

Poszukiwanie modelu całego korpusu gogli. `sources.txt` — rejestr: 27 modeli Printables (ID, tytuł, URL, autor,
licencja), wynik przeszukania innych serwisów i weryfikacja (żaden pobrany model Printables nie jest całym korpusem HDO2).

- `grabcad_fatshark-hdo-goggles-1/` (14 plików + `cad/`) — model „Fatshark HDO goggles”, autor Aisak, GrabCAD,
  2019-05-31. **To oryginalne HDO, nie HDO2, a autor zastrzega, że wymiary i geometria nie są rzeczywiste.** Lokalnie są:
  `fatshark-hdo-goggles-1.snapshot.1.zip` (36 MB), jego rozpakowana kopia `cad/Fatshark HDO (GRABCAD)/` (`FATSHARK HDO
  ASSEMBLY.STEP` 21 MB, `.SLDPRT` 8 MB, 4 rendery) oraz `hdo_grabcad_goggle_frame.stl` (4,2 MB) — siatka używana przez
  `cad/scene_all.scad` i `research/08`. Do tego metadane (`api_model.json`, `api_files.json`, `comments.json`,
  `renders_list.txt`), 7 obrazów i `page.html` (patrz „Pliki, które nie są tym…”). Sposób pozyskania archiwum
  i wykonania STL nie jest zapisany w `sources.txt`.
- `onshape_a2967962b5a508897639f347/` — metadane dokumentu Onshape „PRO58 case” (`doc.json`, `elements.json`)
  i miniatura. Sama geometria nie została pobrana (wg `sources.txt` eksport wymaga logowania); to osłona modułu, nie korpus.
- `printables_<id>/` (27 katalogów, 63 pliki) — akcesoria do gogli Fat Shark / Walksnail: 52 STL, 7 STEP/STP,
  1 IGES, 1 3MF, 2 PNG.
- `measure/` — pusty.

### pod_place/ (research/07b)

- `speedybee_5g8_goggles_receiver_manual_EN.pdf` — „SpeedyBee 5.8GHz Goggles Receiver User Manual” (15 s.).
- `alps_product_catalog_ec_01_ec11e_en_611f078659.pdf` — katalog Alps EC11E, update 2510 (kopia `pod_alps_EC11E_catalog.pdf`);
  tekst w `alps_EC11E_catalog.txt`; `alps_EC11E_p2-2.png` — render strony 2.
- `alps_EC11E09244BS_detail.html` — strona produktu Alps EC11E09244BS (kopia pliku z `papers/`).
- `alps_product_detail_fig_ec11_*.gif` (6) — rysunki ze strony produktu Alps.
- `intofpv_thread_7613_module_bay_size.html` — IntoFPV, „How big is a Fatshark module bay?” (wersja do druku).
- `intofpv_thread_24557_speedybee_module.html` — IntoFPV, „SpeedyBee 5.8GHz FPV Goggles Receiver Module (Analog)”.

### pod_ergo_img/ (research/07c)

9 PNG — własne rendery stron i rysunków, z których odczytano wartości [img]: MIL-STD-1472H (s. 34, 70, 71), 3M VHB 5952
(wykresy z kart 2019 i 2024), Alps EC11E (2 rysunki), Omron B3S (wymiary), Bayer (tabela 1).

### hdo2_net/ (research/09)

Pobrane 2026-11-06. Cytaty: `extracts_hdo2_net.md`.

- `getfpv_fatshark_dust_removal_via_jina.md` — tekst artykułu GetFPV „Fatshark Dust Removal” pobrany przez czytnik
  r.jina.ai (sam tekst, bez zdjęć — zdjęcia są w „Nie pobrane”).
- `oscarliang_open_up_hdo.html` — Oscar Liang, „How I Opened Up Fatshark Goggles (HDO) and Replaced DVR Board”;
  `oscarliang_fan_controller_upgrade.html` — „Fatshark Goggles Fan Controller Upgrade”; `oscarliang_hdo_img/` — 8 zdjęć.
- `flyingtech_fan_hub.html` — Flying Tech, „Fan Hub Speed Controller Module for Fat Shark Dominator HD3 HDO”.
- `banggood_antifog_fan_p1235351.html` — Banggood (wersja polska), wentylator przeciw parowaniu 12 V 9500 obr/min;
  `banggood_fan_img/` — 7 obrazów.
- `intofpv_t-fat-shark-barrel-connector.html` — IntoFPV, wątek „Fat Shark barrel connector”.
- `immersionrc_rapidfire_p5781.txt` — komunikat o zakończeniu działalności (patrz „Pliki, które nie są tym…”).
- `youtube_hdo2_fan_videos.txt` — metadane i opisy dwóch filmów YouTube o naprawie wentylatora HDO2 (TitanFPV,
  DobreLoty); `yt_*_thumb.jpg` (2) — miniatury; `yt_storyboards/` — 12 arkuszy klatek (WebP z rozszerzeniem `.jpg`).
- `fatshark_site/` — 4 strony fatshark.com (HTML + txt): „32CH 5.8GZ OLED Receiver Module”, „32CH 5G8 Race Band
  Receiver Module”, „8CH 2G4 Receiver Module”, „Dominator and Attitude Ultimate Fit Kit”.
- `skaman82_module/` (19 plików) — repozytorium skaman82/2.4GHz-Fatshark-Module: 7 stron wiki (`.md`), płytka Eagle
  `module_S-RX28_rev06_644.brd` i archiwum `module_S-RX28_rev06_644_2019-08-08.zip`, 3 STL drzwiczek, 7 obrazów.
- `printables_bay/` — 7 modeli Printables osłon i drzwiczek zatoki (#34883, #220634, #360094, #430309, #641776,
  #747827, #747830): w każdym katalogu `printables_meta.txt`, pliki modelu, zdjęcia; razem 47 plików.
- `protec/` — `protecbrand_products.json` (odpowiedź `protecbrand.com/products.json`), `protecbrand_selected_texts.txt`
  (wypisy z niej), strona sklepu Kunstform „ProTec Classic Certified Helmet” (HTML + txt).
- `annotated/` — 10 PNG: własne kadry i rendery.

## Nie pobrane

Zebrane 2026-11-11 z sekcji MISSING / „Not retrieved” notatek w `research/`. Notatka rozstrzyga; tu są tylko pozycje,
których status notatka podaje jednoznacznie. Pozycje typu „nie znaleziono żadnego źródła” (np. rysunek Fat Shark
korpusu HDO2, pinout zatoki, wymiary oryginalnej śruby GoPro) zostają w notatkach i nie są tu powtarzane.
Dopisek „*stan katalogu:*” pochodzi z tego indeksu, nie z notatki.

### research/01 (przesunięcie kamery, opóźnienie)

- Biocca & Rolland 1998, „Virtual eyes can rearrange your body…”, *Presence* 7(3):262–277, doi:10.1162/105474698565703.
- Melzer & Moffitt 2007, „Sensor-offset HMD perception and performance”, Proc. SPIE 6557, 65570G, doi:10.1117/12.721156 — dostęp zamknięty.
- Lee & Park 2020, „Visuomotor adaptation to excessive visual displacement in video see-through HMDs”, *Virtual Reality* 24:211–221, doi:10.1007/s10055-019-00390-0 — dostęp zamknięty; notatka wskazuje ją jako najważniejszą do zdobycia.
- Lee & Park 2014, „The effects of visual displacement on simulator sickness in video see-through HMDs”, ISWC 2014, doi:10.1145/2634317.2634339 — dostęp zamknięty.
- State, Keller & Fuchs 2005, ISMAR 2005 s. 28–31, https://www.cs.unc.edu/~andrei/pubs/2005_ISMAR_VSTHMD_design.pdf — 404; kopia Wayback ucięta.
- Redden i in. 2005, ARL-TR-3536 — nie znaleziono.
- Carstens, Bonnett & Redden 2006, ARL-TR-3839, DTIC ADA453392, https://apps.dtic.mil/sti/pdfs/ADA453392.pdf — DTIC niedostępny.

### research/02 (pole widzenia, powiększenie)

- Collewijn, Martins & Steinman 1983, *J Physiol* 340:259–286, doi:10.1113/jphysiol.1983.sp014762, PMC1199209 — PMC zablokowane (reCAPTCHA).
- Jansen, Toet & Werkhoven 2011, *J Motor Behav* 43(1):55–62, doi:10.1080/00222895.2010.533593; https://repository.tno.nl/islandora/object/uuid:d8cc0bea-4807-4049-a05d-31d0c2e51aae („on request”).
- Chapman, Scally & Elliott 2011, *Ophthalmic Physiol Opt* 31:311–317, doi:10.1111/j.1475-1313.2010.00807.x — dostęp zamknięty.
- Roscoe 1984, *Human Factors* 26(6):617–629 — SAGE; raporty DTIC zwracają 403.
- Kuhl, Thompson & Creem-Regehr 2009, *ACM TAP* 6(3):19 — przeczytano tylko plakat z 2008.
- Hassan, Hicks, Lei & Turano 2007, *Vision Research* 47:2115–2123 (ScienceDirect).
- Alfano & Michel 1990, *Percept Mot Skills* 70:35–45 (SAGE).
- Leonardo DRS, „The truth about range data” (MR-2014-10-683), https://www.leonardodrs.com/media/10494/201705_truth_about_rangedata_mr-2014-10-683_rev02.pdf — 404.
- Jansen, Toet & Delleman 2010, *Ergonomics Open Journal* 3:19–24.

### research/03 (kamera Caddx)

- Strony produktów i pobierania caddxfpv.com (TR1-220SL / Eclipse 005SL / 004 Dual), https://caddxfpv.com/ — HTTP 429.
- Instrukcja Caddx Eclipse 002 z „Serial Commands”, https://manuals.plus/m/f461c0ac55da8b8ec844e0856adacaaf20dcf0f7230f0be54a679e5dc1b7932e — 403; notatka wskazuje ją jako najcenniejszy brak (druga, niezależna kopia protokołu).
- Instrukcja Caddx Eclipse 006HD, https://manuals.plus/caddxfpv/006hd-camera-eclipse-thermal-kit-manual — 403.
- Instrukcja Caddx Eclipse 009HD, https://manuals.plus/ae/1005010729144159 — 403.
- GetFPV, strona Eclipse 005SL, https://www.getfpv.com/eclipse-005sl-thermal-analog-camera-system.html — 403.
- Unmanned Tech Shop (429 lub nie próbowano):
  https://www.unmannedtechshop.co.uk/blogs/knowledge-base/caddx-phynan-thermal-fpv-camera-buying-guide ,
  https://www.unmannedtechshop.co.uk/blogs/knowledge-base/caddx-eclipse-005sl-vs-005sl-dual-which-thermal-camera ,
  https://www.unmannedtechshop.co.uk/products/caddx-eclipse-005sh-dual-thermal-visible-light-fpv-camera-ft-d004a-v3

### research/04 (HDO2, kask, masa)

- McEntire & Shanahan 1998, *Mass Requirements for Helicopter Aircrew Helmets*, USAARL Report 98-14 — nie znaleziono numeru DTIC.
- Butler & Alem 1997, *Long-Duration Exposure Criteria for Head-Supported Mass*, USAARL 97-34, https://apps.dtic.mil/sti/pdfs/ADA329484.pdf — DTIC „Under Maintenance”.
- USAARL TM 2019-11, *Preliminary HSM Performance Guidance for Dismounted Soldier Environments* — ograniczona dystrybucja.
- Wątek IntoFPV o gnieździe 3,5 mm HDO2 (tylko wyjście wideo) — znany wyłącznie z wyniku wyszukiwania; notatka trzyma się instrukcji.
- Modele HDO2 na Thingiverse i Cults — w tej notatce nie przeszukane (dalszy ciąg: research/06b niżej).

### research/05 (sterownik, zasilanie)

- Espressif, karta katalogowa ESP32-C3, https://www.espressif.com/sites/default/files/documentation/esp32-c3_datasheet_en.pdf — nie próbowano; wg notatki potrzebna przed ustaleniem dzielnika.
- Microchip ATtiny212/412, DS40001911, https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny212-412-DS40001911B.pdf — zwrócił HTML (to jest `ctrl_attiny412_ds.pdf`).
- Waveshare RP2040-Zero, rysunek wymiarowy — tylko obraz na https://www.waveshare.com/wiki/RP2040-Zero.
- Mini560 / JW5068A, karta producenta (Joulwatt); https://aws.robu.in/wp-content/uploads/2023/07/DE077-DE080.pdf — nie pobrał się.
- C&K KSC6, https://www.ckswitches.com/media/1972/ksc6.pdf — zwrócił HTML.
- Alps SKRH, https://tech.alpsalpine.com/e/products/category/multi-control-devices/sub/01/series/skrh/ — „AccessDenied”.
- MIL-STD-1472H — w notatce 05 jako brak (adres everyspec 404). *Stan katalogu:* plik jest teraz w `pod_MIL-STD-1472H_2020_human_engineering.pdf` (pobrany przez wątek 07; tak też podaje research/07b).
- DTIC ADA256894, „Gloved Operator Performance Study”, https://apps.dtic.mil/sti/pdfs/ADA256894.pdf — zwrócił HTML (zablokowane); to samo w research/07c.
- Wątek IntoFPV o alarmie 6,8 V HDO2, https://intofpv.com/printthread.php?tid=24767 — tylko wynik wyszukiwania; wg notatki niepotrzebny (próg jest w instrukcji, s. 8).

### research/06a (zdjęcia przodu HDO2)

- GetFPV, „Fatshark dust removal” (rozbiórka HDO2), https://www.getfpv.com/learn/fpv-diy-repairs-and-mods/fatshark-dust-removal/ — Cloudflare 403. *Stan katalogu:* sam tekst jest w `hdo2_net/getfpv_fatshark_dust_removal_via_jina.md` (research/09); zdjęć nadal brak.
- GetFPV, recenzja HDO2, https://www.getfpv.com/learn/fpv-product-reviews-and-comparisons/fat-shark-hdo2-fpv-goggles/ — ta sama blokada.
- Post „Greg” na RC Groups o wtyczce wentylatora HDO2 — nie otwierano (adres w research/09 niżej).
- Galerie sklepów (getfpv, team-blacksheep, racedayquads, nextfpv, fpv24) — nie pobierano.

### research/06b (modele przodu HDO2)

- Thingiverse: thing:128718, thing:1109091, thing:1163521, thing:1242876 oraz pierwotna osłona wentylatora Xerpocalypse (ID nieznane) — HTTP 403 (Cloudflare).
- Cults3D: :349552, :482718, :1082638 — HTTP 403.
- MakerWorld (API wyszukiwania; model 413931 nie pobrany) i Thangs (thangs.com/m/727143, /m/803564) — HTTP 403.
- MyMiniFactory — 403.
- GrabCAD — w notatce 06b „not attempted”. *Stan katalogu:* model GrabCAD oryginalnego HDO jest lokalnie w `hdo2_body_models/grabcad_fatshark-hdo-goggles-1/` i na nim opiera się research/08. Rysunku ani CAD-u korpusu **HDO2** nadal nie ma.

### research/06c (wymiary GoPro)

- Patenty wzornicze GoPro D829809, D880571, D908780 (justia.com) — nie pobrane.
- Blog Qidi3D „Printing Custom GoPro Mounts for Cyclists”, qidi3d.com/blogs/print-lab/gopro-mounts-cyclists — HTTP 429; liczby z wyników wyszukiwania nie zostały użyte.
- Cults3D #4873825 — Cloudflare 403; nie użyte.
- Strony Thingiverse 62800 i 3088912 — wymagają JavaScript; użyto kopii z GitHuba.
- Printables #320972 „Basic GoPro Mount - OpenSCAD” — znaleziony, nie pobrany.

### research/07a (elementy poda)

- Hirose, katalog U.FL (wysokości U.FL-R-SMT-1 i wtyku):
  https://www.hirose.com/en/product/document?clcode=&productname=&series=U.FL&documenttype=Catalog&lang=en&documentid=D31688_en (strona logowania),
  https://www.mouser.com/datasheet/2/185/U.FL_catalog-939761.pdf i https://www.hirose.co.jp/cataloge_hp/e32119372.pdf (strony anty-botowe).
- Omron, „safety precautions common to all Tactile Switches” — nie pobrano.
- Karta przycisku TD1183SA (przyciski XIAO) — nie szukano.

### research/07b (położenie poda)

- GetFPV „Fatshark dust removal” — jak w 06a.
- ImmersionRC rapidFIRE, wymiary / rysunek obudowy, https://www.immersionrc.com/?p=5781 — w 07b „nie próbowano”; wg research/09 strona podaje już tylko „ImmersionRC has ceased trading”.
- Strona produktu SpeedyBee, https://www.speedybee.com/speedybee-5-8ghz-goggles-receiver — nie pobrano; instrukcja ją zastępuje.
- ISO 4762 / DIN 125 (łeb i podkładka M5) — nie pobrano; w notatce jako [A].
- Starsze adresy katalogu Alps EC11 (`tech.alpsalpine.com/assets/products/catalog/ec11.en.pdf` i `…/cms.media/product_catalog_ec_02_ec11e_en_611f078659.pdf`) — 403; aktualny katalog pobrano.
- Grubość XIAO ESP32-C3 z DXF — w 07b „not fetched; [A]”. *Stan katalogu:* archiwa DXF Seeed są w `pod_seeed_xiao_esp32c3_*DXF.zip` (wątek 07a).

### research/07c (ergonomia i mocowanie poda)

- NASA-STD-3001 Vol. 2, https://standards.nasa.gov — nie pobrano; użyto HIDH.
- DTIC ADA256894 — jak w research/05; ponownie HTML 2026-11-03.
- Thompson, Meyer, Sandor, Holden 2009 (badanie sterowania kursorem w rękawicach, cytowane przez HIDH) — nie szukano.
- 3M VHB 4941 TDS; 3M VHB RP45 / rodzina RP TDS — nie pobrano.
- 3M „Surface Preparation for 3M VHB Tape Applications” (70-0704-8701-5) — nie pobrano.
- Alps EC11E, formalna specyfikacja — nie pobrano.
- Alps EC11E09244AQ, strona produktu, https://tech.alpsalpine.com/e/products/detail/EC11E09244AQ/ — nie pobrano; siła nacisku wersji AQ nieznana.
- 3M Dual Lock, karta katalogowa — nie szukano.
- Dane zmęczeniowe PETG dla drukowanych elementów sprężystych — nie pobrano.

### research/09 (otwarte punkty HDO2 z sieci)

Strony zablokowane dla automatycznego pobierania; notatka prosi o zapisanie ich z przeglądarki do `papers/hdo2_net/`:

- Zdjęcia z rozbiórki HDO2 na GetFPV (Cloudflare 403):
  https://www.getfpv.com/learn/wp-content/uploads/2020/11/inside_1.jpg ,
  https://www.getfpv.com/learn/wp-content/uploads/2020/11/faceplate.jpg ,
  https://www.getfpv.com/learn/wp-content/uploads/2020/11/module-bay.jpg ,
  https://www.getfpv.com/learn/wp-content/uploads/2020/11/faceplate_removed.jpg ,
  oraz `inside_2.jpg`, `bottom_shell.jpg`, `power_board_top_view.jpg` z tego samego katalogu.
- RC Groups, wątek HDO2, post „Greg”: https://www.rcgroups.com/forums/showthread.php?3443485-Fatshark-Dominator-HDO2/page2#post43065531 — nie otwierano (dostęp automatyczny przez płatną bramkę).
- YouTube w pełnej rozdzielczości: https://www.youtube.com/watch?v=GiXq9a81Ooc (≈2:50–3:10) i https://www.youtube.com/watch?v=3ZoWz2VKuyU (≈5:00–8:10); są tylko miniatury i arkusze klatek, napisów nie dało się pobrać.
- Banggood, specyfikacja wentylatora (opis ładowany skryptem): https://www.banggood.com/Anti-Fog-Cooling-Fan-12V-9500RPM-For-FPV-Camera-Goggles-Pico-Projector-p-1235351.html
- Onshape, źródło osłony Pro58: https://cad.onshape.com/documents/a2967962b5a508897639f347/w/459fd354f5bb73a3797ccf08/e/fb2a5abfa35e43e2f6d2cb4c
- Matek VRX-1G3-V2: http://www.mateksys.com/?portfolio=vrx-1g3-v2 — zwrócona inna strona; nie użyto.
- ImmersionRC rapidFIRE: https://www.immersionrc.com/?p=5781 — firma zakończyła działalność; źródła wymiarów nie ma.
- Thingiverse (403): 1498439, 3839719, 1236390, 5801747.
