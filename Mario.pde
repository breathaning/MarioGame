class Mario extends Entity {
  public Mario() {
    super();
    this.sizeX = 50;
    this.sizeY = 50;
    this.positionX = 250;
    this.positionY = 250;
    this.canCollide = true;
  }
  
  public void update() {
    int directionX = 0;
    if (Input.isInputActive(Constants.InputAction.RIGHT)) { directionX++; }
    if (Input.isInputActive(Constants.InputAction.LEFT)) { directionX--; }
    velocityX = directionX * 2;
    velocityY += Constants.GRAVITY;
    step(velocityX, velocityY);
  }
  
  public void show() {
    noStroke();
    fill(255, 0, 0);
    rect(positionX, positionY, sizeX, sizeY);
  }
  
  private void step(float stepX, float stepY) {
    int segmentX = (int)Math.ceil(stepX / sizeX + 1);
    for (int i = 0; i < segmentX; i++) {
      positionX += stepX / segmentX;
      if (getTouching().size() > 0) {
        Entity touched = getTouching().get(0);
        positionX = touched.positionX - (sizeX + touched.getSizeX()) / 2 * Math.signum(stepX);
        break;
      }
    }
    int segmentY = (int)Math.ceil(stepY / sizeY + 1);
    for (int i = 0; i < segmentY; i++) {
      positionY += stepY / segmentY;
      if (getTouching().size() > 0) {
        Entity touched = getTouching().get(0);
        positionY = touched.positionY - (sizeY + touched.getSizeY()) / 2 * Math.signum(stepY);
        break;
      }
    }
  }
}



