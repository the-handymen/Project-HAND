//number of elements
resolution = 50;

//scale of the full design
SCALE = 1;

//hollowed percentage
HOLLOWP = 0.8;

//height of the full design
HEIGHT = 20 * SCALE;

//dimensions of the bottom layer
BOTLENGTH = 100 * SCALE;
BOTWIDTH = 70 * SCALE;

//dimensions of the top layer
TOPLENGTH = 80 *SCALE;
TOPWIDTH = 42 * SCALE;

//element dimension change
ELEMLENGTH = (BOTLENGTH - TOPLENGTH )/ resolution;
ELEMWIDTH = (BOTWIDTH - TOPWIDTH) / resolution;
ELEMHEIGHT = HEIGHT / resolution;

for(i = [1 : 1 : resolution]){
    difference(){
        translate([
        0, //x
        0, //y
        ((i-1)*ELEMHEIGHT) + (ELEMHEIGHT/2)]) //z 
        %cube([
        BOTLENGTH - (i * ELEMLENGTH), //length
        BOTWIDTH - (i * ELEMWIDTH),   //width
        ELEMHEIGHT],                   //height
        true);                         //center
        
        translate([
        0, //x
        0, //y
        ((i-1)*ELEMHEIGHT) + (ELEMHEIGHT/2)])
        #cube([
        (BOTLENGTH - (i * ELEMLENGTH)) *HOLLOWP, //length
        (BOTWIDTH - (i * ELEMWIDTH)) * HOLLOWP,   //width
        ELEMHEIGHT],                   //height
        true);                         //center
    }
}
