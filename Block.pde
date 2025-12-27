class Block extends Entity {
  private PImage icon;

  public Block(String type) {
    super();
    this.position = new PVector();
    this.size = Constants.BLOCK_SIZE;
    this.canCollide = true;

    if (type == "ground") {
      icon = ImageContainer.GROUND_BLOCK;
    } else if (type == "brick") {
      icon = ImageContainer.BRICK_BLOCK;
    } else if (type == "mystery") {
      icon = ImageContainer.MYSTERY_BLOCK;
    } else if (type == "hard") {
      icon = ImageContainer.HARD_BLOCK;
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



