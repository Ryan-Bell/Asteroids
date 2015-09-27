

class Asteroid
{
  PVector velocity;
  PVector position;
  float direction;
  
  Asteroid(int px, int py, int vx, int vy, float inD)
  {
    velocity = new PVector(px, py);
    position = new PVector(vx, vy);
    direction = inD;
    
  }
  
  void drawAsteroid()
  {
    updateAsteroid(); 
  }
  
  void updateAsteroid()
  {
    
  }
  
}