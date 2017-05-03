import java.util.Calendar;

public Time timeMS, timeS, timeM, timeH, timeD, timeN, timeY;
public Mouse mouse;
public Time[] clockHands;

private Clock clock;

private float cx, cy = 0.0f;

public void initializeMyClock() {  
  timeMS = new Time(Calendar.MILLISECOND, "millis");
  timeS = new Time(Calendar.SECOND, "seconds");
  timeM = new Time(Calendar.MINUTE, "minutes");
  timeH = new Time(Calendar.HOUR_OF_DAY, "hours");
  timeD = new Time(Calendar.DAY_OF_MONTH, "days");
  timeN = new Time(Calendar.MONTH, "months");
  timeY = new Time(Calendar.YEAR, "years");
  
  timeMS.set(null, timeS.set(timeMS, timeM.set(timeS, timeH.set(timeM, timeD.set(timeH, timeN.set(timeD, timeY.set(timeN, null)))))));
  
//  Time.setTimeZone("Australia/Eucla");
  
  clockHands = new Time[]{timeN, timeD, timeH, timeM, timeS};
  
  cx = width/2;
  cy = height/2;
  
  mouse = new Mouse(cx, cy);
  clock = new Clock(cx, cy, 500);
}

public void runClock() {
  background(38);  
    
  pushMatrix();
  pushStyle();
    
    clock.draw();
    
  popStyle();
  popMatrix();
}

public void showDocumentation() {
  runClock();
  
  pushMatrix();
  pushStyle();
  
    translate(cx, cy);
  
    stroke(255, 25);
    strokeWeight(1);
    fill(255, 50);
    
    textSize(24);
    textAlign(LEFT, BOTTOM);
    text("The Polar Clock", -475, -340);
    line(-485, -330, -175, -330);
    
    textSize(14);
    textLeading(14);
    textAlign(LEFT, TOP);
    text(
      "A Polar Clock is a clock that displays the \ntime in a series of circular rings.\n\nEach unit of time is display as an individual \nring, with rings representing the month, day \nof the month, hour, minute, and second. As \ntime progresses, each ring expands growing \ninto a full circle, before receding back to \nnothing."
    , -470, -320);
    
    textAlign(LEFT, BOTTOM);
    text(
      "To set an alarm, click on a ring to create an \nalarm scrubber, and while holding the mouse \nbutton down, drag it around the circle.\n\nRight click on an alarm scrubber to remove it.\n\nPress \"H\" to hide this interface and return to \nthe clock. You can bring this guide back up at \nany time by pressing the \"H\" key."
    , -470, 320);
    

      for(int i = 0; i < clockHands.length; ++i) {
        float lx = (210-(i*15)) * cos(radians((i*37.5)+15+270));
        float ly = (210-(i*15)) * sin(radians((i*37.5)+15+270));
        float dx = 270 * cos(radians((i*30)+30+270));
        float dy = 270 * sin(radians((i*30)+30+270));
        line(lx, ly, dx, dy);
        line(dx, dy, dx+200, dy);
        textSize(16);
        textAlign(LEFT, BOTTOM);
          text("." + clockHands[i].getName() + "//", dx+10, dy-1);
        textSize(12);
        textAlign(RIGHT, TOP);
          text("currently " + (clockHands[i].getInt() + (clockHands[i] == timeN ? 1 : 0)) + " / " + clockHands[i].maxInt(), dx+190, dy+1);
      }
  
  popStyle();
  popMatrix();
}
