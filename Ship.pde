boolean[] keys;
class Ship
{
  PVector acceleration;
  PVector velocity;
  PVector position;
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
  }
  
  void drawShip()
  {
    updateShip();
    
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
}