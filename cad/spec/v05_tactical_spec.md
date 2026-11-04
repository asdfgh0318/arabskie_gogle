# camera_mount v0.5 design spec: "PANCERZ+" (goggle mount and camera heads only)

**Status:** working draft, nothing built or rendered yet. This spec is derived from the three concepts, the two judge reports and `cad/camera_mount.scad` v0.4.
- For any parameter carried over unchanged, `camera_mount.scad` governs.
- Values marked [calc] are hand estimates and must be recomputed from the model. Values marked [A] are assumptions.
- Camera dimensions are still from shop drawings. The HDO2 dimensions are from research/06 and have not been measured on the hardware.

## 0. Basis

| Concept | Judge 1 | Judge 2 | Role in v0.5 |
|---|---|---|---|
| PANCERZ (fork + brow + monocoque + PA66 fuse) | **7.35** | **7.40** | Baseline |
| Saddle (one rigid part, kinematic yaw) | 6.60 | 6.85 | Grafted: pushers take yaw by shape; cameras pulled back; overhang check from STL normals; test coupon first |
| FIELD (rosette, knob, flip-up) | 5.98 | 6.30 | Grafted: knob on the left; every in-use action turns about y; witness line; flip-up rule and cold shoe kept for later |

Three things change from PANCERZ as drawn:
1. **Judge defect fixed.** In PANCERZ the pad preload passed through the PA66 bolts. In v0.5 the preload goes into a **steel locator pin**. The PA66 fuse bolt sits in a hole slotted along x, so it carries only the pitch couple.
2. **The knob moves to the wearer's LEFT (+y)**, matching the left-hand pod. The fixed screw goes on the right, and cables run right toward the AI Box.
3. **Two new checks:**
   - an insertion-path check, because PANCERZ's 6 mm inner trunnion bosses block the thermal head when it is loaded from the rear;
   - an Infra field-of-view check at **108×92°**, the rectilinear worst case for 120° diagonal at 4:3. PANCERZ only checked 96×72°.

## 1. Goals

1. Yaw between camera and goggles stays **≤0.5° and adjustable in the field**, with no reprint. It is held by shape, not by friction in the fan-screw holes.
2. Thermal lens sits at **0…+35 mm** above the eye axis, with Infra stacked above. Tilt adjusts 0–20° (nominal 10°) using one gloved left hand.
3. **Nothing enters either field of view.** Thermal is 50×37.2° from the full Ø16 aperture. Infra is 108×92° and 96×72° from the full Ø19 glass.
4. **Break-away is kept, and every load direction has a defined failure order** (§2.3). A hit never puts a rigid lever into the face.
5. The forward moment about the goggle front wall is no larger than v0.4's.
6. **Three load-bearing printed parts** (BASE, FORK, CAGE), plus two small non-structural accessories (rear cover, knob) on one plate. Everything is PETG on the MK4 with no supports.
7. **Tactical function without copying any product:** lens hood, recessed Infra tube, side arms that guard the cage, a gloved knob, and a rugged, chamfered look. Commercial names and shapes are not used.

## 2. Architecture

### 2.1 Frames (unchanged)
- **Goggle/adapter frame:** x forward, y left, z up. Origin is the fan centre on the deck plane.
- **Cage frame:** same axes. Origin is the centre of the thermal body's front face (the thermal optical axis).
- Placement:
  - At tilt 0 the cage origin is at goggle x **X0 = 55.0**.
  - The trunnion axis is at cage (piv_x = −18.9, piv_z = 0), which is goggle (**PX = 36.1, PZ = piv_rel_seat = −11.0**).
  - PZ = piv_above_eye 12 − seat_above_eye 23.

### 2.2 Parts and load paths
- **BASE:** fan-seat plate, a clevis block, and the helmet GoPro legs. It is the only part screwed to the goggles.
- **FORK:** a tongue sitting in the BASE clevis, a brow beam, two arms, and two yaw pushers bearing on the goggle front wall.
- **CAGE:** a rear-loaded monocoque with the thermal hood and Infra tube, swinging on the FORK trunnion.

