ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
Mothership mothership;
Ship player;
GameManager manager;

class GameManager
{
  
  int bulletIndex;
  int buffer = 90;
  //PVector cameraPosition;
  GameManager()
  {
     bulletIndex = 0;
     asteroids = new ArrayList<Asteroid>();
     bullets = new ArrayList<Bullet>();
     for(int i = 0; i < 20; i++)
       {bullets.add(new Bullet());}
       
     for(int i = 0; i < 10; i++)
     {
       asteroids.add(new Asteroid((int)random(0,width), (int)random(0,height), random(0,1), random(0,1), random(0,360))); 
     }
       
     mothership = new Mothership();
     player = new Ship();
     //cameraPosition = new PVector(width/2, height/2);
  }
  
  void drawGame()
  {
    //background(0);
    fill(0,50);
    rect(0,0,width,height);
    fill(255);
    //player.drawShip();
    //pushMatrix();
    //if(player.shipPosition.x > (cameraPosition.x * 2) - buffer)
    //{
      //translate(-1 * (player.shipPosition.x - (cameraPosition.x * 2 - buffer)),0);
      //cameraPosition.x += (player.shipPosition.x - (cameraPosition.x * 2 - buffer));
      //player.shipPosition.x -= (player.shipPosition.x - (cameraPosition.x * 2 - buffer));
    //}
    mothership.drawMothership();
    player.drawShip();
    for(int i = 0; i < asteroids.size(); i++)
      {asteroids.get(i).drawAsteroid();}
    for(int i = 0; i < bullets.size(); i++)
      {bullets.get(i).drawBullet();}
    //popMatrix();
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
 background(0);
 manager = new GameManager();
}

void draw()
{
  manager.drawGame(); 
}