# cad/web/lib — biblioteki obce (three.js)

Te trzy pliki **nie są częścią projektu**. To kopie biblioteki three.js, trzymane w repo po to, żeby podgląd
`cad/web/index.html` działał bez internetu. `cad/web/template.html` ładuje je jako `lib/three.min.js`,
`lib/STLLoader.js` i `lib/OrbitControls.js`.

| Plik | Co to jest | Adres źródłowy (z listy podmian w `cad/web/build_viewer.py`) |
|---|---|---|
| `three.min.js` | three.js, wydanie r128 (w pliku: `const e="128"`) | `https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js` |
| `STLLoader.js` | przykład z pakietu `three@0.128.0`, `examples/js/loaders/` | `https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/STLLoader.js` |
| `OrbitControls.js` | przykład z pakietu `three@0.128.0`, `examples/js/controls/` | `https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js` |

## Licencja
Nagłówek `three.min.js`:

```
@license
Copyright 2010-2021 Three.js Authors
SPDX-License-Identifier: MIT
```

`STLLoader.js` i `OrbitControls.js` nie mają w sobie żadnej noty o autorach ani licencji (zaczynają się od
`( function () {`). Pochodzą z tego samego pakietu three.js r128 co `three.min.js`, więc dotyczy ich ta sama nota:
Copyright 2010-2021 Three.js Authors, licencja MIT.

Pełny tekst licencji: `LICENSE.three` w tym katalogu — plik `LICENSE` z repozytorium three.js, znacznik `r128`
(pobrany 2026-11-12 z `raw.githubusercontent.com/mrdoob/three.js/r128/LICENSE`).

## Czego tu nie ma / czego nie sprawdzono
- Zgodność tych plików bajt w bajt z adresami źródłowymi nie była sprawdzana (ten opis powstał bez dostępu do
  sieci, 2026-11-11). Pochodzenie plików `STLLoader.js` i `OrbitControls.js` jest tu podane wyłącznie na podstawie
  adresów w `build_viewer.py`.
- Reszta repozytorium ma własny plik `LICENSE` (MIT, 2026-11-12); to osobna decyzja i nie wynika z licencji three.js.
