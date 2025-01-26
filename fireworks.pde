ArrayList<FireworkParticles> fireworks;
PVector gravity;

void setup()
{
  size(800, 600, P2D);
  colorMode(HSB);
  
  fireworks = new ArrayList<FireworkParticles>();
  gravity = new PVector(0, 0.75);
  background(0);
}

void draw()
{
  fill(0, 50);
  noStroke();
  rect(0, 0, width, height);
  
  if (random(5) < 0.1)
    fireworks.add(new FireworkParticles());
  
  var tempFireworks = new ArrayList<FireworkParticles>(fireworks);
  for (FireworkParticles firework : tempFireworks) 
  {
    if (firework.explosionParticles.size() != 0 && firework.explosionParticles.get(0).lifespan <= 0)
    {
      fireworks.remove(firework);
      background(0);
      continue;
    }
    
    firework.update();
    firework.show();
  }
}
