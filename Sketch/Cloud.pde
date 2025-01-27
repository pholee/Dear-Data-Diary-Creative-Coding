PImage cloud1, cloud2;

class Cloud {
  PImage cloud; //Imports asset
  float x, y, speed; //Intial x, y and speed given to cloud

  //Constructor called to create new cloud
  Cloud(PImage img) {
    this.cloud = img;
    
    //Initialises state of cloud with random values
    x = random(1275, 3000);
    y = random(50, 200);
    
    //Initial speed
    updateSpeed();
  }
  
   void reset() {
    x = random(1275, 3000); //Reset x position
    y = random(50, 200); //Reset y position
    updateSpeed(); //Reset speed
  }
  
  //Checks if image name is cloud1 or cloud2 and adjusts speed accordingly
  void updateSpeed() {
    if (cloud == cloud1) {
      speed = 0.75 * (86400 / solarDuration);
    } else {
      speed = 0.5 * (86400 / solarDuration);
    }
  }

  void display() {
    image(cloud, x, y, 250, 250);
  }
  
   void move() {
    x -= speed; //Move the cloud horizontally
    if (x < -300) {
      x = width + 300; //Reset to the right side if it goes offscreen
    }
  }
}
