import processing.sound.*;
SoundFile file;

void setup() {
  size(640, 360);
  background(0);
    
  // Load a soundfile from the data folder of the sketch and play it back in a loop
  file = new SoundFile(this, "/Users/ARGO/Documents/Processing/Sound_loop/wn-b.wav");
  file.loop();
}      

void draw() {
}