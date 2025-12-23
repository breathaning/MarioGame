class Block extends Entity {
  public Block(PVector position) {
    super();
    this.position = position;
    this.size = Constants.BLOCK_SIZE;
    this.canCollide = true;
  }
  
  public void show() {
    new Draw().image(ImageContainer.GROUND_TILE, position.x, position.y, size.x, size.y);
  }
  
  public void gridToPosition(int column, int row) {
    position = new PVector(
      column * Constants.BLOCK_SIZE.x,
      row * Constants.BLOCK_SIZE.y
    );
  }
}