The load paths:
- **Yaw:** goggle front wall → 2 pushers → FORK → steel pin (+x stop) → BASE.
  - Kinematic: two −x point stops (the pushers) and one +x stop (the pin). Any yaw drives one pusher into the wall.
  - The fan-screw hole play (±0.6–1.6°) is no longer in the yaw chain.
- **Pitch (FORK↔BASE):** steel pin plus PA66 M2.5 fuse bolt, a couple in z.
- **Helmet:** helmet legs → plate → 4 fan screws, as in v0.4. Nothing passes through the fuse.

### 2.3 Failure order by load direction (all [calc], to be confirmed by §4.3 tests)

| Load on the cameras | 1st | 2nd | Protected |
|---|---|---|---|
| Lens pushed **down** | Trunnion slips at 0.5–0.9 N·m. The cage swings freely to about 60–65°, until its rear-bottom chamfer touches the shell | Pushers press the wall | Fan screws (only at the end of the swing) |
| Lens pushed **up** | Cage stops on the brow at about −2.5° | **PA66 fuse shears at 1.6–1.9 N·m wet / 2.4–2.7 dry**, about 29–49 N at the thermal lens. The FORK then hinges up on the steel pin | Fan screws, which see about 60 N each at the dry threshold |
| **Sideways** | FORK arm roots break between layers at about 95–150 N at the pivot. The cage then hangs on the tether | n/a | Fan screws, about 27 N each |
| **Frontal (−x)** | Hood rim takes the hit. The pushers put the wall in compression | Not fused (true of all concepts) | n/a |

## 3. MUST: v0.5, implementable now, no new measurements

### M1. BASE: fan-seat plate, clevis block, helmet legs
**Geometry (goggle frame):**
- **Plate:** x,y ∈ [−12.5, 12.5], z [0, 3]. Kept from v0.4:
  - fan holes Ø2.3 (`m2_d`) at (±10, ±10);
  - counterbore Ø4.2 (`screw_cb_d`) from z = 1.2, i.e. `screw_cb_h` 1.8.
  - No fitted pivot hole. BASE yaw no longer sets boresight.
- **Clevis block:** x [0, 18.0], y [−8.0, 8.0], z [0, 12.0], edge radius R1.
  - **Underside forward of the plate:** a 45° chamfer from (x 12.5, z 0) to (15.5, 3.0), then flat at z = 3.0 out to x = 18. This replaces `deck_relief` and avoids a long overhang.
  - **Wells over the front fan screws:** Ø5.0, vertical, at (10, ±10), from z 1.2 to the top. They notch the block edges, so the front screws stay reachable with the FORK fitted.
- **Tongue slot:** x [3.0, 18.0] (open at the front), y [−3.2, 3.2], z [3.0, 12.0] (open at the top).
- **Steel locator pin hole:**
  - along y at (x 7.0, z 7.0), Ø3.2, as a teardrop with its tip toward +z;
  - M3 nut pocket (8.2 mm across corners, 6-sided, 2.6 deep) on the −y cheek face, corner toward +z.
- **PA66 fuse bolt hole:**
  - along y at (x 16.0, z 7.0), Ø2.7 teardrop;
  - M2.5 nut pocket (5.0 across flats, 2.2 deep) on the −y face.
  - Parameter `fuse_d` takes 2.5 (default) or 2.0.
- **Helmet legs:** v0.4 geometry unchanged.
  - `helm_x` −5, `helm_z` 18, `helm_y` ±3.15, `gp_leg` 3, `gp_od` 15, hole Ø5.5 teardrop with tip toward +z, `gp_slit` from the coupon.
  - Leg root: hull from the plate-top rectangle x [−12.5, 2.5] to the disc. The legs merge into the block at x 0–2.5.
- **Tether hole:** Ø2.0 along y at (x 1.5, z 10.5), teardrop.

