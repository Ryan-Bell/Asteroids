ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
Mothership mothership;
Ship player;
GameManager manager;

class GameManager
{
  
  int bulletIndex;
  
  GameManager()
  {
     bulletIndex = 0;
     asteroids = new ArrayList<Asteroid>();
     bullets = new ArrayList<Bullet>();
     for(int i = 0; i < 20; i++)
       {bullets.add(new Bullet());}
     mothership = new Mothership();
     player = new Ship();
  }
  
  void drawGame()
  {
    background(0);
    mothership.drawMothership();
    player.drawShip();
    for(int i = 0; i < asteroids.size(); i++)
      {asteroids.get(i).drawAsteroid();}
    for(int i = 0; i < bullets.size(); i++)
      {bullets.get(i).drawBullet();}
  }
  
  void fireBullet(PVector pos, PVector spe, float dir)
  {
    bullets.get(bulletIndex).reset(pos, spe, dir);
    bulletIndex++;
    bulletIndex %= bullets.size();
    //print(bulletIndex);
  }
}



void setup()
{
 size(1080,480);
 manager = new GameManager();
}

void draw()
{
  manager.drawGame(); 
}