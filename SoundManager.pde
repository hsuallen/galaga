import ddf.minim.*;

final int kTrackGain = -15;

class SoundManager {
  Minim minim;
  AudioPlayer[] players;
  
  SoundManager(PApplet p) {
    this.minim = new Minim(p);
  }
  
  void setTracks(String... names) {
    this.players = new AudioPlayer[names.length];
    for (int i = 0; i < names.length; i++) {
      this.players[i] = this.minim.loadFile(names[i]);
      this.players[i].setGain(kTrackGain);
    }
  }
  
  void playTrack(int n) {
    this.players[n].rewind();
    this.players[n].play();
  }
  
  void pause(int n) {
    this.players[n].pause();
  }
}