**Print:** plate down, so the seat datum is the bed. No brim, 4 perimeters, about 35 min [est]. The legs and cheeks grow as vertical fins and all horizontal holes are teardrops.

**Verify:**
- No overlap with the goggle ghost box or the GrabCAD envelope (`papers/hdo2_body_models/.../hdo_grabcad_goggle_frame.stl`) at front_x 21.6, 23.1, 24.6.
- STL normals in print orientation: no downward face with nz < −0.71 except the plate bottom and flat overhangs ≤2.5 mm.
- Manifold export.

### M2. FORK↔BASE joint: steel pin carries the preload, PA66 bolt is the pitch fuse
**Geometry:**
- **FORK tongue:** x [3.3, 18.5], y [−2.8, 2.8] (0.4 per side, giving ±2° yaw range about the pin), z [3.3, 12.0].
- **Tongue holes:**
  - pin hole Ø3.3 at (7.0, 7.0);
  - fuse hole: a **slot along x**, hull of two Ø2.7 circles at x 15.7 and 16.3, z 7.0. It is tight in z and free in x, so the PA66 carries no x preload;
  - both with 45° tops toward −z, which is "up" in the FORK print.
- **Hardware:**
  - steel M3×16 ISO 7380 button head through the pin hole, from +y, with a nut in the −y pocket and Loctite 222;
  - **PA66 M2.5×16 pan head** from +y, with a steel M2.5 nut in the trap, tightened by hand to about 0.1 N·m.
- **Tether:** 1 mm dyneema, about 120 mm, from the BASE tether hole to the CAGE anchor (M6).

**Why:** the pushers' +x reaction goes only into steel, through PETG bearing at about 1 MPa. The yaw chain never passes through PA66. The fuse is replaceable in the field (one screw).

**Verify ([calc], re-derive):**
- **Fuse moment:** M_f = s·2·A_s·τ, with s = 9.0 mm, A_s = 3.0 mm² (M2.5 minor diameter), τ_PA66 45–50 MPa dry / 30–35 wet [A]. This gives **2.4–2.7 / 1.6–1.9 N·m**, i.e. 44–49 / 29–34 N at the thermal lens (55 mm lever).
- **Steady load on the PA66:** pusher moment = 12 N × 12 mm lever (pusher z −5 to joint z 7) = 0.15 N·m. That gives 17 N bolt couple and τ ≈ 2.8 MPa, about 6–9% of strength, so creep is negligible.
- **Over-tightening:** 80 N on a pusher (finger torque on a 1.5 mm key) gives 0.96 N·m. That is below the wet fuse, with 1.6× margin.
- **Pin tear-out in the tongue:** 2 × 2.1 × 5.6 × 25 ≈ 590 N, far above the preload.
- **Tongue shear-out under nose-up:** 2 × 2.35 × 5.6 × 25 ≈ 660 N, which is 2.2× the 300 N fuse couple.
- **Fan screws at the dry threshold:** 2.7 N·m / 22.5 mm → about 60 N per rear screw. Their capacity is unknown, see S3.
- **Collision:** tongue vs slot with clearances must be empty, at yaw ±2° about the pin.

### M3. FORK: brow, arms, trunnion holes
**Geometry:**
- **Brow:** x [18.5, brow_x1 = 28.6], y ±18.75, z [5.0, 12.0], R1.5.
  - brow_x1 = cage rear at tilt 0 − 1.0. This makes the brow the cage's **up-stop at about −2.5°**.
  - Two underside lightening pockets: x [20.1, 27.0], |y| [4.5, 13.0], z [5.0, 10.4], open downward.
- **Brow and tongue tops are coplanar at z = 12.0** (the print bed).
- **Arms:** plates at y ±[arm_in 14.75, 18.75] (arm_t 4.0). Profile in XZ:
  - hull of the brow-root rectangle x [18.5, 28.6] × z [5, 12], the pivot eye Ø12 at (36.1, −11.0), and the pusher boss (M4);
  - minus the goggle keep-out x < front_x + front_tol + 0.5 = 25.1 for z < 0.5;
  - R3 fillets where the arms meet the brow.
  - arm_in = cage_y 12.45 + boss_out 2.0 + 0.3.
