//number of elements (-1)
resolution = 150;

//dimensions of the bottom layer
BOTLENGTH = 100;
BOTWIDTH = 70;

//dimensions of the top layer
TOPLENGTH = 80;
TOPWIDTH = 42;

//height of the full base
HEIGHT = 20;

//element dimension change
ELEMLENGTH = (BOTLENGTH - TOPLENGTH )/ resolution;
ELEMWIDTH = (BOTWIDTH - TOPWIDTH) / resolution;
ELEMHEIGHT = HEIGHT / resolution;

for(i = [1 : 1 : resolution]){
    translate([
    0, //x
    0, //y
    ((i-1)*ELEMHEIGHT) + (ELEMHEIGHT/2)]) //z 
    cube([
    BOTLENGTH - (i * ELEMLENGTH), //length
    BOTWIDTH - (i * ELEMWIDTH),   //width
    ELEMHEIGHT],                   //height
    true);                         //center
}