

class Asteroid
{
  PVector asteroidVelocity;
  PVector asteroidPosition;
  float asteroidDirection;
  
  Asteroid(int px, int py, int vx, int vy, float inD)
  {
    asteroidVelocity = new PVector(px, py);
    asteroidPosition = new PVector(vx, vy);
    asteroidDirection = inD;
  }
  
  void drawAsteroid()
  {
    updateAsteroid();
    
  }
  
  void updateAsteroid()
  {
    
  }
  
}