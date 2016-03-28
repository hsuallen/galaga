final float kShipMargin = 100;
final float kShipWidth = 50;
final float kShipHeight = 50;

class Ship {
  PImage img;
  float x;
  
  Ship() {
    this.img = loadImage("mainShip.png");
    this.x = width/2;
  }
  
  void move(float dx) {
    this.x += dx;
  }
  
  void draw() {
    image(this.img, this.x, height-kShipMargin, kShipWidth, kShipHeight);
  }
}
