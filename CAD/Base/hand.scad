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
F_OFF = 8;

//finger radius
F_RADIUS = 5;

//finger connector width
F_CRADIUS = 2.5;

//finger connector hole radius
F_HRADIUS = 0.5;

//finger support thickness
F_STHICK = 5;

///////////////////////////////////
////////////   THUMB   ////////////
///////////////////////////////////

//thumb height offset
T_ZOFF = 30;

//thumb support radius
T_SRADIUS = 3;

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
  
  //thumb servo wire hole
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + S_WRADIUS) * SCALE,
    
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

for(i = [1:4])
{
  difference()
  {
    //finger base connector
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS) * SCALE,
      
      //Z TRANSLATION
      H_HEIGHT * SCALE])
      
    sphere(F_RADIUS);
      
    
    //cut the finger sphere in half
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 - F_RADIUS) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_RADIUS * 2) * SCALE])
      
    #cube(F_RADIUS * 2 * SCALE);
    
    
    //finger sphere middle cutout
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 - 0.75 * F_CRADIUS) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 1.5) * SCALE,
      
      //Z TRANSLATION
      H_HEIGHT * SCALE])
      
    #cube([
      //LENGTH (x axis)
      1.5 * F_CRADIUS * SCALE,
      
      //WIDTH (y axis)
      F_RADIUS * SCALE,
      
      //HEIGHT (z axis)
      F_RADIUS / 2 * SCALE]);
      
      
    //finger sphere top cutout
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 - 0.75 * F_CRADIUS) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT + F_RADIUS / 2) * SCALE])
      
    #cube([
      //LENGTH (x axis)
      1.5 * F_CRADIUS * SCALE,
      
      //WIDTH (y axis)
      F_RADIUS * 1.5 * SCALE,
      
      //HEIGHT (z axis)
      F_RADIUS / 2 * SCALE]);
      
      
    //connector joint hole
    translate([
      //X TRANSLATION
      (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 - F_RADIUS) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT + F_RADIUS /2) * SCALE])
      
    rotate(
      //ANGLE
      90,
      
      //AXIS
      [0,1,0])
      
    #cylinder(
      //HEIGHT
      F_RADIUS * 2 * SCALE,
      
      //RADIUS
      r = F_HRADIUS * SCALE);
  }
  
  //left finger support
  translate([
    //X TRANSLATION
    (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 - F_RADIUS) * SCALE,
  
    //Y TRANSLATION
    (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
  
    //Z TRANSLATION
    (H_HEIGHT - F_STHICK) * SCALE])
  
  cube([
    //LENGTH (x axis)
    F_RADIUS / 2 * SCALE,
  
    //WIDTH (y axis)
    (F_OFF + F_RADIUS) * SCALE,
  
    //HEIGHT (z axis)
    F_STHICK * SCALE]);
    
    
  //right finger support
  translate([
    //X TRANSLATION
    (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 + F_RADIUS * 0.5) * SCALE,
  
    //Y TRANSLATION
    (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
  
    //Z TRANSLATION
    (H_HEIGHT - F_STHICK) * SCALE])
  
  cube([
    //LENGTH (x axis)
    F_RADIUS / 2 * SCALE,
  
    //WIDTH (y axis)
    (F_OFF + F_RADIUS) * SCALE,
  
    //HEIGHT (z axis)
    F_STHICK * SCALE]);
    
    
  //finger support bridge
  translate([
    //X TRANSLATION
    (i * ((TOPLENGTH - S_WIDTH) / 5) - S_WIDTH / 2 - F_RADIUS) * SCALE,
  
    //Y TRANSLATION
    (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
  
    //Z TRANSLATION
    (H_HEIGHT - F_STHICK) * SCALE])
  
  cube([
    //LENGTH (x axis)
    F_RADIUS * 2 * SCALE,
  
    //WIDTH (y axis)
    F_RADIUS / 4 * SCALE,
  
    //HEIGHT (z axis)
    F_STHICK * SCALE]);
 
}

//thumb block support
translate([
  //X TRANSLATION
  (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.6) * SCALE,

  //Y TRANSLATION
  T_SRADIUS * SCALE,

  //Z TRANSLATION
  0])

cylinder(
  //HEIGHT
  T_ZOFF * SCALE,

  //RADIUS
  r = T_SRADIUS * SCALE);

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
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 1.1 - S_WWIDTH) * SCALE,
        
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
    (TOPWIDTH - H_THICK * 2 - S_LENGTH * 0.1 - (S_LENGTH - S_FLENGTH) / 2 - S_WWIDTH) * SCALE,
      
    //Z TRANSLATION
    T_ZOFF * SCALE])
      
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
    (TOPWIDTH - H_THICK * 2 - S_LENGTH * 1.1 - S_WWIDTH) * SCALE,
      
    //Z TRANSLATION
    T_ZOFF * SCALE])
      
  #cube([
    //LENGTH (x axis)
    S_WIDTH * SCALE,
      
    //WIDTH (y axis)
    (S_LENGTH - S_FLENGTH) / 2  * SCALE,
      
    //HEIGHT (z axis)
    S_FTHICK * SCALE]);
        
  }
  //servo screw hole 1
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1 + S_HIN + S_HRADIUS) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 1.1 - S_WWIDTH + (S_LENGTH - S_FLENGTH) / 4) * SCALE,
        
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
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1 + S_WIDTH - S_HIN - S_HRADIUS) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 1.1 - S_WWIDTH + (S_LENGTH - S_FLENGTH) / 4) * SCALE,
        
      //Z TRANSLATION
      T_ZOFF * SCALE])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 3
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1 + S_HIN + S_HRADIUS) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 0.1 - (S_LENGTH - S_FLENGTH) / 4 - S_WWIDTH) * SCALE,
        
      //Z TRANSLATION
      T_ZOFF * SCALE])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
        
        
    //servo screw hole 4
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.1 + S_WIDTH - S_HIN - S_HRADIUS) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 0.1 - (S_LENGTH - S_FLENGTH) / 4 - S_WWIDTH) * SCALE,
        
      //Z TRANSLATION
      T_ZOFF * SCALE])
        
    #cylinder(
      //HEIGHT
      H_THICK * 2 * SCALE, //wall thickness
   
      //RADIUS
      r = S_HRADIUS * SCALE);
      
    //wire guide cutout 
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 0.6 - S_WLENGTH / 2) * SCALE,
        
      //Y TRANSLATION
      (TOPWIDTH - H_THICK * 2 - S_LENGTH * 0.1 - S_WWIDTH) * SCALE,
        
      //Z TRANSLATION
      (T_ZOFF + S_FTHICK) * SCALE])
        
    #cube([
      //LENGTH (x axis)
      S_WLENGTH * SCALE,
        
      //WIDTH (y axis)
      S_WWIDTH * SCALE,
        
      //HEIGHT (z axis)
      (H_HEIGHT - T_ZOFF - F_OFF - S_FTHICK) * SCALE]);
}

