Mario mario;
ArrayList<ArrayList<Block>> blocks = new ArrayList();

void setup() {
  size(500, 500);
  rectMode(CENTER);
  
  mario = new Mario();
  for (int i = 0; i < Math.pow(2, 8); i++) {
    blocks.add(new ArrayList<Block>());
  }
  blocks.get(19).add(new Block(0, 19 * 25));
  for (int column = 0; column < 50; column++) {
    int row = 20;
    blocks.get(row).add(new Block(column * Constants.BLOCK_SIZE_X, row * Constants.BLOCK_SIZE_Y));
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



