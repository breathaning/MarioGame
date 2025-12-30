static class Input {
  private static final ArrayList<Character> keysActive = new ArrayList();
  private static final ArrayList<Character> keysBegan = new ArrayList();
  private static final ArrayList<Character> keysEnded = new ArrayList();

  private Input () { }

  public static void refresh() {
    keysBegan.clear();
    keysEnded.clear();
  }

  public static int getX() {
    int x = 0;
    if (isKeyActive('d')) x++;
    if (isKeyActive('a')) x--;
    return x;
  }

  public static int getY() {
    int y = 0;
    if (isKeyActive('s')) y++;
    if (isKeyActive('w')) y--;
    return y;
  }

  public static boolean getRunning() {
    return isKeyActive('x');
  }

  public static boolean getJumping() {
    return isKeyActive('z') || isKeyActive('w');
  }

  public static PVector getDirection() {
    return new PVector(getX(), getY());
  }

  public static boolean isKeyActive(Character key) {
    return keysActive.indexOf(key) != -1;
  }
  
  public static void beginKey(Character key) {
    if (isKeyActive(key)) return;
    keysBegan.add(key);
    keysActive.add(key);
  }
   
    
  public static void endKey(Character key) {
    if (!isKeyActive(key)) return;
    keysEnded.add(key);
    keysActive.remove(key);
  }
}

Character convertKey(Character key, int keyCode) {
  if (key != CODED) return key;
  if (keyCode == UP) return 'w';
  if (keyCode == LEFT) return 'a';
  if (keyCode == DOWN) return 's';
  if (keyCode == RIGHT) return 'd';
  return '.';
}

void keyPressed() {
  Input.beginKey(convertKey(key, keyCode));
}

void keyReleased() {
  Input.endKey(convertKey(key, keyCode));
}



