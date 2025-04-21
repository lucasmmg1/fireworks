ArrayList<PVector> fireworks = new ArrayList<PVector>();
ArrayList<PVector> fireworkVelocities = new ArrayList<PVector>();
ArrayList<Float> fireworkHues = new ArrayList<Float>();
ArrayList<Boolean> exploded = new ArrayList<Boolean>();
ArrayList<ArrayList<PVector>> explosionParticles = new ArrayList<ArrayList<PVector>>();
ArrayList<ArrayList<PVector>> explosionVelocities = new ArrayList<ArrayList<PVector>>();
ArrayList<ArrayList<Integer>> explosionLifespans = new ArrayList<ArrayList<Integer>>();
ArrayList<ArrayList<Boolean>> explosionOutsideScreen = new ArrayList<ArrayList<Boolean>>();

PVector gravity;

void setup() {
  size(800, 600, P2D);
  colorMode(HSB);
  gravity = new PVector(0, 0.75);
  background(0);
}

void draw() {
  fill(0, 50);
  noStroke();
  rect(0, 0, width, height);
  
  if (random(5) < 0.1) {
    // Cria um novo foguete
    fireworks.add(new PVector(random(25, width - 25), height - 1));
    fireworkVelocities.add(new PVector(0, random(-25, -22.5)));
    fireworkHues.add(random(255));
    exploded.add(false);
    explosionParticles.add(new ArrayList<PVector>());
    explosionVelocities.add(new ArrayList<PVector>());
    explosionLifespans.add(new ArrayList<Integer>());
    explosionOutsideScreen.add(new ArrayList<Boolean>());
  }

  for (int i = fireworks.size() - 1; i >= 0; i--) {
    if (exploded.get(i)) {
      boolean allDead = true;
      for (int j = 0; j < explosionParticles.get(i).size(); j++) {
        if (explosionLifespans.get(i).get(j) > 0) {
          allDead = false;
          break;
        }
      }
      if (allDead) {
        fireworks.remove(i);
        fireworkVelocities.remove(i);
        fireworkHues.remove(i);
        exploded.remove(i);
        explosionParticles.remove(i);
        explosionVelocities.remove(i);
        explosionLifespans.remove(i);
        explosionOutsideScreen.remove(i);
        background(0);
        continue;
      }
    }

    if (!exploded.get(i)) {
      PVector pos = fireworks.get(i);
      PVector vel = fireworkVelocities.get(i);
      vel.add(gravity);
      pos.add(vel);

      float hue = fireworkHues.get(i);
      strokeWeight(2);
      stroke(hue, 255, 255);
      point(pos.x, pos.y);
      for (int j = 0; j < 10; j++)
        point(pos.x, pos.y + j * 1.25);

      if (vel.y >= 0) {
        exploded.set(i, true);
        for (int j = 0; j < 250; j++) {
          PVector expPos = new PVector(pos.x, pos.y);
          PVector expVel = PVector.random2D().mult(random(1, 50));
          explosionParticles.get(i).add(expPos);
          explosionVelocities.get(i).add(expVel);
          explosionLifespans.get(i).add(255);
          explosionOutsideScreen.get(i).add(false);
        }
      }
    } else {
      float hue = fireworkHues.get(i);
      ArrayList<PVector> particles = explosionParticles.get(i);
      ArrayList<PVector> velocities = explosionVelocities.get(i);
      ArrayList<Integer> lifespans = explosionLifespans.get(i);
      ArrayList<Boolean> outside = explosionOutsideScreen.get(i);

      for (int j = 0; j < particles.size(); j++) {
        if (lifespans.get(j) <= 0) continue;

        PVector vel = velocities.get(j);
        vel.x = vel.x < 0 ? vel.x * map(vel.x, -50, -1, 0.65, 0.875) :
                            vel.x * map(vel.x, 1, 50, 0.875, 0.65);
        vel.y *= 0.65;
        vel.add(gravity);

        PVector pos = particles.get(j);
        pos.add(vel);
        
        int life = lifespans.get(j) - 8;
        lifespans.set(j, life);

        if (!outside.get(j) && pos.y > height) {
          outside.set(j, true);
        }

        strokeWeight(1.25);
        stroke(hue, 255, 255, life);
        point(pos.x, pos.y);
      }
    }
  }
}
