Player mario;

void settings() {
  size((int)Constants.DISPLAY_RESOLUTION.x, (int)Constants.DISPLAY_RESOLUTION.y);
  
  noSmooth();

  Images.GROUND_BLOCK = loadImage("Ground Block.png");
  Images.BRICK_BLOCK = loadImage("Brick Block.png");
  Images.MYSTERY_BLOCK0 = loadImage("Mystery Block0.png");
  Images.MYSTERY_BLOCK1 = loadImage("Mystery Block1.png");
  Images.MYSTERY_BLOCK2 = loadImage("Mystery Block2.png");
  Images.MYSTERY_BLOCK = Images.MYSTERY_BLOCK0;
  Images.HARD_BLOCK = loadImage("Hard Block.png");

  Images.SmallMario.IDLE = loadImage("Small Mario Idle.png");
  Images.SmallMario.JUMP = loadImage("Small Mario Jump.png");
  Images.SmallMario.WALK0 = loadImage("Small Mario Walk0.png");
  Images.SmallMario.WALK1 = loadImage("Small Mario Walk1.png");
  Images.SmallMario.WALK2 = loadImage("Small Mario Walk2.png");
  Images.SmallMario.SKID = loadImage("Small Mario Skid.png");
  Images.SmallMario.DEATH = loadImage("Small Mario Death.png");

  Images.BigMario.IDLE = loadImage("Big Mario Idle.png");
  Images.BigMario.JUMP = loadImage("Big Mario Jump.png");
  Images.BigMario.WALK0 = loadImage("Big Mario Walk0.png");
  Images.BigMario.WALK1 = loadImage("Big Mario Walk1.png");
  Images.BigMario.WALK2 = loadImage("Big Mario Walk2.png");
  Images.BigMario.SKID = loadImage("Big Mario Skid.png");
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
    .rect("hard", 152, 9, 1, 4)
    .rect("ground", 155, 13, 55, 2)
    .rampDown("hard", 155, 12, 4, 4)
    .rect("brick", 168, 9, 2, 1)
    .block("mystery", 170, 9)
    .block("brick", 171, 9)
    .rampUp("hard", 181, 12, 8, 8)
    .rect("hard", 189, 5, 1, 8);
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
