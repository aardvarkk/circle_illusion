int w = 400;
int h = 400;
int pts = round(0.25*0x20); // number of lines/points on those lines, default = 0.25 = 8pts
float ptdiam = 0.05*w; // diameter of points, default = 0.05 = 20px
float sep = 0.6*PI/pts; // angular separation between lines, default = 1.0 = PI/pts
float phase_offset = 0.2*PI/pts; // how much to offset the phase between each point, default = 1.0 = PI/pts
int period = 3000; // milliseconds for one wavelength, default = 3000 = 3s per rotation
float start_angle = 0.3*PI; // radian angle at which lines begin, default = 0.0 = 0rad
int start_opacity = 0xFF; // opacity of first drawn circle, default = 0xFF = full opacity
float chng_opacity = -1.0*0xFF; // total change in opacity across all circles, default = 0.0 = 0% opacity change across all circles
float line_opacity = 0.05*0xFF; // opacity to draw lines with, default = 0.05 = 5% opacity
float x_offset = 0.0*w/2; // amount to offset initially in "x" direction, default = 0.0 = 0px offset
float x_range = 1.0*w; // total amount of range for "x" to have, default = 1.0 = entire width of circle

void setup() {
  size(w, h);
}

void draw() {
  background(0x00);
  fill(0xFF);
  ellipse(w/2, h/2, w, h);
  fill(0x00);
  
  translate(w/2,h/2);
  
  int m = millis();
  
  if (round(line_opacity) > 0) {
    pushMatrix();
    rotate(start_angle);
    stroke(0x00, 0x00, 0x00, round(line_opacity));
    for (int i = 0; i < pts; ++i) {
      line(-w/2, 0, w/2, 0);
      rotate(sep);
    }
    popMatrix();
  }
  
  rotate(start_angle);
  for (int i = 0; i < pts; ++i) {
    int k = 0x00; 
    fill(k, k, k, round(start_opacity + i*chng_opacity/pts));
    noStroke();
    ellipse(x_offset+x_range*cos(TWO_PI/period*m + i*phase_offset), 0, ptdiam, ptdiam);
    rotate(sep);
  }
  //println(frameRate);
}

