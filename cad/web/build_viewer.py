#!/usr/bin/env python3
"""Buduje podgląd 3D (cad/web): index.html (gogle zastępcze, do repo) i full.html (gogle GrabCAD, tylko lokalnie,
gdy plik modelu jest w papers/). Pokazuje tylko mocowanie kamer v0.6 (bez poda i AI Boxa).
Uruchom: python3 cad/web/build_viewer.py (z dowolnego katalogu); serwer: cd cad/web && python3 -m http.server 8765
→ http://127.0.0.1:8765/ (index.html) albo /full.html.
Kod wyjścia 1 i brak zapisu pliku, jeśli którakolwiek część się nie wyeksportuje (błąd/ostrzeżenie OpenSCAD, pusty STL)."""
import base64, json, os, shutil, struct, subprocess, sys, tempfile, concurrent.futures as cf
HERE = os.path.dirname(os.path.abspath(__file__)); os.chdir(HERE)
GRAB = '../../papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/hdo_grabcad_goggle_frame.stl'
PARTS = [["hdo2", "Gogle HDO2", "#3a3f46", 1], ["adapter", "Adapter: gniazdo wentylatora, kask, popychacze", "#4f86c6", 1],
         ["knob", "Pokrętło M5 (lewa)", "#e07b24", 1], ["hw", "Śruba M5, popychacze M3 (atrapy)", "#d0d4d8", 1],
         ["cage", "Klatka kamer", "#e0b43a", 1], ["shroud", "Nakładka: daszek termo + tuba Infra", "#6b8e23", 1],
         ["cams", "Kamery termo + Infra", "#6e747b", 1], ["cables", "Przewody (początek)", "#111111", 1]]
# Powtarzalność: OpenSCAD zapisuje ściany w kolejności zależnej od adresów w pamięci, więc (1) uruchamiamy go z
# wyłączoną randomizacją adresów (setarch -R, jeśli jest) i (2) każdy STL sprowadzamy do postaci kanonicznej:
# stały nagłówek, trójkąt zaczyna się od najmniejszego wierzchołka, trójkąty posortowane, normalna policzona tu
# z wierzchołków (normalnych z pliku nie bierzemy: dla ścian o zerowym polu OpenSCAD zapisuje zera o różnym znaku,
# 0.0 albo -0.0, i dwa buildy różniły się tylko tym). Dwa kolejne buildy z tych samych źródeł dają wtedy
# identyczny index.html.
SETARCH = [shutil.which("setarch"), "-R"] if shutil.which("setarch") else []
tmp = tempfile.mkdtemp()
def normal(f):
    """Normalna jednostkowa trójkąta z 9 współrzędnych; (0, 0, 0) dla ściany o zerowym polu; bez -0.0."""
    ux, uy, uz = f[3]-f[0], f[4]-f[1], f[5]-f[2]; vx, vy, vz = f[6]-f[0], f[7]-f[1], f[8]-f[2]
    n = (uy*vz - uz*vy, uz*vx - ux*vz, ux*vy - uy*vx); l = (n[0]*n[0] + n[1]*n[1] + n[2]*n[2]) ** 0.5
    return tuple(c/l + 0.0 for c in n) if l > 0 else (0.0, 0.0, 0.0)
# OpenSCAD: zmienna SCAD wymusza program; domyślnie openscad-nightly (Manifold, szybki), inaczej openscad
SCAD = os.environ.get("SCAD") or shutil.which("openscad-nightly") or "openscad"
def canon(raw):
    n = struct.unpack('<I', raw[80:84])[0]
    assert len(raw) == 84 + 50*n, "to nie jest binarny STL"
    tris = []
    for i in range(n):
        r = raw[84 + 50*i: 84 + 50*i + 50]
        v = [r[12:24], r[24:36], r[36:48]]; k = min(range(3), key=lambda j: struct.unpack('<3f', v[j]))
        v = v[k:] + v[:k]
        f = struct.unpack('<9f', b''.join(v))
        tris.append((f, struct.pack('<3f', *normal(f)) + b''.join(v) + b'\0\0'))
    tris.sort(key=lambda t: t[0])
    return b'arabskie_gogle viewer part'.ljust(80, b' ') + struct.pack('<I', n) + b''.join(t[1] for t in tris)
def exp(w, grab):
    """→ (ścieżka, None) albo (None, opis błędu). Każda część z PARTS MUSI się wyeksportować."""
    out = os.path.join(tmp, f"{w}_{int(grab)}.stl")
    r = subprocess.run(SETARCH + [SCAD, "--export-format", "binstl", "-o", out, "-D", f'which="{w}"', "-D", f"grab={'true' if grab else 'false'}", "export_parts.scad"],
                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    msgs = [l for l in r.stdout.splitlines() if any(k in l for k in ("ERROR", "WARNING", "Parser error", "Can't", "top level object is empty"))]
    if r.returncode != 0 or msgs or not os.path.exists(out) or os.path.getsize(out) <= 84:
        return None, f'which="{w}" grab={grab}: kod wyjścia {r.returncode}; ' + ("; ".join(msgs[:3]) or "brak pliku STL / pusty STL")
    return out, None
def build(grab, fname):
    with cf.ThreadPoolExecutor(8) as ex: res = dict(zip([p[0] for p in PARTS], ex.map(lambda p: exp(p[0], grab and p[0] == "hdo2"), PARTS)))
    errs = [e for _, e in res.values() if e]
    if errs:
        for e in errs: print(f"BŁĄD OpenSCAD ({fname}): {e}", file=sys.stderr)
        print(f"NIEZALICZONE: {fname} nie został zapisany (poprzedni plik bez zmian)", file=sys.stderr)
        return False
    note = ("v0.6: adapter na gnieździe wentylatora (nogi do kasku, popychacze M3 na przedniej ścianie = kierunek), przegub GoPro "
            "z zapadkami 0/10/20° i pokrętłem po lewej, klatka z nakładką (daszek termo, tuba Infra). Pochylenie 10°. Gogle: "
            + ("model GrabCAD (oryginalne HDO, wymiary wg autora niedokładne)." if grab else "bryła zastępcza z wymiarów."))
    scenes = {"v06": {"tab": "Mocowanie v0.6", "note": note, "parts": PARTS}}
    data = {f"v06_{p[0]}": base64.b64encode(canon(open(res[p[0]][0], 'rb').read())).decode() for p in PARTS}
    t = open('template.html', encoding='utf-8').read().replace('__SCENES__', json.dumps(scenes, ensure_ascii=False)).replace('__DATA__', json.dumps(data))
    for a, b in [('https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js', 'lib/three.min.js'),
                 ('https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/STLLoader.js', 'lib/STLLoader.js'),
                 ('https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js', 'lib/OrbitControls.js')]:
        t = t.replace(a, b)
    open(fname, 'w', encoding='utf-8').write(t); print(fname, len(t), [p[0] for p in PARTS])
    return True
try:
    ok = build(False, 'index.html')
    if os.path.exists(GRAB): ok = build(True, 'full.html') and ok
finally:
    shutil.rmtree(tmp, ignore_errors=True)
sys.exit(0 if ok else 1)
