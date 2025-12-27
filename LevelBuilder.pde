 class LevelBuilder {
    public LevelBuilder block(String type, int x, int y) {
        new Block(type).gridToPosition(x, y);
        return this;
    }

    public LevelBuilder rect(String type, int x, int y, int w, int h) {
        for (int i = 0; i < w; i++) {
            for (int j = 0; j < h; j++) {
                new Block(type).gridToPosition(x + i, y + j);
            }
        }
        return this;
    }

    public LevelBuilder ramp(String type, int x, int y, int w, int h) {
        for (int i = 0; i < w; i++) {
            for (int j = 0; j < h; j++) {
                rect(type, x, y, w - i, h - j);
            }
        }
        return this;
    }
}