- **Trunnion holes along y at (36.1, −11.0):** +y (left) Ø4.4, −y (right) Ø3.4, both teardrops.
- **Tilt pointer:** a 1.5 mm triangular tip on the **−y** arm eye, pointing +x, reaching from r 6.0 to 7.6 about the pivot, full arm thickness.

**Print:** z = 12 plane on the bed (brow top down). Arms and bosses grow up as fins, 29 mm tall. No brim, 4 perimeters, about 40 min [est].

**Verify:**
- **Overhang:** STL normals in print orientation give nz ≥ −0.71. This checks the arms' front-top edges, which are about 70° from horizontal [calc].
- **Lateral fuse:** two arm roots at z = 5, each x ≈ 11.5 × t 4, Z = 2 × 30.7 mm³. At σ_interlayer 25 MPa → M ≈ 1.5 N·m, F ≈ 95 N at the pivot (16 mm lever). With R3 fillets the target is **100–150 N** [calc].
- **BASE cheeks** are tied by the steel pin and must not fail before the arms (side pull test, §4.3).
- **Collision:** FORK vs goggle ghost and GrabCAD at all front_x; FORK vs BASE.

### M4. Yaw key: two pushers on the goggle front wall
**Geometry:**
- **Boss on each arm:** x [pad_x0 = front_x + front_tol + 1.0 = 25.6, 31.6], y ±[14.75, 20.75] (thickened outward only), z [pad_z − 4, pad_z + 4], R1.
  - **pad_z = −5.0** (parameter; feasible range −4.5…−6.5 with this layout).
  - Thread: **M3 tapped directly into a printed Ø2.5 hole**, 6 mm long along x, on axis (y ±17.75, z pad_z).
  - Bore forward of the thread for clearance and key access: Ø3.4 to x 35.0, then Ø2.0 out through the arm surface.
- **Pusher:** M3×10 set screw (ISO 4026 flat point) with a nylon tip or a glued Ø3 × 1 PTFE dot.
  - Extension past the boss rear face is 1.0–4.0 mm, which covers front_x 21.6–24.6. Thread engagement is 6 mm at both ends of the range.
- **Span 35.5 mm** → 1 turn = 0.81°, **1/8 turn ≈ 0.10°**. Range about ±2°, limited by the tongue clearance.

**Procedure (README):**
1. Back off both pushers.
2. Bring each to touch the wall.
3. Point at a warm target 10 m away. Turn one pusher in and the other out by equal amounts until the target is centred.
4. Finish both at touch + 1/8 turn (about 5–15 N).
5. Paint witness lines across the pusher/boss, the FORK/BASE joint, and the plate edge/shell. A slip shows as a broken line.

**Verify:**
- **Kinematics** [calc, check in the model]:
  - rotation about either pusher drives the pin +x, which is blocked;
  - rotation about the pin drives one pusher −x, which is blocked.
- **Key path:** the Ø2.0 key cylinder along each pusher axis, out to x = 80, must not intersect the knob, hub, cage or arm at tilt 0/10/20.
- **Web:** the Ø3.4 bore must keep ≥2.0 mm of material to the Ø4.4 trunnion hole.
- The boss rear face must be ≥0.5 mm from the ghost wall at front_x 24.6.

### M5. Trunnion tilt: two-sided, knob on the left, fixed screw on the right
**Geometry:**
- **Cage pivot bosses** at cage (−18.9, 0):
  - Ø9, protruding 2.0 outside each wall (|y| 12.45–14.45);
  - **inward only to |y| = 10.15**, which clears the thermal pocket so the camera can be loaded from the rear. PANCERZ's 6 mm-deep inner bosses blocked this path.
