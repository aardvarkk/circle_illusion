import controlP5.*;
ControlP5 cp5;

int w = 400;
int h = 400;
int control_w = 200;
int control_h = 20;
int label_w = 100;
float ptdiam = 0.05*w; // diameter of points, default = 0.05 = 20px

// number of lines/points
int pts = 8;

// angular separation between lines, default = 1.0 = PI/pts
float separation_mult = 1.0;
float get_separation() { return separation_mult * PI/pts; } 

// how much to offset the phase between each point, default = 1.0 = PI/pts
float phase_offset_mult = 1.0;
float get_phase_offset() { return phase_offset_mult * PI/pts; }

int period = 3000; // milliseconds for one wavelength, default = 3000 = 3s per rotation

// radian angle at which lines begin, default = 0.0 = 0rad
float start_angle_mult = 0.0;
float get_start_angle() { return start_angle_mult*PI; } 

int start_opacity = 0xFF; // opacity of first drawn circle, default = 0xFF = full opacity
float chng_opacity = -1.0*0xFF; // total change in opacity across all circles, default = 0.0 = 0% opacity change across all circles
float line_opacity = 0.05*0xFF; // opacity to draw lines with, default = 0.05 = 5% opacity
float x_offset = 0.0*w/2; // amount to offset initially in "x" direction, default = 0.0 = 0px offset
float x_range = 1.0*(w-ptdiam)/2; // total amount of range for "x" to have, default = 1.0 = entire width of circle
 
void setup() {
  size(w+control_w, h);
  cp5 = new ControlP5(this);
  
  cp5.addSlider("start_angle_mult")
     .setLabel("Start Angle")
     .setPosition(w, 0*control_h)
     .setRange(-2.0, +2.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("pts")
     .setLabel("Points")
     .setPosition(w, 1*control_h)
     .setRange(0, 32)
     .setSize(control_w-label_w, control_h)
     .setValue(8)
     ;
     
}

void draw() {
  
  background(0x00);
  fill(0xFF);
  ellipse(w/2, h/2, w, h);
  fill(0x00);
  
  // required so we don't screw up the controls
  pushMatrix();
  
  translate(w/2,h/2);
  
  int m = millis();
  
  if (round(line_opacity) > 0) {
    pushMatrix();
    rotate(get_start_angle());
    stroke(0x00, 0x00, 0x00, round(line_opacity));
    for (int i = 0; i < pts; ++i) {
      line(-w/2, 0, w/2, 0);
      rotate(sep);
    }
    popMatrix();
  }
  
  rotate(get_start_angle());
  for (int i = 0; i < pts; ++i) {
    int k = 0x00; 
    fill(k, k, k, round(start_opacity + i*chng_opacity/pts));
    noStroke();
    ellipse(x_offset+x_range*cos(TWO_PI/period*m + i*phase_offset), 0, ptdiam, ptdiam);
    rotate(sep);
  }
  
  popMatrix();
  
  //println(frameRate);
}

