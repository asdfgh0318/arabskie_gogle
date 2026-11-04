#!/bin/bash
# Test kolizji v0.5 „PANCERZ+” (tactical_mount.scad), §4.1 specyfikacji + przypadki z przeglądu R1.
# Wypisuje tylko problemy, wyniki pomiarów i na końcu „OK: brak kolizji”.
#  - części vs gogle (bryła zastępcza) przy przodzie gogli 21.6 / 23.1 / 24.6 (niepewność research/06 A10), FORK też przy yaw ±2
#  - klatka+kamery+przewody+pokrywa vs gogle / FORK / BASE, gałka vs wszystko, droga klucza do popychaczy,
#    strefy widzenia (termo 50×37.2 z Ø16, Infra 96×72 i 108×92 z Ø19, od 0.5 mm ZA soczewką/szkłem) — tilt −2…22
#  - język w gnieździe z łbami śrub (yaw 0, ±2°), przechył języka na śrubach, obrót FORK na kołku po ścięciu PA66 (0…45°)
#  - kamery w klatce, pokrywa, wsuwanie kamer od tyłu; to samo przy ir_yaw_trim ±2
#  - dostęp wkrętakiem do przednich śrub wentylatora; tarcze klamry GoPro kasku vs BASE
#  - kąty pierwszego styku przy obrocie klatki (nos w górę: czoło FORK ≈ −2.5°; nos w dół: gogle ≥ 55°), z przewodami
#  - pomiary (bez oczekiwania): dostęp do śrub pokrywy, zakres obrotu klamry kasku
#  - model GrabCAD (jeśli jest lokalnie, papers/ nie jest w repo): grabcad_check.py + pusher_reach.py (S2, ostrzeżenia)
#  - kontrole pozytywne (MUSZĄ trafić): osłona z marginesem −0.5 → pole termo; tuba 0.5 przed szkłem → pole Infra;
#    gogle z przodem na 26.5 → FORK; stary prostopadłościenny język → BASE przy obrocie 6°; przechył ±2° → śruby;
#    wnęka 2.5 → bucik przewodu Infra w pokrywie; łeb kołka bez pogłębienia → wkrętak; GrabCAD przodem na 40 → FORK
# Zmienne: J = liczba równoległych zadań (domyślnie nproc), FN = $fn w teście (domyślnie 32).
cd "$(dirname "$0")"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
J=${J:-$(nproc)}; FN=${FN:-32}
GRAB=../../papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/hdo_grabcad_goggle_frame.stl
FXS="21.6 23.1 24.6"; TILTS="-2 0 5 10 15 20 22"
UP="-2.5 -3 -3.5 -4 -5"; DOWN="55 57.5 60 62.5 65 67.5 70 75 80"
HINGE="3 6 10 15 20 25 30 35 40 45"
CACC="0 20 40 60"; BUCK="-30 -15 0 15 30 45 60 75 90"

# zadanie: id  oczekiwanie(c = czysto | h = musi trafić | p = pomiar)  which  tilt  g_fx  [dodatkowe -D klucz=wartość ...]
{
  for fx in $FXS; do
    for w in base_ghost knob_fixed; do echo "c $w 0 $fx"; done
    for y in 0 2 -2; do echo "c fork_ghost 0 $fx yaw=$y"; done
  done
  for y in 0 2 -2; do echo "c fork_base 0 23.1 yaw=$y"; done
  for r in 0.8 -0.8; do echo "c roll 0 23.1 roll=$r"; done
  for h in $HINGE; do for dx in -0.15 0.25; do echo "c hinge 0 23.1 hinge=$h hinge_dx=$dx"; done; done
  echo "c fan_access 0 23.1"; echo "c buckle_disc 0 23.1"
  for w in cams_cage cover_cage cover_cams ins_th ins_ir; do echo "c $w 0 23.1"; done
  for tr in 2 -2; do
    for w in cams_cage cover_cams ins_ir; do echo "c $w 0 23.1 ir_yaw_trim=$tr"; done
    for t in 0 10 20; do echo "c fov $t 23.1 ir_yaw_trim=$tr"; done
  done
  for t in $TILTS; do
    for fx in $FXS; do echo "c stack_ghost $t $fx"; echo "c fov $t $fx"; done
    for w in stack_fork stack_base knob_stack keypath; do echo "c $w $t 23.1"; done
  done
  for t in $UP $DOWN; do echo "p swing $t 24.6"; done
  for t in $CACC; do echo "p cover_access $t 23.1 with_knob=false"; echo "p cover_access $t 23.1 with_knob=true"; done
  for b in $BUCK; do echo "p buckle_body 10 23.1 buckle=$b"; done
  echo "h fov 10 23.1 hood_m=-0.5"
  echo "h fov 10 23.1 ir_tube_back=-0.5 face_x=13.6"
  echo "h fork_ghost 0 26.5"
  echo "h hinge 0 23.1 hinge=6 tg_tail=false"
  for r in 2 -2; do echo "h roll 0 23.1 roll=$r"; done
  echo "h cover_cams 0 23.1 bay=2.5"
  echo "h fan_access 0 23.1 pin_cb_h=0"
} | awk '{printf "%03d %s\n", NR, $0}' > $T/jobs

