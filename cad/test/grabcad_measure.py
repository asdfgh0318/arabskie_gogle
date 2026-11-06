import numpy as np, struct, sys
F = sys.argv[1]
d = open(F, 'rb').read(); n = struct.unpack('<I', d[80:84])[0]
a = np.frombuffer(d[84:84 + n*50], dtype=np.dtype([('n', '<f4', 3), ('v', '<f4', (3, 3)), ('a', '<u2')]))
V = a['v'].astype(np.float64); V0, E1, E2 = V[:, 0], V[:, 1] - V[:, 0], V[:, 2] - V[:, 0]
def hits(o, dr):
    o = np.array(o, float); dr = np.array(dr, float)
    p = np.cross(dr, E2); det = (E1 * p).sum(1); ok = np.abs(det) > 1e-12
    inv = np.where(ok, 1 / np.where(ok, det, 1), 0); t0 = o - V0
    u = (t0 * p).sum(1) * inv; q = np.cross(t0, E1); v = (q * dr).sum(1) * inv; t = (q * E2).sum(1) * inv
    m = ok & (u >= 0) & (v >= 0) & (u + v <= 1) & (t > 0)
    return np.sort(t[m])
def first(o, dr):
    h = hits(o, dr); return h[0] if len(h) else None
print("bbox", V.reshape(-1, 3).min(0).round(1), V.reshape(-1, 3).max(0).round(1))
# 1. przednia ściana: x pierwszego trafienia z przodu
for y in [0, 17.75, -17.75, 30, 45]:
    row = []
    for z in [1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9.5, -11, -13, -16, -20, -25, -30, -35, -40, -45]:
        t = first([100, y, z], [-1, 0, 0]); row.append(f"{z}:{'-' if t is None else round(100 - t, 2)}")
    print(f"front y={y}: " + " ".join(row))
# 2. blat wokół gniazda: z pierwszego trafienia z góry
for (x, y) in [(0, 0), (10, 10), (-10, 10), (10, -10), (-10, -10), (15, 0), (20, 0), (-15, 0), (0, 25)]:
    t = first([x, y, 50], [0, 0, -1]); print(f"deck x={x} y={y}: z={'-' if t is None else round(50 - t, 2)}")
# 3. tył: mapa głębokości (x pierwszego trafienia od tyłu) w siatce y/z
print("rear depth map (x of first hit from behind), rows z, cols y")
ys = list(range(-60, 61, 6)); print("z\\y " + " ".join(f"{y:>5}" for y in ys))
for z in range(0, -50, -3):
    row = []
    for y in ys:
        t = first([-200, y, z], [1, 0, 0]); row.append(f"{'  -  ' if t is None else f'{t - 200:5.0f}'}")
    print(f"{z:>4} " + " ".join(row))
