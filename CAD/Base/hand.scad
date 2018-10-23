include <connect.scad>

//finger radius
F_RADIUS = 10;

//servo cutout length
S_LENGTH = 5;

//servo cutout height
S_HEIGHT = 10;

//servo screw hole radius
S_HRADIUS = 1;

//height of the hand 
H_HEIGHT = 50;

//thickness of the hand
H_THICK = 3;

//width of the thumb connector
T_WIDTH = 20;

  
difference()
{
  union()
  {
    //CONNECTING SHEET
    cube([
      //LENGTH (x axis)
      TOPLENGTH * SCALE, //top length of base
  
      //WIDTH (y axis)
      TOPWIDTH * SCALE, //top width of base
  
      //HEIGHT (z axis)
      H_HEIGHT * SCALE]); //thickness of base
    
    
    //NUB 1
    translate([
      //X TRANSLATION
      TOPLENGTH / 2 * SCALE, //halfway down length
    
      //Y TRANSLATION
      0, 
    
      //Z TRANSLATION
      -THICK * SCALE]) //move down below sheet
    
    cube([
      //LENGTH (x axis)
      THICK * SCALE, //base thickness
    
      //WIDTH (y axis)
      THICK * SCALE, //base thickness
    
      //HEIGHT (z axis)
      THICK * 2 * SCALE]); //double base thickness
    
  
    //NUB 2
    translate([
      //X TRANSLATION
      TOPLENGTH / 2 * SCALE, //halfway down length
    
      //Y TRANSLATION
      (TOPWIDTH - THICK) * SCALE, //far side of sheet 
    
      //Z TRANSLATION
      -THICK * SCALE]) //move down below sheet
  
    cube([
      //LENGTH (x axis)
      THICK * SCALE, //base thickness
    
      //WIDTH (y axis)
      THICK * SCALE, //base thickness
    
      //HEIGHT (z axis)
      THICK * 2 * SCALE]); //double base thickness
    
  
    //NUB 3
    translate([
      //X TRANSLATION
      0,
    
      //Y TRANSLATION
      (TOPWIDTH - THICK) / 2 * SCALE, //halfway down width
    
      //Z TRANSLATION
      -THICK * SCALE]) //move down below sheet
    
    cube([
      //LENGTH (x axis)
      THICK * SCALE, //base thickness
    
      //WIDTH (y axis)
      THICK * SCALE, //base thickness
    
      //HEIGHT (z axis)
      THICK * 2 * SCALE]); //double base thickness
    
  
    //NUB 4
    translate([
      //X TRANSLATION
      (TOPLENGTH - THICK) * SCALE, //far side of sheet
    
      //Y TRANSLATION
      (TOPWIDTH - THICK) / 2 * SCALE, //halfway down width
    
      //Z TRANSLATION
      -THICK * SCALE]) //move down below sheet
    
    cube([
      //LENGTH (x axis)
      THICK * SCALE, //base thickness
    
      //WIDTH (y axis)
      THICK * SCALE, //base thickness
    
      //HEIGHT (z axis)
      THICK * 2 * SCALE]); //double base thickness
  }
    
  translate([
    //X TRANSLATION
    T_WIDTH * SCALE,
  
    //Y TRANSLATION
    0,
    
    //Z TRANSLATION
    THICK * SCALE])
  
  #cube([
    //LENGTH (x axis)
    (TOPLENGTH - T_WIDTH) * SCALE,
    
    //WIDTH (y axis)
    (TOPWIDTH - F_RADIUS) * SCALE,
    
    //HEIGHT (z axis)
    (H_HEIGHT - THICK) * SCALE]);
}
  