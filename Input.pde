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

void keyPressed() {
  Input.beginKey(key);
}

void keyReleased() {
  Input.endKey(key);
}



