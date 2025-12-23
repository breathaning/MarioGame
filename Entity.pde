static class Entity {
  private static final ArrayList<Entity> entities = new ArrayList();
  
  public static ArrayList<Entity> getEntities() {
    return entities;
  }
  
  protected String name;
  protected float positionX, positionY;
  protected float velocityX, velocityY;
  protected float sizeX, sizeY;
  protected boolean canCollide = false;
  
  public Entity() {
    this.name = "";
    this.positionX = 0;
    this.positionY = 0;
    this.velocityX = 0;
    this.velocityY = 0;
    this.sizeX = 0;
    this.sizeY = 0;
    Entity.entities.add(this);
  }
  
  public void update() { }
  
  public void show() { }
  
  public void destroy() {
    Entity.entities.remove(this);
  }
  
  public ArrayList<Entity> getTouching() {
    ArrayList<Entity> touching = new ArrayList();
    for (Entity entity : Entity.entities) {
      if (entity == this) continue;
      if (!entity.canCollide) continue;
      float distX = this.positionX - entity.positionX;
      float distY = this.positionY - entity.positionY;
      if (Math.abs(distX) <= (this.sizeX + entity.sizeY) / 2 && Math.abs(distY) <= (this.sizeY + entity.sizeY) / 2) {
        touching.add(entity);
      }
    }
    return touching;
  }

  public float getPositionX() {
    return positionX;
  }

  public float getPositionY() {
    return positionY;
  }

  public float getVelocityX() {
    return velocityX;
  }

  public float getVelocityY() {
    return velocityY;
  }

  public float getSizeX() {
    return sizeX;
  }

  public float getSizeY() {
    return sizeY;
  }
}

