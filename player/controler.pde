class controlButton {
   int startX;
   int startY;
   int _width;
   int _height;
   int type;
   PImage button;
   
   controlButton (int startX, int startY, int _width, int _height, PImage button, int type) {
     this.startX = startX;
     this.startY = startY;
     this._width = _width;
     this._height = _height;
     this.button = button;
     this.type = type; // 0: play, 1: pause, 2: rewind, 3: forward
   }
   
   void show() {
     imageMode(CENTER);
     image(button, startX, startY, _width, _height);
   }
   
   void press_check() {
     if (int( dist(mouseX, mouseY, startX, startY) ) <= (_width/2)) {
        if (this.type == 0) { // play
          song.play();
        } else if (this.type == 1) { // pause
          song.pause();
        } else if (this.type == 2) { // rewind
          if (song.position() <= 3000) {
            song.pause();
            now_playing = (list_length + --now_playing) % list_length;
            song = minim.loadFile(play_list[now_playing]);
            fft = new FFT(song.bufferSize(), song.sampleRate());
            song.play();
          } else {
            song.rewind();
          }
        } else if (this.type == 3) { // forward
          song.pause();
          now_playing = ++now_playing % list_length;
          song = minim.loadFile(play_list[now_playing]);
          fft = new FFT(song.bufferSize(), song.sampleRate());
          song.play();
        }
     }
   }
}