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

  public static float displayX(float x) {
    return x * Constants.DISPLAY_RESOLUTION.x / Constants.NATIVE_RESOLUTION.x;
  }

  public static float displayY(float y) {
    return y * Constants.DISPLAY_RESOLUTION.y / Constants.NATIVE_RESOLUTION.y;
  }
}
