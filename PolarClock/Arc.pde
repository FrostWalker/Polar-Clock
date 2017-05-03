
class Arc {
  private float cx, cy, cr = 0.0f;
  private Time time;
  private color col;
  private boolean focus, alarmFocus, locked = false;
  private float alarmAngle = 0.0f;
  private boolean initialised = false;
  private int frame;
  
  public Arc(float cx, float cy, float cr, Time time, color col) {
    this.cx = cx;
    this.cy = cy;
    this.cr = cr;
    this.time = time;
    this.col = col;
    this.frame = 0;
  }
  
  private void update() {
    float difference = mouse.getRadius() - (cr*2);
    float tollerance = 20;
    if((difference >= -tollerance && difference <= tollerance && mouse.locked == false) || locked) focus = true;
      else focus = false;
      
    float alarmDifference = mouse.getAngle() - alarmAngle;
    float alarmTollerance = 5;
    if((focus && alarmDifference >= -alarmTollerance && alarmDifference <= alarmTollerance) || locked) alarmFocus = true;
      else alarmFocus = false;
  }
  
  public void draw() {
    update();
    
    pushMatrix();
    pushStyle();
    
    if(alarmFocus || focus || displayDocumentation) {
      fill(255, 10);
      noStroke();
      for(int i = 0; i <= 360; ++i) {
        float lx = cx + cr * cos(radians(i+270));
        float ly = cy + cr * sin(radians(i+270));
        
        if(focus || alarmFocus) ellipse(lx, ly, 2, 2);
          else ellipse(lx, ly, 1, 1);
      }
    }
    
    fill(col);
    noStroke();
    
      float angle = ((time.get() / time.max()) * 360) % 360;
      
      int startAngle, endAngle;
      if(initialised) {
        startAngle = time.mod() ? int(angle) : 0;
        endAngle = time.mod() ? 360 : int(angle);
      } else {
        float initFrame = frame / frameRate / 2;
        startAngle = floor(lerp(0, time.mod() ? int(angle) : 0, initFrame));
        endAngle = floor(lerp(0, time.mod() ? 360 : int(angle), initFrame));
        ++frame;
        if(initFrame > 1) initialised = true;
      }
      
      for(int i = startAngle; i <= endAngle; ++i) {
        float lx = cx + cr * cos(radians(i+270));
        float ly = cy + cr * sin(radians(i+270));
        
        ellipse(lx, ly, 7, 7);
      }
    
    if(hasAlarm()) {
      fill(255);
      
        float lx = cx + cr * cos(radians(alarmAngle+270));
        float ly = cy + cr * sin(radians(alarmAngle+270));
        
        if(alarmFocus) ellipse(lx, ly, 24, 24);
          else ellipse(lx, ly, 16, 16);
    }
      
      if((mousePressed && mouseButton == LEFT && alarmFocus) || (mousePressed && mouseButton == LEFT && !hasAlarm() && focus)) {
        this.locked = true;
        mouse.locked = true;
        alarmAngle = floor(mouse.getAngle() / 360 * time.max())  * (360 / time.max());
        time.setAlarm(floor(mouse.getAngle() / 360 * time.max()));
      } else if(alarmFocus) {
        mouse.locked = false;
        this.locked = false;
      } else {
        this.locked = false;
      }
      
      if(mousePressed && mouseButton == RIGHT && alarmFocus) {
        time.removeAlarm();
      }
      
    popStyle();
    popMatrix();
  }
  
  public boolean hasAlarm() {
    return time.hasAlarm();
  }
  
  public boolean alarmActive() {
    if(hasAlarm()) {
      int current = time.getInt();
      int alarm = time.getAlarm();
      if(current == alarm) return true;
        else return false;
      
    } return true;
  }
}
