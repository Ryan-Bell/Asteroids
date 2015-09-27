ArrayList<Asteroid> asteroids;
Mothership mothership;
Ship player;

void setup()
{
 size(1080,480); 
 asteroids = new ArrayList<Asteroid>();
 mothership = new Mothership();
 player = new Ship();
}

void draw()
{
  background(0);
  mothership.drawMothership();
  player.drawShip();
  for(int i = 0; i < asteroids.size(); i++)
  {
    asteroids.get(i).drawAsteroid(); 
  }
}