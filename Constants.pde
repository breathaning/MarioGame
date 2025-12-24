static class Constants {
  public static final int SIMULATION_RATE = 60;

  public static final PVector NATIVE_RESOLUTION = new PVector(256, 240);
  public static final PVector DISPLAY_RESOLUTION = new PVector(720, 480);
  
  public static final PVector BLOCK_SIZE = new PVector(16, 16);

  public static class Player {
    public static final float GRAVITY = 25;
    public static final float JUMP_GRAVITY = 11;

    public static final float WALK_MAX_SPEED = 100;
    public static final float WALK_ACCELERATION = 4;
    public static final float WALK_SKID = 8;

    public static final float RUN_MAX_SPEED = 160;
    public static final float RUN_ACCELERATION = 6;
    public static final float RUN_SKID = 8;
    
    public static final float AIR_ACCELERATION = 3;
    public static final float AIR_SKID = 1.5;
    
    public static final float DECELERATION = 3;
    public static final float SKID_THRESHOLD = 100;

    public static final float JUMP_VELOCITY = 300;
    public static final float JUMP_X_INFLUENCE = 8;

    public static final float MAX_FALL_SPEED = 280;

    public static final float JUMP_MAX_DURATION = 7;
  }
}



