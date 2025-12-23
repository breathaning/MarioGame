public class Draw {
  public Draw() {
  }

  public Draw square(float x, float y, float s) {
    new Rectangle().draw(x, y, s, s);
    return this;
  }

  public Draw rect(float x, float y, float w, float h) {
    new Rectangle().draw(x, y, w, h);
    return this;
  }

  public Draw line(float x1, float y1, float x2, float y2) {
    new Line().draw(x1, y1, x2, y2);
    return this;
  }

  public Draw point(float x, float y) {
    new Point().draw(x, y);
    return this;
  }

  public Draw circle(float x, float y, float r) {
    new Ellipse().draw(x, y, r, r);
    return this;
  }

  public Draw ellipse(float x, float y, float r1, float r2) {
    new Ellipse().draw(x, y, r1, r2);
    return this;
  }

  public Draw text(String string, float x, float y) {
    new Text().draw(string, x, y);
    return this;
  }
}

private class Rectangle {
  public void draw(float x, float y, float w, float h) {
    rect(x, y, w, h);
  }
}

private class Line {
  public void draw(float x1, float y1, float x2, float y2) {
    line(x1, y1, x2, y2);
  }
}

private class Point {
  public void draw(float x, float y) {
    point(x, y);
  }
}

private class Ellipse {
  public void draw(float x, float y, float r1, float r2) {
    ellipse(x, y, r1, r2);
  }
}

private class Text {
  public void draw(String string, float x, float y) {
    text(string, x, y);
  }
}
