// eksport części do podglądu 3D (cad/web/build_viewer.py); układ gogli: x do przodu, y w lewo, z w górę
include <../camera_mount.scad>
part = "none";
which = "";
grab = false;   // true = gogle z modelu GrabCAD (plik lokalny), false = bryła zastępcza z scene_all
module goggle_body() {
  if (grab) import("../../papers/hdo2_body_models/grabcad_fatshark-hdo-goggles-1/hdo_grabcad_goggle_frame.stl");
  else hdo2_ghost();
}
rotate([0, seat_pitch, 0]) {
  if (which == "adapter") adapter_top();
  if (which == "knob") knob();
  if (which == "hw") { m5_hw(); pushers(); }
  if (which == "cage") at_hinge(tilt) cage();
  if (which == "shroud") at_hinge(tilt) shroud();
  if (which == "cams") at_hinge(tilt) ghost_cams();
  if (which == "cables") at_hinge(tilt) cables();
}
if (which == "hdo2") goggle_body();