//thumb connector
difference()
  {
    //finger base connector
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + F_OFF) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_OFF + F_RADIUS) * SCALE])
      
    sphere(F_RADIUS);
      
    
    //cut the finger sphere in half
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + F_OFF - F_RADIUS * 2) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_OFF) * SCALE])
      
    #cube(F_RADIUS * 2 * SCALE);
    
    
    //finger sphere middle cutout
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + F_OFF) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS - 0.75 * F_CRADIUS) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_OFF + F_RADIUS/2) * SCALE])
    
    #cube([
      //LENGTH (x axis)
      F_RADIUS / 2 * SCALE,
      
      //WIDTH (y axis)
      1.5 * F_CRADIUS * SCALE,
      
      //HEIGHT (z axis)
      F_RADIUS * SCALE]);
      
      
    //finger sphere top cutout
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + F_OFF + F_RADIUS / 2) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS - F_CRADIUS * 0.75) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_OFF + F_RADIUS / 2) * SCALE])
      
    #cube([
      //LENGTH (x axis)
      F_RADIUS / 2 * SCALE,
      
      //WIDTH (y axis)
      1.5 * F_CRADIUS * SCALE,
      
      //HEIGHT (z axis)
      F_RADIUS * 1.5 * SCALE]);
      
      
    //connector joint hole
    translate([
      //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + F_OFF + F_RADIUS / 2) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_OFF + F_RADIUS) * SCALE])
      
    rotate(
      //ANGLE
      90,
      
      //AXIS
      [1,0,0])
      
    #cylinder(
      //HEIGHT
      F_RADIUS * 2 * SCALE,
      
      //RADIUS
      r = F_HRADIUS * SCALE);
  }
  
  //thumb support
  translate([
    //X TRANSLATION
      (4 * ((TOPLENGTH - S_WIDTH) / 5) + S_WIDTH * 1.2 + F_OFF) * SCALE,
      
      //Y TRANSLATION
      (TOPWIDTH - H_THICK - F_OFF - F_RADIUS * 2) * SCALE,
      
      //Z TRANSLATION
      (H_HEIGHT - F_OFF) * SCALE])
  
  cube([
    //LENGTH (x axis)
    F_RADIUS / 2 * SCALE,
  
    //WIDTH (y axis)
    (F_OFF + F_RADIUS) * SCALE,
  
    //HEIGHT (z axis)
    F_RADIUS / 2 * SCALE]);
    