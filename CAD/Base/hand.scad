include <connect.scad>

//CONNECTING SHEET
cube([
  //LENGTH (x axis)
  TOPLENGTH * SCALE, //top length of base
  
  //WIDTH (y axis)
  TOPWIDTH * SCALE, //top width of base
  
  //HEIGHT (z axis)
  THICK * SCALE]); //thickness of base


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
  
  