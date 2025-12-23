class Player extends Entity {
  public Player() {
    super();
    this.size = new PVector(12, 16);
    this.position = new PVector(0, 0);
    this.canCollide = true;
  }
  
  public void update() {
    velocity.y += Constants.Player.GRAVITY;

    int directionX = Input.getX();
    if (directionX != 0) {
      if (sign(directionX) == sign(velocity.x)) {
        velocity.x += sign(directionX) * Constants.Player.GROUND_WALK_ACCELERATION;
      } else {
        velocity.x += sign(directionX) * Constants.Player.WALK_SKID;
      }
      velocity.x = Math.min(Constants.Player.WALK_MAX_SPEED, Math.max(-Constants.Player.WALK_MAX_SPEED, velocity.x));
    } else {
      if (Constants.Player.DECELERATION >= Math.abs(velocity.x)) {
        velocity.x = 0;
      } else {
        velocity.x -= sign(velocity.x) * Constants.Player.DECELERATION;
      }
    }

    int directionY = Input.getY();
    if (directionY < 0 && isGrounded()) {
      velocity.y = -(Constants.Player.JUMP_VELOCITY + Constants.Player.JUMP_X_INFLUENCE * (int)(Math.abs(velocity.x) / 25));
    }
    
    if (velocity.y > 280) {
      velocity.y = 280;
    }
    super.update();
  }
  
  public void show() {
    noStroke();
    fill(255, 0, 0);
    new Draw().rect(position.x, position.y, size.x, size.y);
  }

  private int sign(float x) {
    if (x == 0) return 0;
    else if (x > 0) return 1;
    return -1;
  }
}



