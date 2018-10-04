import java.util.Collections;
import ddf.minim.*;
import ddf.minim.analysis.*;

Client client;
Minim minim;

float screenShake = 0;
float screenRotate = 0;

static final float sum(float... arr) {
  float sum = 0;
  for (float f: arr)  sum += f;
  return sum;
}

void recurseDirMP3(ArrayList<String> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      recurseDirMP3(a, subfiles[i].getAbsolutePath());
    }
  } else if (file.getAbsolutePath().indexOf(".mp3") != -1) {
    a.add(file.getAbsolutePath());
  }
}

void folderSelected(File selection) {
  if (selection == null) {
    exit();
  } else {
    client.selectMusicFolder(selection);
  }
}


void setup() {
  minim = new Minim(this);
  client = new Client();
  
  fullScreen(P3D);
  
  textFont(createFont("Arial", 12));
  
  selectFolder("Select song folder to visualize:", "folderSelected");
}

void draw() {
  background(0);
  if (client != null) {
    translate(width/2,height/2);
    rotate(screenRotate);
    translate(-width/2,-height/2);
    
    translate(random(-screenShake,screenShake),random(-screenShake,screenShake));
    
    client.step();
  }
  if (frameRate < 50) {
    println(frameRate);
  }
  //text(str(frameRate),width-100,30);
}

void keyPressed() {
  if (client != null) {
    client.keyPress();
  }
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
