Player mario;
ArrayList<ArrayList<Block>> blocks = new ArrayList();

void settings() {
  size((int)Constants.DISPLAY_RESOLUTION.x, (int)Constants.DISPLAY_RESOLUTION.y);

  ImageContainer.GROUND_TILE = loadImage("Ground Tile.png");
}

void setup() {
  frameRate(Constants.SIMULATION_RATE);
  imageMode(CENTER);
  rectMode(CENTER);

  mario = new Player();
  for (int i = 0; i < Math.pow(2, 8); i++) {
    blocks.add(new ArrayList<Block>());
  }
  for (int column = 0; column < 50; column++) {
    int row = 14;
    blocks.get(row).add(new Block(new PVector(column * Constants.BLOCK_SIZE.x, row * Constants.BLOCK_SIZE.y)));
    blocks.get(row + 1).add(new Block(new PVector(column * Constants.BLOCK_SIZE.x, (row + 1) * Constants.BLOCK_SIZE.y)));
  }
  blocks.get(13).add(new Block(new PVector(30 * Constants.BLOCK_SIZE.x, 13 * Constants.BLOCK_SIZE.y)));
  blocks.get(12).add(new Block(new PVector(30 * Constants.BLOCK_SIZE.x, 12 * Constants.BLOCK_SIZE.y)));
  blocks.get(11).add(new Block(new PVector(30 * Constants.BLOCK_SIZE.x, 11 * Constants.BLOCK_SIZE.y)));
  blocks.get(10).add(new Block(new PVector(30 * Constants.BLOCK_SIZE.x, 10 * Constants.BLOCK_SIZE.y)));
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
