private static class Chunk {
    private final ArrayList<Entity> entities = new ArrayList();

    public void addEntity(Entity entity) {
      if (entities.contains(entity)) return;
      entities.add(entity);
    }

    public void removeEntity(Entity entity) {
      entities.remove(entity);
    }

    public Entity[] getEntities() {
      return entities.toArray(new Entity[0]);
    }

    public int getEntityCount() {
      return entities.size();
    }

    public boolean containsEntity(Entity entity) {
      return entities.contains(entity);
    }
  }

static class Entity {
  private static final ArrayList<Entity> entities = new ArrayList();

  public static Entity[] getEntities() {
    return entities.toArray(new Entity[0]);
  }

  private static final ArrayList<Chunk> boundChunks = new ArrayList();
  private static final ArrayList<String> boundChunkIds = new ArrayList();
  private static final ArrayList<Entity> uncachedEntities = new ArrayList();
  private static final PVector chunkSize = Constants.NATIVE_RESOLUTION;

  public static void flagEntityUncached(Entity entity) {
    if (uncachedEntities.contains(entity)) return;
    uncachedEntities.add(entity);
  }

  public static void cacheEntities() {
    if (uncachedEntities.size() == 0) return;

    for (Entity entity : uncachedEntities) {
      for (Chunk chunk : boundChunks) {
        chunk.removeEntity(entity);
      }
      cacheEntityBoundChunk(entity);
    }
    uncachedEntities.clear();

    for (int i = 0; i < boundChunks.size(); i++) {
      if (boundChunks.get(i).getEntityCount() != 0) continue;
      boundChunks.remove(i);
      boundChunkIds.remove(i);
      i--;
    }
  }

  private static void cacheEntityBoundChunk(Entity entity) {
    int chunkSpanX = (int)Math.floor(entity.size.x / chunkSize.x + 2);
    int chunkSpanY = (int)Math.floor(entity.size.y / chunkSize.y + 2);
    float chunkStartX = (float)(chunkSize.x * Math.floor(entity.position.x / chunkSize.x) + chunkSize.x / 2 * (1 - chunkSpanX));
    float chunkStartY = (float)(chunkSize.y * Math.floor(entity.position.y / chunkSize.y) + chunkSize.y / 2 * (1 - chunkSpanY));
    for (int i = 0; i < chunkSpanX; i++) {
      float chunkPositionX = chunkStartX + i * chunkSize.x;
      if (!Util.isBounding(entity.position.x, 0, entity.size.x, 0, chunkPositionX, 0, chunkSize.x, 0)) continue;
      for (int j = 0; j < chunkSpanY; j++) {
        float chunkPositionY = chunkStartY + j * chunkSize.y;
        if (!Util.isBounding(0, entity.position.y, 0, entity.size.y, 0, chunkPositionY, 0, chunkSize.y)) continue;
        String chunkId = (String)(chunkPositionX + "," + chunkPositionY);
        if (!boundChunkIds.contains(chunkId)) {
          boundChunkIds.add(chunkId);
          boundChunks.add(new Chunk());
        }
        boundChunks.get(boundChunkIds.indexOf(chunkId)).addEntity(entity);
      }
    }
  }

  private static Entity[] getOtherEntitiesInBoundingChunks(Entity entity) {
    cacheEntityBoundChunk(entity);
    ArrayList<Entity> otherEntities = new ArrayList();
    for (Chunk chunk : boundChunks) {
      if (!chunk.containsEntity(entity)) continue;
      for (Entity otherEntity : chunk.getEntities()) {
        if (otherEntity == entity) continue;
        if (otherEntities.contains(otherEntity)) continue;
        otherEntities.add(otherEntity);
      }
    }
    entity.otherEntitiesInBoundingChunks = otherEntities.toArray(new Entity[0]);
    return entity.otherEntitiesInBoundingChunks;
  }

  protected String name;

  protected PVector position;
  protected PVector velocity;
  protected PVector size;

  protected boolean canCollide;
  protected boolean keepOnScreen;

  protected Animation currentAnimation;

  protected int drawLayer;

  protected Entity[] otherEntitiesInBoundingChunks;

  public Entity() {
    this.name = "";
    this.position = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
    this.size = new PVector(0, 0);
    this.canCollide = false;
    this.keepOnScreen = false;
    this.drawLayer = 0;
    this.otherEntitiesInBoundingChunks = new Entity[0];
    Entity.entities.add(this);
    flagEntityUncached(this);
  }

