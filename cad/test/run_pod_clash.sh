#!/bin/bash
# Test kolizji poda v0.2: wypisuje tylko pary z niezerową objętością przecięcia.
cd "$(dirname "$0")"
T=$(mktemp -d)
pairs="shell,chassis shell,knob shell,cap chassis,cap chassis,knob shell,enc chassis,enc shell,b3s chassis,b3s cap,b3s shell,shim chassis,shim shell,xiao chassis,xiao shell,vib chassis,vib shell,buck chassis,buck shell,perf chassis,perf xiao,vib xiao,perf vib,perf vib,buck perf,pins xiao,heads vib,heads perf,heads buck,heads buck,enc buck,b3s xiao,pins vib,pins shell,heads knob,cap sweep,shell cap_stop,lid_fixed"
bad=0
for p in $pairs; do
  a=${p%,*}; b=${p#*,}
  openscad -o $T/x.stl -D "which=[\"$a\",\"$b\"]" pod_clash.scad >/dev/null 2>$T/log
  if [ -s $T/x.stl ] && ! grep -q "Current top level object is empty" $T/log; then
    v=$(python3 -c "
import re
d=open('$T/x.stl').read()
vs=[tuple(map(float,m)) for m in re.findall(r'vertex\s+(\S+)\s+(\S+)\s+(\S+)',d)]
V=0
for i in range(0,len(vs),3):
  a,b,c=vs[i:i+3]
  V+=(a[0]*(b[1]*c[2]-b[2]*c[1])-a[1]*(b[0]*c[2]-b[2]*c[0])+a[2]*(b[0]*c[1]-b[1]*c[0]))/6
print(abs(V))")
    awk -v v="$v" 'BEGIN{exit !(v>0.001)}' && { echo "KOLIZJA $a × $b: $v mm3"; bad=1; }
  fi
done
[ $bad = 0 ] && echo "OK: brak kolizji w podzie (w tym wsuwanie płytki i ruch CAM do ogranicznika)"
rm -rf $T
