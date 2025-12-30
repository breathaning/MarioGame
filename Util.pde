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
}
