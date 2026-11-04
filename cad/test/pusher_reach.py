#!/usr/bin/env python3
"""Zasięg popychaczy yaw do ściany gogli wg modelu GrabCAD (PRZEGLĄD fit-pusher-reach, S2).

Promień wzdłuż x na osi popychacza (y = ±pad_y, z = pad_z) do powierzchni GrabCAD (przód 21.7 przesunięty na badany
front_x). Wysuw popychacza poza tył występu: e = pad_x0 − x_ściany; wkręcenie w gwint występu: min(pad_len, L − e).
Warunki: e ≥ e_min (popychacz cofnięty do oporu wystaje e_min — inaczej FORK nie wejdzie na miejsce) i wkręcenie ≥ 5.
Model GrabCAD to oryginalne HDO, „wymiary niedokładne” → wynik to OSTRZEŻENIE (S2 blokuje druk FORK), nie błąd.

Użycie: pusher_reach.py GRABCAD.stl "21.6 23.1 24.6" pad_x0 pad_y pad_z pad_len L e_min
Kod wyjścia zawsze 0; problemy wypisuje jako „OSTRZEŻENIE S2”.
"""
import sys
import numpy as np
sys.path.insert(0, __import__('os').path.dirname(__file__))
from grabcad_check import load

def ray_x(G, y, z):
    a, b, c = G[:, 0], G[:, 1], G[:, 2]
    v0 = (b - a)[:, 1:]; v1 = (c - a)[:, 1:]; v2 = np.array([y, z]) - a[:, 1:]
    den = v0[:, 0]*v1[:, 1] - v1[:, 0]*v0[:, 1]; ok = np.abs(den) > 1e-12; den = np.where(ok, den, 1)
    u = (v2[:, 0]*v1[:, 1] - v1[:, 0]*v2[:, 1])/den; v = (v0[:, 0]*v2[:, 1] - v2[:, 0]*v0[:, 1])/den
    hit = ok & (u >= 0) & (v >= 0) & (u + v <= 1)
    return np.sort((a[:, 0] + u*(b - a)[:, 0] + v*(c - a)[:, 0])[hit])

def main():
    G0 = load(sys.argv[1]); fxs = [float(s) for s in sys.argv[2].split()]
    pad_x0, pad_y, pad_z, pad_len, L, e_min = map(float, sys.argv[3:9])
    for fx in fxs:
        G = G0 + np.array([fx - 21.7, 0, 0])
        for s in (1, -1):
            h = ray_x(G, s*pad_y, pad_z); h = h[h > 0]
            if not len(h):
                print(f"OSTRZEŻENIE S2: front_x {fx}, y {s*pad_y:+.2f}: promień nie trafia w ścianę GrabCAD"); continue
            wx = h.max()
            hu = ray_x(G, s*pad_y, pad_z + 0.5); hd = ray_x(G, s*pad_y, pad_z - 0.5)
            slope = np.degrees(np.arctan2(hd[hd > 0].max() - hu[hu > 0].max(), 1.0)) if len(hu[hu > 0]) and len(hd[hd > 0]) else float('nan')
            e = pad_x0 - wx; eng = min(pad_len, L - e)
            msg = (f"front_x {fx}, y {s*pad_y:+.2f}, z {pad_z}: ściana x {wx:.2f} (pochylenie {slope:.0f}° od pionu), "
                   f"wysuw {e:.2f}, wkręcenie {eng:.2f}")
            if e < e_min or eng < 5:
                print("OSTRZEŻENIE S2: " + msg + (" — popychacz cofnięty do oporu nie mieści się" if e < e_min else " (< 5)"))
            else:
                print("zasięg popychacza: " + msg)

if __name__ == '__main__':
    main()
