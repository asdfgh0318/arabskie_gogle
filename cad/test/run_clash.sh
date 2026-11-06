#!/bin/bash
# Test kolizji v0.6 (camera_mount.scad). Wypisuje tylko problemy (+ wyniki pomiarów) i na końcu „OK: brak kolizji”.
#  - adapter (z belką i blokami popychaczy) + gałka + M5 vs gogle przy przodzie 21.6 / 23.1 / 24.6 (research/06 A10), yaw 0/±2
#  - klatka + osłona + kamery + przewody vs gogle i vs adapter/gałka/M5/popychacze/droga klucza — tilt 0/5/10/15/20
#  - zapadki: wypustki w rowkach przy 0/10/20 (luz szczeliny i palce dociśnięte), gałka vs adapter/popychacze/klucz
#  - osłona vs klatka i kamery, kamery vs klatka, przewody vs klatka/osłona
#  - strefy widzenia: termo 50×37.2 z całej soczewki Ø16, Infra 96×72 z całego szkła Ø19 — od 0.5 mm ZA soczewką/szkłem,
#    z osłoną, popychaczami, gałką, przewodami i goglami — tilt 0/5/10/15/20 × przód 21.6/23.1/24.6
#  - kontrole pozytywne (MUSZĄ trafić): osłona z marginesem −0.5 → pole termo; wypustka przy tilt 5 (między rowkami)
#    → palec żeński; gogle z przodem na 26.5 → adapter; rowek bez luzu −0.1 → wypustka przy 0
#  - pomiar: zakres kątów korpusu klamry kasku wolny od adaptera/belki
#  - model GrabCAD (jeśli jest lokalnie; papers/ nie jest w repo): grabcad_check.py + pusher_reach.py (ostrzeżenia S2)
# Zmienne: J = liczba równoległych zadań (domyślnie nproc), FN = $fn w teście (domyślnie 32).
cd "$(dirname "$0")"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
J=${J:-$(nproc)}; FN=${FN:-32}
GRAB=../../papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/hdo_grabcad_goggle_frame.stl
FXS="21.6 23.1 24.6"; TILTS="0 5 10 15 20"; BUCK="-30 -15 0 15 30 45 60 75 90"

# zadanie: oczekiwanie (c = czysto | h = musi trafić | p = pomiar)  which  tilt  g_fx  [dodatkowe -D klucz=wartość ...]
{
  for fx in $FXS; do
    for y in 0 2 -2; do echo "c adapter_ghost 0 $fx yaw=$y"; done
    for t in $TILTS; do echo "c stack_ghost $t $fx"; echo "c fov $t $fx"; echo "c stack_front $t $fx"; done
    echo "c knob_front 0 $fx"
  done
  for t in 0 10 20; do echo "c detent $t 23.1 clamp=false"; echo "c detent $t 23.1 clamp=true"; done
  for w in shroud_cage shroud_cams cams_cage cables_cage; do echo "c $w 0 23.1"; done
  for b in $BUCK; do echo "p buckle 10 23.1 buckle=$b"; done
  echo "h fov 10 23.1 hood_m=-0.5"
  echo "h detent 5 23.1 clamp=true"
  echo "h adapter_ghost 0 26.5"
  echo "h detent 0 23.1 clamp=true det_c=-0.1"
} | awk '{printf "%03d %s\n", NR, $0}' > $T/jobs

run_job() {
  id=$1; ex=$2; w=$3; t=$4; fx=$5; shift 5
  D=(); for kv in "$@"; do D+=(-D "$kv"); done
  out=$(timeout 1800 openscad -D "\$fn=$FN" -D "which=\"$w\"" -D "tilt=$t" -D "g_fx=$fx" "${D[@]}" -o "$T/$id.stl" clash.scad 2>&1)
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
bf=""; for b in $BUCK; do [ "$(grep -l " buckle .*buckle=$b\$" $T/*.res | xargs cat | awk '{print $3}')" = 0 ] && bf="$bf $b"; done
echo "pomiar: korpus klamry GoPro kasku wolny (vs adapter z belką, gałka, klatka tilt 10) przy kątach [°, 0 = do góry, + = do przodu]:${bf:- żadnym}"

# GrabCAD
gmsg="GrabCAD: brak pliku lokalnie, pominięto"
if [ -f "$GRAB" ]; then
  for y in 0 2 -2; do openscad -D "\$fn=$FN" -D 'which="x_front"' -D yaw=$y -o $T/x_front_$y.stl clash.scad >/dev/null 2>&1 & done
  for t in $TILTS; do openscad -D "\$fn=$FN" -D 'which="x_stack"' -D tilt=$t -o $T/x_stack_$t.stl clash.scad >/dev/null 2>&1 & done
  wait
  args=""; for y in 0 2 -2; do args="$args adapter+gałka_yaw$y=$T/x_front_$y.stl"; done
  for t in $TILTS; do args="$args klatka+osłona_tilt$t=$T/x_stack_$t.stl"; done
  python3 -I grabcad_check.py "$GRAB" "$FXS" $args || bad=1
  # kontrola pozytywna: GrabCAD przesunięty przodem na x = 40 MUSI wejść w adapter
  python3 -I grabcad_check.py "$GRAB" "40" adapter=$T/x_front_0.stl >/dev/null && { echo "BŁĄD KONTROLI POZYTYWNEJ: GrabCAD na 40 nie trafił w adapter"; bad=1; }
  # zasięg popychaczy do ściany (S2) — tylko ostrzeżenia
  openscad -D 'which="par"' -o $T/par.echo clash.scad >/dev/null 2>&1; P=$(grep -o 'PAR [^"]*' $T/par.echo | cut -d' ' -f2-)
  python3 -I pusher_reach.py "$GRAB" "$FXS" $P
  gmsg="GrabCAD sprawdzony (adapter też przy yaw ±2)"
fi

n=$(wc -l < $T/jobs)
[ $bad = 0 ] && echo "OK: brak kolizji ($n zadań OpenSCAD, \$fn=$FN; kontrole pozytywne trafiają; $gmsg)"
exit $bad
