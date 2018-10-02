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
BOTLENGTH = 100;
BOTWIDTH = 70;

//dimensions of the top layer
TOPLENGTH = 80;
TOPWIDTH = 42;

///////////////////////////////////
/////////////   LCD   /////////////
///////////////////////////////////
//dimensions of the LCD
L_LENGTH = 25;
L_WIDTH = 10;

//placement of the LCD (offset from 0,0)
L_XOFF = 25;
L_YOFF = 5;

///////////////////////////////////
///////////// DRAWING /////////////
///////////////////////////////////
difference(){ 
  //base shape   
  centered_fustrum(BOTLENGTH * SCALE, 
                   BOTWIDTH * SCALE,
                   TOPLENGTH * SCALE,
                   TOPWIDTH * SCALE,
                   HEIGHT * SCALE);
    
  //hollowed center  
  translate([((THICK) + (0.5*(BOTLENGTH - TOPLENGTH) * BOTTHICK / HEIGHT)) * SCALE,
             ((THICK) + (0.5*(BOTWIDTH - TOPWIDTH) * BOTTHICK / HEIGHT)) * SCALE,
              (BOTTHICK)*SCALE])
  centered_fustrum((BOTLENGTH-2*THICK-((BOTLENGTH-TOPLENGTH)*BOTTHICK/HEIGHT))*SCALE,
                   (BOTWIDTH-2*THICK-((BOTWIDTH-TOPWIDTH)*BOTTHICK/HEIGHT))*SCALE,
                   (TOPLENGTH-2*THICK+((BOTLENGTH-TOPLENGTH)*TOPTHICK/HEIGHT))*SCALE,
                   (TOPWIDTH-2*THICK+((BOTWIDTH-TOPWIDTH)*TOPTHICK/HEIGHT))*SCALE,
                   ((HEIGHT-TOPTHICK-BOTTHICK)*SCALE));

    //LCD cutout
    translate([L_XOFF * SCALE,
               L_YOFF *(tan(90 - atan(2*HEIGHT/(BOTWIDTH-TOPWIDTH)))) * SCALE,
               L_YOFF * SCALE]) 
    rotate(-90 + atan(2*HEIGHT/(BOTWIDTH-TOPWIDTH)),
          [1, 0, 0]) 
    cube([L_LENGTH * SCALE,
          THICK * SCALE,
          L_WIDTH * SCALE]);
}