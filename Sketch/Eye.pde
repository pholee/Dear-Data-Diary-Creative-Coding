PImage eye1, eye2;

void drawEye() {
  
  // Check if eye is hovered over
  boolean isHovered = mouseX > 875 && mouseX < 975 && mouseY > 20 && mouseY < 135;

  //If night time or hovered over sleep (eye shut) else awake (eye open)
  if (solarElapsed>0.5 && solarElapsed<1 || isHovered) {
    image(eye2, 875, 70, 100, 100);
  } else {
    image(eye1, 875, 30, 110, 110);
  }
}
