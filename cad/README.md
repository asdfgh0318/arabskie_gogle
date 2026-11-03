# cad/ — części drukowane

## camera_mount.scad — mocowanie kamer na HDO2 (v0.2, WERSJA ROBOCZA — nic jeszcze nie zmierzone na goglach)
Parametryczny OpenSCAD. Gotowe STL (PETG, Prusa MK4, już w orientacji do druku) w `stl/`.

| Część | Plik | Druk |
|---|---|---|
| Próbka przegubu GoPro (drukować **najpierw**) | `stl/coupon.stl` | nogi pionowo; wybierz szczelinę 3.1–3.5, która wchodzi ręką bez luzu → `gp_slit` |
| Klatka na kamery | `stl/print_cage.stl` | przodem w dół, brim 5 mm, bez podpór; nogi GoPro 4 obwody / 100 % |
| Adapter na gnieździe wentylatora | `stl/print_adapter.stl` | tyłem w dół (stoi, 52 mm), brim 5 mm, bez podpór |

```
openscad -D 'part="assembly"' -D tilt=10 camera_mount.scad   # podgląd z goglami + FOV termo; ECHO podaje wysokości obiektywów
openscad -D 'part="print_cage"' -o stl/print_cage.stl camera_mount.scad
```

- **Adapter** (`adapter_top`): płytka 25×25 w miejscu usuniętego wentylatora **na górze** gogli (research/06),
  4 śruby wentylatora 20×20 (dłuższe niż fabryczne), pełna — zamyka otwór Ø23–24. Pełny blok-ramię do przodu
  nad krawędź; 3 palce GoPro z osią tuż przed przednią ścianą; nakrętka M5 w występie (+y); podziałka 0–20° (−y).
- **Klatka** (`cage`): termo na dole, Infra nad nią. Kamery wsuwane od przodu, dosunięte do zderzaków z tyłu,
  boczne M2 z zestawu w szczelinach ±1.5 mm. Szczeliny w mostkach → kamera z przewodem wkłada się z boku.
  Płetwa-wskaźnik pochylenia. Pasuje też do zwykłej klamry GoPro.
- **Śruba przegubu:** M5×25 imbus + podkładka od strony −y, nakrętka M5 w pułapce (+y).
- **Wysokość obiektywów nad osią okularów** (przy `seat_above_eye`=23): tilt 0/10/20° → termo 12.4 / 6.1 / 0.3 mm,
  Infra 33.9 / 25.2 / 16.5 mm (cel research/01: 0…+35).

**Do zmierzenia przed drukiem właściwym** (research/06 §3): śruba wentylatora (M1), co jest pod wentylatorem /
słupki (M2, `post_relief`), wysokość blatu nad osią okularów (**M5** → `seat_above_eye`), odległość środka
wentylatora od przedniej ściany (M6 → `front_x`), kamery suwmiarką (wymiary z rysunków sklepu).
