# cad/ — części drukowane

## camera_mount.scad — mocowanie kamer na HDO2 (v0.3, WERSJA ROBOCZA)
Po dwóch przeglądach adwersarialnych. **Nic nie zostało zmierzone na sprzęcie**: kamery z rysunków sklepu,
HDO2 ze zdjęć i modeli społeczności (`research/06`). Gotowe STL (PETG, Prusa MK4, w orientacji do druku) w `stl/`.

| Część | Plik | Druk |
|---|---|---|
| Próbka przegubu (drukować **najpierw**) | `stl/coupon.stl` | 3 pary 3.2/3.3/3.4; 4 obwody; para, która składa się ręką bez luzu → `gp_slit` |
| Klatka na kamery | `stl/print_cage.stl` | przodem w dół, **bez brimu**, bez podpór, 4 obwody |
| Adapter na gnieździe wentylatora | `stl/print_adapter.stl` | tyłem w dół (stoi, 54 mm), brim 5 mm (zewnętrzny), bez podpór, 4 obwody |

```
openscad -D 'part="assembly"' -D tilt=10 camera_mount.scad   # podgląd; ECHO = wysokości obiektywów nad osią okularów
./test/run_clash.sh                                          # kolizje: tilt 0/10/20 × przód gogli 21.6/23.1/24.6 (ostatni wynik: OK)
```

### Montaż
1. Zdejmij osłonę i wentylator z **góry** gogli. Adapter na 4 śruby **fabryczne** (pod łbem 1.2 mm = kołnierz
   osłony). Zanim kupisz inne śruby: zmierz śrubę i to, co jest pod wentylatorem (research/06 M1/M2).
2. Kamery wsuń od przodu (przewód wkładasz z boku przez szczelinę w mostku), dosuń do tylnych zderzaków.
   Najpierw dokręć M2 po stronie **+y (lewej)** — korpus dociąga się do ścianki, która jest bazą kierunku — potem −y.
3. Przegub: **M5×20 ISO 4762 + podkładka DIN 125 (Ø10 — większa zakryje podziałkę)** od strony −y, nakrętka M5
   w pułapce (+y). Dokręcaj **ręcznie** (≤0.3 N·m). **Przed zmianą pochylenia poluzuj M5.**
4. Podziałka (−y): kreski 0/10/20°, nacięcia 5/15°, czytane grotem płetwy klatki. Zero i wysokości z ECHO są
   liczone względem blatu, dopóki nie zmierzysz `seat_pitch` (M4).
5. Zbieżność: cel ciepły z 10 m, adapter przekręć w luzie otworów i dokręć; resztę → `th_yaw_trim` / `ir_yaw_trim`
   (krok 0.25°, przedruk klatki).

### Bezpieczeństwo (kolejność zniszczenia)
poślizg przegubu (≈1.3 N·m przy dokręceniu ręcznym) → **bezpiecznik w adapterze** (przewężenie 10×8 mm za
przednimi śrubami, ≈2.6 N·m zginania) → nogi klatki (≈5 N·m). Gniazda śrub w goglach: wytrzymałość nieznana.
Wartości wyliczone (PETG ~25 MPa międzywarstwowo), nie zmierzone.

### Wysokość obiektywów nad osią okularów (`seat_above_eye` = 23, nie zmierzone; cel research/01: 0…+35)
| tilt | termo | Infra |
|---|---|---|
| 0° | 12.4 | 33.9 |
| 10° | 6.1 | 25.2 |
| 20° | 0.3 | 16.5 |

Przy `seat_above_eye` z zakresu 19–29 obie liczby przesuwają się o tyle samo → po pomiarze M5 ustaw
`axis_rel_seat`, żeby wrócić do tabeli. Klatka **nie** jest gwarantowanie zgodna z fabryczną klamrą GoPro.

**Do zmierzenia** (research/06 §3): M1 śruba, M2 pod wentylatorem (`post_relief`), M4 pochylenie blatu
(`seat_pitch`), **M5 wysokość blatu nad osią okularów** (`seat_above_eye`), M6 środek wentylatora → przód
(`front_x`), kamery suwmiarką (`th_*`, `ir_*`, położenie otworów M2, średnica przewodu → `cable_slot_w`).
