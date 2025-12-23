static class Entity {
  private static final ArrayList<Entity> entities = new ArrayList();

  public static ArrayList<Entity> getEntities() {
    return entities;
  }

  protected String name;
  protected PVector position;
  protected PVector velocity;
  protected PVector size;
  protected boolean canCollide = false;

  public Entity() {
    this.name = "";
    this.position = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
    this.size = new PVector(0, 0);
    Entity.entities.add(this);
  }

  public void update() {
    move(PVector.div(velocity, Constants.SIMULATION_RATE));
  }

  public void show() {
  }

  public void destroy() {
    Entity.entities.remove(this);
  }

  public boolean isHittingWall(int direction) {
    if (direction == 0) return false;
    ArrayList<Entity> bounding = getBounding();
    for (Entity other : bounding) {
      if ((this.position.x - other.position.x) * direction > 0 || getAbsoluteYSeperation(other) >= 0) continue;
      return true;
    }
    return false;
  }

  public boolean isGrounded() {
    ArrayList<Entity> bounding = getBounding();
    for (Entity other : bounding) {
      if (getYSeperation(other) > 0) continue;
      return true;
    }
    return false;
  }

  public boolean isBounding(Entity other) {
    if (!other.canCollide) return false;
    float distX = this.position.x - other.position.x;
    float distY = this.position.y - other.position.y;
    return Math.abs(distX) <= (this.size.x + other.size.y) / 2 && Math.abs(distY) <= (this.size.y + other.size.y) / 2;
  }

  public ArrayList<Entity> getBounding() {
    ArrayList<Entity> bounding = new ArrayList();
    for (Entity other : Entity.entities) {
      if (other == this) continue;
      if (!isBounding(other)) continue;
      bounding.add(other);
    }
    return bounding;
  }

  public boolean isTouching(Entity other) {
    if (!other.canCollide) return false;
    float distX = this.position.x - other.position.x;
    float distY = this.position.y - other.position.y;
    return Math.abs(distX) < (this.size.x + other.size.y) / 2 && Math.abs(distY) < (this.size.y + other.size.y) / 2;
  }

  public ArrayList<Entity> getTouching() {
    ArrayList<Entity> touching = new ArrayList();
    for (Entity other : Entity.entities) {
      if (other == this) continue;
      if (!isTouching(other)) continue;
      touching.add(other);
    }
    return touching;
  }

  public Entity getFirstTouching() {
    for (Entity other : Entity.entities) {
      if (other == this) continue;
      if (!isTouching(other)) continue;
      return other;
    }
    return null;
  }

  public void move(PVector offset) {
    int steps = (int)Math.ceil(2 * offset.mag() / size.mag());
    if (steps == 0) return;
    for (int i = 0; i < steps; i++) {
      boolean xTouched = false;
      boolean yTouched = false;

      if (offset.x != 0) {
        position.x += offset.x / steps;
        ArrayList<Entity> xTouching = getTouching();
        if (xTouching.size() > 0) {
          xTouched = true;
          Entity closest = xTouching.get(0);
          float closestSeperation = Math.abs(getXSeperation(closest));
          for (int j = 0; j < xTouching.size(); j++) {
            Entity other = xTouching.get(j);
            float separation = Math.abs(getXSeperation(other));
            if (separation > closestSeperation) continue;
            closest = other;
            closestSeperation = separation;
          }
          position.x = closest.position.x - (Util.sign(offset.x) * (closest.size.x + this.size.x) / 2);
        }
      }

      if (offset.y != 0) {
        position.y += offset.y / steps;
        ArrayList<Entity> yTouching = getTouching();
        if (yTouching.size() > 0) {
          yTouched = true;
          Entity closest = yTouching.get(0);
          float closestSeperation = Math.abs(getYSeperation(closest));
          for (int j = 0; j < yTouching.size(); j++) {
            Entity other = yTouching.get(j);
            float separation = Math.abs(getYSeperation(other));
            if (separation > closestSeperation) continue;
            closest = other;
            closestSeperation = separation;
          }
          position.y = closest.position.y - (Util.sign(offset.y) * (closest.size.y + this.size.y) / 2);
        }
      }

      if (xTouched && yTouched) break;
    }
  }

  public PVector getPosition() {
    return position;
  }

  public PVector getVelocity() {
    return velocity;
  }

  public PVector getSize() {
    return size;
  }

  public float getXSeperation(Entity other) {
    float offset = this.position.x - other.position.x;
    return offset - Util.sign(offset) * ((other.size.x + this.size.x) / 2);
  }

  public float getYSeperation(Entity other) {
    float offset = this.position.y - other.position.y;
    return offset - Util.sign(offset) * ((other.size.y + this.size.y) / 2);
  }

  public float getAbsoluteXSeperation(Entity other) {
    return Math.abs(this.position.x - other.position.x) - ((other.size.x + this.size.x) / 2);
  }

  public float getAbsoluteYSeperation(Entity other) {
    return Math.abs(this.position.y - other.position.y) - ((other.size.y + this.size.y) / 2);
  }
}
