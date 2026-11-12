#!/bin/bash
# Test kolizji poda v0.2 (pod.scad przez pod_clash.scad). Wypisuje tylko problemy i na końcu „OK: brak kolizji w podzie”.
#  - pary części i atrap (c = musi być czysto), wsuwanie płytki od spodu (sweep), nakładka CAM tuż przed ogranicznikiem
#  - kontrole pozytywne (h = MUSZĄ trafić): nakładka 1.6 mm za ogranicznikiem → wieko; wsuwanie płytki przesuniętej
#    o 1.5 mm w x → obudowa; gałka opuszczona 1 mm w wieko → obudowa
#  - błąd OpenSCAD (kod wyjścia, ERROR/WARNING, brak pliku wynikowego) = BŁĄD testu, nie „czysto”; każda para ma własny
#    plik wynikowy, więc nieudany render nie odziedziczy wyniku poprzedniej pary
#  - styk płaszczyznami (shell×chassis na z −2.1, shell×cap na z 12) daje niepusty wynik o zerowej objętości i ostrzeżenie
#    „may not be a valid 2-manifold” — to nie kolizja i nie błąd; kolizja = objętość > 0.001 mm³
# Kod wyjścia 0 tylko wtedy, gdy wszystko się wyrenderowało, pary „c” są puste, a kontrole „h” trafiły.
# Zmienna: J = liczba równoległych zadań (domyślnie nproc).
cd "$(dirname "$0")"
. ./scad_bin.sh
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
J=${J:-$(nproc)}
pairs="shell,chassis shell,knob shell,cap chassis,cap chassis,knob shell,enc chassis,enc shell,b3s chassis,b3s cap,b3s shell,shim chassis,shim shell,xiao chassis,xiao shell,vib chassis,vib shell,buck chassis,buck shell,perf chassis,perf xiao,vib xiao,perf vib,perf vib,buck perf,pins xiao,heads vib,heads perf,heads buck,heads buck,enc buck,b3s xiao,pins vib,pins shell,heads knob,cap sweep,shell cap_stop,lid_fixed"
hits="cap_over,lid_fixed sweep_off,shell shell,knob_low"
{ for p in $pairs; do echo "c $p"; done; for p in $hits; do echo "h $p"; done; } | awk '{printf "%03d %s\n", NR, $0}' > $T/jobs

run_job() {
  id=$1; ex=$2; a=${3%,*}; b=${3#*,}
  out=$(timeout 3600 "$SCAD" -o "$T/$id.stl" -D "which=[\"$a\",\"$b\"]" pod_clash.scad 2>&1); rc=$?
  msg=$(echo "$out" | grep -E "ERROR|WARNING|Parser error|Can't" | grep -v "2-manifold")
  if [ -n "$msg" ]; then r=E
  elif echo "$out" | grep -qi "top level object is empty"; then r=0
  elif [ $rc = 0 ] && [ -s "$T/$id.stl" ]; then r=1
  else r=E; fi
  v=0; [ $r = 1 ] && v=$(admesh "$T/$id.stl" 2>/dev/null | awk '/Volume/{print $NF}')
  [ $r = E ] && { [ -n "$msg" ] && echo "$msg" || echo "brak pliku wynikowego"; } | head -3 > "$T/$id.err"
  echo "$id $ex $r ${v:-0} $a×$b kod=$rc" > "$T/$id.res"
}
export -f run_job; export T
xargs -P "$J" -L 1 bash -c 'run_job "$@"' _ < $T/jobs

bad=0; n=$(wc -l < $T/jobs); nres=$(ls $T/*.res 2>/dev/null | wc -l)
[ "$nres" = "$n" ] || { echo "BŁĄD: wyniki dla $nres z $n zadań"; bad=1; }
for f in $T/*.res; do
  [ -e "$f" ] || continue
  read -r id ex r v w rest < "$f"
  if [ "$r" = E ]; then echo "BŁĄD OpenSCAD: $w ($rest)"; sed 's/^/    /' "$T/$id.err" 2>/dev/null; bad=1; continue; fi
  case $ex in
    c) [ "$r" = 1 ] && awk -v v="$v" 'BEGIN{exit !(v>0.001)}' && { echo "KOLIZJA $w: $v mm3"; bad=1; } ;;
    h) { [ "$r" = 1 ] && awk -v v="$v" 'BEGIN{exit !(v>0.001)}'; } || { echo "BŁĄD KONTROLI POZYTYWNEJ (test nie wykrył trafienia): $w"; bad=1; } ;;
  esac
done
if [ $bad = 0 ]; then echo "OK: brak kolizji w podzie ($n zadań OpenSCAD: w tym wsuwanie płytki i ruch CAM do ogranicznika; 3 kontrole pozytywne trafiają)"
else echo "NIEZALICZONE: test kolizji poda (patrz wyżej)"; fi
exit $bad
