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
  blocks.get(13).add(new Block(new PVector(0, 13 * 16)));
  for (int column = 0; column < 50; column++) {
    int row = 14;
    blocks.get(row).add(new Block(new PVector(column * Constants.BLOCK_SIZE.x, row * Constants.BLOCK_SIZE.y)));
  }
}

void draw() {
  for (Entity entity : Entity.getEntities()) {
    entity.update();
  }

  Input.refresh();
  
  background(92, 148, 253);
  
  for (Entity entity : Entity.getEntities()) {
    pushMatrix();
    entity.show();
    popMatrix();
  }
}



