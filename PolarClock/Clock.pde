class Clock {
  private float cx, cy, r = 0.0f;
  private Arc sh, mh, hh, dh, nh;
  private boolean alarmActive = false;
  private int alarmFrame = 0;
  private int alarmTime = 10;
  private color[] colours = {
    color(22, 117, 188),
    color(0, 163, 150),
    color(129, 197, 64),
    color(245, 181, 46),
    color(237, 91, 53),
    color(234, 34, 94),
    color(194, 34, 134),
    color(97, 46, 141)
  };
  
  public Clock(float cx, float cy, float r) {
    this.cx = cx;
    this.cy = cy;
    this.r = r;
    
    initialise();
  }
  
  private void initialise() {
    sh = new Arc(cx, cy, 150, timeS, colours[2]);
    mh = new Arc(cx, cy, 165, timeM, colours[3]);
    hh = new Arc(cx, cy, 180, timeH, colours[4]);
    dh = new Arc(cx, cy, 195, timeD, colours[5]);
    nh = new Arc(cx, cy, 210, timeN, colours[6]);
  }
  
  public void draw() {
//    if(!displayDocumentation) debug();
    checkAlarm();
    
    pushMatrix();
    pushStyle();
    
      translate(width/2, height/2);
    
      int hour = timeH.getInt();
      int minute = timeM.getInt();
      textSize(64);
      textAlign(CENTER, BOTTOM);
      if(alarmActive && alarmFrame % frameRate*2 < frameRate) text("ALARM", -5, -15);
        else text((hour < 10 ? "0" : "") + hour + ":" + (minute < 10 ? "0" : "") + minute, -5, -15);
        
      String day = Time.getDOW().toUpperCase();
      int date = timeD.getInt();
      String month = timeN.getShort().toUpperCase();
      textSize(32);
      textAlign(CENTER, TOP);
      text(day + ", " + date + " " + month, -5, -15);
      
      textSize(12);
      text(Time.getTimeZone().getDisplayName(), -5, 35);
      
    popMatrix();
    pushMatrix();
    
      sh.draw();
      mh.draw();
      hh.draw();
      dh.draw();
      nh.draw();
    
    popStyle();
    popMatrix();    
  }
  
  private void checkAlarm() {
    if(!alarmActive && sh.alarmActive() && mh.alarmActive() && hh.alarmActive() && dh.alarmActive() && nh.alarmActive() &&
      (sh.hasAlarm() || mh.hasAlarm() || hh.hasAlarm() || dh.hasAlarm() || nh.hasAlarm())) {
        alarmActive = true;
        alarmFrame = 0;
    } else if(alarmActive) {
      if(alarmFrame > frameRate * alarmTime) alarmActive = false;
      ++alarmFrame;
    } else {
      alarmActive = false;
      alarmFrame = 0;
    }
  }
  
  public void debug() {
      pushMatrix();
      pushStyle();
      
        stroke(255, 25);
        strokeWeight(1);
        noFill();
        textSize(12);
      
      arc(cx, cy, mouse.getRadius(), mouse.getRadius(), 0, TAU);
      line(cx, cy, mouse.getX(), mouse.getY());
      
      for(int i = 0; i < 24; ++i) {
        float pos1x = cx;
        float pos1y = cy;
        float pos2x = cx + 250 * cos( radians((i/24.0f) * 360) );
        float pos2y = cy + 250 * sin( radians((i/24.0f) * 360) );
        
        line(pos1x, pos1y, pos2x, pos2y);
      }
      text((timeMS.mod() ? "2" : "0") + " milli: " + timeMS.max() + " / " + timeMS.get(), cx+350, cy+100);
      text((timeS.mod() ? "2" : "0") + " second: " + timeS.max() + " / " + timeS.get(), cx+350, cy+120);
      text((timeM.mod() ? "2" : "0") + " minute: " + timeM.max() + " / " + timeM.get(), cx+350, cy+140);
      text((timeH.mod() ? "2" : "0") + " hour: " + timeH.max() + " / " + timeH.get(), cx+350, cy+160);
      text((timeD.mod() ? "2" : "0") + " day: " + timeD.max() + " / " + timeD.get(), cx+350, cy+180);
      text((timeN.mod() ? "2" : "0") + " month: " + timeN.max() + " / " + timeN.get(), cx+350, cy+200);
      text((timeY.mod() ? "2" : "0") + " year: " + timeY.get(), cx+350, cy+220);
      
      text("mouse.getX: " + mouse.getX(), cx+350, cy+260);
      text("mouse.getY: " + mouse.getY(), cx+350, cy+280);
      text("mouse.getAngle: " + mouse.getAngle(), cx+350, cy+300);
      text("mouse.getRadius: " + mouse.getRadius(), cx+350, cy+320);
      
    popStyle();
    popMatrix();
  }
}
