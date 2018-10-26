include <connect.scad>

//finger radius
F_RADIUS = 5;

//servo cutout length
S_LENGTH = 20;

//servo cutout width
S_WIDTH = 10;

//servo cutout height displacement
S_HEIGHT = 15;

//front servo cutout length 
S_FLENGTH = 12;

//thickness of front servo cutout
S_FTHICK = 5;

//servo screw hole radius
S_HRADIUS = 1;

//offset of screw holes over servo cutouts
S_HIN = 2;

//length of servo wire cutout
S_WLENGTH = 3;

//width of servo wire cutout
S_WWIDTH = 2;

//radius of servo wire hole
S_WRADIUS = 2;

//y offset of servo wire hole
S_WYOFF = 20;

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
    0,
  
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
    if(i == 1 || i == 3)
    {
      difference()
      {
        //servo main cutout
        translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH / 4) * SCALE])
      
        #cube([
          //LENGTH (x axis)
          S_WIDTH * SCALE,
      
          //WIDTH (y axis)
          F_RADIUS * 2 * SCALE,
      
          //HEIGHT (z axis)
          S_LENGTH * SCALE]);
        
        
        //servo front cutout bottom
        translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - S_FTHICK) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH / 4) * SCALE])
      
        #cube([
          //LENGTH (x axis)
          S_WIDTH * SCALE,
      
          //WIDTH (y axis)
          S_FTHICK * SCALE,
      
          //HEIGHT (z axis)
          (S_LENGTH - S_FLENGTH) / 2  * SCALE]);
          
          
        //servo front cutout bottom
        translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - S_FTHICK) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 2 + S_LENGTH / 4) * SCALE])
      
        #cube([
          //LENGTH (x axis)
          S_WIDTH * SCALE,
      
          //WIDTH (y axis)
          S_FTHICK * SCALE,
      
          //HEIGHT (z axis)
          (S_LENGTH - S_FLENGTH) / 2 * SCALE]);
          
      }
      
      //servo screw hole 1
      translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        ((S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4) + S_LENGTH / 4) * SCALE])
        
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
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 + S_LENGTH / 4) * SCALE])
        
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
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 + S_LENGTH / 4) * SCALE])
        
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
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4 + S_LENGTH / 4) * SCALE])
        
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
      
      //wire guide cutout 
      translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH / 2 - S_WLENGTH / 2 - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH / 4 - S_WWIDTH) * SCALE])
        
      #cube([
        //LENGTH (x axis)
        S_WLENGTH * SCALE,
        
        //WIDTH (y axis)
        (F_RADIUS * 2 - S_FTHICK) * SCALE,
        
        //HEIGHT (z axis)
        S_WWIDTH * SCALE]);
    }
    else
    {
      difference()
      {
        //servo main cutout
        translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT - S_LENGTH / 4) * SCALE])
      
        #cube([
          //LENGTH (x axis)
          S_WIDTH * SCALE,
      
          //WIDTH (y axis)
          F_RADIUS * 2 * SCALE,
      
          //HEIGHT (z axis)
          S_LENGTH * SCALE]);
        
        
        //servo front cutout bottom
        translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - S_FTHICK) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT - S_LENGTH / 4) * SCALE])
      
        #cube([
          //LENGTH (x axis)
          S_WIDTH * SCALE,
      
          //WIDTH (y axis)
          S_FTHICK * SCALE,
      
          //HEIGHT (z axis)
          (S_LENGTH - S_FLENGTH) / 2 * SCALE]);
          
          
        //servo front cutout bottom
        translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - S_FTHICK) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 2 - S_LENGTH / 4) * SCALE])
      
        #cube([
          //LENGTH (x axis)
          S_WIDTH * SCALE,
      
          //WIDTH (y axis)
          S_FTHICK * SCALE,
      
          //HEIGHT (z axis)
          (S_LENGTH - S_FLENGTH) / 2 * SCALE]);
          
      }
      
      //servo screw hole 1
      translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4 - S_LENGTH / 4) * SCALE])
        
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
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 - S_LENGTH / 4) * SCALE])
        
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
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 - S_LENGTH / 4) * SCALE])
        
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
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4 - S_LENGTH / 4) * SCALE])
        
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
        
        
      //wire guide cutout 
      translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH / 2 - S_WLENGTH / 2 - S_WIDTH) * SCALE,
        
        //Y TRANSLATION
        (TOPWIDTH - F_RADIUS * 2) * SCALE,
        
        //Z TRANSLATION
        (S_HEIGHT - S_LENGTH / 4 - S_WWIDTH)  * SCALE])
        
      #cube([
        //LENGTH (x axis)
        S_WLENGTH * SCALE,
        
        //WIDTH (y axis)
        (F_RADIUS * 2 - S_FTHICK) * SCALE,
        
        //HEIGHT (z axis)
        S_WWIDTH * SCALE]);
    }
    
    //servo wire hole
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH / 2 - S_WIDTH) * SCALE,
    
      //Y TRANSLATION
      S_WYOFF * SCALE,
    
      //Z TRANSLATION
      0])
    
    #cylinder(
      //HEIGHT
      THICK * SCALE,
    
      //radius
      r = S_WRADIUS * SCALE);
  }
}
  