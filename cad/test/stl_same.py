#!/usr/bin/env python3
"""Czy dwa STL (ASCII z OpenSCAD) opisują tę samą bryłę. md5 pliku się do tego nie nadaje: OpenSCAD 2021.01 zapisuje
ściany w kolejności, która zmienia się między uruchomieniami, a płaskie wielokąty potrafi podzielić na trójkąty inaczej.
  kod 0 „identyczne trójkąty”      — ten sam zbiór trójkątów (niezależnie od kolejności ścian i wierzchołka początkowego)
  kod 0 „inna triangulacja”        — te same wierzchołki, ta sama liczba ścian, objętość zgodna do 1e-6, pole do 1e-5
                                     (względnie; zaobserwowane dla pod_print_shell: 7 z 4294 trójkątów, pole 2.5e-7)
  kod 0 „inna siatka”              — inna liczba ścian (inny backend OpenSCAD), ale ten sam prostopadłościan otaczający
                                     (1e-4 mm), objętość (2e-5) i pole (1e-4)
  kod 1                            — inna bryła albo brak pliku
Użycie: stl_same.py a.stl b.stl"""
import re, sys, os, math

def read(fn):
    v = re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', open(fn, 'rb').read())
    tris = []
    for i in range(0, len(v) - 2, 3):
        t = v[i:i + 3]; k = min(range(3), key=lambda j: t[j])
        tris.append(tuple(t[k:] + t[:k]))
    return sorted(tris)

def vol_area(tris):
    V = A = 0.0
    for t in tris:
        a, b, c = [tuple(map(float, p)) for p in t]
        V += (a[0]*(b[1]*c[2] - b[2]*c[1]) - a[1]*(b[0]*c[2] - b[2]*c[0]) + a[2]*(b[0]*c[1] - b[1]*c[0]))/6
        u = [b[i] - a[i] for i in range(3)]; w = [c[i] - a[i] for i in range(3)]
        A += math.sqrt((u[1]*w[2] - u[2]*w[1])**2 + (u[2]*w[0] - u[0]*w[2])**2 + (u[0]*w[1] - u[1]*w[0])**2)/2
    return V, A

def bbox(tris):
    pts = [tuple(map(float, p)) for t in tris for p in t]
    return [f(p[i] for p in pts) for i in range(3) for f in (min, max)] if pts else None

def same(a, b):
    """→ (kod, opis)"""
    if not (os.path.exists(a) and os.path.exists(b)): return 1, "brak pliku"
    A, B = read(a), read(b)
    if not A or not B: return 1, "pusty STL"
    if A == B: return 0, f"identyczne trójkąty ({len(A)})"
    if len(A) == len(B) and {p for t in A for p in t} == {p for t in B for p in t}:
        (va, aa), (vb, ab) = vol_area(A), vol_area(B)
        if abs(va - vb) <= 1e-6*abs(va) and abs(aa - ab) <= 1e-5*aa:
            return 0, f"inna triangulacja tej samej bryły ({len(A)} ścian, V {va:.3f} mm³, pole {aa:.3f} mm²)"
    # inna siatka tej samej bryły (np. OpenSCAD 2021.01/CGAL wobec nightly/Manifold): prostopadłościan otaczający do
    # 1e-4 mm, objętość do 2e-5, pole do 1e-4 (względnie). Zmiana wymiaru o 0.01 mm na części 40 mm daje ≥ 2.5e-4 objętości.
    (va, aa), (vb, ab) = vol_area(A), vol_area(B)
    if bbox(A) is not None and all(abs(x - y) <= 1e-4 for x, y in zip(bbox(A), bbox(B))) \
       and abs(va - vb) <= 2e-5*abs(va) and abs(aa - ab) <= 1e-4*aa:
        return 0, f"inna siatka tej samej bryły ({len(A)} / {len(B)} ścian, V {va:.3f} / {vb:.3f} mm³, pole {aa:.3f} / {ab:.3f} mm²)"
    return 1, f"INNA BRYŁA ({len(A)} / {len(B)} ścian, V {va:.3f} / {vb:.3f} mm³)"

if __name__ == "__main__":
    rc, msg = same(*sys.argv[1:3]); print(msg); sys.exit(rc)
