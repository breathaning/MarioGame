static class Scene {
  private static final PVector sceneOffset = new PVector(-Constants.BLOCK_SIZE.x / 2, Constants.BLOCK_SIZE.y / 2);;
  private static PVector position = new PVector(sceneOffset.x, sceneOffset.y);

  public static void panHorizontal(float offset) {
    position.x += offset;
  }

  public static PVector getPosition() {
    return position;
  }
}
