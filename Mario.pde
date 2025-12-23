class Mario extends Entity {
  public Mario() {
    super();
    this.size = new PVector(50, 50);
    this.position = new PVector(250, 250);
    this.canCollide = true;
  }
  
  public void update() {
    int directionX = Input.getX();
    velocity.x = directionX * 2;
    velocity.y += Constants.GRAVITY;
    step(velocity);
  }
  
  public void show() {
    noStroke();
    fill(255, 0, 0);
    new Draw().rect(position.x, position.y, size.x, size.y);
  }
}



