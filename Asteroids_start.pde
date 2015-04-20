import ddf.minim.*;
Minim minim;
AudioPlayer background;

import de.ilu.movingletters.*;
PFont font;
//ArrayList stars;
float shootX;
float shipX;//ship location
float shipY;//ship location
float shipWidth, shipSize;
float shipAngle;
float direction;//ships direction
PVector location;//ships location
PVector velocity;//ship speeds
PVector accel;//ship acceleration
float bugX, bugY;//bug location
int xDir = 1;
int score = 0;
//^^^ Score Tally
MovingLetters letters;

void setup() 
{
  size(1000, 1000);
minim = new Minim(this);
background = minim.loadFile("background.mp3");
background.loop();
  strokeWeight(random(2, 5));
  letters = new MovingLetters(this, 50, 1, 0);  
  bugX = random(0, width); //this sets the bug on a random movement
  bugY = 50;
  location = new PVector(width/2, height/2, 0);
  velocity = new PVector();
  accel = new PVector();
  shipX = width/2;
  shipY = height/2;
  shipAngle = 0.0;
}

void drawBug(float bugX, float bugY, float bugSize)
{

  line(bugX + bugSize/2, bugY, bugX, bugY + bugSize/2); 
  line(bugX, bugY + bugSize/2, bugX + bugSize, bugY + bugSize/2);
  line(bugX + bugSize/2, bugY, bugX + bugSize, bugY + bugSize/2);
  line(bugX + bugSize/8, bugY + bugSize/2, bugX, bugY + bugSize);
  line(bugX + bugSize/4, bugY + bugSize/2, bugX, bugY + bugSize);
  line(bugX + bugSize/1.15, bugY + bugSize/2, bugX + bugSize, bugY + bugSize);
  line(bugX + bugSize/1.35, bugY + bugSize/2, bugX + bugSize, bugY + bugSize);
  line(bugX + bugSize/1.5, bugY + bugSize/3, bugX + bugSize/1.5, bugY + bugSize/6);
  line(bugX + bugSize/3, bugY + bugSize/3, bugX + bugSize/3, bugY + bugSize/6);
  line(bugX + bugSize/3, bugY + bugSize/2.5, bugX + bugSize/1.5, bugY + bugSize/2.5);
}

void draw() {

  checkKeys();
  background(0);
  fill(0, 10);
  rect(0, 0, width, height);
  fill(255);
  noStroke();
  ellipse(random(width), random(height), 4, 4);
  stroke(0, 255, 0);
  strokeWeight(random(2, 5));


  drawBug(bugX, bugY, 60);
  moveBug();
  shootX = shipX + shipWidth/2;
  letters.text("Score: " + score, 5, 35);
  velocity.add(accel);
  location.add(velocity);
  drawShip();
  accel.set(0, 0, 0);
  if (velocity.mag() != 0) velocity.mult(0.99);
  //wrap of the ship on screen
  if (location.x<0) 
  {
    location.x = location.x+width;
  }
  if (location.x>width) 
  {
    location.x = 0;
  }
  if (location.y<0) 
  {
    location.y = location.y+height;
  }
  if (location.y>height) 
  {
    location.y = 0;
  }
 
}

void moveBug()
{
  if (frameCount % 60 == 0)
  {
    bugX += random(-100, 100);
    bugY += (25);
  }

  if (bugX < 50)
  {
    bugX = 120;
  } 
  if (bugX > width - 50)
  {
    bugX = width - 120;
  }
}

void drawShip() 
{
  strokeWeight(random(2, 5));
  pushMatrix();
  translate(location.x, location.y);  // Translate the ships origin
  rotate(direction);  // Rotate ship
  fill(105, 0, 95);  // Display the ship
  stroke(0, 255, 0);
  triangle(-10, 20, 10, 20, 0, -10);
  
  if (accel.mag() != 0) // if the ship is accelerating draw a thruster
  {  
    float thrusterCol = random(0, 255);//thuster that appears behind the ship
    fill(thrusterCol, thrusterCol/2, 0);
    triangle(-5, 22, 5, 22, 0, 30);
  }
   if (key == ' ')
  {
    line(shootX, shipX, shipY, 0);
    //shipY, shipX + shipWidth/2
    if (shootX >= bugX && shootX <= bugX + 60)
    {
      bugX = random(0, width);
      bugY = 0;
      score ++;
    }
  }
  popMatrix();
}

//moving the ship
void checkKeys() {
  if (keyPressed && key == CODED) 
  {
    if (keyCode == LEFT) 
    {
      direction-=0.1;
    } else if (keyCode == RIGHT) 
    {
      direction+=0.1;
    } else if (keyCode == UP) 
    {
      float totalAccel = 0.3;                 // how much ship accelerates
      accel.x = totalAccel * sin(direction);  // total accel
      accel.y = -totalAccel * cos(direction); // total accel
    }
  }
}