- **Heat-set inserts from the outside:**
  - +y: short M4 insert, hole Ø5.6 × 5.0;
  - −y: short M3 insert, hole Ø4.0 × 4.0.
  - Bolt tips must stop ≥0.3 mm short of the boss inner face.
- **Interfaces:** PETG on PETG (no PTFE, because friction is the function). Gap 0.3 per side between boss and arm.
- **Right (−y):** M3×10 ISO 7380 + Loctite 222, set once.
- **Left (+y):** knob (M8) with a captive M4 hex bolt (thread engagement ≥3.5 mm, length from the stack). Wave washer DIN 137B M4 between the hub and the arm. A nylon-patch bolt is preferred so the bolt cannot back out fully.
- **Tilt scale:**
  - Engraved 0.4 mm deep on the cage's **−y** outer wall, on the forward arc around the pivot.
  - Lines 0.5 wide at 0/5/10/15/20°, r 8.0–9.5; the 10° lines run r 7.8–10.5.
  - Read against the M3 pointer.

**Verify:**
- **Slip torque** [calc]: T = Σ μ·N·r_m, with μ 0.3–0.4, r_m 3.35, N ≈ 250–400 N (hand-tight M4) plus about 250 N (M3) → **0.5–0.9 N·m**.
  - It must be above the camera inertia at 3 g (about 0.02 N·m) and below the fuse (1.6 N·m wet).
- **Swing sweep at front_x 24.6:** first contact angles must be about −2.5° (cage on brow) nose-up and ≥55° nose-down (cage on goggle wall).
  - Hand estimate: the rear-bottom chamfer corner reaches the wall at about 65°.
  - No contact anywhere in −2…+22°.
- **Lens heights** (ECHO), seat_above_eye 23:
  - thermal **12.0 / 7.5 / 3.0**, Infra **33.5 / 27.6 / 21.3** at tilt 0/10/20.
  - Also print the values for seat 19 and 29. Thermal at 19/tilt 20 is −1.0 and Infra at 29/tilt 0 is 39.5, so both need S1.

### M6. CAGE: rear-loaded monocoque (cage frame)
**Geometry:**
- **Outer:** x [cage_x1 −25.4, face_x 12.6], y ±12.45, z [−11.95, 33.95], R2.
  - **side_t 2.0** (was 2.5), cage_y = ir_w/2 + clr + side_t.
  - Rear-bottom chamfer 5×45°.
- **Thermal:**
  - pocket ±9.95 × ±9.95, open to the rear through the bay;
  - the body seats against the **front frame at x = 0**;
  - lens bore Ø16.6 to x 7.3.
- **Infra:**
  - `ir_setback` 6.0, so the body front is at x −6.0 against an annular frame;
  - bore Ø19.6, glass at x 13.1;
  - pocket open to the rear.
- **M2 slots:** Ø2.3, slot_len 3.0. Thermal at x −5.2, z 0. Infra at x −13.5, z 21.5.
- **Cable bay:** y ±10.45, z [−9.95, 21.5], from cage_x1 to −12.7, plus 2.5 behind the Infra.
- **Tether anchor:** Ø2.0 hole along z through the top bridge at x = cage_x1 + 4. Knot the cord inside the bay.
- `ir_yaw_trim` is kept (Infra relative to thermal, cage reprint). `th_yaw_trim` is **removed**.

**Print:** front down (the x = 12.6 plane on the bed).
- Add 45° chamfers at every box→hood and box→tube shelf (1–4 mm today).
- Make the outer pivot bosses and insert holes teardrop-shaped, tip toward −x.
- Give the M2 slots 45° roofs.
- 5 mm outer brim (footprint about 260 mm², 38 mm tall). About 75 min [est].

**Verify:**
- Cameras vs cage at their seats: empty.
- **Insertion path:** sweep each camera body envelope (+clr) from x −45 to its seat. The swept volume vs the cage must be empty.
- Centre of gravity of the camera stack (assume [A] thermal 10 g, Infra 15 g) is about x 38 in the goggle frame (PANCERZ 38.4; v0.4 45.6).

