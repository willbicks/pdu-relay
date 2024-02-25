// Keystone 4966 Right Angle Spade Terminal model
//
// Based on https://www.mouser.com/datasheet/2/215/4966-743260.pdf

thickness = 0.81;

full_width = 14.99;
from_pcb_height = 8.89;

rear_chamfer_size = 2;
front_chamfer_size = 1;

spade_width = 7.92;
spade_height = 6.35;

pin_height = 3.81;
pin_height_straight = 1.52;
pin_width_top = 1.42;
pin_width_bottom = 1.29;
pin_spacing = 5.08;

hole_dia = 1.78;
hole_offset = 4.52;

overcut = 0.1;

module mainBody() {
    linear_extrude(height = thickness) {
        polygon(points=[
        
            // terminal body
            [0, 0],
            [0, from_pcb_height-rear_chamfer_size],
            [rear_chamfer_size, from_pcb_height],
            [full_width-front_chamfer_size, from_pcb_height],
            [full_width, from_pcb_height-front_chamfer_size],
            [full_width, from_pcb_height-spade_height+front_chamfer_size],
            [full_width-front_chamfer_size, from_pcb_height-spade_height],
            [full_width-spade_width, from_pcb_height-spade_height],
            [full_width-spade_width, 0],
        
            // forward pin
            [pin_spacing+pin_width_top, 0],
            [pin_spacing+pin_width_top, -pin_height_straight],
            [pin_spacing+pin_width_top-0.5*(pin_width_top-pin_width_bottom), -pin_height],
            [pin_spacing+0.5*(pin_width_top-pin_width_bottom), -pin_height],
            [pin_spacing, -pin_height_straight],
            [pin_spacing, 0],
        
            // rear pin
            [pin_width_top, 0],
            [pin_width_top, -pin_height_straight],
            [pin_width_top-0.5*(pin_width_top-pin_width_bottom), -pin_height],
            [0.5*(pin_width_top-pin_width_bottom), -pin_height],
            [0, -pin_height_straight],
        ]);
    }
}

module hole() {
    translate([full_width-hole_offset, from_pcb_height-0.5*spade_height, -overcut])
        cylinder(d=hole_dia, h=thickness+2*overcut, $fn=50);
}

module terminal() {
    difference() {
        mainBody();
        hole();
    }
}

terminal();
