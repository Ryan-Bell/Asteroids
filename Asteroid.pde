

class Asteroid
{
  PVector asteroidVelocity;
  PVector asteroidPosition;
  float asteroidDirection;
  //PVector anchor1, anchor2, control1, control2;
  float rotAngle;
  float[] anchorsX;
  float[] anchorsY;
  float asteroidSize;
  int numAnchors;

  Asteroid(int px, int py, float vx, float vy, float inD)
  {
    asteroidVelocity = new PVector(vx, vy);
    asteroidPosition = new PVector(px, py);
    asteroidDirection = inD;
    asteroidSize = 30;
    numAnchors = 6;
    rotAngle = 0;
    anchorsX = new float[numAnchors];
    anchorsY = new float[numAnchors];
  }

  void drawAsteroid()
  {
    updateAsteroid();

    curveTightness(0);
    beginShape();
    noStroke();
    for (int i=0; i<numAnchors; i++) {
      curveVertex(anchorsX[i], anchorsY[i]);
    }
    for (int i=0; i<numAnchors; i++) {
      curveVertex(anchorsX[i], anchorsY[i]);
    }
    endShape(CLOSE);
  }

  void updateAsteroid()
  {
    asteroidPosition.add(asteroidVelocity);
    asteroidPosition.x %= width;
    if (asteroidPosition.x < -10)
    {
      asteroidPosition.x = width;
    }
    asteroidPosition.y %= height;
    if (asteroidPosition.y < -10)
    {
      asteroidPosition.y = height;
    }

    rotAngle = 0;
    for (int i=0; i<numAnchors; i++)
    {
      anchorsX[i] = asteroidPosition.x + cos(radians(rotAngle) + noise(asteroidPosition.x/20+i*4))*asteroidSize ;
      anchorsY[i] = asteroidPosition.y + sin(radians(rotAngle) + noise(asteroidPosition.y/20+i*4))*asteroidSize ;
      rotAngle += 360/numAnchors;
    }
  }
}