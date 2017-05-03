/**
 * DO NOT CHANGE ANYTHING IN THIS TAB
 **/


/*
 * returns an array of the current time according to the system.
 * the array consists of three integers that correspond to the hour, minutes and seconds
*/

int[] initializeTime() {
  SimpleDateFormat f = new SimpleDateFormat("hh,mm,ss");
  String TIME = f.format(new Date());
  String[] t = TIME.split(",");
  
  int[] ret = new int[3];
  ret[0] = Integer.parseInt(t[0]);
  ret[1] = Integer.parseInt(t[1]);
  ret[2] = Integer.parseInt(t[2]);
  
  return ret;
}

