//scale of the full design
SCALE = 1;

//resolution of the hole cutouts
RESOLUTION = 25;

//connector length
LENGTH = 25 * SCALE;

//connector width
WIDTH = 5 * SCALE;

//connector thickness
THICK = 3 * SCALE;

//hole radius
RADIUS = 1 * SCALE;

//hole offset from edge
OFFSET = 1 * SCALE;

difference(){
  //CONNECTOR SHAPE
  cube([
    //LENGTH (x-axis)
    LENGTH, 
    
    //WIDTH (y-axis)
    WIDTH,
  
    //HEIGHT (z-axis)
    THICK]);
  
  //HOLE 1
  translate([
    //X TRANSLATION
    RADIUS + OFFSET, //offset from edge
  
    //Y TRANSLATION
    WIDTH / 2, //middle of connector width
  
    //Z TRANSLATION
    -THICK / 2]) //move down so hole is cut from top to bottom
  
  #cylinder(
    //RESOLUTION
    $fn = RESOLUTION,
    
    //HEIGHT
    THICK * 2, //double the connector thickness
    
    //BOTTOM RADIUS
    RADIUS,
    
    //TOP RADIUS
    RADIUS);
  
  //HOLE 2
  translate([
    //X TRANSLATION
    LENGTH - RADIUS - OFFSET, //offset from edge
  
    //Y TRANSLATION
    WIDTH / 2, //middle of connector width
  
    //Z TRANSLATION
    -THICK / 2]) //move down so hole is cut from top to bottom
  
  #cylinder(
    //RESOLUTION
    $fn = RESOLUTION,
    
    //HEIGHT
    THICK * 2, //double the connector thickness
    
    //BOTTOM RADIUS
    RADIUS,
    
    //TOP RADIUS
    RADIUS);
}