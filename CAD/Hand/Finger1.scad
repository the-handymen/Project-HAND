//scale of the full design
SCALE = 1;

//resolution of the outer design (~50 MAX)
RESOLUTION =25;

//total height of the design
TOTAL_HEIGHT = 30 * SCALE;

//radius of the design
F_RADIUS = 10 * SCALE;

//height of the cylinder portion
F_HEIGHT = (TOTAL_HEIGHT - F_RADIUS);

//wall thickness
F_THICK = 2 * SCALE;

//internal cylinder joint
C_RADIUS = 5 * SCALE;

//radius of the joint connector hole
H_RADIUS = 1 * SCALE;

//length of the top cutout
S_LENGTH = 1.5 * C_RADIUS;

difference()
{
  union()
  {
    cylinder($fn = RESOLUTION,F_HEIGHT, F_RADIUS, F_RADIUS);
    translate([0, 0, F_HEIGHT])
    sphere($fn = RESOLUTION, F_RADIUS);
  }
  difference()
  {
    #cylinder($fn = RESOLUTION,TOTAL_HEIGHT - F_RADIUS/2, F_RADIUS -  F_THICK, F_RADIUS - F_THICK);
    
    translate([-F_RADIUS, F_RADIUS -(F_RADIUS * 2 - S_LENGTH)/2, 0])
    #cube([F_RADIUS * 2, F_RADIUS, TOTAL_HEIGHT - F_RADIUS/2]);
    
    translate([-F_RADIUS, -F_RADIUS*2 +(F_RADIUS * 2 - S_LENGTH)/2, 0])
    #cube([F_RADIUS * 2, F_RADIUS, TOTAL_HEIGHT - F_RADIUS/2]);
  }
 
  translate([0, ((F_RADIUS + 2) * 2) / 2, TOTAL_HEIGHT - F_RADIUS / 2])
  rotate(90, [1,0,0])
  #cylinder($fn = RESOLUTION,(F_RADIUS + 2) * 2, H_RADIUS, H_RADIUS);
  
  translate([-F_RADIUS / 2, -S_LENGTH / 2, TOTAL_HEIGHT - F_RADIUS/2 - H_RADIUS])
  #cube([F_RADIUS * 9/2, S_LENGTH, F_HEIGHT]);
}