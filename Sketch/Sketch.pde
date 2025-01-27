PFont font;
PImage line;

boolean screenAnimation = false;
boolean isAnimating = false;
boolean screenSun = false;
boolean screenSleep = false;
boolean screenTravel = false;

Cloud[] clouds; //Initialise array of clouds

void setup() {
  size(1024, 700);
  
  //Text font
  font = createFont("Margarine-Regular.ttf", 20);
  textFont(font);
  
  //Load the images
  line = loadImage("Line.png");
  cloud1 = loadImage("Cloud1.png");
  cloud2 = loadImage("Cloud2.png");
  eye1 = loadImage("Eye1.png");
  eye2 = loadImage("Eye2.png");
  sun = loadImage("Sun.png");
  moon = loadImage("Moon.png");
  sprite = loadImage("Sprite.png");
  speechBubble = loadImage("Speech bubble.png");

  //Initialize the clouds
  int numClouds = int(random(1, 7)); //Randomises number of clouds each time the program is run between 1 and 7
  clouds = new Cloud[numClouds]; //Creates array of clouds
  
  //Loops through array appending cloud1 and cloud2 at random
  for (int i=0; i<numClouds; i++) {
    float num = random(0, 1);
    if (num < 0.5) {
      clouds[i] = new Cloud(cloud1);
    } else {
      clouds[i] = new Cloud(cloud2);
    }
  }
  
  //Read from file into original array
  String[] textLines = loadStrings("A week in my life.txt");
  
  //Create separate arrays for specific data
  dates = new int[textLines.length];
  sunSet = new String[textLines.length];
  sunRise = new String[textLines.length];
  wakeUp = new String[textLines.length];
  sleep = new String[textLines.length];
  trainOut = new String[textLines.length];
  trainHome = new String[textLines.length];

  //Iterate through original array and store like data in separate arrays
  for (int i=1; i<textLines.length; i=i+1) {
    
    String[] values = split(textLines[i], ","); //Split line by comma
   
    dates[i] = int(values[0]); 
    sunRise[i] = values[1];
    sunSet[i] = values[2];
    wakeUp[i] = values[3];
    sleep[i] = values[4];
    trainOut[i] = values[5];
    trainHome[i] = values[6];
  }
}

void draw() {
  background(207,226,243);
  
  //Title
  textSize(65);
  text("A week in my life", 50, 115);
  fill(0, 0, 0);
  image(line, 40, 140, 495, 10);
  
  //Menu item 1.1
  textSize(20);
  fill(0, 0, 0); 
  text("Sunset/ Sunrise times", 60, 200);
  //If menu item is hovered over, make interactable
  boolean menu11IsHovered = mouseX > 50 && mouseX < 270 && mouseY > 170 && mouseY < 215 && !screenAnimation;
  if (menu11IsHovered) {
    noStroke();
    circle(45, 192.5, 7);
    fill(0, 0, 0);
  }
  
  //Menu item 1.2
  textSize(20); 
  fill(0, 0, 0); 
  text("Sleep Schedule", 60, 245); 
  //If menu item is hovered over, make interactable
  boolean menu12IsHovered = mouseX > 50 && mouseX < 270 && mouseY > 215 && mouseY < 260 && !screenAnimation;
  if (menu12IsHovered) {
    noStroke();
    circle(45, 237.5, 7);
    fill(0, 0, 0);
  }

  //Menu item 1.3
  textSize(20);
  fill(0, 0, 0);
  text("Travel", 60, 290);  
  //If menu item is hovered over, make interactable
  boolean menu13IsHovered = mouseX > 50 && mouseX < 270 && mouseY > 260 && mouseY < 305 && !screenAnimation;
  if (menu13IsHovered) {
    noStroke();
    circle(45, 282.5, 7);
    fill(0, 0, 0);
  }
  
  interactiveButton();
  drawEye();
 
  //Show sunset/rise schedule when menu 1.1 clicked
  if (screenSun) {
    screenSunData();
  }
  //Show sleep schedule when menu 1.2 clicked
  if (screenSleep) {
    screenSleepData();
  }
  //Show travel schedule when menu 1.3 clicked
  if (screenTravel) {
    screenTravelData();
  }
  //Switch to animation screen when sprite clicked
  if (screenAnimation) {
    
    //If unpaused, update animation variables
    if (isAnimating) {
      timeElapsed = millis() - startAnimationTime;
      solarElapsed = (timeElapsed % solarDuration) / solarDuration;
    }
        
    drawAnimation();
    
    for (Cloud cloud : clouds) {
      cloud.display();
      if (isAnimating) {
        cloud.move(); // Only move the clouds when the animation is running
      }
    }
    
    //Title
    textSize(65);
    text("Options", 50, 115);
    fill(0, 0, 0);
    image(line, 42, 140, 250, 10);
    
    //Menu item 2.1
    textSize(15);
    if (isAnimating) {
      text("Pause", 60, 175);
    } else {
      text("Play", 60, 175);
    }
    fill(0, 0, 0);
    //If menu item is hovered over, make interactable
    boolean menu21IsHovered = mouseX > 50 && mouseX < 105 && mouseY > 155 && mouseY < 185 && screenAnimation;
    if (menu21IsHovered) {
      noStroke();
      circle(47, 170, 5);
      fill(0, 0, 0);
    }
    
    //Menu item 2.2
    textSize(15);
    text(">> / <<", 60, 200);
    fill(0, 0, 0);
    //If menu item is hovered over, make interactable
    boolean menu22IsHovered = mouseX > 50 && mouseX < 105 && mouseY > 185 && mouseY < 210 && screenAnimation;
    if (menu22IsHovered) {
      noStroke();
      circle(47, 195, 5);
      fill(0, 0, 0);
    }
    
    displayDate(currentDay);
    displayTime(timeString);
    interactiveButton();
    drawEye();
      
  } else {
    //Reset when not animating
    solarElapsed = 0;
    currentDay = startDay;
    isAnimating = false;
  }
}

