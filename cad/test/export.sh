#!/bin/bash
# Eksport STL v0.6 (camera_mount.scad) do cad/stl/ + kontrola drukowalności: admesh (manifold, liczba brył),
# overhang.py (ściany > 45° w dół; nawisy odziedziczone po v0.4 są wypisywane informacyjnie — ta sama lista co dla STL
# v0.4), float_check.py (wyspy bez podparcia = BŁĄD). Opcjonalnie cięcie PrusaSlicerem:
#   PROFILE=/ścieżka/mk4_petg.ini ./export.sh   (4 obwody, bez podpór; brim 5 mm zewn. dla adaptera i osłony)
# Masa przy 2 obwodach i przebieg z auto-podporami tylko jako wskaźniki. gcode_check.py: brim w środku osłony termo /
# tuby Infra = BŁĄD. Ostrzeżenia PrusaSlicera (stabilność, „floating”, „overhang”) są wypisywane.
cd "$(dirname "$0")/.."
declare -A NP=([print_adapter]=1 [print_cage]=1 [print_shroud]=1 [print_knob]=1 [coupon]=8)
declare -A BRIM=([print_adapter]=5 [print_cage]=0 [print_shroud]=5 [print_knob]=0 [coupon]=0)
PARTS="print_adapter print_cage print_shroud print_knob coupon"
bad=0
for p in $PARTS; do openscad -D "part=\"$p\"" -o stl/$p.stl camera_mount.scad > /dev/null 2>&1 & done; wait
for p in $PARTS; do
  a=$(admesh stl/$p.stl 2>/dev/null)
  n=$(echo "$a" | awk '/Number of parts/{print $5}'); v=$(echo "$a" | awk '/Volume/{print $NF}')
  fx=$(echo "$a" | awk '/Edges fixed/{print $4}'); dg=$(echo "$a" | awk '/Degenerate facets/{print $4}')
  [ "$n" = "${NP[$p]}" ] && [ "$fx" = 0 ] && [ "$dg" = 0 ] || { echo "BŁĄD SIATKI $p: brył $n (oczek. ${NP[$p]}), naprawionych krawędzi $fx, zdegenerowanych $dg"; bad=1; }
  printf "%-14s brył %s  V = %s cm³\n" "$p" "$n" "$(awk -v v="$v" 'BEGIN{printf "%.2f", v/1000}')"
done
python3 -I test/overhang.py stl/print_shroud.stl stl/print_knob.stl || bad=1
echo "nawisy adaptera, klatki i próbki (informacyjnie; te same co w STL v0.4):"
python3 -I test/overhang.py stl/print_adapter.stl stl/print_cage.stl stl/coupon.stl | sed 's#^stl/#  #'
python3 -I test/float_check.py $(for p in $PARTS; do echo stl/$p.stl; done) || bad=1
if [ -n "$PROFILE" ]; then
  T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
  irz=$(echo 'include <'"$(pwd)"'/camera_mount.scad>
part="none"; echo(str("IRZ ", ir_z));' > $T/p.scad; openscad -o $T/p.echo $T/p.scad >/dev/null 2>&1; grep -o 'IRZ [0-9.]*' $T/p.echo | cut -d' ' -f2)
  for p in $PARTS; do
    b=${BRIM[$p]}
    log=$(prusa-slicer --export-gcode --load "$PROFILE" --perimeters 4 --no-support-material --brim-type outer_only --brim-width $b -o $T/$p.gcode stl/$p.stl 2>&1)
    echo "$log" | grep -iE -A2 "stability|floating|loose|collapsing" | sed "s/^/UWAGA PrusaSlicer $p: /"
    prusa-slicer --export-gcode --load "$PROFILE" --perimeters 2 --no-support-material --brim-type outer_only --brim-width $b -o $T/${p}_2.gcode stl/$p.stl > /dev/null 2>&1
    prusa-slicer --export-gcode --load "$PROFILE" --perimeters 4 --support-material --support-material-auto --dont-support-bridges -o $T/${p}_s.gcode stl/$p.stl > /dev/null 2>&1
    t=$(grep -m1 "estimated printing time (normal mode)" $T/$p.gcode | cut -d= -f2); g=$(grep -m1 "^; filament used \[g\]" $T/$p.gcode | cut -d= -f2)
    g2=$(grep -m1 "^; filament used \[g\]" $T/${p}_2.gcode | cut -d= -f2); gs=$(grep -m1 "^; filament used \[g\]" $T/${p}_s.gcode | cut -d= -f2)
    printf "%-14s czas%s, masa%s g (4 obwody, brim %s mm); 2 obwody%s g; z auto-podporami%s g\n" "$p" "$t" "$g" "$b" "$g2" "$gs"
    if [ $p = print_shroud ]; then
      # układ STL osłony: X = z klatki, Y = y klatki; oś termo (0,0), oś Infra (ir_z, 0)
      python3 -I test/gcode_check.py $T/$p.gcode stl/$p.stl $p --box 0,0,9,9 --circle $irz,0,9.5 || bad=1
    fi
  done
fi
[ $bad = 0 ] && echo "OK: STL manifold, bez wysp w powietrzu, osłona i gałka bez nawisów > 45°${PROFILE:+, bez brimu w osłonie i tubie}"
exit $bad