  public void update() {
    move(PVector.div(velocity, Constants.SIMULATION_RATE));
  }

  public boolean cull() {
    return false;
  }

  public void show() {
  }

  public void destroy() {
    Entity.entities.remove(this);
  }

  public int getDrawLayer() {
    return drawLayer;
  }

  public boolean isHittingWall(int direction) {
    if (direction == 0) return false;
    Entity[] bounding = getBounding(otherEntitiesInBoundingChunks);
    for (Entity other : bounding) {
      if ((this.position.x - other.position.x) * direction > 0 || getAbsoluteYSeperation(other) >= 0) continue;
      return true;
    }
    return false;
  }

  public boolean isHittingCeiling() {
    Entity[] bounding = getBounding(otherEntitiesInBoundingChunks);
    for (Entity other : bounding) {
      if (this.position.y - other.position.y < 0 || getAbsoluteXSeperation(other) == 0 || getYSeperation(other) > 0) continue;
      return true;
    }
    return false;
  }

  public boolean isHittingFloor() {
    Entity[] bounding = getBounding(otherEntitiesInBoundingChunks);
    for (Entity other : bounding) {
      if (this.position.y - other.position.y > 0 || getAbsoluteXSeperation(other) == 0 || getYSeperation(other) > 0) continue;
      return true;
    }
    return false;
  }

  public boolean isBounding(Entity other) {
    if (!other.canCollide) return false;
    return Util.isBounding(
      this.position.x,
      this.position.y,
      this.size.x,
      this.size.y,
      other.position.x,
      other.position.y,
      other.size.x,
      other.size.y
      );
  }

  public Entity[] getBounding(Entity[] group) {
    ArrayList<Entity> bounding = new ArrayList();
    for (Entity other : group) {
      if (other == this) continue;
      if (!isBounding(other)) continue;
      bounding.add(other);
    }
    return bounding.toArray(new Entity[0]);
  }

  public boolean isTouching(Entity other) {
    if (!other.canCollide) return false;
    return Util.isTouching(
      this.position.x,
      this.position.y,
      this.size.x,
      this.size.y,
      other.position.x,
      other.position.y,
      other.size.x,
      other.size.y
      );
  }

  public Entity[] getTouching(Entity[] group) {
    ArrayList<Entity> touching = new ArrayList();
    for (Entity other : group) {
      if (other == this) continue;
      if (!isTouching(other)) continue;
      touching.add(other);
    }
    return touching.toArray(new Entity[0]);
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
    if (offset.x == 0 && offset.y == 0) return;
    cacheEntities();
    flagEntityUncached(this);
    int steps = (int)Math.ceil(2 * offset.mag() / size.mag());
    if (steps == 0) return;
    for (int i = 0; i < steps; i++) {
      boolean xTouched = false;
      boolean yTouched = false;
      if (offset.x != 0) {
        position.x += offset.x / steps;
        if (keepOnScreen) {
          if (position.x < Scene.getPosition().x + size.x / 2) {
            position.x = Scene.getPosition().x + size.x / 2;
          }
          if (position.x > Scene.getPosition().x + Scene.getSize().x - size.x / 2) {
            position.x = Scene.getPosition().x + Scene.getSize().x - size.x / 2;
          }
        }
        Entity[] xTouching = getTouching(getOtherEntitiesInBoundingChunks(this));
        if (xTouching.length > 0) {
          xTouched = true;
          Entity closest = xTouching[0];
          float closestSeperation = Math.abs(getXSeperation(closest));
          for (int j = 0; j < xTouching.length; j++) {
            Entity other = xTouching[j];
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
        Entity[] yTouching = getTouching(getOtherEntitiesInBoundingChunks(this));
        if (yTouching.length > 0) {
          yTouched = true;
          Entity closest = yTouching[0];
          float closestSeperation = Math.abs(getYSeperation(closest));
          for (int j = 0; j < yTouching.length; j++) {
            Entity other = yTouching[j];
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

  public void setAnimation(Animation animation) {
    if (currentAnimation != null && currentAnimation != animation) {
      animation.start();
    }
    currentAnimation = animation;
  }

  public void stepAnimation(float progress) {
    if (currentAnimation == null) return;
    currentAnimation.step(progress);
  }

  public void resetAnimation() {
    if (currentAnimation == null) return;
    currentAnimation.start();
  }

  public PImage getAnimationFrame() {
    if (currentAnimation == null) return null;
    return currentAnimation.get();
  }
}