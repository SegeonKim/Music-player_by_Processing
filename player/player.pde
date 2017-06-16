import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
FFT fft;
PImage play_button_img, pause_button_img, rewind_button_img, forward_button_img, volume_img, plus_img, minus_img;

controlButton play_button, stop_button, pause_button, rewind_button, forward_button;
playBar play_bar;
volumeBar volume_bar;
Equalizer equalizer;
addList add_list;
deleteList delete_list;
playList list_box;

String[] play_list;
String[] play_list_meta;
int list_length = 0;
int now_playing = 0;

Boolean pressed = false;
Boolean is_init = false;

void setup()
{
  size(800, 500);
 
  minim = new Minim(this);
 
  //song = minim.loadFile("Closer-The_Chainsmokers.mp3");
  //fft = new FFT(song.bufferSize(), song.sampleRate());
  
  init_img();
  init_object();
}

void init_img() {
  play_button_img = loadImage("img/play.png", "png");
  pause_button_img = loadImage("img/pause.png", "png");
  rewind_button_img = loadImage("img/rewind.png", "png");
  forward_button_img = loadImage("img/forward.png", "png");
  volume_img = loadImage("img/volume.png", "png");
  plus_img = loadImage("img/plus.png", "png");
  minus_img = loadImage("img/minus.png", "png");
}

void init_object() {
  play_button = new controlButton(50, 460, 60, 60, play_button_img, 0);
  pause_button = new controlButton(50, 460, 60, 60, pause_button_img, 1);
  rewind_button = new controlButton(110, 460, 40, 40, rewind_button_img, 2);
  forward_button = new controlButton(160, 460, 40, 40, forward_button_img, 3);
  add_list = new addList(730, 350, 30, plus_img);
  delete_list = new deleteList(770, 350, 30, minus_img);
  play_bar = new playBar(30, 410, 740);
  volume_bar = new volumeBar(690, 460, 80);
  play_list = new String[100];
  play_list_meta = new String[100];
  list_box = new playList(560, 0, 240, 380);
  equalizer = new Equalizer(0, 0, 560, 380);
}
 
void draw()
{
  make_grid();
  
  if (is_init) {
      fft.forward(song.mix);
      equalizer.show();
  
      if (song.isPlaying()) {
        pause_button.show();
      } else {
        play_button.show();
      }
    
      list_box.show();
      rewind_button.show();
      forward_button.show();
      play_bar.show();
      volume_bar.show();
  } else {
    show_default();
  }
  add_list.show();
  delete_list.show();
}

void show_default() {
  // play bar
   stroke(#46474b);
   line( 30, 410, 30 + 740, 410 );
   ellipseMode(CENTER);
   noStroke();
   fill(#ffffff);
   ellipse(30, 410, 20, 20);
   textSize(13);
   text("00:00 / 00:00", 700, 435);
   
   // volume bar
   imageMode(CENTER);
   image(volume_img, 690 - 20, 460, 20, 20);
   stroke(#ff3b28);
   strokeWeight(2);
   line( 690, 460, 690 + 40, 460 );
   stroke(#46474b);
   line( 690 + 40, 460, 690 + 80, 460 );
   ellipseMode(CENTER);
   noStroke();
   fill(#ffffff);
   ellipse(690 + 40, 460, 15, 15);
   
   // control button
   image(play_button_img, 50, 460, 60, 60);
   //image(pause_button_img, 50, 460, 60, 60);
   image(rewind_button_img, 110, 460, 40, 40);
   image(forward_button_img, 160, 460, 40, 40);
}

void make_grid() {
  fill(#29292a);
  strokeWeight(2);
  stroke(#1c1c1c);
  rect(0, 0, 560, 380);
  rect(560, 0, 240, 380);
  rect(0, 380, 800, 120);
}

void mousePressed() {
  if (is_init) {
    pressed = true;
    
    if (song.isPlaying()) {
      pause_button.press_check();
    } else {
      play_button.press_check();
    }
    play_bar.press_check();
    volume_bar.press_check();
    rewind_button.press_check();
    forward_button.press_check();
    equalizer.press_check();
  }
  add_list.press_check();
  delete_list.press_check();
  list_box.press_check();
  
}

void mouseReleased() {
  if (is_init) {
    pressed = false;
    play_bar.release_check();
    volume_bar.release_check();
  }
}