run_job() {
  id=$1; ex=$2; w=$3; t=$4; fx=$5; shift 5
  D=(); for kv in "$@"; do D+=(-D "$kv"); done
  out=$(timeout 1800 openscad -D "\$fn=$FN" -D "which=\"$w\"" -D "tilt=$t" -D "g_fx=$fx" "${D[@]}" -o "$T/$id.stl" tactical_clash.scad 2>&1)
  if echo "$out" | grep -qi "top level object is empty"; then r=0; v=0
  elif [ -s "$T/$id.stl" ]; then r=1; v=$(admesh "$T/$id.stl" 2>/dev/null | awk '/Volume/{print $NF}')
  else r=E; v=0; fi
  echo "$id $ex $r $v $w tilt=$t przód_gogli=$fx $*" > "$T/$id.res"
}
export -f run_job; export T FN
xargs -P "$J" -L 1 bash -c 'run_job "$@"' _ < $T/jobs

bad=0
for f in $T/*.res; do
  read -r id ex r v w rest < "$f"
  if [ "$r" = E ]; then echo "BŁĄD OpenSCAD: $w $rest"; bad=1; continue; fi
  case $ex in
    c) [ "$r" = 1 ] && { echo "KOLIZJA $w $rest: ${v} mm3"; bad=1; } ;;
    h) [ "$r" = 0 ] && { echo "BŁĄD KONTROLI POZYTYWNEJ (test nie wykrył trafienia): $w $rest"; bad=1; } ;;
  esac
done
# kąty pierwszego styku
res() { grep -l " $1 tilt=$2 .*$3" $T/*.res | head -1 | xargs cat | awk '{print $3}'; }
first() { for t in $1; do [ "$(res swing $t)" = 1 ] && { echo "$t"; return; }; done; echo "brak"; }
up=$(first "$UP"); down=$(first "$DOWN")
case $up in -2.5|-3|-3.5) ;; *) echo "OGRANICZNIK NOS W GÓRĘ poza oczekiwaniem (≈−2.5°): pierwszy styk przy $up°"; bad=1;; esac
[ "$down" = 55 ] && { echo "STYK NOS W DÓŁ już przy 55° (wymagane ≥55°)"; bad=1; }
# pomiary: dostęp do śrub pokrywy (wkrętak Ø2.5 wzdłuż y), zakres obrotu klamry kasku
for k in false true; do
  fr=""; for t in $CACC; do [ "$(grep -l " cover_access tilt=$t .*with_knob=$k" $T/*.res | xargs cat | awk '{print $3}')" = 0 ] && fr="$fr $t"; done
  [ $k = false ] && kk="bez gałki" || kk="z gałką"
  echo "pomiar: śruby pokrywy dostępne wkrętakiem Ø2.5 z obu stron ($kk) przy tilt:${fr:- żadnym z $CACC}"
done
bf=""; for b in $BUCK; do [ "$(grep -l " buckle_body .*buckle=$b\$" $T/*.res | xargs cat | awk '{print $3}')" = 0 ] && bf="$bf $b"; done
echo "pomiar: korpus klamry GoPro kasku wolny (vs BASE/FORK/gałka/klatka tilt 10) przy kątach [°, 0 = do góry, + = do przodu]:${bf:- żadnym}"

# GrabCAD
gmsg="GrabCAD: brak pliku lokalnie, pominięto"
if [ -f "$GRAB" ]; then
  openscad -D "\$fn=$FN" -D 'which="x_base"' -o $T/x_base.stl tactical_clash.scad >/dev/null 2>&1 &
  for y in 0 2 -2; do openscad -D "\$fn=$FN" -D 'which="x_fork"' -D yaw=$y -o $T/x_fork_$y.stl tactical_clash.scad >/dev/null 2>&1 & done
  for t in $TILTS; do openscad -D "\$fn=$FN" -D 'which="x_stack"' -D tilt=$t -o $T/x_stack_$t.stl tactical_clash.scad >/dev/null 2>&1 & done
  wait
  args="base=$T/x_base.stl"; for y in 0 2 -2; do args="$args fork+gałka_yaw$y=$T/x_fork_$y.stl"; done
  for t in $TILTS; do args="$args klatka_tilt$t=$T/x_stack_$t.stl"; done
  python3 grabcad_check.py "$GRAB" "$FXS" $args || bad=1
  # kontrola pozytywna: GrabCAD przesunięty przodem na x = 40 MUSI wejść w FORK
  python3 grabcad_check.py "$GRAB" "40" fork=$T/x_fork_0.stl >/dev/null && { echo "BŁĄD KONTROLI POZYTYWNEJ: GrabCAD na 40 nie trafił w FORK"; bad=1; }
  # zasięg popychaczy do ściany (S2) — tylko ostrzeżenia
  cat > $T/par.scad <<EOF
include <$(pwd)/../tactical_mount.scad>
part = "none";
echo(str("PAR ", pad_x0, " ", pad_y, " ", pad_z, " ", pad_len, " ", pusher_len, " ", pad_x0 - (pad_bore_x1 - pusher_len)));
EOF
  openscad -o $T/par.echo $T/par.scad >/dev/null 2>&1; P=$(grep -o 'PAR [^"]*' $T/par.echo | cut -d' ' -f2-)
  python3 pusher_reach.py "$GRAB" "$FXS" $P
  gmsg="GrabCAD sprawdzony (FORK też przy yaw ±2)"
fi

n=$(wc -l < $T/jobs)
[ $bad = 0 ] && echo "OK: brak kolizji ($n zadań OpenSCAD, \$fn=$FN; pierwszy styk: nos w górę ${up}°, nos w dół ${down}° przy przodzie gogli 24.6; kontrole pozytywne trafiają; $gmsg)"
exit $bad
