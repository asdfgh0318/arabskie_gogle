#!/usr/bin/env python3
"""Nawisy w orientacji do druku (§4.2): ściany skierowane w dół, poza stołem. Sprawdza trzy rzeczy:

1. „nawis”: ściany pochyłe w dół bardziej niż 45° (−0.99 ≤ nz < −0.71) — dopuszczalne tylko drobne (< 1 mm² w skupisku,
   fasetowanie łuków).
2. „most”: płaski sufit (nz < −0.99) podparty z DWÓCH przeciwnych stron. Rozpiętość liczona wzdłuż kierunku, w którym
   jest najkrótsza (co 15°), od podpory do podpory; wypisywana, gdy największa rozpiętość w suficie > 10 mm.
3. „wspornik płaski”: część płaskiego sufitu, która w żadnym kierunku nie ma podpory po obu stronach (wisi z jednej
   strony albo z narożnika). Wypisywany, gdy ma ≥ 1 mm² i wysięg (odległość od najbliższej podpory) > 1.35 mm.
Punkty sufitu bliżej niż 1.35 mm od podpory (3 ścieżki 0.45 mm — ta sama reguła co przy stop_w w camera_mount.scad)
nie liczą się ani do mostu, ani do wspornika: wąska półka wzdłuż ściany nie jest „mostem” na całą swoją długość.

Podpora = materiał 0.05 mm pod sufitem (przekrój siatki), szukany do 1 mm za krawędzią sufitu (pod sufitem bywa skos,
np. płaski szczyt poziomego otworu okrągłego to mostek między jego zboczami). Raster 0.1 mm, więc wymiary ±0.2 mm. Progi 10 mm / 1.35 mm /
1 mm² to założenia skryptu, nie wynik prób druku. Skrypt nie zna slicera: nie ocenia zakotwienia mostu ani kierunku,
w którym slicer faktycznie go położy. Wyspy bez żadnego podparcia sprawdza float_check.py.

Użycie: overhang.py [--all] plik.stl [...]   — wypisuje tylko problemy; kod wyjścia 1 = problem.
        --all       dodatkowo wypisuje każdy płaski sufit ≥ 1 mm² („info”, bez wpływu na kod wyjścia)
        --selftest  bryły kontrolne (most 20 i 100 mm, wspornik 10 × 50, skos 60° MUSZĄ zostać wykryte; most 8 mm,
                    półka 0.8 mm, skos 40° i kostka muszą przejść); kod wyjścia 1 = skrypt nie działa
"""
import struct, sys, collections, math
import numpy as np

RES = 0.1          # [mm] raster sufitu
BRIDGE_MAX = 10.0  # [mm] dopuszczalna rozpiętość mostu
CANT_REACH = 1.35  # [mm] dopuszczalny wysięg płaskiej półki/wspornika (3 ścieżki 0.45 mm)
MIN_AREA = 1.0     # [mm²] mniejsze skupiska to fasetowanie
GAP = 1.0          # [mm] promień szuka podpory jeszcze tyle za krawędzią sufitu (skos pod sufitem, np. strop otworu poziomego)
DIRS = 12          # kierunki co 15°

