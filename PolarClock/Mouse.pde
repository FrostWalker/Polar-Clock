class Mouse { //Mouse class
  private float cx, cy = 0.0f; //The location of origin (centre of canvas)
  public boolean locked = false; //Lock the mouse if another class is using a click method
  
  Mouse(float cx, float cy) { //Constructor Method
    this.cx = cx;
    this.cy = cy;
  }
  
  public float getX() { //Returns the X position of the mouse
    return mouseX;
  }
  
  public float getY() { //Returns the Y position of the mouse
    return mouseY;
  }
  
  public float getAngle() { //Returns the angle of inclination of the mouse relative to the origin
    return -((atan2((getX() - cx), (getY() - cy)) * 180 / PI) - 180);
  }
  
  public float getRadius() { //Returns the distance from origin to the mouse
    return sqrt(sq(getX() - cx) + sq(getY() - cy)) * 2;
  }
}
