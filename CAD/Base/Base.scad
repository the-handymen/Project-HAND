use <fustrum.scad>
include <connect.scad>

///////////////////////////////////
////////////   BASE   /////////////
///////////////////////////////////

//top thickness
TOPTHICK = 0;

//bottom thickness
BOTTHICK = 5; //TEMP

//height of the full design
HEIGHT = 70; //TEMP

//dimensions of the bottom layer
BOTLENGTH = TOPLENGTH * 1.1; //length
BOTWIDTH = TOPWIDTH * 1.1;   //width

///////////////////////////////////
/////////////   LCD   /////////////
///////////////////////////////////

//dimensions
L_LENGTH = 71; //length

L_WIDTH = 27;  //width

//placement on base wall (offset from 0,0)
L_XOFF = (BOTLENGTH - TOPLENGTH) / 2 + TOPLENGTH / 2 - L_LENGTH / 2; //offset on x-axis
L_YOFF = 35;  //offset on y-axis

//screw hole
L_SRADIUS = 1.25; //screw hole radius
L_SOFF = 2.5; //offset from display

///////////////////////////////////
///////   ROTARY ENCODER   ////////
///////////////////////////////////
//radius
RE_RADIUS = 4;

//placement on base wall (offset from 0,0)
RE_XOFF = (BOTLENGTH - TOPLENGTH) / 2 + TOPLENGTH / 2; //offset on x-axis
RE_YOFF = 22;  //offset on y-axis

///////////////////////////////////
/////////   POWER INPUT   /////////
///////////////////////////////////

//dimensions
PI_LENGTH = 8; //length
PI_WIDTH = 4;  //width

//placement on base wall(offset from 0,0)
PI_XOFF = 53 + (BOTWIDTH - TOPWIDTH) / 2; //offset on x-axis
PI_YOFF = BOTTHICK + 1; //offset on y-axis


///////////////////////////////////
////////   POWER SWITCH   /////////
///////////////////////////////////
//radius
PS_RADIUS = 7;

//placement on base wall (offset from 0,0)
PS_XOFF = 25;
PS_YOFF = 25;

