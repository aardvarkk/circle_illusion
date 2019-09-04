import controlP5.*;
ControlP5 cp5;

int w = 400;
int h = 400;
int control_w = 200;
int control_h = 20;
int label_w = 100;

// number of lines/points
int pts;

// diameter of points, default = 0.05 = 20px
float ptdiam_mult; 
float get_ptdiam() { return ptdiam_mult * w; }

// angular separation between lines, default = 1.0 = PI/pts
float separation_mult;
float get_separation() { return separation_mult * PI/pts; } 

// how much to offset the phase between each point, default = 1.0 = PI/pts
float phase_offset_mult;
float get_phase_offset() { return phase_offset_mult * PI/pts; }

// milliseconds for one wavelength, default = 3000 = 3s per rotation
float period_s;
int get_period() { return round(period_s * 1000); }

// amount to offset initially in "x" direction, default = 0.0 = 0px offset
float lin_offset_mult; 
float get_lin_offset() { return lin_offset_mult * w/2; }

// total amount of range for "x" to have, default = 1.0 = entire width of circle
float lin_offset_rng_mult;
float get_lin_offset_rng() { return lin_offset_rng_mult * (w-get_ptdiam())/2; }

// opacity to draw lines with, default = 0.05 = 5% opacity
float line_opacity_mult;
float get_line_opacity() { return line_opacity_mult * 0xFF; } 

// total change in opacity across all circles, default = 0.0 = 0% opacity change across all circles
float chng_opacity_mult; 
float get_chng_opacity() { return -chng_opacity_mult * 0xFF; }

int start_opacity; // opacity of first drawn circle, default = 0xFF = full opacity

void restore_defaults() {
  pts = 8; cp5.getController("pts").setValue(pts);
  ptdiam_mult = 0.1; cp5.getController("ptdiam_mult").setValue(ptdiam_mult);
  separation_mult = 1.0; cp5.getController("separation_mult").setValue(separation_mult);
  phase_offset_mult = 1.0; cp5.getController("phase_offset_mult").setValue(phase_offset_mult);
  period_s = 3.0; cp5.getController("period_s").setValue(period_s);
  lin_offset_mult = 0.0; cp5.getController("lin_offset_mult").setValue(lin_offset_mult); 
  lin_offset_rng_mult = 1.0; cp5.getController("lin_offset_rng_mult").setValue(lin_offset_rng_mult);
  line_opacity_mult = 0.1; cp5.getController("line_opacity_mult").setValue(line_opacity_mult);
  chng_opacity_mult = 1.0; cp5.getController("chng_opacity_mult").setValue(chng_opacity_mult);
  start_opacity = 0xFF;
}

void setup() {
  size(600, 400); // w + control_w, h
  cp5 = new ControlP5(this);
  
  int i = 0;
  
  cp5.addSlider("pts")
     .setLabel("Points")
     .setPosition(w, i++ * control_h)
     .setRange(0, 32)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("line_opacity_mult")
     .setLabel("Line Opacity")
     .setPosition(w, i++ * control_h)
     .setRange(0.0, +1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("ptdiam_mult")
     .setLabel("Size")
     .setPosition(w, i++ * control_h)
     .setRange(0.0, 1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("period_s")
     .setLabel("Period")
     .setPosition(w, i++ * control_h)
     .setRange(0.0, 5.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("lin_offset_mult")
     .setLabel("Linear Offset")
     .setPosition(w, i++ * control_h)
     .setRange(-1.0, +1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("lin_offset_rng_mult")
     .setLabel("Linear Offset Range")
     .setPosition(w, i++ * control_h)
     .setRange(-1.0, +1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("separation_mult")
     .setLabel("Separation")
     .setPosition(w, i++ * control_h)
     .setRange(-1.0, +1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("phase_offset_mult")
     .setLabel("Phase Offset")
     .setPosition(w, i++ * control_h)
     .setRange(-1.0, +1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addSlider("chng_opacity_mult")
     .setLabel("Point Fade")
     .setPosition(w, i++ * control_h)
     .setRange(0.0, +1.0)
     .setSize(control_w-label_w, control_h)
     ;
  cp5.addButton("restore_defaults")
     .setPosition(w, i++ * control_h)
     .setSize(control_w-label_w, control_h)
     ;
  restore_defaults();
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
  
  if (round(get_line_opacity()) > 0) {
    pushMatrix();
    stroke(0x00, 0x00, 0x00, round(get_line_opacity()));
    for (int i = 0; i < pts; ++i) {
      line(-w/2, 0, w/2, 0);
      rotate(get_separation());
    }
    popMatrix();
  }
  
  for (int i = 0; i < pts; ++i) {
    int k = 0x00; 
    fill(k, k, k, round(start_opacity + i*get_chng_opacity()/pts));
    noStroke();
    ellipse(get_lin_offset()+get_lin_offset_rng()*cos(TWO_PI/get_period()*m + i*get_phase_offset()), 0, get_ptdiam(), get_ptdiam());
    rotate(get_separation());
  }
  
  popMatrix();
  
  //println(frameRate);
}
