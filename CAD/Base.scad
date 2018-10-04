use <fustrum.scad>

//scale of the full design
SCALE = 1;

///////////////////////////////////
//////////BASIC STRUCTURE//////////
///////////////////////////////////

//wall thickness
THICK = 3;

//top thickness
TOPTHICK = 3;

//bottom thickness
BOTTHICK = 3;

//height of the full design
HEIGHT = 20;

//dimensions of the bottom layer
BOTLENGTH = 100; //length
BOTWIDTH = 70;   //width

//dimensions of the top layer
TOPLENGTH = 80; //length
TOPWIDTH = 42;  //width

///////////////////////////////////
/////////////   LCD   /////////////
///////////////////////////////////

//dimensions
L_LENGTH = 25; //length
L_WIDTH = 10;  //width

//placement on base wall (offset from 0,0)
L_XOFF = 20; //offset on x-axis
L_YOFF = 5;  //offset on y-axis

///////////////////////////////////
////////  ROTARY ENCODER   ////////
///////////////////////////////////

//radius
RE_RADIUS = 3;

//placement on base wall (offset from 0,0)
RE_XOFF = 55; //offset on x-axis
RE_YOFF = 7;  //offset on y-axis

///////////////////////////////////
///////////// DRAWING /////////////
///////////////////////////////////
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
  
  //END BASE SHAPE
    
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
                   
  //END HOLLOWED CENTER

  //LCD CUTOUT
  
  translate([
    //X TRANSLATION
    L_XOFF * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    L_YOFF *                                            //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))))//move the cutout along the sloped wall
    * SCALE,                                            //adjust for scale
               
    //Z TRANSLATION
    L_YOFF * SCALE])//y offset, adjusted for scale
               
  rotate(
    //ANGLE
    -90 + atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH)), //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
          
  cube([
         //LENGTH (x-axis)
         L_LENGTH * SCALE, //length adjusted for scale
         
         //THICKNESS (y-axis)
         THICK * SCALE,    //wall thickness, adjusted for scale, to cut through entire side wall
         
         //WIDTH (z-axis)
         L_WIDTH * SCALE]);//width adjusted for scale
    
  //END LCD CUTOUT
  
  //ROTARY ENCODER CUTOUT
  
  translate([
    //X TRANSLATION
    RE_XOFF * SCALE, //x offset, adjusted for scale
               
    //Y TRANSLATION
    RE_YOFF *                                            //y offset
    (tan(90 - atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))))//move the cutout along the sloped wall
    * SCALE,                                            //adjust for scale
               
    //Z TRANSLATION
    RE_YOFF * SCALE])//y offset, adjusted for scale
  
  rotate(
    //ANGLE
    atan(2 * HEIGHT / (BOTWIDTH - TOPWIDTH))-180, //angle of the wall cutout is placed on
    
    //AXIS
    [1, 0, 0]) //x-axis
    
  cylinder(
    //HEIGHT
    THICK * SCALE, //wall thickness, adjusted for scale
    
    //RADIUS
    r = RE_RADIUS * SCALE); //radius, adjusted for scale
  
  //END ROTARY ENCODER CUTOUT
}
