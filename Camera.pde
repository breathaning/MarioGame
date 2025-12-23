class Camera {
  private PVector position;

  public Camera() {
    position = new PVector(-Constants.BLOCK_SIZE.x / 2, Constants.BLOCK_SIZE.y / 2);
  }

  public void draw() {
    pushMatrix();
    translate(Util.displayX(-position.x), Util.displayY(-position.y));
    for (Entity entity : Entity.getEntities()) {
      pushMatrix();
      entity.show();
      popMatrix();
    }
    popMatrix();
  }
}
