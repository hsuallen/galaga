class Cosmos {
  Star[] stars;
  
  Cosmos(int n, float minSize, float maxSize) {
    this.stars = new Star[n];
    for (int i = 0; i < this.stars.length; i++) {
      this.stars[i] = new Star(
        random(maxSize, width-maxSize),
        random(maxSize, height-maxSize),
        random(minSize, maxSize)
      );
    }
  }

  void move() {
    for (int i = 0; i < this.stars.length; i++) {
      this.stars[i].update();
    }
  }

  void draw() {
    background(0);
    for (int i = 0; i < this.stars.length; i++) {
      this.stars[i].shine();
      this.stars[i].draw();
    }
  }
}

class Star {
  float x, y;
  float size;
  float sizeReference;
  float shine;
  float speed;
  
  Star (float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.shine = size/2;
    this.sizeReference = size;
    this.speed = 5;
  }
  
  void draw() {
    noStroke();
    fill(255);
    ellipse(this.x, this.y, this.size, this.size);
  }
  
  void shine() {
    this.size += this.shine;
    
    if (this.size >= this.sizeReference*1.3) {
      this.shine = -0.05;
    } else if (this.size <= this.sizeReference*0.7) {
      this.shine = 0.05;
    }
  }
  
  void update() {
    this.y += this.speed;
    
    if (this.y >= height) {
      this.y = 0;
    }
  }
}
