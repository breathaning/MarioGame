 class LevelBuilder {
    public LevelBuilder block(String type, int x, int y) {
        new Block(type).gridToPosition(x, y);
        return this;
    }

    public LevelBuilder rect(String type, int x, int y, int w, int h) {
        for (int i = 0; i < w; i++) {
            for (int j = 0; j < h; j++) {
                block(type, x + i, y + j);
            }
        }
        return this;
    }

    public LevelBuilder rampUp(String type, int x, int y, int w, int h) {
        for (int i = 0; i < h; i++) {
            rect(type, x + i, y - i, w - i, 1);
        }
        return this;
    }

    public LevelBuilder rampDown(String type, int x, int y, int w, int h) {
        for (int i = 0; i < h; i++) {
            rect(type, x, y - i, w - i, 1);
        }
        return this;
    }
}