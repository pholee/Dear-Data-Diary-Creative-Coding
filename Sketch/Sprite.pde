PImage sprite, speechBubble;
String string = "Click me to play an animation!";

float spriteWidth = 200; //Image width
float spriteHeight = 200; //Image height
float spriteX = 30; //Image Xpos
float spriteY = 470; //Image Ypos

void interactiveButton() {
  image(sprite, spriteX, spriteY, spriteWidth, spriteHeight);
  
  //Check if sprite is hovered over
  boolean spriteIsHovered = mouseX > 50 && mouseX < spriteWidth && mouseY > 500 && mouseY < height-35;
  
  //If hovered, display speech bubble
  if (spriteIsHovered) {
    image(speechBubble, spriteX+175, spriteY-50, spriteWidth, spriteHeight);
    textSize(16);
    text(string, spriteX+225, spriteY+50, 120, 100);
    fill(0, 0, 0);
  }
  
  //If clicked, change text
  if (screenAnimation) {
    string = "Click me to return to the launch page.";
  } else {
    string = "Click me to play an animation!";
  }
}
