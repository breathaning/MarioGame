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
  }

  public void show() {
  }

  public void destroy() {
    Entity.entities.remove(this);
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

  public void step(PVector offset) {
    int steps = (int)Math.ceil(offset.mag() / size.mag());
    if (steps == 0) return;
    for (int i = 0; i < steps; i++) {
      boolean touched = false;

      if (offset.x != 0) {
        position.x += offset.x / steps;
        ArrayList<Entity> xTouching = getTouching();
        if (xTouching.size() > 0) {
          touched = true;
          Entity closest = xTouching.get(0);
          float closestSeperation = getXSeperation(closest);
          for (int j = 0; j < xTouching.size(); j++) {
            Entity other = xTouching.get(j);
            float separation = getXSeperation(other);
            if (separation > closestSeperation) continue;
            closest = other;
            closestSeperation = separation;
          }
          position.x = closest.position.x - ((closest.size.x + this.size.x) / 2 * sign(offset.x));
        }
      }

      if (offset.y != 0) {
        position.y += offset.y / steps;
        ArrayList<Entity> yTouching = getTouching();
        if (yTouching.size() > 0) {
          touched = true;
          Entity closest = yTouching.get(0);
          float closestSeperation = getYSeperation(closest);
          for (int j = 0; j < yTouching.size(); j++) {
            Entity other = yTouching.get(j);
            float separation = getYSeperation(other);
            if (separation > closestSeperation) continue;
            closest = other;
            closestSeperation = separation;
          }
          position.y = closest.position.y - ((closest.size.y + this.size.y) / 2 * sign(offset.y));
        }
      }

      if (touched) break;
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

  private int sign(float x) {
    if (x == 0) return 0;
    else if (x > 0) return 1;
    return -1;
  }

  private float getXSeperation(Entity other) {
    return Math.abs(this.position.x - other.position.x) - ((other.size.x + this.size.x) / 2);
  }

  private float getYSeperation(Entity other) {
    return Math.abs(this.position.y - other.position.y) - ((other.size.y + this.size.y) / 2);
  }
}
