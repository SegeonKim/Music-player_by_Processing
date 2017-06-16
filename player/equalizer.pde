class Equalizer {
   int startX;
   int startY;
   int _width;
   int _height;
   int type = 0;
   int eq_width = 10;
   int eq_height = 6;
   int gap = 4;
   int max_type = 2;
   float sum = 0;
  
  Equalizer(int startX, int startY, int _width, int _height) {
     this.startX = startX;
     this.startY = startY;
     this._width = _width;
     this._height = _height;
  }
  
  void show() {
    if (type == 0) {
      int total = _width / (eq_width + gap);
      int total_h;
      int pos;
      int position = int( map( song.position(), 0, song.length(), 0, total/2 ) );
      int max_height = 36;
      colorMode(HSB, total * 2);
      
      for(int i = 0; i < total - 1; i++) {
        pos = (gap+eq_width) * i + gap;
        rectMode(CORNER);
        total_h = int( (fft.getBand(i) * 4) / eq_height );
        if (total_h > max_height) {
          total_h = max_height;
        }
        for (int j = total_h - 1; j >= 0; j--) {
          fill(total/2 + position + i , total * 2, total + j);
          stroke(total/2 + position + i, total * 2, total + j);
          rect(pos, _height - (eq_height + gap + (gap + eq_height) * j + gap), eq_width, eq_height);
        }
      }
      colorMode(RGB);
    } else if (type == 1) {
      int scale = 70;
      int smooth = 2;
      strokeWeight(1);
      
      colorMode(HSB, _width * 2);
      int position = int( map( song.position(), 0, song.length(), 0, _width/2 ) );
      for(int i = 2; i < _width - 2; i+=smooth) {
        stroke(_width/2 + position + i, _width * 2, _width + i);
        line(i, 110 + song.left.get(i)*scale, i+smooth, 110 + song.left.get(i+smooth)*scale);
        stroke(_width * 2 - position - i, _width * 2, _width + i);
        line(i, 250 + song.right.get(i)*scale, i+smooth, 250 + song.right.get(i+smooth)*scale);
      }
      
      //for(int i = 2; i < _width - 2; i++) {
      //  stroke(_width/2 + position + i, _width * 2, _width + i);
      //  line(i, 110  + song.right.get(i)*50,  i+1, 110  + song.right.get(i+1)*50);
      //  line(i, 250 + song.left.get(i)*50, i+1, 250 + song.left.get(i+1)*50);
      //}
      colorMode(RGB);
    } else {    
      //float scale = 20.0;
      //float smoothFactor = 0.2;
      //float min_r = 100.0;
      //float max_r = _height/4 - 100.0;

      //noStroke();
      //colorMode(HSB, song.length());

      //// Smooth the rms data by smoothing factor
      //sum += (song.left.get(10) - sum) * smoothFactor;  
    
      //// rms.analyze() return a value between 0 and 1. It's
      //// scaled to height/2 and then multiplied by a scale factor
      //float rmsScaled = sum * (_height/2) * scale;
    
      //// Draw an ellipse at a size based on the audio analysis
      //colorMode(HSB, smoothFactor * (_height/2) * scale);
      //fill(rmsScaled - 100 , smoothFactor * (_height/2) * scale, rmsScaled);
      //if (rmsScaled < min_r) {
      //  rmsScaled = min_r;
      //}
      //if (rmsScaled > max_r) {
      //  rmsScaled = max_r;
      //}
      //ellipse(_width/2, _height/2, rmsScaled, rmsScaled);
      //colorMode(RGB);
    }
  }
  
  void press_check() {
    if (mouseX >= startX && mouseX <= startX + _width && mouseY >= startY && mouseY <= startY + _height) {
        type = ++type % max_type;
     }  
  }
  
}