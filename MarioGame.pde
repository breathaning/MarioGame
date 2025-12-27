Player mario;

void settings() {
  size((int)Constants.DISPLAY_RESOLUTION.x, (int)Constants.DISPLAY_RESOLUTION.y);

  ImageContainer.GROUND_BLOCK = loadImage("Ground Block.png");
  ImageContainer.BRICK_BLOCK = loadImage("Brick Block.png");
}

void setup() {
  frameRate(Constants.SIMULATION_RATE);
  imageMode(CENTER);
  rectMode(CENTER);

  mario = new Player();
  new LevelBuilder()  
    .rect("ground", 0, 13, 69, 2)
    .block("brick", 16, 9)
    .block("brick", 20, 9)
    .block("brick", 21, 9)
    .block("brick", 22, 9)
    .block("brick", 23, 9)
    .block("brick", 24, 9)
    .block("brick", 22, 5)
    .rect("ground", 71, 13, 15, 2)
    .rect("ground", 89, 13, 58, 2);
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
