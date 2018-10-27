include <connect.scad>

///////////////////////////////////
////////   SERVO CUTOUT   /////////
///////////////////////////////////

//servo cutout length (z axis)
S_LENGTH = 20;

//servo cutout width (x axis)
S_WIDTH = 10;

//servo cutout height displacement
S_HEIGHT = 15;

//front servo plate length (z axis) 
S_FLENGTH = 12;

//thickness of front servo plate
S_FTHICK = 5;

//servo screw hole radius
S_HRADIUS = 1;

//horizontal offset of screw holes on servo plates
S_HIN = 2;

//length of servo wire cutout
S_WLENGTH = 4;

//width of servo wire cutout
S_WWIDTH = 2;

//radius of servo wire hole
S_WRADIUS = 2;

//y offset of servo wire hole
S_WYOFF = 20;


///////////////////////////////////
////////////   HAND   /////////////
///////////////////////////////////

//height of the hand 
H_HEIGHT = 50;

//thickness of the hand (*2)
H_THICK = 5;


///////////////////////////////////
////////////   FINGER   ///////////
///////////////////////////////////

//finger offset from hand wall
F_OFF = 5;
///////////////////////////////////
////////////   THUMB   ////////////
///////////////////////////////////

//thumb height offset
T_ZOFF = 35;


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
    TOPLENGTH * SCALE,
    
    //WIDTH (y axis)
    (TOPWIDTH - H_THICK * 2) * SCALE,
    
    //HEIGHT (z axis)
    (H_HEIGHT - THICK) * SCALE]);
    
  for(i = [1:4])
  {
    difference()
    {
      //servo main cutout
      translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - H_THICK * 2) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT + (i%2 * 2 - 1) * S_LENGTH / 4) * SCALE])
      
      #cube([
        //LENGTH (x axis)
        S_WIDTH * SCALE,
      
        //WIDTH (y axis)
        H_THICK * 2 * SCALE,
      
        //HEIGHT (z axis)
        S_LENGTH * SCALE]);
        
        
      //servo front cutout bottom
      translate([
        //X TRANSLATION
        (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH) * SCALE,
     
        //Y TRANSLATION
        (TOPWIDTH - S_FTHICK) * SCALE,
      
        //Z TRANSLATION
        (S_HEIGHT + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
      
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
        (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 2 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
      
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
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      ((S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4) + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 2
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 3
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 4
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
      
    //wire guide cutout 
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH / 2 - S_WLENGTH / 2 - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + (i%2 * 2 - 1) * S_LENGTH / 4 - S_WWIDTH) * SCALE])
        
    #cube([
      //LENGTH (x axis)
      S_WLENGTH * SCALE,
        
      //WIDTH (y axis)
      (H_THICK * 2 - S_FTHICK) * SCALE,
        
      //HEIGHT (z axis)
      S_WWIDTH * SCALE]);
  

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
  difference()
  {
  //thumb block
  translate([
    //X TRANSLATION
    (4 * ((TOPLENGTH - S_WIDTH) / 5)) * SCALE,
    
    //Y TRANSLATION
    0,
    
    //Z TRANSLATION
    (T_ZOFF) * SCALE])
    
  cube([
    //LENGTH (x axis)
    S_WIDTH * 1.2 * SCALE,
    
    //WIDTH (y axis)
    TOPWIDTH * SCALE,
    
    //HEIGHT (z axis)
    (H_HEIGHT - T_ZOFF - F_OFF) * SCALE]);
    
    difference()
    {
    //servo main cutout
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1) * SCALE,
       
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 1.1) * SCALE,
        
      //Z TRANSLATION
      T_ZOFF * SCALE])
      
  #cube([
    //LENGTH (x axis)
    S_WIDTH * SCALE,
      
    //WIDTH (y axis)
    S_LENGTH * SCALE,
      
    //HEIGHT (z axis)
    S_LENGTH * SCALE]);
        
        
  //servo front cutout bottom
  translate([
    //X TRANSLATION
    (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1) * SCALE,
     
    //Y TRANSLATION
    TOPWIDTH - H_THICK * 2 - S_LENGTH * 0.1 - (S_LENGTH - S_FLENGTH) / 2,
      
    //Z TRANSLATION
    T_ZOFF])
      
  #cube([
    //LENGTH (x axis)
    S_WIDTH * SCALE,
      
    //WIDTH (y axis)
    (S_LENGTH - S_FLENGTH) / 2  * SCALE,
      
    //HEIGHT (z axis)
    S_FTHICK * SCALE]);
          
          
  //servo front cutout bottom
  translate([
    //X TRANSLATION
    (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1) * SCALE,
     
    //Y TRANSLATION
    (TOPWIDTH - H_THICK * 2 - S_LENGTH * 1.1) * SCALE,
      
    //Z TRANSLATION
    T_ZOFF])
      
  #cube([
    //LENGTH (x axis)
    S_WIDTH * SCALE,
      
    //WIDTH (y axis)
    S_FTHICK  * SCALE,
      
    //HEIGHT (z axis)
    (S_LENGTH - S_FLENGTH) / 2 * SCALE]);
        
  }
  //servo screw hole 1
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      T_ZOFF * SCALE])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 2
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_HRADIUS + S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 3
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + (S_LENGTH - S_FLENGTH) / 4 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 4
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH - S_HRADIUS - S_HIN - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + S_LENGTH - (S_LENGTH - S_FLENGTH) / 4 + (i%2 * 2 - 1) *  S_LENGTH / 4) * SCALE])
        
    rotate(
      //ANGLE
      -90,
        
      //AXIS
      [1,0,0])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
      
    //wire guide cutout 
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH / 2 - S_WLENGTH / 2 - S_WIDTH) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2) * SCALE,
        
      //Z TRANSLATION
      (S_HEIGHT + (i%2 * 2 - 1) * S_LENGTH / 4 - S_WWIDTH) * SCALE])
        
    #cube([
      //LENGTH (x axis)
      S_WLENGTH * SCALE,
        
      //WIDTH (y axis)
      (H_THICK * 2 - S_FTHICK) * SCALE,
        
      //HEIGHT (z axis)
      S_WWIDTH * SCALE]);
  

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
  