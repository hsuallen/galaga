// GALAGA by Allen Hsu

interface View {
  void draw();
  View mouseClicked();
}

PFont gFontSans, gFontStar;
Cosmos gCosmos;
SoundManager gSound;
View gCurrentView;

void setup() {
  size(600, 800);
  smooth();
  textAlign(CENTER);
  gFontSans = createFont("Cambria.ttf", 20);
  gFontStar = createFont("Starjedi.ttf", 20);
  gCosmos = new Cosmos(100, 1, 5);
  gSound = new SoundManager(this);
  gCurrentView = new MainView();
}

void draw() {
  gCurrentView.draw();
}

void mouseClicked() {
  View v = gCurrentView.mouseClicked();
  if (v != null) {
    gCurrentView = v;
  }
}
