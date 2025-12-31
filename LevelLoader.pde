class LevelLoader {
  public LevelLoader() {
  }

  public void load(String levelName) {
    switch (levelName) {
    case "1-1":
      {
        loadWorld1_1();
        break;
      }

    default:
      {
        loadWorld1_1();
      }
    }
  }

  private void loadWorld1_1() {
    new LevelBuilder()
      // first platform
      .rect("ground", 0, 13, 69, 2)
      .block("brick", 16, 9)
      .block("mystery", 20, 9)
      .block("brick", 21, 9)
      .block("mystery", 22, 9)
      .block("brick", 23, 9)
      .block("mystery", 24, 9)
      .block("mystery", 22, 5)
      // second platform
      .rect("ground", 71, 13, 15, 2)
      .block("brick", 77, 9)
      .block("mystery", 78, 9)
      .block("brick", 79, 9)
      .rect("brick", 80, 5, 8, 1)
      // third platform
      .rect("ground", 89, 13, 64, 2)
      .rect("brick", 91, 5, 3, 1)
      .block("mystery", 94, 5)
      .block("brick", 94, 9)
      .rect("brick", 100, 9, 2, 1)
      .block("mystery", 106, 9)
      .block("mystery", 109, 9)
      .block("mystery", 112, 9)
      .block("mystery", 109, 5)
      .block("brick", 118, 9)
      .rect("brick", 121, 5, 3, 1)
      .rect("brick", 129, 9, 2, 1)
      .block("brick", 128, 5)
      .rect("mystery", 129, 5, 2, 1)
      .block("brick", 131, 5)
      .rampUp("hard", 134, 12, 4, 4)
      .rampDown("hard", 140, 12, 4, 4)
      .rampUp("hard", 148, 12, 4, 4)
      .rect("hard", 152, 9, 1, 4)
      // fourth platform
      .rect("ground", 155, 13, 55, 2)
      .rampDown("hard", 155, 12, 4, 4)
      .rect("brick", 168, 9, 2, 1)
      .block("mystery", 170, 9)
      .block("brick", 171, 9)
      .rampUp("hard", 181, 12, 8, 8)
      .rect("hard", 189, 5, 1, 8);
  }
}

