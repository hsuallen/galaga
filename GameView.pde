int x = 300-25;
Laser[] lasers = new Laser[20];
Laser[] bossLasers = new Laser[20];
Missile[] missiles = new Missile[10];
int xBoss = 300;
int incs = 5;
boolean stopHP = false;
PImage imgMissile, imgMissileFire;

final float speed = 5;

void generateAssets() {
  for (int i = 0; i < lasers.length; i++) {
    lasers[i] = new Laser(1000, 100, 10, 255, 255, 0);
  }
}

class GameView implements View {
  PImage imgMainShip, imgFire, imgBoss;
  int randFire = width/2;
  int yFire = 40;
  int inc = 10;
  int health = 248;
//  int health2 = 248;
//  int health3 = 248;
  int yBoss = 140;
  int xWin = width/2;
  int yWin = height/2+40;
  int winSize = 0;
  int nLasers = 0;
  boolean firstStage = false;
  boolean secondStage = false;
  boolean win = false;
  
  GameView() {
    generateAssets();
    loadAssets();
    gSound.setTracks(
      "laser.mp3",
      "grunt.wav",
      "arcade.mp3",
      "launch.mp3",
      "explosion.wav"
    );
    gSound.playTrack(2);
    int randFire = width/2;
    
    for (int i = 0; i < missiles.length; i++) {
      missiles[i] = new Missile(1000, 100, 10, imgMissile, imgMissileFire);
    }
  }

  void draw() {
    background(0);
    gCosmos.move();
    gCosmos.draw();
    
    imageMode(CORNER);
    //image(imgFire, x+12, 745, 30, yFire);
    displayLasers();
    image(this.imgMainShip, x, 700, 50, 50);
    update();
    updateShip();
    displayBrichta();
    checkCollision();
    HPBar();
  }
  
  void loadAssets() {
    this.imgMainShip = loadImage("mainShip.png");
    this.imgFire = loadImage("fire.png");
    this.imgBoss = loadImage("brichta.png");
    imgMissile = loadImage("missile.png");
    imgMissileFire = loadImage("missileFire.png");
  }
  
  View mouseClicked() { 
    gSound.pause(2);
    return new MainView();
//    return null;
  }
  
  void checkCollision() {
    if (!stopHP && !win) {
      for (int i = 0; i < lasers.length; i++) {
        if (lasers[i].x >= xBoss-50 && lasers[i].x <= xBoss+50 && lasers[i].y >= yBoss-70 && lasers[i].y <= yBoss+65) {
          health -= 10;
          gSound.playTrack(1);
          stopHP = true;
          lasers[i].x = width+100;
          stopHP = false;
        }
      }
      
      for (int i = 0; i < missiles.length; i++) {
        if (missiles[i].x >= xBoss-50 && missiles[i].x <= xBoss+50 && missiles[i].y >= yBoss-70 && missiles[i].y <= yBoss+65) {
          health -= 50;
          gSound.pause(3);
          gSound.playTrack(4);
          stopHP = true;
          missiles[i].x = width+100;
          stopHP = false;
        }
      }
    }
    
    if (health <= 0) {
      health = 0;
      win = true;
    }
  }

  void updateShip() {
    if (x >= width+25) {
      x = -25;
    } else if (x <= -25) {
      x = width+25;
    }
    
    yFire += inc;
    
    if (yFire >= 60) { 
      inc = -inc;
    } else if (yFire <= 40) {
      inc = -inc;
    }
  }
  
  void HPBar() {
    resetMatrix();
    rectMode(CENTER);
    fill(100);
    stroke(255);
    strokeWeight(2);
    rect(width/2, 20, 250, 25);
    
    rectMode(CORNER);
    fill(255, 0, 0);
    noStroke();
    rect(width/2-124, 8, health, 23);
    
//    rectMode(CORNER);
//    fill(255, 255, 0);
//    noStroke();
//    rect(width/2-124, 8, health, 23);
//    
//    rectMode(CORNER);
//    fill(0, 255, 0);
//    noStroke();
//    rect(width/2-124, 8, health, 23);
  }
  
  void displayBrichta() {
    imageMode(CENTER);
    resetMatrix();
    translate(xBoss, yBoss);
    if (win) {
      yBoss += 10;
      
      if (yBoss >= height+200) {
        yBoss = height+200;
      }
      rotate(yBoss/100.0);
    }
    image(imgBoss, 0, 0, 200, 200);
    
    if (yBoss >= height) {
      resetMatrix();
      textFont(gFontStar);
      textSize(100);
      fill(255, 255, 0);
      text("You Win!", width/2, height/2+40);
    }
    
    if (!win) {
      xBoss += incs;
    }
    
    if (xBoss >= width-50) {
      incs = -incs;
    } else if (xBoss <= 50) {
      incs = -incs;
    }
  }
  
  void bossLasers() {    
    if (xBoss >= randFire-10 && xBoss <= randFire+10 && !win) {
      bossLasers[nLasers] = new Laser (xBoss, yBoss, -10, 255, 0, 0);
      nLasers++;
      
      if (nLasers > lasers.length-2) {
        nLasers = 0;
      } else {
        nLasers++;
      }
      randFire = int(random(50, width-50));
    }
  }
  
  void displayLasers() {
    for (int i = 0; i < lasers.length; i++) {
      lasers[i].display();
      lasers[i].update();
    }
    
    for (int i = 0; i < missiles.length; i++) {
      missiles[i].display();
      missiles[i].update();
    }
  }
  
  void update() {
    if (keyPressed && key == CODED) {
      switch (keyCode) {
        case RIGHT: x += speed; break;
        case LEFT: x -= speed; break;
      }
    }
  }
}

int i = 0;
int a = 0;
void keyPressed() {
  if (key == 32) {
    gSound.playTrack(0);
    lasers[i] = new Laser(x+23.0, 680.0, 10.0, 255.0, 255.0, 0.0);
    
    if (i > lasers.length-2) {
      i = 0;
    } else {
      i++;
    }
  } else if (keyCode == CONTROL) {
    gSound.playTrack(3);
    missiles[a] = new Missile(x+14.0, 680.0, 10.0, imgMissile, imgMissileFire);
    
    if (a > missiles.length-2) {
      a = 0;
    } else {
      a++;
    }
  }
}