### M7. Thermal hood and Infra tube (cage front)
**Geometry:** as PANCERZ.
- **Thermal hood:**
  - interior = the thermal keep-out from the **full Ø16 aperture** (th_ap 8) plus hood_m 0.5, flaring 25° horizontally and 18.6° vertically;
  - wall hood_t 1.6, exit about 21.9 × 20.6 at x 12.6;
  - 45° chamfer back to the Ø16.6 bore;
  - drain notch 2×2 in the floor at y ±1.
- **Infra tube:** ID 19.6, OD 22.8, ends at x 12.6, i.e. **0.5 mm behind the glass**.
- **Rain strip:** 16 × 1.6 on z_top out to x 13.6. Rib 1.6 from tube to strip; web 1.6 from hood to tube (z 9–13).
- Everything forward ends in the single plane x = 12.6.

**Verify:**
- **Thermal FOV:** intersection of the keep-out (L = 300) with all parts, cameras and goggle ghost must be empty.
- **Infra FOV, 108×92° and 96×72° from the full Ø19 glass:** intersection must be empty. These pass by construction, since nothing lies ahead of the glass plane, but run them anyway.
- **Positive controls:** move the hood margin to −0.5 and the check must report a hit.
- Run at tilt 0/10/20 × front_x 21.6/23.1/24.6.

### M8. Accessories (one plate): rear cover and knob
- **Cover** (cage frame), plate 1.5 thick at x [−25.4, −23.9], y ±11.85:
  - 45° strip matching the chamfer;
  - 4 posts 2.4 × 2.4 at (y ±7.75, z ±7.75), long enough to stop 0.3 short of the thermal rear (x −13.0). They clear the inner pivot bosses (|y| ≥ 10.15 at z ±4.5);
  - 2 mm EVA behind the Infra;
  - **cable exit 6 × 5 at the bottom, −y corner**;
  - fixed with 2× M2×5 through Ø2.3 holes in the side walls into Ø1.7 pilot holes in 3 mm cover tabs.
- **Knob** (+y):
  - hub Ø7 × 2.75 (y 18.75–21.5);
  - grip **Ø16 × 6** with 12 R1.5 flutes (y 21.5–27.5);
  - M4 hex-head pocket 7.2 across flats × 2.8 deep, bore 4.3.
  - Clearances: 0.75 to the pusher boss in y; 3.5 mm between the grip and the worst-case wall in x.
- **Print:** both outer face down, flat, about 15 min.
- **Verify:**
  - knob vs goggle, cage, pusher boss and key paths: empty at tilt 0/10/20;
  - cover posts vs cameras: contact ≤0.3, no overlap.

### M9. Coupons (print first)
- **`coupon` (v0.4, kept):** GoPro slit 3.2/3.3/3.4, for the helmet legs.
- **`coupon_joint` (new):**
  - BASE clevis slice (x 0–18, with plate stub for a vice);
  - FORK tongue extended by a bar to a load eye 55 mm ahead of the pin at z −11;
  - one pusher boss with tapped M3;
  - one cage boss slice with the M4 and M3 inserts.
- **Tests:**
  - (a) luggage scale on the load eye, up: break at **30–50 N** (record dry and after 48 h in a humid bag);
  - (b) M3 thread survives 20 adjust cycles;
  - (c) inserts pull-out > 2× clamp.

### M10. Assembly order (README, no geometry)
1. Fit BASE on the 4 stock fan screws, front block square to the wall.
2. Drop the FORK tongue into the slot, then fit the steel pin and the PA66 bolt.
3. Load the cameras from the rear, pushed against the front frames. Tighten M2 on +y first, then −y.
4. Fit the cover.
5. Fit the cage on the trunnion: right M3 first, then the knob.
6. Tie the tether.
7. Set boresight per M4 and paint the witness lines.

## 4. Global verification (all must pass before STL export)

