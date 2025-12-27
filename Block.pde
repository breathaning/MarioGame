class Block extends Entity {
  private String type;
  private PImage icon;

  public Block(String type, PVector position) {
    super();
    this.type = type;
    this.position = position;
    this.size = Constants.BLOCK_SIZE;
    this.canCollide = true;

    if (type == "ground") {
      icon = ImageContainer.GROUND_BLOCK;
    } else if (type == "brick") {
      icon = ImageContainer.BRICK_BLOCK;
    }
  }
  
  public void show() {
    new Draw().image(icon, position.x, position.y, size.x, size.y);
  }
  
  public void gridToPosition(int column, int row) {
    position = new PVector(
      column * Constants.BLOCK_SIZE.x,
      row * Constants.BLOCK_SIZE.y
    );
  }
}



