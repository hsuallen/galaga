//class ShipLaser {
//  int i = 0;
//  float x;
//  float y;
//  float dec;
//  float r;
//  float g;
//  float b;
//  
//  ShipLaser(float x, float y, float dec, float r, float g, float b) {
//    this.x = x;
//    this.y = y;
//    this.dec = dec;
//    this.r = r;
//    this.g = g;
//    this.b = b;
//  }
//  
//  void something() {
//    gSound.playTrack(0);
//    lasers[i] = new Laser (this.x, this.y, this.dec, this.r, this.g, this.b);
//    
//    if (i > lasers.length-2) {
//      i = 0;
//    } else {
//      i++;
//    }
//  }
//}

class BossLaser {
  int n;
  float x;
  float rand;
  boolean win;
  Laser bossLasers[] = new Laser[20];
  
  BossLaser(int n, float x, float rand, boolean win) {
    this.x = x;
    this.win = win;
    
    this.rand = width/2;
    for (int i = 0; i < this.bossLasers.length; i++) {
      this.bossLasers[i] = new Laser(1000, 100, -10, 255, 0, 0);
    }
  }
  
  void check() {
    if (this.x >= this.rand-5 && this.x <= this.rand+5 && !this.win) {
      this.bossLasers[this.n] = new Laser(this.x, 140, -10, 255, 0, 0);
      this.n++;
      
      if (this.n > this.bossLasers.length-2) {
        this.n = 0;
      } 
      
      this.rand = random(50, width-50);
    }
  }
  
  void draw() {
    for (int i = 0; i < this.bossLasers.length; i++) {
      this.bossLasers[i].display();
      this.bossLasers[i].update();
    }
  }
}

class Laser {
  float x;
  float y;
  float dec;
  float r;
  float g;
  float b;
  
  Laser (float x, float y, float dec, float r, float g, float b) {
    this.x = x;
    this.y = y;
    this.dec = dec;
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  void update() {
    this.y -= dec;
    if (this.y < -100) {
      this.y = -100;
    }
  }
  
  void display() {
    fill(r, g, b);
    noStroke();
    rect(this.x, this.y, 3, 20);
  }
}

class Missile {
  float fire = 32.12;
  float inc = 5;
  float x;
  float y;
  float dec;
  PImage missile;
  PImage missileFire;
  
  Missile (float x, float y, float dec, PImage missile, PImage missileFire) {
    this.x = x;
    this.y = y;
    this.dec = dec;
    this.missile = missile;
    this.missileFire = missileFire;
  }
  
  void update() {
    this.y -= this.dec;
    if (this.y < -2000) {
      this.y = -2000;
    }
    
    this.fire += this.inc;
    
    if (fire >= 45) {
      this.inc = -this.inc;
    } else if (fire <= 32.12) {
      this.inc = -this.inc;
    }
  }
  
  void display() {
    imageMode(CENTER);
    image(this.missile, this.x+11, this.y, 22.2, 52.08);
    
    imageMode(CORNER);
    image(this.missileFire, this.x+6, this.y+23, 10.16, fire);
  }
}
