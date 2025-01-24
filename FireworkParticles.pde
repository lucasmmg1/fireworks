class FireworkParticles extends Particle
{
  int explosionParticlesRatio, explosionParticlesOutsideScreen;
  float hueValue;
  Boolean exploded;
  ArrayList<ExplosionParticles> explosionParticles;
  
  FireworkParticles()
  {
    super(new PVector(random(25, width - 25), height - 1));
    velocity = new PVector(0, random(-25, -22.5));
    explosionParticlesRatio = 250;
    explosionParticlesOutsideScreen = 0;
    hueValue = random(255);
    exploded = false;
    explosionParticles = new ArrayList<ExplosionParticles>();
  }
  
  void update()
  {
    switch (exploded.toString())
    {
      case "true":
        for (ExplosionParticles explosionParticle : explosionParticles)
          explosionParticle.update();
      break;
      
      case "false":
        physics();
        if (velocity.y >= 0)
          explode();
      break;
    }
  }
  void show()
  {
    switch (exploded.toString())
    {
      case "true":
        for (ExplosionParticles explosionParticle : explosionParticles)
        {
          if (!explosionParticle.outsideScreen && explosionParticle.position.y > height)
          {
            explosionParticle.outsideScreen = true;
            explosionParticlesOutsideScreen++;
            continue;
          }
          explosionParticle.show(hueValue);
        } //<>//
      break;
      
      case "false":
        display(2, new PVector(hueValue, 255, 255), 255);
        for (var i = 0; i < 10; i++)
          point(position.x, position.y + i * 1.25);
      break;
    }
  }
  void explode()
  {
    exploded = true; //<>//
    
    for (var i = 0; i < explosionParticlesRatio; i++)
      explosionParticles.add(new ExplosionParticles(new PVector(position.x, position.y)));
  }
}
