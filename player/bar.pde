class playBar {
   int startX;
   int startY;
   int _width;
   Boolean playbar_pressed = false;
   int circle_position;
   Time total_time;
   
   playBar (int startX, int startY, int _width) {
     this.startX = startX;
     this.startY = startY;
     this._width = _width;
   }
   
   void show() {
     this.total_time = make_time(song.length());
     if (map(song.position(), 0, song.length(), 0, 100) >= 98) {
        song.pause();
        now_playing = ++now_playing % list_length;
        song = minim.loadFile(play_list[now_playing]);
        fft = new FFT(song.bufferSize(), song.sampleRate());
        song.play();
     }
     if (playbar_pressed) {
       stroke(#ff3b28);
       strokeWeight(2);
       int position = int( map( mouseX - startX, 0, _width, 0, _width ) );
       if (position < 0) {
         position = 0;
       }
       if (position > _width) {
         position = _width;
       }
       line( startX, startY, startX + position, startY );
       stroke(#46474b);
       line( startX + position, startY, startX + _width, startY );
       ellipseMode(CENTER);
       noStroke();
       fill(#ffffff);
       ellipse(startX + position, startY, 20, 20);
     } else {
       stroke(#ff3b28);
       strokeWeight(2);
       int position = int( map( song.position(), 0, song.length(), 0, _width ) );
       line( startX, startY, startX + position, startY );
       stroke(#46474b);
       line( startX + position, startY, startX + _width, startY );
       ellipseMode(CENTER);
       noStroke();
       fill(#ffffff);
       ellipse(startX + position, startY, 20, 20);    
     }
     Time now_time = make_time(song.position());
     fill(#ffffff);
     textSize(14);
     text(now_time.minute + ":" + now_time.second + " / " + total_time.minute + ":" + total_time.second, 700, 435);
     
     text(play_list_meta[now_playing], 200, 460);
   }
   
   Time make_time(int time) {
     time = time/1000;
     int m = time / 60;
     int s = time % 60;
     
     return new Time(m, s);
   }
   
   void press_check() {
     int position = int( map( song.position(), 0, song.length(), 0, _width ) );
     if (int( dist(mouseX, mouseY, startX + position, startY) ) <= 10) {
       playbar_pressed = true;
     }  
   }
   
   void release_check() {
     if (playbar_pressed || (mouseX >= startX && mouseX <= startX + _width && mouseY <= startY + 4 && mouseY >= startY - 4) ) {
        int position = int( map( mouseX - startX, 0, _width, 0, song.length() ) );
        song.cue( position );
     } 
     playbar_pressed = false;
   }
}

class volumeBar {
   int startX;
   int startY;
   int _width;
   int max_volume = 100;
   int volume = 50;
   int circle_position;
   Boolean volume_pressed = false;

   volumeBar (int startX, int startY, int _width) {
     this.startX = startX;
     this.startY = startY;
     this._width = _width;
   }
   
   void show() {
     if (volume_pressed) {
       imageMode(CENTER);
       image(volume_img, startX - 20, startY, 20, 20);
       stroke(#ff3b28);
       strokeWeight(2);
       int position = int( map( mouseX - startX, 0, _width, 0, _width ) );
       if (position < 0) {
         position = 0;
       }
       if (position > _width) {
         position = _width;
       }
       line( startX, startY, startX + position, startY );
       stroke(#46474b);
       line( startX + position, startY, startX + _width, startY );
       ellipseMode(CENTER);
       noStroke();
       fill(#ffffff);
       ellipse(startX + position, startY, 15, 15);
     } else {
       imageMode(CENTER);
       image(volume_img, startX - 20, startY, 20, 20);
       stroke(#ff3b28);
       strokeWeight(2);
       int position = int( map( volume, 0, max_volume, 0, _width ) );
       line( startX, startY, startX + position, startY );
       stroke(#46474b);
       line( startX + position, startY, startX + _width, startY );
       ellipseMode(CENTER);
       noStroke();
       fill(#ffffff);
       ellipse(startX + position, startY, 15, 15);
     }
   }
   
   void press_check() {
     int position = int( map( volume, 0, max_volume, 0, _width ) );
     if (int( dist(mouseX, mouseY, startX + position, startY) ) <= 8) {
       volume_pressed = true;
     }  
   }
   
   void release_check() {
     if (volume_pressed || (mouseX >= startX && mouseX <= startX + _width && mouseY <= startY + 4 && mouseY >= startY - 4) ) {
        int position = int( map( mouseX - startX, 0, _width, 0, max_volume ) );
        volume = position;
        song.setVolume(volume/max_volume);
     } 
     volume_pressed = false;
   }
}

class Time {
  String minute;
  String second;
  
  Time(int m, int s) {
    this.minute = String.valueOf(m);
    this.second = String.valueOf(s);
    
    if (this.second.length() == 1) {
      this.second = "0" + this.second; 
    }
  }
}