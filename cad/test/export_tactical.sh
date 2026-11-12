#!/bin/bash
# v0.5 ODRZUCONA 2026-11-06 — nie drukować (aktualna wersja: camera_mount.scad v0.6, eksport: export.sh)
# Eksport STL v0.5 „PANCERZ+” do cad/stl/tac_*.stl + kontrola drukowalności (§4.2): admesh (manifold, liczba brył),
# overhang.py (ściany > 45° w dół), float_check.py (wyspy bez podparcia). Wypisuje tylko problemy + tabelkę.
# Opcjonalnie cięcie PrusaSlicerem: PROFILE=/ścieżka/mk4_petg.ini ./export_tactical.sh  (4 obwody, BASE 6; bez podpór;
# klatka z brimem 5 mm zewn.); do tego masa przy 2 obwodach (porównanie z kalibracją v0.4) i przebieg z auto-podporami
# tylko jako wskaźnik, ile podpór „chciałby” slicer. gcode_check.py: brim w środku osłony termo / tuby Infra = BŁĄD,
# suma pojedynczych ściegów zewnętrznych (informacja); ostrzeżenia stabilności PrusaSlicera są wypisywane.
# Render idzie do katalogu tymczasowego; błąd OpenSCAD kończy skrypt kodem 1 przed sprawdzaniem i bez ruszania cad/stl/.
cd "$(dirname "$0")/.."
declare -A NP=([print_base]=1 [print_fork]=1 [print_cage]=1 [print_acc]=2 [coupon]=6 [coupon_joint]=4)
bad=0
. test/render_lib.sh
R=$(mktemp -d); trap 'rm -rf "$R"' EXIT
render_parts tactical_mount.scad "$R" tac_ "${!NP[@]}" || { echo "NIEZALICZONE: render się nie udał — cad/stl/ bez zmian, nic nie sprawdzono"; exit 1; }
install_parts "$R" tac_ "${!NP[@]}"
for p in print_base print_fork print_cage print_acc coupon coupon_joint; do
  a=$(admesh stl/tac_$p.stl 2>/dev/null)
  n=$(echo "$a" | awk '/Number of parts/{print $5}'); v=$(echo "$a" | awk '/Volume/{print $NF}')
  fx=$(echo "$a" | awk '/Edges fixed/{print $4}'); dg=$(echo "$a" | awk '/Degenerate facets/{print $4}')
  # trójkąty o zerowym polu (backend Manifold zostawia ich kilkanaście–kilkaset) są wypisywane, ale nie są błędem:
  # admesh je usuwa i nie musi potem naprawiać żadnej krawędzi (fx = 0), więc bryła jest szczelna
  [ "$dg" = 0 ] || echo "  tac_$p: $dg trójkątów o zerowym polu (bez wpływu na bryłę)"
  [ "$n" = "${NP[$p]}" ] && [ "$fx" = 0 ] || { echo "BŁĄD SIATKI tac_$p: brył $n (oczek. ${NP[$p]}), naprawionych krawędzi $fx, zdegenerowanych $dg"; bad=1; }
  printf "tac_%-13s brył %s  V = %s cm³\n" "$p" "$n" "$(awk -v v="$v" 'BEGIN{printf "%.2f", v/1000}')"
done
python3 test/overhang.py stl/tac_*.stl || bad=1
python3 test/float_check.py stl/tac_*.stl || bad=1
if [ -n "$PROFILE" ]; then
  T=$(mktemp -d)
  irz=$(echo 'include <'"$(pwd)"'/tactical_mount.scad>
part="none"; echo(str("IRZ ", ir_z));' > $T/p.scad; "$SCAD" -o $T/p.echo $T/p.scad >/dev/null 2>&1; grep -o 'IRZ [0-9.]*' $T/p.echo | cut -d' ' -f2)
  for p in print_base print_fork print_cage print_acc coupon coupon_joint; do
    b=0; [ $p = print_cage ] && b=5
    # BASE (i wycinek BASE w coupon_joint): 6 obwodów — policzki 6.3 mm prawie pełne; przy 4 obwodach PrusaSlicer
    # zgłasza „Floating bridge anchors” (mosty wewnętrzne nad rzadkim wypełnieniem)
    n=4; case $p in print_base|coupon_joint) n=6;; esac
    log=$(prusa-slicer --export-gcode --load "$PROFILE" --perimeters $n --no-support-material --brim-width $b -o $T/$p.gcode stl/tac_$p.stl 2>&1)
    echo "$log" | grep -qi "stability" && echo "UWAGA PrusaSlicer tac_$p: $(echo "$log" | grep -i -A2 stability | tr '\n' ' ')"
    prusa-slicer --export-gcode --load "$PROFILE" --perimeters 2 --no-support-material --brim-width $b -o $T/${p}_2.gcode stl/tac_$p.stl > /dev/null 2>&1
    prusa-slicer --export-gcode --load "$PROFILE" --perimeters $n --support-material --support-material-auto --dont-support-bridges -o $T/${p}_s.gcode stl/tac_$p.stl > /dev/null 2>&1
    t=$(grep -m1 "estimated printing time (normal mode)" $T/$p.gcode | cut -d= -f2); g=$(grep -m1 "^; filament used \[g\]" $T/$p.gcode | cut -d= -f2)
    g2=$(grep -m1 "^; filament used \[g\]" $T/${p}_2.gcode | cut -d= -f2); gs=$(grep -m1 "^; filament used \[g\]" $T/${p}_s.gcode | cut -d= -f2)
    printf "tac_%-13s czas%s, masa%s g (%s obwody, brim %s mm); 2 obwody%s g; z auto-podporami%s g\n" "$p" "$t" "$g" "$n" "$b" "$g2" "$gs"
    if [ $p = print_cage ]; then
      # układ STL klatki: X = z klatki, Y = y klatki; oś termo (0,0), oś Infra (ir_z, 0)
      python3 test/gcode_check.py $T/$p.gcode stl/tac_$p.stl tac_$p --box 0,0,9,9 --circle $irz,0,9.5 || bad=1
    else
      python3 test/gcode_check.py $T/$p.gcode stl/tac_$p.stl tac_$p
    fi
  done
  rm -rf $T
fi
[ $bad = 0 ] && echo "OK: wszystkie STL manifold, bez nawisów > 45°, bez wysp w powietrzu${PROFILE:+, bez brimu w osłonie i tubie}" || echo "NIEZALICZONE: eksport v0.5 (patrz wyżej)"
exit $bad
