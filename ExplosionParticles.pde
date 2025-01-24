class ExplosionParticles extends Particle
{
  int lifespan;
  Boolean outsideScreen;
  
  ExplosionParticles(PVector position)
  {
    super(position);
    velocity = PVector.random2D();
    velocity.mult(random(1, 50));
    lifespan = 255;
    outsideScreen = false;
  }
  
  void update()
  {
    physics(); //<>//
  }
  void show(float hueValue)
  {
    velocity = new PVector(velocity.x < 0 ? velocity.x * map(velocity.x, -50, -1, 0.65, 0.875) : velocity.x * map(velocity.x, 1, 50, 0.875, 0.65), velocity.y * 0.65);
    lifespan -= 8.5;
    display(1.25, new PVector(hueValue, 255, 255), lifespan);
  }
}
