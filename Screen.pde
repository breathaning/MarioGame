static class Screen {

    private static final PVector NATIVE_RESOLUTION = new PVector(256, 224);
    private static final PVector DISPLAY_RESOLUTION = new PVector(768, 672);

    private Screen() {

    }

    public static PVector getDisplayResolution() {
        return DISPLAY_RESOLUTION;
    }
}