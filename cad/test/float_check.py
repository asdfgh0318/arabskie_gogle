#!/usr/bin/env python3
"""„Nic nie wisi w powietrzu”: wyspy bez podparcia w orientacji do druku (§4.2), bez podpór.

STL → woksele 0.2 mm (promień pionowy przez każdą kolumnę, parzystość przecięć), warstwy co 0.2 mm.
Wyspa (spójny obszar 4-sąsiedztwa) w warstwie k, która nie ma ani jednego piksela nad materiałem warstwy k−1
(poszerzonym o 1 piksel), jest „pływająca”. Mosty i nawisy ≤45° są podparte, więc przechodzą.
Użycie: float_check.py plik.stl [...]  — wypisuje tylko problemy; kod wyjścia 1 = problem.
"""
import struct, sys
import numpy as np

R = 0.2; LH = 0.2; MIN_PX = 6   # wyspy < 6 px (0.24 mm²) to szum rastra

def load(fn):
    d = open(fn, 'rb').read()
    if d[:5] == b'solid' and b'facet' in d[:400]:
        import re
        return np.array(re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', d), dtype=float).reshape(-1, 3, 3)
    n = struct.unpack('<I', d[80:84])[0]
    a = np.frombuffer(d[84:84 + n*50], dtype=np.dtype([('n', '<3f4'), ('v', '<9f4'), ('a', '<u2')]))
    return a['v'].reshape(-1, 3, 3).astype(float)

def voxels(T):
    lo = T.reshape(-1, 3).min(0); hi = T.reshape(-1, 3).max(0)
    nx = int((hi[0] - lo[0])/R) + 3; ny = int((hi[1] - lo[1])/R) + 3; nl = int((hi[2] - lo[2])/LH) + 1
    xs = lo[0] - R + (np.arange(nx) + 0.5)*R + 1.1e-5; ys = lo[1] - R + (np.arange(ny) + 0.5)*R + 0.7e-5
    zc = lo[2] + (np.arange(nl) + 0.5)*LH
    hits = [[] for _ in range(nx*ny)]
    for t in T:
        a, b, c = t
        den = (b[0] - a[0])*(c[1] - a[1]) - (c[0] - a[0])*(b[1] - a[1])
        if abs(den) < 1e-12: continue
        i0 = max(0, int((min(t[:, 0]) - xs[0])/R)); i1 = min(nx - 1, int((max(t[:, 0]) - xs[0])/R) + 1)
        j0 = max(0, int((min(t[:, 1]) - ys[0])/R)); j1 = min(ny - 1, int((max(t[:, 1]) - ys[0])/R) + 1)
        if i1 < i0 or j1 < j0: continue
        X, Y = np.meshgrid(xs[i0:i1 + 1], ys[j0:j1 + 1], indexing='ij')
        u = ((X - a[0])*(c[1] - a[1]) - (c[0] - a[0])*(Y - a[1]))/den
        v = ((b[0] - a[0])*(Y - a[1]) - (X - a[0])*(b[1] - a[1]))/den
        m = (u >= 0) & (v >= 0) & (u + v <= 1)
        if not m.any(): continue
        Z = a[2] + u*(b[2] - a[2]) + v*(c[2] - a[2])
        for (ii, jj), z in zip(np.argwhere(m), Z[m]): hits[(i0 + ii)*ny + j0 + jj].append(z)
    occ = np.zeros((nl, nx, ny), bool)
    for k, h in enumerate(hits):
        if len(h) < 2: continue
        h = np.sort(h)
        for z0, z1 in zip(h[0::2], h[1::2]):
            occ[(zc >= z0) & (zc <= z1), k // ny, k % ny] = True
    return occ, lo

def labels2d(o):
    lab = np.where(o, np.arange(o.size).reshape(o.shape), -1)
    big = o.size + 1
    while True:
        L = np.where(lab < 0, big, lab)
        m = L.copy()
        m[1:, :] = np.minimum(m[1:, :], L[:-1, :]); m[:-1, :] = np.minimum(m[:-1, :], L[1:, :])
        m[:, 1:] = np.minimum(m[:, 1:], L[:, :-1]); m[:, :-1] = np.minimum(m[:, :-1], L[:, 1:])
        new = np.where(o, m, -1)
        if np.array_equal(new, lab): return lab
        lab = new

bad = 0
for fn in sys.argv[1:]:
    occ, lo = voxels(load(fn))
    probs = []
    for k in range(1, len(occ)):
        o = occ[k]
        if not o.any(): continue
        below = occ[k - 1].copy()
        below[1:, :] |= occ[k - 1][:-1, :]; below[:-1, :] |= occ[k - 1][1:, :]
        below[:, 1:] |= occ[k - 1][:, :-1]; below[:, :-1] |= occ[k - 1][:, 1:]
        lab = labels2d(o)
        ids, cnt = np.unique(lab[o], return_counts=True)
        sup = set(np.unique(lab[o & below]).tolist())
        for i, c in zip(ids, cnt):
            if i in sup or c < MIN_PX: continue
            p = np.argwhere(lab == i)
            probs.append(f"wyspa bez podparcia na z {lo[2] + (k + 0.5)*LH:.1f}: {c*R*R:.1f} mm² przy x {lo[0] + p[:,0].mean()*R:.1f}, y {lo[1] + p[:,1].mean()*R:.1f}")
    for p in probs: print(f"{fn}: {p}")
    bad |= bool(probs)
sys.exit(bad)
