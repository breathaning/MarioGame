static class Constants {
  public static final float GRAVITY = 0.1;
  
  public static final float BLOCK_SIZE_X = 25;
  public static final float BLOCK_SIZE_Y = 25;

  public static enum InputAction {
    LEFT, RIGHT, UP, DOWN
  }
  public static final HashMap<Character, InputAction> INPUT_MAP = new HashMap();
  static {
    INPUT_MAP.put('w', InputAction.UP);
    INPUT_MAP.put('s', InputAction.DOWN);
    INPUT_MAP.put('a', InputAction.LEFT);
    INPUT_MAP.put('d', InputAction.RIGHT);
  }
}



