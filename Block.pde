class Block extends Entity {
  public Block(String type) {
    super();
    this.position = new PVector();
    this.size = Constants.BLOCK_SIZE;
    this.canCollide = true;
    this.drawLayer = 0;

    if (type == "ground") {
      setAnimation(new Animation(new PImage[] { Images.GROUND_BLOCK }));
    } else if (type == "brick") {
      setAnimation(new Animation(new PImage[] { Images.BRICK_BLOCK }));
    } else if (type == "mystery") {
      setAnimation(new Animation(new PImage[] { Images.MYSTERY_BLOCK0, Images.MYSTERY_BLOCK1, Images.MYSTERY_BLOCK2, Images.MYSTERY_BLOCK1, Images.MYSTERY_BLOCK0 }));
    } else if (type == "hard") {
      setAnimation(new Animation(new PImage[] { Images.HARD_BLOCK }));
    }
  }
  
  public void show() {
    if (Util.isVisible(position.x, position.y, size.x, size.y)) {
      new Draw().image(getAnimationFrame(), position.x, position.y, size.x, size.y);
    }
    stepAnimation(6.7 / Constants.SIMULATION_RATE);
  }
  
  public void gridToPosition(int column, int row) {
    position = new PVector(
      column * Constants.BLOCK_SIZE.x,
      row * Constants.BLOCK_SIZE.y
    );
  }
}



