//scale of the full design
SCALE = 1;

//open (1) or closed (0) top?
OPEN = 1;

//resolution of the design (~50 MAX)
RESOLUTION =25;

//total height of the design
TOTAL_HEIGHT = 30 * SCALE;

//radius of the design
F_RADIUS = 7.5 * SCALE;

//height of the cylinder portion
F_HEIGHT = (TOTAL_HEIGHT - F_RADIUS);

//wall thickness
F_THICK = 2 * SCALE;

//internal cylinder joint
C_RADIUS = 5 * SCALE;

//radius of the joint connector hole
H_RADIUS = 1 * SCALE;

difference()
{
  //FINGER SHAPE
  union()
  {
    //FINGER SHAFT
    cylinder(
      //RESOLUTION
      $fn = RESOLUTION,
    
      //HEIGHT
      F_HEIGHT,
    
      //BOTTOM RADIUS
      F_RADIUS,
    
      //TOP RADIUS
      F_RADIUS);
    
    //FINGER TOP
    translate([
      //X-TRANSLATION
      0, 
    
      //Y-TRANSLATION
      0, 
      
      //Z_TRANSLATION
      F_HEIGHT]) //set center of top sphere at the top of the shaft
      
    sphere(
      //RESOLUTION
      $fn = RESOLUTION,
     
      //RADIUS
      F_RADIUS);
  }
  
  //INNER CUTOUT
  difference()
  {
    //CUTOUT SHAPE
    #cylinder(
      //RESOLUTION
      $fn = RESOLUTION,
    
      //HEIGHT
      TOTAL_HEIGHT - F_RADIUS/2, //hollow up to half-way up the top sphere
    
      //BOTTOM RADIUS
      F_RADIUS -  F_THICK, //leave specified wall thickness
    
      //TOP RADIUS
      F_RADIUS - F_THICK); //leave specified wall thickness
    
    //FLAT CUTOUT SIDE 1
    translate([
      //X-TRANSLATION
      -F_RADIUS, //line cutout up with corner of cylinder
      
      //Y-TRANSLATION
      F_RADIUS -(F_RADIUS * 2 - 1.5 * C_RADIUS)/2, //cut out half of connector's length, leaving extra space
     
      //Z-TRANSLATION
       0])
       
    #cube([
      //LENGTH (x-dimension)
      F_RADIUS * 2, //diameter of finger
      
      //WIDTH (y-dimension)
      F_RADIUS, //radius of finger
      
      TOTAL_HEIGHT - F_RADIUS/2]); //bottom to half-way up the top sphere
      
    //FLAT CUTOUT SIDE 2
    translate([
      //X-TRANSLATION
      -F_RADIUS, //line cutout up with corner of cylinder
      
      //Y-TRANSLATION
      -F_RADIUS*2 +(F_RADIUS * 2 - 1.5 * C_RADIUS)/2, //cut out half of connector's length, leaving extra space
     
      //Z-TRANSLATION
      0])
      
    #cube([
      //LENGTH (x-dimension)
      F_RADIUS * 2, //diameter of finger
      
      //WIDTH (y-dimension)
      F_RADIUS, //radius of finger
      
      //HEIGHT (z-dimension)
      TOTAL_HEIGHT - F_RADIUS/2]); //bottom to half-way up the top sphere
  }
  
  
  //BOTTOM CONNECTOR HOLE
  translate([
    //X-TRANSLATION
    0,
      
    //Y-TRANSLATION
    ((F_RADIUS + 2) * 2) / 2, //half of connector hole cutout length
   
    //Z-TRANSLATION
    F_RADIUS + F_THICK  ]) //top of bottom sphere cutout
    
  rotate(
    //ANGLE
    90, //cut the hole sideways, through the cylinder
    
    //AXIS
    [1,0,0]) //x-axis
    
  #cylinder(
    //RESOLUTION
    $fn = RESOLUTION,
    
    //HEIGHT
    (F_RADIUS + 2) * 2, //diameter of finger, with extra length to ensure cutout
    
    //BOTTOM RADIUS
    H_RADIUS, //connector hole radius
    
    //TOP RADIUS
    H_RADIUS); //connector hole radius
  
  if(OPEN)
  {
    //TOP CONNECTOR HOLE
    translate([
      //X-TRANSLATION
      0,
    
      //Y-TRANSLATION
      ((F_RADIUS + 2) * 2) / 2, //half of connector hole cutout length
 
      //Z-TRANSLATION
      TOTAL_HEIGHT - F_RADIUS / 2]) //halfway up the top sphere
  
    rotate(
      //ANGLE
      90, //cut the hole sideways, through the cylinder
 
      //AXIS
      [1,0,0]) //x-axis
  
    #cylinder(
      //RESOLUTION
      $fn = RESOLUTION,
  
      //HEIGHT
      (F_RADIUS + 2) * 2, //diameter of finger, with extra length to ensure cutout
  
      //BOTTOM RADIUS
      H_RADIUS, //connector hole radius
  
      //TOP RADIUS
      H_RADIUS);//connector hole radius
    
    //CONNECTOR CUTOUT
    translate([
      //X-TRANSLATION
      -F_RADIUS / 2, //half of finger radius
    
      //Y-TRANSLATION
      -1.5 * C_RADIUS / 2, //half of cutout length
   
      //Z-TRANSLATION
      TOTAL_HEIGHT - F_RADIUS/2 - H_RADIUS]) //cut down to bottom of top connector hole
    
    #cube([
      //LENGTH (x-axis)
      F_RADIUS * 2, //diameter of finger
    
      //WIDTH (y-axis)
      1.5 * C_RADIUS, //width of connector, with extra space
   
      //HEIGHT
      F_RADIUS]); //radius of finger 
  } 
    
  //BOTTOM CUTOUT  
  translate([
    //X TRANSLATION
    0,
    
    //Y TRANSLATION
    F_RADIUS,
    
    //Z TRANSLATION
    -H_RADIUS])
    
  rotate(
    //ANGLE
    90,
    
    //AXIS
    [1,0,0]) //rotate about the x axis
  #cylinder(
    //RESOLUTION
    $fn = RESOLUTION,
    
    //HEIGHT
    F_RADIUS * 2,
    
    //BOTTOM RADIUS
    F_RADIUS,
   
    //TOP RADIUS
    F_RADIUS);
  
  //FRONT CUTOUT
  translate([
    //X TRANSLATION
    0,
    
    //Y TRANSLATION
    -F_RADIUS, //translate so entire length is cut out
    
    //Z TRANSLATION
    0])
    
  #cube([
  //LENGTH
  F_RADIUS,
  
  //WIDTH
  F_RADIUS * 2,
  
  //HEIGHT
  F_RADIUS - H_RADIUS]);
}