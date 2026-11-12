. "$(dirname "${BASH_SOURCE[0]}")/scad_bin.sh"
# Wspólne dla export.sh i export_tactical.sh (source). Render idzie do katalogu tymczasowego; do stl/ trafia dopiero
# to, co się wyrenderowało bez błędu. Dzięki temu nieudany render nie zostawia starych STL do „sprawdzenia”.

# render_parts ŹRÓDŁO.scad KATALOG PREFIKS część...  → KATALOG/PREFIKSczęść.stl; zwraca 1, gdy którakolwiek część zawiodła
render_parts() {
  local src=$1 out=$2 pre=$3 p rc fail=0; shift 3
  for p in "$@"; do
    ( "$SCAD" -D "part=\"$p\"" -o "$out/$pre$p.stl" "$src" > "$out/$pre$p.log" 2>&1; echo $? > "$out/$pre$p.rc" ) &
  done; wait
  for p in "$@"; do
    rc=$(cat "$out/$pre$p.rc" 2>/dev/null)
    if [ "$rc" != 0 ] || [ ! -s "$out/$pre$p.stl" ] || grep -qE "ERROR|WARNING|Parser error|Can't|top level object is empty" "$out/$pre$p.log"; then
      echo "BŁĄD OpenSCAD: $src part=\"$p\" (kod wyjścia ${rc:-?})"
      grep -E "ERROR|WARNING|Parser error|Can't|top level object is empty" "$out/$pre$p.log" | head -5 | sed 's/^/    /'
      fail=1
    fi
  done
  return $fail
}

# install_parts KATALOG PREFIKS część...  → kopiuje do stl/ tylko pliki o zmienionej geometrii (stl_same.py), żeby
# zmieniona kolejność ścian w pliku nie wyglądała w git jak zmiana części
install_parts() {
  local out=$1 pre=$2 p; shift 2
  for p in "$@"; do
    if python3 -I test/stl_same.py "$out/$pre$p.stl" "stl/$pre$p.stl" > /dev/null 2>&1; then :
    else [ -e "stl/$pre$p.stl" ] && echo "ZMIENIONA GEOMETRIA: stl/$pre$p.stl (zapisano nowy plik)" || echo "NOWY: stl/$pre$p.stl"
         cp "$out/$pre$p.stl" "stl/$pre$p.stl"; fi
  done
}
