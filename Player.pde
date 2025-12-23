class Player extends Entity {
  public Player() {
    super();
    this.size = new PVector(12, 16);
    this.position = new PVector(Constants.BLOCK_SIZE.x, 0);
    this.canCollide = true;
  }
  
  public void update() {
    velocity.y += Constants.Player.GRAVITY;

    int directionX = Input.getX();
    if (directionX != 0) {
      float maxSpeed, acceleration, skid;
      if (Input.getRunning()) {
        maxSpeed = Constants.Player.RUN_MAX_SPEED;
        acceleration = Constants.Player.RUN_ACCELERATION;
        skid = Constants.Player.RUN_SKID;
      } else {
        maxSpeed = Constants.Player.WALK_MAX_SPEED;
        acceleration = Constants.Player.WALK_ACCELERATION;
        skid = Constants.Player.WALK_SKID;
      }
      if (!isGrounded()) {
        acceleration = Constants.Player.AIR_ACCELERATION;
        skid = Constants.Player.AIR_SKID;
      }
      if (sign(directionX) == sign(velocity.x) || Math.abs(velocity.x) < Constants.Player.SKID_THRESHOLD) {
        velocity.x += sign(directionX) * acceleration;
      } else {
        velocity.x += sign(directionX) * skid;
      }
      velocity.x = Math.min(maxSpeed, Math.max(-maxSpeed, velocity.x));

      if (isHittingWall(sign(velocity.x))) {
        velocity.x = 0;
      }
    } else {
      if (Constants.Player.DECELERATION >= Math.abs(velocity.x)) {
        velocity.x = 0;
      } else {
        velocity.x -= sign(velocity.x) * Constants.Player.DECELERATION;
      }
    }

    if (isGrounded()) {
      if (Input.getJumping()) {
        velocity.y = -(Constants.Player.JUMP_VELOCITY + Constants.Player.JUMP_X_INFLUENCE * (int)(Math.abs(velocity.x) / 25));
      } else {
        velocity.y = 0;
      }
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



