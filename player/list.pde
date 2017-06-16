int list_selected = -1;

class playList {
  int startX;
  int startY;
  int _width;
  int _height;
  int node_height = 40;
  
  playList(int startX, int startY, int _width, int _height) {
    this.startX = startX;
    this.startY = startY;
    this._width = _width;
    this._height = _height;
  }
  
  void show() {
    for (int i = 0; i < list_length; i++) {
      if (list_selected == i) {
        continue;
      }
      noFill();
      strokeWeight(1);
      stroke(#1c1c1c);
      rectMode(CORNER);
      rect(startX, i * node_height, width - startX, node_height);
      textSize(14);
      if (now_playing == i) {
        fill(#f312ac);
      } else {
        fill(#ffffff);
      }
      text(play_list_meta[i], startX + 10, i * node_height + 24);
    }
    if (list_selected > -1) {
      noFill();
      strokeWeight(1);
      stroke(#ffffff);
      rectMode(CORNER);
      rect(startX, list_selected * node_height, width - startX, node_height);
      textSize(14);
      if (now_playing == list_selected) {
        fill(#f312ac);
      } else {
        fill(#ffffff);
      }
      text(play_list_meta[list_selected], startX + 10, list_selected * node_height + 24);
    }
  }
  
  void press_check() {
    if (mouseX >= startX && mouseX <= startX + _width && mouseY >= 0 && mouseY <= 380) {
      int select = mouseY/node_height;
      if (select <= list_length) {
        if (list_selected == select) {
          list_selected = -1;
        } else {
          list_selected = select;
        }
      }
    }
  }
}

class addList {
  int startX;
  int startY;
  int _width;
  PImage add_button;
  
  addList(int startX, int startY, int _width, PImage add_button) {
    this.startX = startX;
    this.startY = startY;
    this._width = _width;
    this.add_button = add_button;
  }
  
  void show() {
     imageMode(CENTER);
     image(add_button, startX, startY, _width, _width);
   }
   
   void press_check() {
     if (int( dist(mouseX, mouseY, startX, startY) ) <= (_width/2)) {
        selectInput("Select a music", "folderSelected");
     }
   }
}

class deleteList {
  int startX;
  int startY;
  int _width;
  PImage delete_button;
  
  deleteList(int startX, int startY, int _width, PImage delete_button) {
    this.startX = startX;
    this.startY = startY;
    this._width = _width;
    this.delete_button = delete_button;
  }
  
  void show() {
     imageMode(CENTER);
     image(delete_button, startX, startY, _width, _width);
   }
   
   void press_check() {
     if (int( dist(mouseX, mouseY, startX, startY) ) <= (_width/2)) {
        if (list_selected >= 0 && list_selected != now_playing) {
          for (int i = list_selected; i < list_length - 1; i++) {
            play_list[i] = play_list[i + 1];
            play_list_meta[i] = play_list_meta[i + 1];
            if (i + 1 == now_playing) {
              now_playing = i;
            }
          }
          list_selected = -1;
          list_length--;
        }
     }
   }
}

void folderSelected(File selection) {
  String path = selection.getPath();
  AudioMetaData tmp_meta;

  if (!is_init) {
    song = minim.loadFile(path);
    fft = new FFT(song.bufferSize(), song.sampleRate());
    now_playing = 0;
    tmp_meta = song.getMetaData();
  } else {
    tmp_meta = minim.loadFile(path).getMetaData();
  }
  play_list[list_length] = path;
  play_list_meta[list_length] = tmp_meta.title() + " - " + tmp_meta.author();
  list_length++;

  is_init = true;

}