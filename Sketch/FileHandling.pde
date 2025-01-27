//Initialise schedule arrays
int[] dates;
String[] sunSet;
String[] sunRise;
String[] wakeUp;
String[] sleep;
String[] trainOut;
String[] trainHome;

void screenSunData() {
  textSize(20);

  //Table dimensions
  int x = 450; //Start x-coordinates for collumns
  int y = 250; //Start y-coordinate for rows

  //Table headers
  text("Date", x, y);
  text("Sunrise", x+110, y);
  text("Sunset", x+220, y);
  text("Daylight hours", x+330, y);

  //Iterate over the data to display
  for (int i = 1; i < dates.length; i++) {
    
    //Calculate daylight hours duration
    String sunRiseTime = sunRise[i];
    String sunSetTime = sunSet[i];
    int lightDuration = calculateDuration(sunRiseTime, sunSetTime);
    String durationString = formatDuration(lightDuration);

    //Display the data in the table
    text(dates[i], x, y+50);
    text(sunRise[i], x+110, y+50);
    text(sunSet[i], x+220, y+50);
    text(durationString, x+330, y+50);

    y += 30; //Move to the next row
  }
}

void screenSleepData() {
  textSize(20);

  //Table dimensions
  int x = 450; //Start x-coordinates for collumns
  int y = 250; //Start y-coordinate for rows

  //Table headers
  text("Date", x, y);
  text("Slept", x+110, y);
  text("Woke", x+220, y);
  text("Sleep duration", x+330, y);

  //Iterate over the data to display
  for (int i = 1; i < dates.length; i++) {
    
    //Calculate sleep duration
    String sleepTime = sleep[i];
    String wakeUpTime = wakeUp[i];
    int sleepDuration = calculateDuration(sleepTime, wakeUpTime);
    String durationString = formatDuration(sleepDuration);

    //Display the data in the table
    text(dates[i], x, y+50);
    text(sleep[i], x+110, y+50);
    text(wakeUp[i], x+220, y+50);
    text(durationString, x+330, y+50);

    y += 30; //Move to the next row
  }
}

void screenTravelData() {
textSize(20);

  //Table dimensions
  int x = 450; //Start x-coordinates for collumns
  int y = 250; //Start y-coordinate for rows

  //Table headers
  text("Date", x, y);
  text("Train out", x+110, y);
  text("Train home", x+220, y);
  text("Est. time outside", x+330, y);

  //Iterate over the data to display
  for (int i = 1; i < dates.length; i++) {
    
    //Calculate sleep duration
    String trainOutTime = trainOut[i];
    String trainHomeTime = trainHome[i];
    int outsideDuration = calculateDuration(trainOutTime, trainHomeTime);
    String durationString = formatDuration(outsideDuration);

    //Display the data in the table
    text(dates[i], x, y+50);
    text(trainOut[i], x+110, y+50);
    text(trainHome[i], x+220, y+50);
    text(durationString, x+330, y+50);

    y += 30; //Move to the next row
  }
}

//Calculate time duration
int calculateDuration(String startTime, String endTime) {
  //Parse hours and minutes from the time strings
  String[] startParts = split(startTime, ":");
  String[] endParts = split(endTime, ":");

  if (startParts.length < 2 || endParts.length < 2) {
    return 0; //Return 0 if time format is invalid
  }
  
  int startHours = int(startParts[0]);
  int startMinutes = int(startParts[1]);

  int endHours = int(endParts[0]);
  int endMinutes = int(endParts[1]);

  //Convert both times to minutes since midnight
  int endTotalMinutes = startHours * 60 + startMinutes;
  int startTotalMinutes = endHours * 60 + endMinutes;

  //Handle overnight times
  if (startTotalMinutes < endTotalMinutes) {
    startTotalMinutes += 24 * 60; //Add 24 hours in minutes
  }
  
  return startTotalMinutes - endTotalMinutes;
}

//Format time for duration
String formatDuration(int durationMinutes) {
  int hours = durationMinutes / 60;
  int minutes = durationMinutes % 60;
  return nf(hours, 2) + ":" + nf(minutes, 2) + " hrs";
}