difference(){ 
  //BASE SHAPE  
  centered_fustrum(
    //BOTTOM LENGTH (x-axis)
    BOTLENGTH * SCALE, //bottom length, adjusted for scale
    
    //BOTTOM WIDTH (y-axis)
    BOTWIDTH * SCALE, //bottom width, adjusted for scale
  
    //TOP LENGTH (x-axis)
    TOPLENGTH * SCALE, //top length, adjusted for scale
 
    //TOP WIDTH (y-axis)
    TOPWIDTH * SCALE, //top width, adjusted for scale
  
    //HEIGHT (z-axis)
    HEIGHT * SCALE); //height, adjusted for scale
    
  
  
  //HOLLOWED CENTER
  translate([
    //X TRANSLATION
    ((THICK) +                                        //wall thickness
    (0.5*(BOTLENGTH - TOPLENGTH) * BOTTHICK / HEIGHT))//amount that wall along x axis slopes in at z = BOTTHICK
    * SCALE,                                          //adjust for scale
    
    //Y TRANSLATION
    ((THICK) +                                      //wall thickness
    (0.5*(BOTWIDTH - TOPWIDTH) * BOTTHICK / HEIGHT))//amount that wall along y axis slopes in at z = BOTTHICK
    * SCALE,                                        //adjust for scale
    
    //Z TRANSLATION
    (BOTTHICK)*SCALE]) //bottom floor thickness, adjusted for scale
             
             
  centered_fustrum(
    //BOTTOM LENGTH (x-axis)
    (BOTLENGTH - 2 * THICK -                      //full base length excluding wall thickness
    ((BOTLENGTH - TOPLENGTH) * BOTTHICK / HEIGHT))//amount that wall along x axis slopes in at z = BOTTHICK
    * SCALE,                                      //adjust for scale
                    
    //BOTTOM WIDTH (y-axis)
    (BOTWIDTH - 2 * THICK -                     //full base width excluding wall thickness
    ((BOTWIDTH - TOPWIDTH) * BOTTHICK / HEIGHT))//amount that wall along y axis slopes in at z = BOTTHICK
    *SCALE,                                     //adjust for scale
                   
    //TOP LENGTH (x-axis)
    (TOPLENGTH - 2 * THICK +                      //full top length excluding wall thickness
    ((BOTLENGTH - TOPLENGTH) * TOPTHICK / HEIGHT))//amount that wall along x axis slopes out at z = TOPTHICK
    *SCALE,                                       //adjust for scale
                   
    //TOP WIDTH (y-axis)
    (TOPWIDTH - 2 * THICK +                     //full top width excluding wall thickness
    ((BOTWIDTH - TOPWIDTH) * TOPTHICK / HEIGHT))//amount that wall along y axis slopes out at z = TOPTHICK
    *SCALE,                                     //adjust for scale
                   
    //HEIGHT (z-axis)
    ((HEIGHT - TOPTHICK - BOTTHICK)//full height excluding top and bottom thickness 
    * SCALE));                     //adjust for scale
                   


  //LCD CUTOUT
  translate([
    //X TRANSLATION
    L_XOFF * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    (-1 + L_YOFF *                                       //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))//move the cutout along the sloped wall
    * SCALE,                                             //adjust for scale
               
    //Z TRANSLATION
    L_YOFF * SCALE])//y offset, adjusted for scale
               
  rotate(
    //ANGLE
    -90 + atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)), //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
          
  #cube([
    //LENGTH (x-axis)
    L_LENGTH * SCALE, //length adjusted for scale
         
    //THICKNESS (y-axis)
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale, to cut through entire side wall
         
    //WIDTH (z-axis)
    L_WIDTH * SCALE]); //width adjusted for scale
    
  
  
  //LCD TOP LEFT HOLE
  translate([
    //X TRANSLATION
    (L_XOFF - L_SOFF) * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    (-1 + (L_YOFF + L_WIDTH + L_SOFF) *                                       //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))//move the cutout along the sloped wall
    * SCALE,                                             //adjust for scale
               
    //Z TRANSLATION
    (L_YOFF + L_WIDTH + L_SOFF) * SCALE])//y offset, adjusted for scale
               
  rotate(
    //ANGLE
    -180 + atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)), //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
          
  #cylinder(
    //HEIGHT
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = L_SRADIUS * SCALE); //radius, adjusted for scale
    
    
    
  //LCD TOP RIGHT HOLE
  translate([
    //X TRANSLATION
    (L_XOFF + L_LENGTH + L_SOFF) * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    (-1 + (L_YOFF + L_WIDTH + L_SOFF) *                                       //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))//move the cutout along the sloped wall
    * SCALE,                                             //adjust for scale
               
    //Z TRANSLATION
    (L_YOFF + L_WIDTH + L_SOFF) * SCALE])//y offset, adjusted for scale
               
  rotate(
    //ANGLE
    -180 + atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)), //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
          
  #cylinder(
    //HEIGHT
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = L_SRADIUS * SCALE); //radius, adjusted for scale
  
  
  //LCD BOTTOM RIGHT HOLE
  translate([
    //X TRANSLATION
    (L_XOFF + L_LENGTH + L_SOFF) * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    (-1 + (L_YOFF - L_SOFF) *                                       //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))//move the cutout along the sloped wall
    * SCALE,                                             //adjust for scale
               
    //Z TRANSLATION
    (L_YOFF - L_SOFF) * SCALE])//y offset, adjusted for scale
               
  rotate(
    //ANGLE
    -180 + atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)), //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
          
  #cylinder(
    //HEIGHT
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = L_SRADIUS * SCALE); //radius, adjusted for scale
  
  
  //LCD BOTTOM LEFT HOLE
  translate([
    //X TRANSLATION
    (L_XOFF - L_SOFF) * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    (-1 + (L_YOFF - L_SOFF) *                                       //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))//move the cutout along the sloped wall
    * SCALE,                                             //adjust for scale
               
    //Z TRANSLATION
    (L_YOFF - L_SOFF) * SCALE])//y offset, adjusted for scale
               
  rotate(
    //ANGLE
    -180 + atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)), //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
          
  #cylinder(
    //HEIGHT
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = L_SRADIUS * SCALE); //radius, adjusted for scale
  
  
  
  //ROTARY ENCODER CUTOUT
  translate([
    //X TRANSLATION
    RE_XOFF * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    (-1 + RE_YOFF *                                      //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))//move the cutout along the sloped wall
    * SCALE,                                             //adjust for scale
               
    //Z TRANSLATION
    RE_YOFF * SCALE]) //y offset, adjusted for scale
  
  rotate(
    //ANGLE
    atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))-180, //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
    
  #cylinder(
    //HEIGHT
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = RE_RADIUS * SCALE); //radius, adjusted for scale
  


  //POWER INPUT CUTOUT
  translate([
    //X TRANSLATION
    (BOTLENGTH - 2*THICK -                                           //initial position on far wall, accounting for wall thickness
    PI_YOFF * (tan(90 - atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH)))))//move the cutout along the sloped wall
    * SCALE,                                                         //adjust for scale
    
    //Y TRANSLATION
    PI_XOFF * SCALE, //x offset (on the plane of the wall cutout is placed on)
    
    //Z TRANSLATION,
    PI_YOFF * SCALE])//y offset (on the plane of the wall cutout is placed on)
    
    
  #cube([
    //THICKNESS (x-axis)
    2*THICK * SCALE, //extra thickness to cut through entire wall, adjusted for scale
    
    //LENGTH (y-axis)
    PI_LENGTH * SCALE, //length of cutout, adjusted for scale
    
    //WIDTH (z-axis)
    PI_WIDTH * SCALE]); //width of cutout adjusted for scale
    
    
    
  //POWER SWITCH CUTOUT
  translate([
    //X TRANSLATION
    (BOTLENGTH + 1 -                                                 //initial position on far wall
    PS_YOFF * (tan(90 - atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH)))))//move the cutout along the sloped wall
    * SCALE,                                                         //adjust for scale
               
    //Y TRANSLATION
    PS_XOFF * SCALE, //x offset (on the plane of the wall cutout is placed on)
               
    //Z TRANSLATION
    PS_YOFF * SCALE])//y offset (on the plane of the wall cutout is placed on)
  
  rotate(
    //ANGLE
    atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH)) - 180, //angle of the wall cutout is placed on
    
    //AXIS
    [0, 1, 0]) //y-axis
    
  #cylinder(
    //HEIGHT
    (THICK + 1) * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = PS_RADIUS * SCALE); //radius, adjusted for scale
  
  //NUB 1
  translate([
    //X TRANSLATION
    (HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH)))) //slope from base to top on x axis
    + (TOPLENGTH / 2 - THICK / 2)) * SCALE, //halfway down the length of the top
    
    //Y TRANSLATION
    (HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))))) * SCALE, //slope from base to top on y axis
    
    //Z TRANSLATION
    (HEIGHT - THICK) * SCALE]) //embed the nub into the top
    
  #cube(THICK * SCALE); //cube based on wall thickness
  
  //NUB 2
  translate([
    //X TRANSLATION
    (HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH)))) //slope from base to top on x axis 
    + (TOPLENGTH / 2 - THICK / 2)) * SCALE, //halfway down the length of the top
    
    //Y TRANSLATION
    (BOTWIDTH - THICK //far base wall
    -(HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)))))) * SCALE, //slope from base to top on y axis
    
    //Z TRANSLATION
    (HEIGHT - THICK) * SCALE //embed the nub into the top
    ])
    
  #cube(THICK * SCALE); //cube based on wall thickness
  
  //NUB 3
  translate([
    //X TRANSLATION
    (HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH))))) * SCALE, //slope from base to top on x axis
    
    //Y TRANSLATION
    ((TOPWIDTH / 2) //halfway down the width of the top
    + (HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))))) - THICK / 2) * SCALE, //slope from base to top on y axis
    
    //Z TRANSLATION
    (HEIGHT - THICK) * SCALE]) //embed the nub into the top
    
  #cube(THICK * SCALE); //cube based on wall thickness
  
  //NUB 4
  translate([
    //X TRANSLATION
    (BOTLENGTH - THICK //far base wall
    -(HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTLENGTH - TOPLENGTH)))))) * SCALE, //slope from base to top on x axis
    
    //Y TRANSLATION
    ((TOPWIDTH / 2) //halfway down the width of the top
    + (HEIGHT * (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))))) - THICK / 2) * SCALE, //slope from base to top on y axis
    
    //Z TRANSLATION
    (HEIGHT - THICK) * SCALE]) //embed the nub into the top
    
  #cube(THICK * SCALE); //cube based on wall thickness
  
  }
  