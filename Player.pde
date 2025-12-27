class Player extends Entity {
  boolean jumping;
  float lastJump;
  float gravity;

  public Player() {
    super();
    this.size = new PVector(12, 16);
    this.position = new PVector(Constants.BLOCK_SIZE.x * 100, 0);
    this.canCollide = true;
    this.keepOnScreen = true;
    this.jumping = false;
    this.gravity = Constants.Player.GRAVITY;
  }
  
  public void update() {
    boolean hittingFloor = isHittingFloor();
    boolean hittingCeiling = isHittingCeiling();

    if (jumping) {
      gravity = Constants.Player.JUMP_GRAVITY;
    } else if (!jumping && velocity.y > 0) {
      gravity = Constants.Player.GRAVITY;
    }
    velocity.y += gravity;

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
      if (!hittingFloor) {
        acceleration = Constants.Player.AIR_ACCELERATION;
        skid = Constants.Player.AIR_SKID;
      }
      if (Util.sign(directionX) == Util.sign(velocity.x) || Math.abs(velocity.x) < Constants.Player.SKID_THRESHOLD) {
        velocity.x += Util.sign(directionX) * acceleration;
      } else {
        velocity.x += Util.sign(directionX) * skid;
      }
      velocity.x = Math.min(maxSpeed, Math.max(-maxSpeed, velocity.x));
    } else {
      if (Constants.Player.DECELERATION >= Math.abs(velocity.x)) {
        velocity.x = 0;
      } else {
        velocity.x -= Util.sign(velocity.x) * Constants.Player.DECELERATION;
      }
    }

    if (isHittingWall(Util.sign(velocity.x))) {
      velocity.x = 0;
    }

    if (jumping == true) {
      if (!hittingCeiling && !hittingFloor && Time.frame - lastJump <= Constants.Player.JUMP_MAX_DURATION) {
        if (Input.getJumping()) {
          jumping = true;
        } else {
          // jump cancelled
          jumping = false;
          velocity.y *= Constants.Player.JUMP_CANCEL_SCALAR;
        }
      } else {
        jumping = false;
      }
     }

    if (hittingFloor) {
      if (Input.getJumping()) {
        jumping = true;
        lastJump = Time.frame;
        jump();
      } else {
        velocity.y = 0;
      }
    }

    if (hittingCeiling) {
      velocity.y = Constants.Player.CEILING_BUMP_SPEED;
    }
    
    if (velocity.y > Constants.Player.MAX_FALL_SPEED) {
      velocity.y = Constants.Player.MAX_FALL_SPEED;
    }

    super.update();
  }
  
  public void show() {
    noStroke();
    fill(255, 0, 0);
    new Draw().rect(position.x, position.y, size.x, size.y);
  }

  private void jump() {
    velocity.y = -(Constants.Player.JUMP_VELOCITY + Constants.Player.JUMP_X_INFLUENCE * (int)(Math.abs(velocity.x) / 25));
  }
}



