final String kGameTitle = "Bungay";
final String kCopyrightMsg = "Copyright Allen Hsu 2014. All Rights Reserved.";
final int kCopyrightSize = 12;
final int kTitleMaxSize = 100;
final int kTitleGrowthSpeed = 1;

class MainView implements View {
  float titleSize;
  float startAlpha = 0;
  float alphaInc = 5;
  
  MainView() {
    this.titleSize = 0;
    gSound.setTracks("starWars.mp3");
    gSound.playTrack(0);
  }
  
  void draw() {
    gCosmos.draw();
    this.titleSize = min(this.titleSize + kTitleGrowthSpeed, kTitleMaxSize);
    this.displayText();
    fadeTitle();
  }
  
  View mouseClicked() {
    gSound.pause(0);
    return new GameView();
  }
  
  void displayText() {
    textFont(gFontStar);
    textSize(this.titleSize);
    fill(255, 255, 0);
    text(kGameTitle, width/2, 250);
    
    textFont(gFontSans);
    textSize(kCopyrightSize);
    fill(255, 0, 0);
    text(kCopyrightMsg, width/2, height-10); 
  }
  
  void fadeTitle() {
    if (this.titleSize >= 100) {
      textFont(gFontStar);
      textSize(30);
      fill(255, 255, 0, startAlpha);
      text("Click to start . . .", width/2, height/2+20);
      
      startAlpha += alphaInc;
    
      if (startAlpha >= 255) {
        alphaInc = -alphaInc;
      } else if (startAlpha <= 0) {
        alphaInc = -alphaInc;
      }
    }
  }
}
