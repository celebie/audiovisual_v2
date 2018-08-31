import ddf.minim.*;
import ddf.minim.analysis.*;

Visualizer viz;

Minim minim;

float screenShake = 0;
float screenRotate = 0;
int idx = 0;

void fileSelected(File selection) {
  if (selection == null) {
    exit();
  } else {
    viz = new Visualizer(selection.getPath());
  }
}

void setup() {
  minim = new Minim(this);
  
  fullScreen(P3D);
  
  selectInput("Select song to visualize:", "fileSelected");
}

void draw() {
  background(0);
  if (viz != null) {
    translate(width/2,height/2);
    rotate(screenRotate);
    translate(-width/2,-height/2);
    
    translate(random(-screenShake,screenShake),random(-screenShake,screenShake));
    
    viz.step();
    viz.display();
    
    idx += 1;
  }
  if (frameRate < 50) {
    println(frameRate);
  }
  //text(str(frameRate),width-100,30);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      viz.song.skip(5000);
    } else if (keyCode == UP) {
      viz.loud += .1;
    } else if (keyCode == DOWN) {
      viz.loud -= .1;
    }
  }
}


float sum(float[] arr) {
  float s = 0;
  for (int i=0; i<arr.length; i++) {
    s += arr[i];
  }
  return s;
}

float angleBetween(float x1, float y1, float x2, float y2) {
  float a = atan2(y2-y1, x2-x1) % TWO_PI;
  while (a < 0) {
    a += TWO_PI;
  }
  while (a > TWO_PI) {
    a -= TWO_PI;
  }
  return a;
}
