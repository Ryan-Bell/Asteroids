boolean[] keys;
class Ship
{
  PVector acceleration;
  PVector velocity;
  PVector position;
  PShape shipShape;
  float direction;
  int health;

  
  Ship()
  {
    acceleration = new PVector();
    velocity = new PVector();
    position = new PVector(width/2, height/2);
    direction = 90;
    health = 100;
    keys = new boolean[5];
    shipShape = createShape();
    shipShape.beginShape();
    shipShape.fill(255);
    shipShape.strokeWeight(2);
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
    shape(shipShape, position.x, position.y, 20,20);
  }
  

  
  void updateShip()
  {
    
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