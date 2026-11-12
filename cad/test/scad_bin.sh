# Wybór programu OpenSCAD dla skryptów w cad/test (source). Zmienna SCAD wymusza konkretny program.
# Domyślnie openscad-nightly, jeśli jest (backend Manifold: części v0.6 renderują się w 1–2 s zamiast 20–100 s
# w OpenSCAD 2021.01 z CGAL), inaczej zwykły openscad. Ta sama bryła, inna siatka trójkątów — patrz stl_same.py.
SCAD=${SCAD:-$(command -v openscad-nightly || command -v openscad)}
[ -n "$SCAD" ] || { echo "BŁĄD: brak OpenSCAD (ani openscad-nightly, ani openscad)"; exit 1; }
export SCAD
