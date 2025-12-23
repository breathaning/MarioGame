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
}