//If different items on screen clicked, make things happen
void mousePressed() {
  //Sprite plays animation
  if (mouseX > 50 && mouseX < spriteWidth && mouseY > 500 && mouseY < height-35) {
    screenAnimation = !screenAnimation;
    for (Cloud cloud : clouds) {
      cloud.reset();
    }
    screenSun = false;
    screenSleep = false;
    screenTravel = false;
    interactiveButton();
  }
  //Menu1.1 shows sunset/rise schedule
  if (mouseX > 50 && mouseX < 300 && mouseY > 170 && mouseY < 215 && !screenAnimation) {
    screenSun = !screenSun;
    screenSleep = false;
    screenTravel = false;
  }
  //Menu1.2 shows sleep schedule
  if (mouseX > 50 && mouseX < 300 && mouseY > 215 && mouseY < 260 && !screenAnimation) {
    screenSun = false;
    screenSleep = !screenSleep;
    screenTravel = false;
  }
  //Menu1.3 shows travel schedule
  if (mouseX > 50 && mouseX < 300 && mouseY > 260 && mouseY < 305 && !screenAnimation) {
    screenSun = false;
    screenSleep = false;
    screenTravel = !screenTravel;
  }
  //Menu2.1 pauses animation
  if (mouseX > 50 && mouseX < 100 && mouseY > 155 && mouseY < 185 && screenAnimation) {
    isAnimating = !isAnimating;
    if (isAnimating) {
        // Resuming animation: calculate the start time based on the stored solarElapsed
        startAnimationTime = millis() - solarElapsed * solarDuration;
    } else {
        // Pausing animation: store the current elapsed time as a fraction
        solarElapsed = ((millis() - startAnimationTime) % solarDuration) / solarDuration;
    }
  }
  //Menu2.2 speeds up animation
  if (mouseX > 50 && mouseX < 78 && mouseY > 185 && mouseY < 215 && isAnimating) {
    if (solarDuration > 10000) {
      float currentProgress = (millis() - startAnimationTime) / solarDuration;
      solarDuration = solarDuration/1.5;
      startAnimationTime = millis() - currentProgress * solarDuration;
      //Update cloud speeds
      for (Cloud cloud : clouds) {
        cloud.updateSpeed();
      }
    }
  }
  //Menu 2.2 slows down animation
  if (mouseX > 80 && mouseX < 105 && mouseY > 180 && mouseY < 210 && isAnimating) {
    if (solarDuration < 86400) {
      float currentProgress = (millis() - startAnimationTime) / solarDuration;
      solarDuration = solarDuration*1.5;
      startAnimationTime = millis() - currentProgress * solarDuration;
      //Update cloud speeds
      for (Cloud cloud : clouds) {
        cloud.updateSpeed();
      }
    }
  }
}
