static class Util {
  public static int sign(float n) {
    if (n > 0) return 1;
    if (n < 0) return -1;
    return 0;
  }

  public static float rad(float deg) {
    return deg * PI / 180;
  }

  public static float deg(float rad) {
    return rad * 180 / PI;
  }

  public static boolean isVisible(float x, float y, float w, float h) {
    PVector scenePosition = Scene.getPosition();
    PVector sceneSize = Scene.getSize();
    return Math.abs(x - scenePosition.x - sceneSize.x / 2) - w / 2 <= sceneSize.x / 2 && Math.abs(y - scenePosition.y - sceneSize.y / 2) - h / 2 <= sceneSize.y / 2;
  }

  public static float displayX(float x) {
    return x * Constants.DISPLAY_RESOLUTION.x / Constants.NATIVE_RESOLUTION.x;
  }

  public static float displayY(float y) {
    return y * Constants.DISPLAY_RESOLUTION.y / Constants.NATIVE_RESOLUTION.y;
  }
  
  public static boolean isTouching(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    float distX = x1 - x2;
    float distY = y1 - y2;
    return Math.abs(distX) < (w1 + w2) / 2 && Math.abs(distY) < (h1 + h2) / 2;
  }

  public static boolean isBounding(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    float distX = x1 - x2;
    float distY = y1 - y2;
    return Math.abs(distX) <= (w1 + w2) / 2 && Math.abs(distY) <= (h1 + h2) / 2;
  }

}