### 4.1 OpenSCAD test script (extend `test/run_clash.sh`)
- **Grid:** tilt {−2, 0, 5, 10, 15, 20, 22} × front_x {21.6, 23.1, 24.6}.
- **Pairs:** cage∪cams∪cover vs ghost, GrabCAD, FORK and BASE; FORK vs ghost and GrabCAD; BASE vs ghost and GrabCAD; knob vs everything; tongue vs slot.
- **Fields of view:** thermal; Infra 108×92 and 96×72.
- **Also:** camera insertion sweeps; pusher key paths; swing first-contact angles.
- **Pass:** empty everywhere, positive controls report hits, all parts export as manifold.

### 4.2 Printability and mass
- `overhang.py` (precision concept) on every print-oriented STL: nz ≥ −0.71 except bed faces and bridges ≤10 mm.
- **Volumes from the model** [est]:

  | | BASE | FORK | CAGE | Cover | Knob | Total | v0.4 |
  |---|---|---|---|---|---|---|---|
  | Volume (cm³) | ≈5.7 | ≈5.9 | ≈10.3 | ≈1.8 | ≈1.0 | ≈24.7 | 16.8 |

  - Solid upper bound: about 31 g (v0.4: 21.3 g).
  - Sliced (0.73 g/cm³, calibrated on v0.4): about 18 g (v0.4: 12.2 g).
  - Hardware: about +2 g net, after removing the M5 joint hardware.
- **Budget:** sliced total ≤20 g. The moment of everything forward of the goggle front wall must be ≤ v0.4's 0.010 N·m.
- If over budget, trim in this order: cage side walls at the Infra level → ribbed cover → brow pockets.

### 4.3 Physical acceptance tests
- Fuse up-load at the thermal lens: 30–50 N.
- Side pull at the pivot: arms break at 100–150 N, BASE intact.
- Slip torque with the knob hand-tight: 0.5–0.9 N·m (13–30 N at 30 mm).
- Boresight repeatability after 10 tilt cycles and a 50 N side push on the hood: ≤0.1° (2 thermal pixels at 10 m).

## 5. SHOULD (after measurements, coupon results or cables)

| ID | Trigger | Change |
|---|---|---|
| S1 | **M5** seat height above the eye axis | piv_rel_seat = −11 − (meas − 23). Reprint the FORK only. Thermal ≈ +7.5 at tilt 10; Infra ≤35 at tilt 0 |
| S2 | **M6** front_x, flatness, top-edge radius at y ±17.75 | Set pad_z (fallback if the radius is >4 mm: pushers below the pivot at z ≈ −21, but the lever to the joint becomes 28 mm, so the over-tightening margin drops to <1, and a torque-limited thumbwheel is then needed). Reduce front_tol from 1.5 toward 0.3, which pulls X0 back by up to 1.2 mm |
| S3 | **M1/M2** fan screw and what is below it; pull-out test | If a screw holds <80 N: `fuse_d` 2.0 (≈1.45–1.6 N·m dry). Choose screw length for the 1.2 mm head stack |
| S4 | Cameras in hand | M2 positions (slots → round holes), bay depth, connector, lens and glass diameters (hood/tube), real FOV on the bench (research/02 §8) |
| S5 | Cable diameter | Groove 3.5×3.5 on the right arm (2 tie slots) and 4.5×3.5 along the brow top to the −y end; service loop ≥15 mm for the 65° swing |
| S6 | Lens cap | One part pressed onto the hood and tube (1.2 flange, 0.15 clearance, 4 crush ribs), on a dyneema lanyard; when unclipped it hangs outside both FOVs |
| S7 | H1–H3 | helm_x/helm_z, extension, buckle-exit clearance against the tongue/BASE block (x ≥ 3) |
| S8 | Detent coupon | Bump on a sprung tongue on the cage +y boss, 5 notches at r ≥ 10 (0/5/10/15/20); stop lug. No Hirth |

