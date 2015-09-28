class Bullet
{
  PVector bulletPosition;
  PVector bulletVelocity;
  boolean bulletHidden;
  int bulletSize;
  int bulletCreationTime;
  int bulletLifespan;
  int bulletSpeed;

  Bullet()
  {
    bulletHidden = true;
    bulletSize = 5;
    bulletPosition = new PVector();
    bulletVelocity = new PVector();
    bulletCreationTime = 0;
    bulletLifespan = 2000;
    bulletSpeed = 3;
  }

  void updateBullet()
  {
    if (!bulletHidden)
    {
      bulletPosition.add(bulletVelocity);
      if (millis() - bulletCreationTime > bulletLifespan)
      {
        bulletHidden = true;
      }
    bulletPosition.x %= width;
    if(bulletPosition.x < -1)
      {bulletPosition.x = width;}
    bulletPosition.y %= height;
    if(bulletPosition.y < -1)
      {bulletPosition.y = height;}
    }
  }

  void drawBullet()
  {
    if (!bulletHidden)
    {
      updateBullet();
      ellipse(bulletPosition.x, bulletPosition.y, bulletSize, bulletSize);
    }
  }

  void reset(PVector pos, PVector spe, float direct)
  {
    bulletPosition = new PVector(pos.x + (20 * cos(radians(direct) - PI/2)), pos.y + (20 * sin(radians(direct) - PI/2)));
    bulletVelocity.x = bulletSpeed * cos(radians(direct) - PI/2) + spe.x;
    bulletVelocity.y = bulletSpeed * sin(radians(direct) - PI/2) + spe.y;
    bulletCreationTime =  millis();
    //print(bulletVelocity);
    bulletHidden = false;
  }
}