static class Scene {
  private static PVector position = new PVector(-Constants.BLOCK_SIZE.x / 2, -Constants.BLOCK_SIZE.y / 2);
  private static PVector size = new PVector(Constants.NATIVE_RESOLUTION.x, Constants.NATIVE_RESOLUTION.y);

  public static void setX(float x) {
    position.x = x;
  }

  public static PVector getPosition() {
    return position;
  }

  public static PVector getSize() {
    return size;
  }
}
