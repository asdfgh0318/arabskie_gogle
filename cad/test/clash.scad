// Test kolizji: openscad -D which="..." -D tilt=.. -D front_x=.. -o out.stl clash.scad  (pusty wynik = OK)
include <../camera_mount.scad>
part = "none";
which = "adapter_goggles";
g_fx = 23.1;   // przód gogli w teście (niezależny od front_x, z którym wydrukowano część)
module ghostbox() translate([g_fx - 80, -169.2/2, -45.5]) cube([80, 169.2, 45.5 - 0.01]);   // blat 0.01 niżej: styk płytki to nie kolizja
module at_hinge() translate([adapter_axis_x, 0, adapter_axis_z]) rotate([0, tilt, 0]) translate([-cage_axis_x, 0, -axis_z]) children();
module mounted_cage() at_hinge() { cage(); cam_thermal(0); cam_infra(0); }
module fovs() at_hinge() {   // termo 50x37.2; Infra najgorszy przypadek 96x72 (120° po przekątnej)
  translate([th_lens_len+0.5,0,0]) hull(){ cube(0.1,center=true); translate([300,0,0]) cube([0.1, 600*tan(25), 600*tan(18.6)], center=true); }
  translate([ir_lens_len+0.5,0,ir_z]) hull(){ cube(0.1,center=true); translate([300,0,0]) cube([0.1, 600*tan(48), 600*tan(36)], center=true); } }
if (which=="adapter_goggles") intersection(){ adapter_top(); ghostbox(); }
if (which=="cage_goggles") intersection(){ mounted_cage(); ghostbox(); }
if (which=="cage_adapter") intersection(){ at_hinge() cage(); adapter_top(); }
if (which=="fov_hits") intersection(){ fovs(); union(){ adapter_top(); mounted_cage(); ghostbox(); } }
