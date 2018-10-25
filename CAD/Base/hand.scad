include <connect.scad>

//finger radius
F_RADIUS = 5;

//servo cutout length
S_LENGTH = 20;

//servo cutout width
S_WIDTH = 10;

//servo cutout height displacement
S_HEIGHT = 15;

//servo screw hole radius
S_HRADIUS = 1;

//seperation of servo cutout and servo hole
S_HSEP = 1;

//offset of screw holes over servo cutouts
S_HIN = 1;

//height of the hand 
H_HEIGHT = 50;

//thickness of the hand
H_THICK = 3;
  
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
  
  //HAND BASE CUTOUT
  translate([
    //X TRANSLATION
    F_RADIUS * 2 * SCALE,
  
    //Y TRANSLATION
    0,
    
    //Z TRANSLATION
    THICK * SCALE])
  
  #cube([
    //LENGTH (x axis)
    (TOPLENGTH - F_RADIUS * 2) * SCALE,
    
    //WIDTH (y axis)
    (TOPWIDTH - F_RADIUS * 2) * SCALE,
    
    //HEIGHT (z axis)
    (H_HEIGHT - THICK) * SCALE]);
    
  for(i = [1:4])
  {
    //servo main cutout
    translate([
    //X TRANSLATION
    (F_RADIUS * 2 + i * ((TOPLENGTH - S_WIDTH) / 5)) * SCALE,
   
    //Y TRANSLATION
    (TOPWIDTH - F_RADIUS * 2) * SCALE,
    
    //Z TRANSLATION
    S_HEIGHT * SCALE
    ])
    
    #cube([
      //LENGTH (x axis)
      S_WIDTH * SCALE,
    
      //WIDTH (y axis)
      F_RADIUS * 2 * SCALE,
    
      //HEIGHT (z axis)
      S_LENGTH * SCALE]);
      
      
    //servo screw hole 1
    translate([
      //X TRANSLATION
      (F_RADIUS * 2 + i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (S_HEIGHT + S_LENGTH + S_HSEP + S_HRADIUS) * SCALE])
      
    rotate(
      //ANGLE
      -90,
      
      //AXIS
      [1,0,0])
      
    #cylinder(
      //HEIGHT
      F_RADIUS * 2 * SCALE, //wall thickness
 
      //RADIUS
      r = S_HRADIUS * SCALE);
      
      
    //servo screw hole 2
    translate([
      //X TRANSLATION
      (F_RADIUS * 2 + i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (S_HEIGHT - S_HSEP - S_HRADIUS) * SCALE])
      
    rotate(
      //ANGLE
      -90,
      
      //AXIS
      [1,0,0])
      
    #cylinder(
      //HEIGHT
      F_RADIUS * 2 * SCALE, //wall thickness
 
      //RADIUS
      r = S_HRADIUS * SCALE);
      
      
    //servo screw hole 3
    translate([
      //X TRANSLATION
      (F_RADIUS * 2 + i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (S_HEIGHT - S_HSEP - S_HRADIUS) * SCALE])
      
    rotate(
      //ANGLE
      -90,
      
      //AXIS
      [1,0,0])
      
    #cylinder(
      //HEIGHT
      F_RADIUS * 2 * SCALE, //wall thickness
 
      //RADIUS
      r = S_HRADIUS * SCALE);
      
      
    //servo screw hole 4
    translate([
      //X TRANSLATION
      (F_RADIUS * 2 + i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (S_HEIGHT + S_LENGTH + S_HSEP + S_HRADIUS) * SCALE])
      
    rotate(
      //ANGLE
      -90,
      
      //AXIS
      [1,0,0])
      
    #cylinder(
      //HEIGHT
      F_RADIUS * 2 * SCALE, //wall thickness
 
      //RADIUS
      r = S_HRADIUS * SCALE);
  }
}
  