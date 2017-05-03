import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;
import java.util.Locale;

class Time { //Time class
  private Time last = null; //Smaller Time unit
  private Time next = null; //Larger Time unit
  private final int field; //This unit (Java Calendar Field)
  private int alarm = 0; //Alarm setting
  private String name; //Local name for this unit of time
  private boolean hasAlarm = false; //Stores if alarm is set
  private static TimeZone timeZone; //Local time zone
  private Calendar calendar = new GregorianCalendar(); //Initalise the calender as a Gregorian Calendar
  
  public Time(int field, String name) { //Constructor Method
    this.field = field;
    this.name = name;
  }
  
  public Time set(Time last, Time next) { //Initialisation Method
    this.last = last;
    this.next = next;
    calendar.setTime(new Date());
    calendar.set(1900, 06, 12);
    setTimeZone();
    
    return this;
  }
  
  public String getName() { //Returns the local name
    return this.name;
  }
  
  public String getShort() { //Returns the Java Calendar SHORT name
    return calendar.getInstance(timeZone).getDisplayName(field, Calendar.SHORT, new Locale("en"));
  }
  
  public String getLong() { //Returns the Java Calendar LONG name
    return calendar.getInstance(timeZone).getDisplayName(field, Calendar.LONG, new Locale("en"));
  }
  
  public float get() { //Returns the current time
    return getInt() + (last != null ? (last.get() / last.max()) : 0);
  }
  
  public int getInt() { //Returns the current time
    return calendar.getInstance(timeZone).get(field);
  }
  
  public float max() { //Returns the max value for this time unit
    return calendar.getInstance(timeZone).getActualMaximum(field) + 1;
  }
  
  public int maxInt() { //Returns the max value for this time unit
    return calendar.getInstance(timeZone).getActualMaximum(field) + 1;
  }
  
  public boolean mod() { //Returns whether or not this unit modified by the next unit's isTwo
    return (next != null) ? next.isTwo() : false;
  }
  
  public boolean isTwo() { //Returns whether or not this unit a multiple of two
    return Math.floor(get()) % 2 == 0;
  }
  
  public static void setTimeZone() {
    timeZone = Calendar.getInstance().getTimeZone();
  }
  
  public static void setTimeZone(String tz) {
    timeZone = TimeZone.getTimeZone(tz);
  }
  
  public static TimeZone getTimeZone() {
    return timeZone;
  }
  
  public int setAlarm(int alarm) { //Sets the alarm, returns the alarm value that was just set
    this.hasAlarm = true;
    this.alarm = alarm;
    return getAlarm();
  }
  
  public int getAlarm() { //Return the time value for the alarm
    return this.alarm;
  }
  
  public boolean hasAlarm() { //Returns if this time unit has an alarm set
    return this.hasAlarm;
  }
  
  public int removeAlarm() { //Removes the alarm and resets the variables, returns the previous alarm value
    int val = this.alarm;
    this.hasAlarm = false;
    this.alarm = 0;
    
    return val;
  }
  
  public static String getDOW() { //Returns the day of the week
    return Calendar.getInstance(timeZone).getDisplayName(Calendar.DAY_OF_WEEK, Calendar.SHORT, new Locale("en"));
  }
}
