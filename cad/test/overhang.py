#!/usr/bin/env python3
"""Nawisy w orientacji do druku (§4.2): ściany skierowane w dół bardziej niż 45° (nz < −0.71), poza stołem.

Ściany płaskie (nz < −0.99) to mosty — dopuszczalne do 10 mm rozpiętości (krótszy wymiar skupiska).
Ściany pochyłe −0.99 ≤ nz < −0.71 to nawis bez podpory — dopuszczalne tylko drobne (< 1 mm², fasetowanie łuków).
Użycie: overhang.py plik.stl [...]   — wypisuje tylko problemy; kod wyjścia 1 = problem.
"""
import struct, sys, collections
import numpy as np

def load(fn):
    d = open(fn, 'rb').read()
    if d[:5] == b'solid' and b'facet' in d[:400]:
        import re
        return np.array(re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', d), dtype=float).reshape(-1, 3, 3)
    n = struct.unpack('<I', d[80:84])[0]
    a = np.frombuffer(d[84:84 + n*50], dtype=np.dtype([('n', '<3f4'), ('v', '<9f4'), ('a', '<u2')]))
    return a['v'].reshape(-1, 3, 3).astype(float)

bad = 0
for fn in sys.argv[1:]:
    T = load(fn)
    N = np.cross(T[:, 1] - T[:, 0], T[:, 2] - T[:, 0]); A = np.linalg.norm(N, axis=1)/2
    N = N/np.maximum(2*A, 1e-12)[:, None]
    zmin = T[:, :, 2].min()
    off_bed = T[:, :, 2].max(1) > zmin + 0.05
    down = (N[:, 2] < -0.71) & off_bed & (A > 1e-6)
    # skupiska połączone wspólnym wierzchołkiem
    idx = np.where(down)[0]
    key = lambda p: tuple(np.round(p, 3))
    par = {i: i for i in idx}
    def f(i):
        while par[i] != i: par[i] = par[par[i]]; i = par[i]
        return i
    vmap = collections.defaultdict(list)
    for i in idx:
        for v in T[i]: vmap[key(v)].append(i)
    for l in vmap.values():
        for j in l[1:]: par[f(j)] = f(l[0])
    cl = collections.defaultdict(list)
    for i in idx: cl[f(i)].append(i)
    probs = []
    for c in cl.values():
        c = np.array(c); P = T[c].reshape(-1, 3); ext = P.max(0) - P.min(0)
        flat = N[c, 2] < -0.99; area_s = A[c][~flat].sum(); area_f = A[c][flat].sum()
        span = min(ext[0], ext[1])
        if area_s >= 1.0:
            probs.append(f"nawis {area_s:.1f} mm² (min nz {N[c,2].min():.2f}) przy x {P[:,0].mean():.1f}, y {P[:,1].mean():.1f}, z {P[:,2].mean():.1f}")
        if area_f > 0 and span > 10:
            probs.append(f"most {ext[0]:.1f} × {ext[1]:.1f} mm (> 10) przy z {P[:,2].mean():.1f}")
    for p in probs: print(f"{fn}: {p}")
    bad |= bool(probs)
sys.exit(bad)
