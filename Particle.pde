class Particle
{
  float hueValue;
  PVector position, acceleration, velocity;
  
  Particle(PVector position)
  {
    this.position = position;
    acceleration = new PVector(0, 0);
  }
  void physics()
  {
    acceleration.add(gravity);
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  void display(float strokeWeight, PVector stroke, float alpha)
  {
    strokeWeight(strokeWeight);
    stroke(stroke.x, stroke.y, stroke.z, alpha);
    point(position.x, position.y);
  }
}
