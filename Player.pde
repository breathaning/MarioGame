class Player extends Entity {
  private boolean jumping;
  private float lastJump;
  private boolean jumpDebounce;
  private float gravity;
  private boolean dead = false;

  private Animation smallIdleAnimation = new Animation(new PImage[] { Images.SmallMario.IDLE });
  private Animation smallJumpAnimation = new Animation(new PImage[] { Images.SmallMario.JUMP });
  private Animation smallWalkAnimation = new Animation(new PImage[] { Images.SmallMario.WALK0, Images.SmallMario.WALK1, Images.SmallMario.WALK2 });
  private Animation smallSkidAnimation = new Animation(new PImage[] { Images.SmallMario.SKID });
  private Animation smallDeathAnimation = new Animation(new PImage[] { Images.SmallMario.DEATH });

  private Animation bigIdleAnimation = new Animation(new PImage[] { Images.BigMario.IDLE });
  private Animation bigJumpAnimation = new Animation(new PImage[] { Images.BigMario.JUMP });
  private Animation bigWalkAnimation = new Animation(new PImage[] { Images.BigMario.WALK0, Images.BigMario.WALK1, Images.BigMario.WALK2 });
  private Animation bigSkidAnimation = new Animation(new PImage[] { Images.BigMario.SKID });

  private boolean animationFlip = false;


  public Player() {
    super();
    this.size = new PVector(12, 16);
    this.position = new PVector(Constants.BLOCK_SIZE.x, 0);
    this.canCollide = true;
    this.keepOnScreen = true;
    this.jumping = false;
    this.jumpDebounce = false;
    this.gravity = Constants.Player.GRAVITY;
    this.currentAnimation = smallIdleAnimation;
  }

  public void update() {
    if (!dead) {
      movement();
    }
    if (position.y > 300) {
      dead = true;
      velocity.x = 0;
      velocity.y = -400;
      gravity = Constants.Player.GRAVITY;
    }
    animation();
    super.update();
  }

  public void show() {
    int flip = animationFlip ? -1 : 1;
    new Draw().image(getAnimationFrame(), position.x, position.y, size.y * flip, size.y);
  }

  private void movement() {
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

    if (jumping) {
      if (!hittingCeiling && !hittingFloor && Time.frame - lastJump <= Constants.Player.JUMP_MAX_DURATION) {
        if (Input.getJumping()) {
          jumping = true;
        } else {
          jumping = false;
          cancelJump();
        }
      } else {
        jumping = false;
      }
    }

    if (hittingFloor) {
      if (!jumpDebounce && Input.getJumping()) {
        jumping = true;
        lastJump = Time.frame;
        jumpDebounce = true;
        jump();
      } else {
        velocity.y = 0;
      }

      if (!Input.getJumping()) {
        jumpDebounce = false;
      }
    }

    if (hittingCeiling) {
      velocity.y = Constants.Player.CEILING_BUMP_SPEED;
    }

    if (velocity.y > Constants.Player.MAX_FALL_SPEED) {
      velocity.y = Constants.Player.MAX_FALL_SPEED;
    }
  }

  private void jump() {
    velocity.y = -(Constants.Player.JUMP_VELOCITY + Constants.Player.JUMP_X_INFLUENCE * (int)(Math.abs(velocity.x) / 25));
  }

  private void cancelJump() {
    velocity.y *= Constants.Player.JUMP_CANCEL_SCALAR;
  }

  private void animation() {
    if (currentAnimation == smallWalkAnimation) {
      stepAnimation(Math.abs(velocity.x) / 400.0);
    } else {
      stepAnimation(1);
    }

    if (dead) {
      setAnimation(smallDeathAnimation);
    } else {
      boolean hittingFloor = isHittingFloor();
      if (hittingFloor) {
        if (velocity.x == 0) {
          setAnimation(smallIdleAnimation);
        } else {
          if (Input.getX() == 0 || Util.sign(Input.getX()) == Util.sign(velocity.x) || Math.abs(velocity.x) < Constants.Player.SKID_ANIMATION_THRESHOLD) {
            setAnimation(smallWalkAnimation);
          } else {
            setAnimation(smallSkidAnimation);
          }
        }
        animationFlip = Input.getX() == 0 ? animationFlip : (Input.getX() < 0);
      } else {
        setAnimation(smallJumpAnimation);
      }
    }
  }
}

