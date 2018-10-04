class Client {
  
  String songfolder;
  ArrayList<String> songfiles;
  int sidx;
  
  String title = "";
  boolean hide = false;
  
  Visualizer viz;
  
  Client() {
  }
  
  void selectMusicFolder(File selection) {
    songfolder = selection.getAbsolutePath();
    
    songfiles = new ArrayList<String>();
    recurseDirMP3(songfiles,songfolder);
    Collections.shuffle(songfiles);
    
    sidx = -1;
    next();
  }
  
  void step() {
    if (viz != null) {
      viz.step();
      viz.display();
      
      if (!hide) {
        text(title,20,20);
        if (viz.loud != 1.) {
          text(nf(viz.loud,1,1),width-50,20);
        }
      }
      
      if (viz.done) {
        next();
      }
    }
  }
  
  void next() {
    if (viz != null) {
      viz.song.pause();
    }
    
    sidx = (sidx+1) % songfiles.size();
    viz = new Visualizer(songfiles.get(sidx));
    
    AudioMetaData metadata = viz.song.getMetaData();
    String t = metadata.title();
    String a = metadata.author();
    
    if (t != "" && a != "") {
      title = t+"\n"+a;
    } else {
      String[] splt = split(songfiles.get(sidx),'/');
      title = splt[splt.length-1];
    }
  }
  
  void keyPress() {
    if (viz != null) {
      if (key == CODED) {
        if (keyCode == RIGHT) {
          viz.song.skip(5000);
        } else if (keyCode == UP) {
          viz.loud += .1;
        } else if (keyCode == DOWN) {
          viz.loud -= .1;
        }
      }
      if (key == TAB) {
        next();
      } else if (key == 'h') {
        hide = true;
      }
    }
  }
}  