def load(fn):
    d = open(fn, 'rb').read()
    if d[:5] == b'solid' and b'facet' in d[:400]:
        import re
        return np.array(re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', d), dtype=float).reshape(-1, 3, 3)
    n = struct.unpack('<I', d[80:84])[0]
    a = np.frombuffer(d[84:84 + n*50], dtype=np.dtype([('n', '<3f4'), ('v', '<9f4'), ('a', '<u2')]))
    return a['v'].reshape(-1, 3, 3).astype(float)

def clusters(T, idx):
    """skupiska ścian połączonych wspólnym wierzchołkiem"""
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
    return [np.array(c) for c in cl.values()]

def raster_tris(tris, xs, ys):
    """piksele (środki xs × ys), które leżą w rzucie któregoś trójkąta"""
    m = np.zeros((len(xs), len(ys)), bool)
    for t in tris:
        a, b, c = t[:, :2]
        den = (b[0] - a[0])*(c[1] - a[1]) - (c[0] - a[0])*(b[1] - a[1])
        if abs(den) < 1e-12: continue
        i0 = max(0, int((t[:, 0].min() - xs[0])/RES)); i1 = min(len(xs) - 1, int((t[:, 0].max() - xs[0])/RES) + 1)
        j0 = max(0, int((t[:, 1].min() - ys[0])/RES)); j1 = min(len(ys) - 1, int((t[:, 1].max() - ys[0])/RES) + 1)
        if i1 < i0 or j1 < j0: continue
        X, Y = np.meshgrid(xs[i0:i1 + 1], ys[j0:j1 + 1], indexing='ij')
        u = ((X - a[0])*(c[1] - a[1]) - (c[0] - a[0])*(Y - a[1]))/den
        v = ((b[0] - a[0])*(Y - a[1]) - (X - a[0])*(b[1] - a[1]))/den
        m[i0:i1 + 1, j0:j1 + 1] |= (u >= 0) & (v >= 0) & (u + v <= 1)
    return m

def section(T, zs, xs, ys):
    """przekrój siatki płaszczyzną z = zs jako raster (parzystość przecięć wzdłuż x w każdym wierszu y)"""
    z = T[:, :, 2]
    sel = (z.min(1) < zs) & (z.max(1) > zs)
    occ = np.zeros((len(xs), len(ys)), bool)
    if not sel.any(): return occ
    S = T[sel]; P = []
    for a, b in ((0, 1), (1, 2), (2, 0)):
        za = S[:, a, 2]; zb = S[:, b, 2]
        cr = (za - zs)*(zb - zs) < 0
        k = np.where(cr, (zs - za)/np.where(cr, zb - za, 1), np.nan)
        P.append(S[:, a, :2] + k[:, None]*(S[:, b, :2] - S[:, a, :2]))
    P = np.stack(P, 1)                                   # (n, 3, 2), jeden wiersz z trzech to NaN
    o = np.argsort(np.isnan(P[:, :, 0]), axis=1, kind='stable')
    P = np.take_along_axis(P, o[:, :, None], 1)[:, :2]   # dwa punkty odcinka
    p, q = P[:, 0], P[:, 1]
    for j, y in enumerate(ys):
        cr = (p[:, 1] - y)*(q[:, 1] - y) < 0
        if not cr.any(): continue
        x = np.sort(p[cr, 0] + (y - p[cr, 1])/(q[cr, 1] - p[cr, 1])*(q[cr, 0] - p[cr, 0]))
        for x0, x1 in zip(x[0::2], x[1::2]):
            occ[np.searchsorted(xs, x0):np.searchsorted(xs, x1), j] = True
    return occ

def ceilings(T, N, A, zmin):
    """płaskie sufity: dla każdego skupiska (wymiary, pole, rozpiętość mostu, pole i wysięg wspornika, środek)"""
    flat = (N[:, 2] < -0.99) & (T[:, :, 2].max(1) > zmin + 0.05) & (A > 1e-6)
    fidx = np.where(flat)[0]
    out = []
    for c in clusters(T, fidx):
        if A[c].sum() < MIN_AREA: continue
        P = T[c].reshape(-1, 3); lo = P.min(0); hi = P.max(0); z = lo[2]
        xs = np.arange(lo[0] - 1.0, hi[0] + 1.0, RES) + RES/2 + 1.1e-5
        ys = np.arange(lo[1] - 1.0, hi[1] + 1.0, RES) + RES/2 + 0.7e-5
        B = section(T, z - 0.05 + 1.3e-5, xs, ys)                       # materiał tuż pod sufitem = podpora
        same = fidx[np.abs(T[fidx, :, 2].min(1) - z) < 0.05]            # wszystkie sufity na tej wysokości
        Mall = raster_tris(T[same], xs, ys) & ~B
        Mc = raster_tris(T[c], xs, ys) & ~B
        if Mc.sum()*RES*RES < MIN_AREA: continue
        Bd = B.copy()                                                    # podpora poszerzona o 1 piksel (szew rastra)
        Bd[1:, :] |= B[:-1, :]; Bd[:-1, :] |= B[1:, :]; Bd[:, 1:] |= B[:, :-1]; Bd[:, :-1] |= B[:, 1:]
        pi, pj = np.where(Mc); n = len(pi)
        span = np.full(n, np.inf); reach = np.full(n, np.inf)
        nx, ny = Mc.shape
        for k in range(DIRS):
            th = math.pi*k/DIRS; d = np.array([math.cos(th), math.sin(th)])
            L = []; sup = []
            for sgn in (1, -1):
                ln = np.zeros(n); ok = np.zeros(n, bool); alive = np.ones(n, bool); gap = np.zeros(n, int); s = 0
                while alive.any():
                    s += 1
                    i = np.rint(pi + sgn*s*d[0]).astype(int); j = np.rint(pj + sgn*s*d[1]).astype(int)
                    inside = (i >= 0) & (i < nx) & (j >= 0) & (j < ny)
                    ic = np.clip(i, 0, nx - 1); jc = np.clip(j, 0, ny - 1)
                    inM = inside & Mall[ic, jc]
                    hit = alive & inside & ~inM & Bd[ic, jc]             # wyszedł z sufitu na podporę
                    ln[hit] = (s - 0.5)*RES; ok[hit] = True
                    gap = np.where(inM, 0, gap + 1)                      # piksele poza sufitem i poza podporą
                    dead = alive & ~hit & (~inside | (gap > GAP/RES))    # wolna krawędź
                    ln[dead] = (s - gap[dead] + 0.5)*RES
                    alive = alive & ~hit & ~dead
                L.append(ln); sup.append(ok)
            both = sup[0] & sup[1]
            span = np.where(both, np.minimum(span, L[0] + L[1]), span)
            for ln, ok in zip(L, sup): reach = np.where(ok, np.minimum(reach, ln), reach)
        far = reach > CANT_REACH                                         # bliżej podpory = półka, nie liczy się
        br = far & np.isfinite(span); ca = far & ~np.isfinite(span)
        Pm = np.array([xs[pi].mean(), ys[pj].mean(), z])
        out.append(dict(ext=(xs[pi].max() - xs[pi].min() + RES, ys[pj].max() - ys[pj].min() + RES), area=n*RES*RES,
                        span=span[br].max() if br.any() else 0.0, cant_area=ca.sum()*RES*RES,
                        cant_reach=reach[ca].max() if ca.any() else 0.0, at=Pm))
    return sorted(out, key=lambda r: (round(r['at'][2], 1), round(r['at'][0], 1), round(r['at'][1], 1)))

def check(T, list_all=False):
    """→ (problemy, informacje)"""
    N = np.cross(T[:, 1] - T[:, 0], T[:, 2] - T[:, 0]); A = np.linalg.norm(N, axis=1)/2
    N = N/np.maximum(2*A, 1e-12)[:, None]
    zmin = T[:, :, 2].min()
    off_bed = T[:, :, 2].max(1) > zmin + 0.05
    down = (N[:, 2] < -0.71) & off_bed & (A > 1e-6)
    probs = []; info = []
    for c in clusters(T, np.where(down)[0]):
        P = T[c].reshape(-1, 3)
        flat = N[c, 2] < -0.99; area_s = A[c][~flat].sum()
        if area_s >= MIN_AREA:
            probs.append(f"nawis {area_s:.1f} mm² (min nz {N[c,2].min():.2f}) przy x {P[:,0].mean():.1f}, y {P[:,1].mean():.1f}, z {P[:,2].mean():.1f}")
    for r in ceilings(T, N, A, zmin):
        where = f"sufit {r['ext'][0]:.1f} × {r['ext'][1]:.1f} mm, {r['area']:.1f} mm², przy x {r['at'][0]:.1f}, y {r['at'][1]:.1f}, z {r['at'][2]:.1f}"
        if r['span'] > BRIDGE_MAX:
            probs.append(f"most {r['span']:.1f} mm (> {BRIDGE_MAX:g}): {where}")
        if r['cant_area'] >= MIN_AREA and r['cant_reach'] > CANT_REACH:
            reach = "bez podpory" if not np.isfinite(r['cant_reach']) else f"wysięg {r['cant_reach']:.1f} mm (> {CANT_REACH:g})"
            probs.append(f"wspornik płaski {r['cant_area']:.1f} mm², {reach}: {where}")
        if list_all:
            reach = "bez podpory" if not np.isfinite(r['cant_reach']) else f"{r['cant_reach']:.1f} mm"
            info.append(f"info: {where}: poza pasem {CANT_REACH:g} mm przy podporach: most do {r['span']:.1f} mm, wspornik {r['cant_area']:.1f} mm² / wysięg {reach}")
    return probs, info

# ---------- bryły kontrolne ----------
def prism(outline, y0, y1):
    """graniastosłup: obrys (x, z) przeciwnie do ruchu wskazówek patrząc od −y, wyciągnięty wzdłuż y; siatka zamknięta"""
    pts = [np.array(p, float) for p in outline]; n = len(pts); tris = []
    v = lambda p, y: [p[0], y, p[1]]
    for i in range(n):
        a, b = pts[i], pts[(i + 1) % n]
        tris += [[v(a, y0), v(b, y1), v(b, y0)], [v(a, y0), v(a, y1), v(b, y1)]]
    idx = list(range(n))                                  # denka: obcinanie uszu
    cross = lambda o, a, b: (a[0] - o[0])*(b[1] - o[1]) - (a[1] - o[1])*(b[0] - o[0])
    while len(idx) > 2:
        for k in range(len(idx)):
            i0, i1, i2 = idx[k - 1], idx[k], idx[(k + 1) % len(idx)]
            if cross(pts[i0], pts[i1], pts[i2]) <= 1e-12: continue
            if any(all(cross(*e, pts[m]) > 1e-12 for e in ((pts[i0], pts[i1]), (pts[i1], pts[i2]), (pts[i2], pts[i0])))
                   for m in idx if m not in (i0, i1, i2)): continue
            tris += [[v(pts[i0], y0), v(pts[i1], y0), v(pts[i2], y0)], [v(pts[i0], y1), v(pts[i2], y1), v(pts[i1], y1)]]
            idx.pop(k); break
        else: raise RuntimeError("triangulacja denka")
    return np.array(tris, float)

def gate(gap, w=10.0):   # dwa słupy 5 × 10 i belka 3 nad przerwą `gap`
    return prism([(0, 0), (5, 0), (5, 10), (5 + gap, 10), (5 + gap, 0), (10 + gap, 0), (10 + gap, 13), (0, 13)], 0, w)
def arm(reach, w=10.0):  # słup 10 × 10 i płaskie ramię 3 o wysięgu `reach`
    return prism([(0, 0), (10, 0), (10, 10), (10 + reach, 10), (10 + reach, 13), (0, 13)], 0, w)
def lean(deg):           # ściana 5 × 20 pochylona o `deg` od pionu
    dx = 20*math.tan(math.radians(deg))
    return prism([(0, 0), (5, 0), (5 + dx, 20), (dx, 20)], 0, 10)

def selftest():
    cases = [("most 20 mm (szer. 10)", gate(20), "most"), ("most 100 mm (szer. 10)", gate(100), "most"),
             ("wspornik płaski 10 × 50", arm(50, 10), "wspornik"), ("wspornik płaski 50 × 10", arm(10, 50), "wspornik"),
             ("skos 60° od pionu", lean(60), "nawis"),
             ("most 8 mm", gate(8), None), ("półka 0.8 mm", arm(0.8), None), ("skos 40° od pionu", lean(40), None),
             ("kostka", prism([(0, 0), (10, 0), (10, 10), (0, 10)], 0, 10), None)]
    bad = 0
    for name, T, want in cases:
        probs, _ = check(T)
        got = sorted({p.split()[0] for p in probs})
        ok = (got == [want]) if want else not got
        if not ok:
            bad = 1; print(f"SELFTEST BŁĄD: {name}: oczekiwano {want or 'brak problemów'}, jest {got or 'brak'}: {probs}")
    if not bad: print(f"overhang.py selftest OK ({len(cases)} brył kontrolnych: 5 musi być wykrytych, 4 muszą przejść)")
    return bad

if __name__ == "__main__":
    args = sys.argv[1:]
    if "--selftest" in args: sys.exit(selftest())
    list_all = "--all" in args
    files = [a for a in args if not a.startswith("--")]
    if not files: print(__doc__); sys.exit(2)
    bad = 0
    for fn in files:
        probs, info = check(load(fn), list_all)
        for p in probs + info: print(f"{fn}: {p}")
        bad |= bool(probs)
    sys.exit(bad)
