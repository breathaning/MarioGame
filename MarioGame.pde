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
  
  new LevelLoader().load("1-1");
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
