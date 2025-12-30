class Animation {
    private PImage[] animationFrames;
    private float animationProgress;

    public Animation(PImage[] animationFrames) {
        this.animationFrames = animationFrames;
    }

    public void start() {
        animationProgress = 0.0;
    }

    public void step(float progress) {
        animationProgress += progress;
    }

    public PImage get() {
        return animationFrames[(int)Math.floor(animationProgress) % animationFrames.length];
    }
}