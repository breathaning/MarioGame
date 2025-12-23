static class Input {
  private static final ArrayList<Constants.InputAction> inputsActive = new ArrayList();
  private static final ArrayList<Constants.InputAction> inputsBegan = new ArrayList();
  private static final ArrayList<Constants.InputAction> inputsEnded = new ArrayList();

  private Input () { }

  public static void refresh() {
    inputsBegan.clear();
    inputsEnded.clear();
  }

  public static boolean isInputActive(Constants.InputAction inputAction) {
    return inputsActive.indexOf(inputAction) != -1;
  }
  
  public static void beginInput(Constants.InputAction inputAction) {
    if (isInputActive(inputAction)) return;
    inputsBegan.add(inputAction);
    inputsActive.add(inputAction);
  }
   
    
  public static void endInput(Constants.InputAction inputAction) {
    if (!isInputActive(inputAction)) return;
    inputsEnded.add(inputAction);
    inputsActive.remove(inputAction);
  }
}

void keyPressed() {
  Constants.InputAction inputAction = Constants.INPUT_MAP.get(key);
  if (inputAction == null) return;
  Input.beginInput(inputAction);
}

void keyReleased() {
  Constants.InputAction inputAction = Constants.INPUT_MAP.get(key);
  if (inputAction == null) return;
  Input.endInput(inputAction);
}



