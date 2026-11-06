# 08 — Wymiary odczytane z modelu GrabCAD (oryginalne HDO) — WERSJA ROBOCZA

Źródło: model „Fatshark HDO goggles” autorstwa Aisak (GrabCAD, 2019). Plik lokalny, poza repo (licencja GrabCAD):
`papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/`. Autor pisze, że „wymiary i geometria NIE SĄ RZECZYWISTE ANI
DOKŁADNE”, a to model **oryginalnego HDO**, nie HDO2. Liczby poniżej to więc druga, niezależna ocena obok research/06
(zdjęcia), a nie pomiar. Gdzie się różnią, rozstrzyga pomiar na goglach Adama.

Model przeliczony na układ gogli (x do przodu, y w lewo, z w górę, początek = środek wentylatora na blacie; blat = góra
korpusu, z = 22.2 w pliku). Pomiar: rzutowanie promieni na siatkę, skrypt `cad/test/grabcad_measure.py`.

| Wielkość | Model GrabCAD | Przyjęte w CAD (research/06) | Wniosek |
|---|---|---|---|
| Środek wentylatora → przednia ściana (`front_x`) | **21.7** (pionowa ściana z −11 do −25 w osi, do −30 przy y ±17.75) | 23.1 ± 1.5 | w testowanym zakresie 21.6–24.6; zostaje 23.1 (bezpieczniej dla luzu tarcz GoPro) |
| Zaokrąglenie górnej przedniej krawędzi | duże: ściana x = 15.6 / 18.6 / 20.2 / 21.2 / 21.65 przy z = −1 / −3 / −5 / −7 / −9.5; blat opada od x ≈ 15 (z −0.8) do x 20 (z −4.7) | nieznane (S2) | popychacze na z −9.5 trafiają w ścianę 4° od pionu — OK; wyżej (z −5) byłyby na zaokrągleniu |
| Blat wokół gniazda | płaski, z ≈ −0.2 w (±10, ±10) | z = 0 | zgodne |
| Oś okularów pod blatem (`seat_above_eye`) | ≈ **22.5** (wnęki okularów z −15…−30, y ±18…±42 w mapie głębokości od tyłu) | 23 | zgodne w granicach odczytu |
| Wysokość korpusu | 51.8 | 45.5 (instrukcja HDO2) | model wyższy → inny kształt dołu; nie używać do dołu gogli |
| Zatoka/drzwiczki boczne (lewa, VRx) | bryła drzwiczek: wzdłuż 42 (x −30.3…11.7) × wys. 38 (z −42.2…−4.2) × w głąb boku do 27 | pod: 44 × 32 × 13 (HDO v1, forum) | podobna skala; drzwiczki obejmują narożnik — kołnierz poda trzeba wygiąć (P1) |

Czego model nie daje: śruby wentylatora i tego, co pod nim (M1/M2), pochylenia blatu w HDO2 (M4), położenia podstawki
na kasku (H1–H3), wnętrza zatoki (gniazdo, głębokość — P1/P2).
