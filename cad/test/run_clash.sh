#!/bin/bash
# Kolizje: część wg projektu, gogle z przodem na 21.6/23.1/24.6 (niepewność research/06 A10), tilt 0/10/20. Wypisuje tylko problemy.
cd "$(dirname "$0")"; T=$(mktemp -d); bad=0
for t in 0 10 20; do for fx in 21.6 23.1 24.6; do for w in adapter_goggles cage_goggles cage_adapter fov_hits; do
  out=$(timeout 300 openscad -D tilt=$t -D g_fx=$fx -D which=\"$w\" -o $T/o.stl clash.scad 2>&1)
  if echo "$out" | grep -qi "empty"; then continue; fi
  v=$(admesh $T/o.stl 2>/dev/null | grep Volume | awk '{print $NF}'); echo "KOLIZJA tilt=$t przód_gogli=$fx $w: ${v} mm3"; bad=1
done; done; done
[ $bad = 0 ] && echo "OK: brak kolizji"; rm -rf $T
