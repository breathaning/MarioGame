class Block extends Entity {
  
  public Block(float positionX, float positionY) {
    super();
    this.positionX = positionX;
    this.positionY = positionY;
    this.sizeX = Constants.BLOCK_SIZE_X;
    this.sizeY = Constants.BLOCK_SIZE_Y;
    this.canCollide = true;
  }
  
  public void show() {
    noStroke();
    fill(255, 255, 0);
    rect(positionX, positionY, sizeX, sizeY);
  }
  
  public void gridToPosition(int column, int row) {
    positionX = column * Constants.BLOCK_SIZE_X;
    positionY = row * Constants.BLOCK_SIZE_Y;
  }
}



