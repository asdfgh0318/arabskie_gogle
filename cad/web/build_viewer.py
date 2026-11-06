#!/usr/bin/env python3
"""Buduje podgląd 3D (cad/web): index.html (gogle zastępcze, do repo) i full.html (gogle GrabCAD, tylko lokalnie).
Uruchom z cad/web: python3 build_viewer.py; serwer: python3 -m http.server 8765 → http://127.0.0.1:8765/full.html"""
import base64, json, os, subprocess, tempfile, concurrent.futures as cf
HERE = os.path.dirname(os.path.abspath(__file__)); os.chdir(HERE)
GRAB = '../../papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/hdo_grabcad_goggle_frame.stl'
PARTS = [["hdo2", "Gogle HDO2", "#3a3f46", 1], ["adapter", "Adapter: gniazdo wentylatora, kask, popychacze", "#4f86c6", 1],
         ["knob", "Pokrętło M5 (lewa)", "#e07b24", 1], ["hw", "Śruba M5, popychacze M3 (atrapy)", "#d0d4d8", 1],
         ["cage", "Klatka kamer", "#e0b43a", 1], ["shroud", "Nakładka: daszek termo + tuba Infra", "#6b8e23", 1],
         ["cams", "Kamery termo + Infra", "#6e747b", 1], ["cables", "Przewody (początek)", "#111111", 1]]
tmp = tempfile.mkdtemp()
def exp(w, grab):
    out = os.path.join(tmp, f"{w}_{int(grab)}.stl")
    subprocess.run(["openscad", "--export-format", "binstl", "-o", out, "-D", f'which="{w}"', "-D", f"grab={'true' if grab else 'false'}", "export_parts.scad"],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    return out
def build(grab, fname):
    with cf.ThreadPoolExecutor(8) as ex: files = dict(zip([p[0] for p in PARTS], ex.map(lambda p: exp(p[0], grab and p[0] == "hdo2"), PARTS)))
    note = ("v0.6: adapter na gnieździe wentylatora (nogi do kasku, popychacze M3 na przedniej ścianie = kierunek), przegub GoPro "
            "z zapadkami 0/10/20° i pokrętłem po lewej, klatka z nakładką (daszek termo, tuba Infra). Pochylenie 10°. Gogle: "
            + ("model GrabCAD (oryginalne HDO, wymiary wg autora niedokładne)." if grab else "bryła zastępcza z wymiarów."))
    parts = [p for p in PARTS if os.path.getsize(files[p[0]]) > 84]
    scenes = {"v06": {"tab": "Mocowanie v0.6", "note": note, "parts": parts}}
    data = {f"v06_{p[0]}": base64.b64encode(open(files[p[0]], 'rb').read()).decode() for p in parts}
    t = open('template.html').read().replace('__SCENES__', json.dumps(scenes, ensure_ascii=False)).replace('__DATA__', json.dumps(data))
    for a, b in [('https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js', 'lib/three.min.js'),
                 ('https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/STLLoader.js', 'lib/STLLoader.js'),
                 ('https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js', 'lib/OrbitControls.js')]:
        t = t.replace(a, b)
    open(fname, 'w').write(t); print(fname, len(t), [p[0] for p in parts])
build(False, 'index.html')
if os.path.exists(GRAB): build(True, 'full.html')
