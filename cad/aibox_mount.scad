// arabskie_gogle — UCHWYT AI BOXA kamery TR1-220SL na prawym boku HDO2 — v0.1 (WERSJA ROBOCZA)
// AI Box: 33,5 × 33,5 × 16,5 mm, otwory 25,5 × 25,5 (rysunek BZB UAS: papers/bzbuas_tr1-220sl_dimensions_aibox_thermal.png),
// złącza: CVBS + zasilanie (3-pin, lewy bok na rysunku), GPIO/UART (6-pin, góra), OSD (2-pin, prawy bok),
// USB (4-pin, prawy bok), złącze kamer na spodzie (widok z boku) — papers/bzbuas_tr1-220sl_wiring_diagram.png.
// Dlaczego prawy bok: tu są gniazdo AV i zasilania HDO2 (research/07b), więc CVBS i zasilanie mają krótkie
// przewody. Masa równoważy pod po lewej. Przewody kamer idą od przodu po górnej krawędzi.
// Mocowanie: taśma 3M VHB 5952 (research/07c) na płaskiej części boku przed gniazdem AV (≈37 × 36 mm, 07b c-R).
// Zasłania drzwiczki Expansion Bay (zworka trybu zasilania) — zdjąć uchwyt, jeśli trzeba się do niej dostać.
//
// Układ lokalny: x = do przodu gogli, y = w górę, z = na zewnątrz w PRAWO (z = 0 = bok gogli). Prawoskrętny.

part = "assembly";
$fn = 40;

box   = [33.5, 33.5, 16.5];
hole  = 25.5;           // rozstaw otworów AI boxa
base  = [38, 37];       // płytka pod VHB (07b: ≈37 × 36 przed gniazdem AV — do pomiaru P3)
base_t = 2.0;
so_h  = 5.0;            // dystanse: miejsce na złącze kamer od spodu boxa i wyjście przewodu bokiem [A]
so_d  = 5.0;
m2_pilot = 1.8;
tie   = [3.2, 1.6];     // szczeliny na opaskę (przewód kamer)

module aibox_ghost() {  // atrapa AI boxa na dystansach
    color("dimgray") translate([0, 0, base_t + so_h]) translate([-box[0]/2, -box[1]/2, 0]) cube(box);
}
module aibox_mount() {
    difference() {
        union() {
            translate([-base[0]/2, -base[1]/2, 0]) linear_extrude(base_t) offset(3) offset(-3) square(base);
            for (sx = [-1, 1], sy = [-1, 1]) translate([sx*hole/2, sy*hole/2, 0]) cylinder(d = so_d, h = base_t + so_h);
        }
        for (sx = [-1, 1], sy = [-1, 1]) translate([sx*hole/2, sy*hole/2, base_t]) cylinder(d = m2_pilot, h = so_h + 1);
        // szczeliny na opaskę przy przedniej krawędzi (przewód kamer przychodzi z przodu)
        for (sy = [-1, 1]) translate([base[0]/2 - 4, sy*7 - tie[0]/2, -1]) cube([tie[1], tie[0], base_t + 2]);
    }
}
module assembly() { color("steelblue") aibox_mount(); aibox_ghost(); }
// do gogli (x do przodu, y w lewo, z w górę): (x, y, z) → (x, −z, y)
module to_goggle_right() { multmatrix([[1,0,0,0],[0,0,-1,0],[0,1,0,0],[0,0,0,1]]) children(); }

if (part == "mount") aibox_mount();
else if (part == "print") aibox_mount();
else if (part == "assembly") assembly();
else if (part == "none") { }
