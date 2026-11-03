# cad/ — części drukowane

## camera_mount.scad — mocowanie kamer na przód HDO2 (v0.1, WERSJA ROBOCZA)
Parametryczny OpenSCAD. Części: `cage` (klatka na kamery) i `adapter_fan` (ramka na wentylator gogli).

```
openscad -D 'part="print_cage"'    -o cage.stl    camera_mount.scad
openscad -D 'part="print_adapter"' -o adapter.stl camera_mount.scad
openscad -D 'part="assembly"' -D tilt=10 camera_mount.scad      # podgląd z goglami i FOV termo
```

- **Klatka:** termo na dole (oś = wysokość oczu), Infra nad nią (+21,25 mm). Kamery wsuwane od przodu,
  trzymane bocznymi śrubami M2 z zestawu (szczeliny ±1,5 mm, bo położenie otworów to odczyt z rysunku).
  Z tyłu 2 palce GoPro → pasuje też do zwykłej klamry GoPro na podstawce VHB.
- **Adapter:** nasuwa się na obudowę wentylatora 25×25 (geometria z Printables #262727), mocowany
  dłuższymi śrubami M2 wentylatora (20×20). Ustala kierunek patrzenia (yaw) bez kleju.
- **Pochylenie:** przegub GoPro, M5 + nakrętka w pułapce, 0–20° w dół.
- Druk: PETG, obie części na boku (oś M5 pionowo).

**Niezmierzone [A]:** wymiary kamer (rysunki sklepu), położenie bocznych otworów M2, położenie wentylatora
względem oczu (`thermal_z_rel_fan`), głębokość wystawania wentylatora (`fan_wall_depth`), gogle w podglądzie = prostopadłościan.