## 6. LATER
- **Flip-up**, only with a pivot at x −25…−45, z ≥ 40 (FIELD sweep). Needs a positive stow latch (hold at 3 g was only 1.8×) and a decision on the strap.
- **ISO 518 cold shoe** on the cage top for an IR illuminator, once the unit and its power are known. Lock the knob whenever a light is fitted.
- Quick-release helmet shoe with glove wings.
- Clip-on Infra bumper. Optional; the judges disagree.
- Central spigot pivot in the Ø23 hole (only if M2 shows a clean edge).
- Fuzzy skin on purely cosmetic outer walls only. **Never** on frames, the seat, the slot/tongue, pivot bosses or pusher bosses.

## 7. Rejected (and why)
- **Hirth 36T on Ø20:** teeth of 0.6–0.87 mm on a vertical face won't print cleanly.
- **Single-shear sprung tilt joint:** its yaw depends on a spring.
- **One rigid part:** lateral failure at 550–600 N, so it is not break-away.
- **Tilt on the cameras' own M2 screws:** wears the camera threads and gives two separate settings.
- **Yaw trim by reprint (`th_yaw_trim`).**
- **Fitted fan screws as the only yaw key.**
- **Preload through the PA66 bolts.**
- **Moving the cameras forward.**
- **Building flip-up now.**
- **Lowering helm_z before H2 is measured.**

## 8. Parameter delta vs v0.4
- **Removed:**
  - camera side: gp_* at the camera, axis_z, axis_back, bar_*, cage_axis_x, adapter_axis_x/z, fem_*, boss_*, root_*;
  - fuse and trims: fuse_x/fuse_core and V grooves, stop_d/stop_w, cable_slot_w, th_yaw_trim.
- **Kept:**
  - helmet legs: helm_*, gp_* (helmet);
  - fan seat: seat, plate_t, fan_hole, m2_d, screw_cb_*, post_relief;
  - geometry: front_x, front_tol, seat_above_eye, seat_pitch;
  - cameras: camera dimensions, clr, slot_len, m2_cbore, ir_yaw_trim, cam_gap.
- **New:**
  - BASE and joint: blk_x1 18, blk_y 8, blk_h 12, slot_x0 3.0, slot_y 3.2, j_z 7.0, pin_x 7.0, fuse_bx 16.0, fuse_d 2.5;
  - FORK: tg_y 2.8, brow_x0 18.5, brow_z0 5, brow_z1 12, arm_t 4;
  - pushers: pad_x0, pad_len 6, pad_y 17.75, pad_z −5.0;
  - placement: X0 55, piv_rel_seat −11;
  - cage: side_t 2.0, ir_setback 6, bay 2.5, cover_t 1.5, boss_d 9, boss_out 2, boss_in_y 10.15, hood_m 0.5, hood_t 1.6, tube_t 1.6;
  - knob_d 16.
- **Parts:** `base | fork | cage | cover | knob | assembly | print_base | print_fork | print_cage | print_acc | coupon | coupon_joint`.

## 9. Decisions needed from Adam
1. **Replace decision 1c.10** (one M5 GoPro joint at the camera) with: trunnion slip, then the PA66 shear fuse, then the arms. The cage would no longer fit GoPro accessories.
2. Accept the pusher height **pad_z −5** (5 mm below the deck edge), or measure the top-edge radius first (S2).
3. Accept about +6 g of sliced print in exchange for the hood, tube, arms and field boresight.
4. Is a tilt that holds by friction (push the cage against 0.5–0.9 N·m, knob only to lock) the everyday mode, with detents (S8) later?

Reference files (concept prototypes, not the repo):
- `/tmp/claude-1000/tactical/protect/v05.scad`
- `/tmp/claude-1000/tactical/protect/chk.sh`
- `/tmp/claude-1000/tactical/precision/overhang.py`
- `/tmp/claude-1000/tactical/field/flip2.py`

Base files:
- `/home/adam/ŻYCIE/VIBECODING/arabskie_gogle/cad/camera_mount.scad`
- `/home/adam/ŻYCIE/VIBECODING/arabskie_gogle/cad/README.md`