Player mario;

void settings() {
  size((int)Constants.DISPLAY_RESOLUTION.x, (int)Constants.DISPLAY_RESOLUTION.y);
  
  noSmooth();

  ImageContainer.GROUND_BLOCK = loadImage("Ground Block.png");
  ImageContainer.BRICK_BLOCK = loadImage("Brick Block.png");
  ImageContainer.MYSTERY_BLOCK = loadImage("Mystery Block.png");
  ImageContainer.HARD_BLOCK = loadImage("Hard Block.png");
}

void setup() {
  frameRate(Constants.SIMULATION_RATE);
  imageMode(CENTER);
  rectMode(CENTER);

  mario = new Player();
  new LevelBuilder()  
    .rect("ground", 0, 13, 69, 2)
    .block("brick", 16, 9)
    .block("mystery", 20, 9)
    .block("brick", 21, 9)
    .block("mystery", 22, 9)
    .block("brick", 23, 9)
    .block("mystery", 24, 9)
    .block("mystery", 22, 5)
    .rect("ground", 71, 13, 15, 2)
    .block("brick", 77, 9)
    .block("mystery", 78, 9)
    .block("brick", 79, 9)
    .rect("brick", 80, 5, 8, 1)
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
    .rect("hard", 152, 9, 1, 4);
}

void draw() {
  updateTime();

  for (Entity entity : Entity.getEntities()) {
    entity.update();
  }

  Input.refresh();

  if (mario.position.x - Scene.getPosition().x > Scene.getSize().x / 2) {
    Scene.setX(mario.position.x - Scene.getSize().x / 2);
  }
  pushMatrix();
  translate(Util.displayX(-Scene.position.x), Util.displayY(-Scene.position.y));
  background(92, 148, 253);
  for (Entity entity : Entity.getEntities()) {
    pushMatrix();
    entity.show();
    popMatrix();
  }
  popMatrix();
}

void updateTime() {
  Time.seconds = millis() / 1000.0;
  Time.frame = Time.seconds * Constants.SIMULATION_RATE;
}
