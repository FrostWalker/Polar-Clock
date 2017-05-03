//-----------------------
// DO NOT TOUCH THIS
//-----------------------

import java.util.Date;
import java.text.SimpleDateFormat;

int initialH, initialM, initialS;
boolean displayDocumentation = true;

void initialize() {
  int[] initTime = initializeTime();    
  //current hour
  initialH = initTime[0];
  //current minute
  initialM = initTime[1];
  //current second
  initialS = initTime[2];

  initializeMyClock();
}

void setup() {
  size(1024, 768);
  smooth();
  PFont f = createFont("SansSerif", 24);
  textFont(f);

  initializeMyClock();
}

void draw() {
  if(!displayDocumentation) {
    runClock();
  } else {
    showDocumentation();
  }
}


void keyPressed() {
 if(key == 's') {
   float id = random(1) + millis();
   String file = "screengrabs/capture_" + id + ".png"; 
   saveFrame("saved file: " + file);
 }
  if(key == 'h') {
    displayDocumentation = !displayDocumentation;
    
  }
}
