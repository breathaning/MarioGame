static class Constants {
  public static final int SIMULATION_RATE = 60;

  public static final PVector NATIVE_RESOLUTION = new PVector(256, 224);
  public static final PVector DISPLAY_RESOLUTION = new PVector(768, 672);
  
  public static final PVector BLOCK_SIZE = new PVector(16, 16);

  public static class Player {
    public static final float GRAVITY = 25;

    public static final float WALK_MAX_SPEED = 96;
    public static final float GROUND_WALK_ACCELERATION = 4;
    public static final float WALK_SKID = 8;

    public static final float DECELERATION = 3;

    public static final float JUMP_VELOCITY = 300;
    public static final float JUMP_X_INFLUENCE = 8;
  }
}



