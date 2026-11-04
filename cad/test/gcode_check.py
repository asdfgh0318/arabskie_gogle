#!/usr/bin/env python3
"""Kontrola pociętego G-code (PrusaSlicer) — PRZEGLĄD print-01 / print-11.

1. Brim w środku osłony termo / tuby Infra (pierwsza warstwa, typ Skirt/Brim): przy brimie „outer_only” wchodzi do
   środka, gdy pierwsza warstwa osłony nie jest zamkniętym pierścieniem. Obszary podawane w układzie STL (przed
   ułożeniem na stole); przesunięcie STL → stół z porównania środków obrysu (bez brimu).
   --box cx,cy,hx,hy (prostokąt ±hx, ±hy) i --circle cx,cy,r; każde trafienie = BŁĄD (kod wyjścia 1).
2. Pojedyncze ściegi: suma długości „External perimeter” o ;WIDTH < 0.42 powyżej pierwszej warstwy — tylko informacja.

Użycie: gcode_check.py plik.gcode plik.stl etykieta [--box ...] [--circle ...]
"""
import math, re, sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(__file__))
from grabcad_check import load

def main():
    fn, stl, lab = sys.argv[1:4]
    regions = []
    a = sys.argv[4:]
    for i in range(0, len(a), 2):
        regions.append((a[i][2:], [float(v) for v in a[i + 1].split(',')]))
    T = load(stl).reshape(-1, 3); sc = (T[:, :2].min(0) + T[:, :2].max(0))/2
    z = 0; t = None; x = y = 0; w = 0.45
    brim = []; lo = np.array([1e9, 1e9]); hi = -lo; thin = 0.0; thin_z = [1e9, -1e9]
    for line in open(fn):
        if line.startswith(';Z:'): z = float(line[3:]); continue
        if line.startswith(';TYPE:'): t = line[6:].strip(); continue
        if line.startswith(';WIDTH:'): w = float(line[7:]); continue
        if not line.startswith(('G1', 'G2', 'G3')): continue
        m = dict((k, float(v)) for k, v in re.findall(r'([XYEIJ])([-\d.]+)', line))
        nx, ny = m.get('X', x), m.get('Y', y)
        if m.get('E', 0) > 0:
            pts = [(nx, ny)]
            if line.startswith(('G2', 'G3')):
                cx, cy = x + m.get('I', 0), y + m.get('J', 0); r = math.hypot(x - cx, y - cy)
                a0 = math.atan2(y - cy, x - cx); a1 = math.atan2(ny - cy, nx - cx)
                if line.startswith('G2') and a1 > a0: a1 -= 2*math.pi
                if line.startswith('G3') and a1 < a0: a1 += 2*math.pi
                pts = [(cx + r*math.cos(a0 + (a1 - a0)*k/8), cy + r*math.sin(a0 + (a1 - a0)*k/8)) for k in range(1, 9)]
            if t == 'Skirt/Brim':
                if z < 0.25: brim += pts
            elif t not in (None, 'Custom'):          # bez linii czyszczącej z G-code startowego
                P = np.array(pts); lo = np.minimum(lo, P.min(0)); hi = np.maximum(hi, P.max(0))
                if t == 'External perimeter' and w < 0.42 and z > 0.3:
                    thin += math.hypot(nx - x, ny - y); thin_z = [min(thin_z[0], z), max(thin_z[1], z)]
        x, y = nx, ny
    off = (lo + hi)/2 - sc
    bad = 0
    B = np.array(brim) - off if brim else np.zeros((0, 2))
    for kind, v in regions:
        if kind == 'box':
            n = int(np.sum((np.abs(B[:, 0] - v[0]) < v[2]) & (np.abs(B[:, 1] - v[1]) < v[3]))) if len(B) else 0
        else:
            n = int(np.sum(np.hypot(B[:, 0] - v[0], B[:, 1] - v[1]) < v[2])) if len(B) else 0
        if n:
            print(f"BŁĄD BRIMU {lab}: {n} punktów brimu w środku ({kind} {v})"); bad = 1
    tz = f", z {thin_z[0]:.1f}–{thin_z[1]:.1f}" if thin else ""
    bm = ("brim w osłonie/tubie: " + ("0 pkt" if not bad else "JEST")) if regions else "brim: nie dotyczy"
    print(f"{lab}: {bm}; pojedyncze ściegi zewnętrzne (w < 0.42): {thin:.0f} mm{tz}")
    sys.exit(bad)

if __name__ == '__main__':
    main()
