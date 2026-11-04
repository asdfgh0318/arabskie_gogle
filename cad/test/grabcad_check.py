#!/usr/bin/env python3
"""Kolizja części v0.5 z modelem GrabCAD (oryginalne HDO, „wymiary niedokładne”, plik lokalny, nie w repo).

Model GrabCAD nie jest zamknięty (34 kawałki), więc nie da się go odjąć w OpenSCAD. Zamiast tego: gęsto próbkujemy
jego powierzchnię (wierzchołki + siatka barycentryczna co ≤0.5 mm) i sprawdzamy promieniem wzdłuż +z, czy któraś
próbka leży WEWNĄTRZ zamkniętej bryły części (STL z OpenSCAD w układzie gogli). Przebicie ścianki gogli przez część
zawsze zostawia próbki w środku części. Przód GrabCAD (x = 21.7) przesuwamy na badany front_x.

Użycie: grabcad_check.py GRABCAD.stl "21.6 23.1 24.6" etykieta1=część1.stl [etykieta2=część2.stl ...]
Wypisuje tylko kolizje; kod wyjścia 1 = kolizja.
"""
import struct, sys
import numpy as np

def load(fn):
    d = open(fn, 'rb').read()
    if d[:5] == b'solid' and b'facet' in d[:400]:
        import re
        v = np.array(re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', d), dtype=float)
        return v.reshape(-1, 3, 3)
    n = struct.unpack('<I', d[80:84])[0]
    a = np.frombuffer(d[84:84 + n*50], dtype=np.dtype([('n', '<3f4'), ('v', '<9f4'), ('a', '<u2')]))
    return a['v'].reshape(-1, 3, 3).astype(float)

def samples(T, step=0.5):
    out = [T.reshape(-1, 3)]
    e = np.max(np.linalg.norm(T - np.roll(T, 1, axis=1), axis=2), axis=1)
    for k in np.unique(np.clip(np.ceil(e/step).astype(int), 1, 60)):
        S = T[np.clip(np.ceil(e/step).astype(int), 1, 60) == k]
        if k < 2 or len(S) == 0: continue
        uv = np.array([(i/k, j/k) for i in range(k + 1) for j in range(k + 1 - i)])
        w = np.c_[1 - uv.sum(1), uv]
        out.append(np.einsum('pk,tkc->tpc', w, S).reshape(-1, 3))
    return np.concatenate(out)

def inside(P, T):
    """parzystość przecięć promienia +z z trójkątami T (bryła zamknięta)"""
    if len(P) == 0: return np.zeros(0, bool)
    P = P + np.array([1.3e-5, 0.7e-5, 0])          # unik trafienia dokładnie w krawędź
    a, b, c = T[:, 0], T[:, 1], T[:, 2]
    cnt = np.zeros(len(P), int)
    for i in range(0, len(P), 400):
        p = P[i:i + 400, None, :]
        v0 = (b - a)[None, :, :2]; v1 = (c - a)[None, :, :2]; v2 = p[..., :2] - a[None, :, :2]
        den = v0[..., 0]*v1[..., 1] - v1[..., 0]*v0[..., 1]
        ok = np.abs(den) > 1e-12
        den = np.where(ok, den, 1)
        u = (v2[..., 0]*v1[..., 1] - v1[..., 0]*v2[..., 1]) / den
        v = (v0[..., 0]*v2[..., 1] - v2[..., 0]*v0[..., 1]) / den
        hit = ok & (u >= 0) & (v >= 0) & (u + v <= 1)
        z = a[None, :, 2] + u*(b - a)[None, :, 2] + v*(c - a)[None, :, 2]
        cnt[i:i + 400] = (hit & (z > p[..., 2])).sum(1)
    return cnt % 2 == 1

def main():
    G = load(sys.argv[1]); shifts = [float(s) for s in sys.argv[2].split()]
    parts = [a.split('=', 1) for a in sys.argv[3:]]
    bad = 0
    for lab, fn in parts:
        T = load(fn); lo = T.reshape(-1, 3).min(0) - 0.5; hi = T.reshape(-1, 3).max(0) + 0.5
        for fx in shifts:
            Gs = G + np.array([fx - 21.7, 0, 0])
            tl = Gs.min(1); th = Gs.max(1)
            sel = np.all((th >= lo) & (tl <= hi), axis=1)
            P = samples(Gs[sel]) if sel.any() else np.zeros((0, 3))
            P = P[np.all((P >= lo) & (P <= hi), axis=1)]
            m = inside(P, T)
            if m.any():
                bad = 1; q = P[m]
                print(f"KOLIZJA GrabCAD przód_gogli={fx} {lab}: {m.sum()} próbek w środku, x {q[:,0].min():.1f}…{q[:,0].max():.1f}, "
                      f"y {q[:,1].min():.1f}…{q[:,1].max():.1f}, z {q[:,2].min():.1f}…{q[:,2].max():.1f}")
    sys.exit(bad)

if __name__ == '__main__':
    main()
