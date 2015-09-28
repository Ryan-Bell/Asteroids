boolean[] keys;
class Ship
{
  PVector shipAcceleration;
  PVector shipVelocity;
  PVector shipPosition;
  PShape shipShape;
  float shipDirection;
  int shipHealth;
  int shipLastFire;
  int shipDelayTime;
  float shipMaxSpeed;
  
  Ship()
  {
    shipAcceleration = new PVector();
    shipVelocity = new PVector();
    shipPosition = new PVector(width/2, height/2);
    shipDirection = 0;
    shipHealth = 100;
    shipLastFire = 0;
    shipDelayTime = 300;
    //shipMaxSpeed = 0;
    keys = new boolean[5];
    shipShape = createShape();
    shipShape.beginShape();
    shipShape.fill(255);
    shipShape.strokeWeight(1);
    shipShape.vertex(0, -4);
    shipShape.vertex(2,0);
    shipShape.vertex(2,2);
    shipShape.vertex(0,1);
    shipShape.vertex(-2,2);
    shipShape.vertex(-2,0);
    shipShape.vertex(0, -4);
    shipShape.endShape();
  }
  
  void drawShip()
  {
    updateShip();
    shipShape.resetMatrix();
    shipShape.rotate(radians(shipDirection));
    shape(shipShape, shipPosition.x, shipPosition.y, 10,10);
  }
  
  void destroyShip()
  {
    fill(150);
    textAlign(CENTER,CENTER);
    textSize(72);
    noLoop();
    text("You Lose",width/2, height/2);
  }
  
  void updateShip()
  {
    shipAcceleration.x = 0;
    shipAcceleration.y = 0;
    if(keys[0])
    {
      shipAcceleration.x = 0.5 * cos(radians(shipDirection)  - PI/2);
      shipAcceleration.y = 0.5 * sin(radians(shipDirection) - PI/2);
    }
    if(keys[1] && !keys[2])
      {shipDirection -= 5;}
    if(keys[2] && !keys[1])
      {shipDirection += 5;}
    shipVelocity.add(shipAcceleration);
    shipPosition.add(shipVelocity);
    shipVelocity.mult(.95);
    shipPosition.x %= width;
    if(shipPosition.x < -10)
      {shipPosition.x = width;}
    shipPosition.y %= height;
    if(shipPosition.y < -10)
      {shipPosition.y = height;}
    if(keys[4])
    {
      if(millis() - shipLastFire > shipDelayTime)
        {
          shipLastFire = millis();
          manager.fireBullet(shipPosition, shipVelocity, shipDirection);
        }
    }
  }
}

void keyPressed()
{
   if(key == CODED)
   {
     if(keyCode == UP)
       keys[0] = true;
     if(keyCode == LEFT)
       keys[1] = true;
     if(keyCode == RIGHT)
       keys[2] = true;
     if(keyCode == DOWN)
       keys[3] = true;
   }
   else
   {
     if(key == 'w')
       keys[0] = true;
     if(key == 'a')
       keys[1] = true;
     if(key == 'd')
       keys[2] = true;
     if(key == 's')
       keys[3] = true;
     if(key == ' ')
       keys[4] = true;
   }
}

void keyReleased()
{
   if(key == CODED)
   {
     if(keyCode == UP)
       keys[0] = false;
     if(keyCode == LEFT)
       keys[1] = false;
     if(keyCode == RIGHT)
       keys[2] = false;
     if(keyCode == DOWN)
       keys[3] = false;
   }
   else
   {
     if(key == 'w')
       keys[0] = false;
     if(key == 'a')
       keys[1] = false;
     if(key == 'd')
       keys[2] = false;
     if(key == 's')
       keys[3] = false;
     if(key == ' ')
       keys[4] = false;
   }
}