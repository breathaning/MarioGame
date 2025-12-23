Mario mario;
ArrayList<ArrayList<Block>> blocks = new ArrayList();

void settings() {
  PVector displayResolution = Screen.getDisplayResolution();
  size((int)displayResolution.x, (int)displayResolution.y);

}

void setup() {
  rectMode(CENTER);

  mario = new Mario();
  for (int i = 0; i < Math.pow(2, 8); i++) {
    blocks.add(new ArrayList<Block>());
  }
  blocks.get(19).add(new Block(new PVector(0, 19 * 25)));
  for (int column = 0; column < 50; column++) {
    int row = 20;
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

  // new Draw().rect(1, 1, 1, 1);
}



