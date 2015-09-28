

class Asteroid
{
  PVector asteroidVelocity;
  PVector asteroidPosition;
  float asteroidDirection;
  PVector anchor1, anchor2, control1, control2;
  float asteroidSize;
  
  Asteroid(int px, int py, float vx, float vy, float inD)
  {
    asteroidVelocity = new PVector(vx, vy);
    asteroidPosition = new PVector(px, py);
    asteroidDirection = inD;
    asteroidSize = 5;
    anchor1 = new PVector(asteroidPosition.x, asteroidPosition.y - asteroidSize);
    anchor2 = new PVector(asteroidPosition.x, asteroidPosition.y + asteroidSize);
    control1 = new PVector(asteroidPosition.x + asteroidSize, asteroidPosition.y);
    control2 = new PVector(asteroidPosition.x - asteroidSize, asteroidPosition.y);
  }
  
  void drawAsteroid()
  {
    updateAsteroid();
    beginShape();
    vertex(anchor1);
    quadraticVertex(c1,a2);
    quadraticVertex(c2,a1);
    endShape();
    ellipse(asteroidPosition.x, asteroidPosition.y, 10,10);
  }
  
  void updateAsteroid()
  {
    asteroidPosition.add(asteroidVelocity);
    asteroidPosition.x %= width;
    if(asteroidPosition.x < -10)
      {asteroidPosition.x = width;}
    asteroidPosition.y %= height;
    if(asteroidPosition.y < -10)
      {asteroidPosition.y = height;}
      
    
  }
  
}