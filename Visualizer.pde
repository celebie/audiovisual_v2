class Visualizer {
  
  ArrayList<ParticleArray> parrays;
  
  float loud = 1;
  boolean done;
  
  AudioPlayer song;
  FFT fft;
  
  Visualizer(String fp) {
    parrays = new ArrayList<ParticleArray>();
    float n = 18;
    for (int i=0; i<n; i++) {
      parrays.add(new ParticleArray(width/2,height/2, 40, ((float)i/n)*TWO_PI));
    }
    
    song = minim.loadFile(fp);
    fft = new FFT(song.bufferSize(), song.sampleRate());
    fft.linAverages(int(fft.specSize()/2));
    
    song.play();
    done = false;
  }
  
  void step() {
    fft.forward(song.mix);
    
    int fftLen = fft.avgSize();
    float fftSum = 0;
    float[] avgs = new float[fftLen];
    for(int i = 0; i < fftLen; i++) {
      float a = fft.getAvg(i)*loud;
      avgs[i] = a;
      fftSum += a;
    }
    
    screenShake = fftSum/100;
    screenRotate = pow(fftSum/4000,2);
    
    int interval = floor(float(avgs.length)/3);
    float avg1 = sum(subset(avgs,0,interval))/interval;
    float avg2 = sum(subset(avgs,interval,interval))/interval;
    float avg3 = sum(subset(avgs,interval*2,interval))/interval;
    float maxavg = max(avg1,avg2,avg3);
    
    float red = avg1*(255/(.01+maxavg*.2)) * (fftSum/1000);
    float green = avg2*(255/(.01+maxavg*.2)) * (fftSum/1000);
    float blue = avg3*(255/(.01+maxavg*.2)) * (fftSum/1000);
    color fill = color(red,green,blue);
    
    for (ParticleArray pa: parrays) {
      pa.forward(pow(fftSum/fftLen,1.5));
    }
    
    ParticleArray pa1 = parrays.get(0);
    int particlesLen = pa1.particles.size();
    int one = floor(avgs.length/particlesLen);
    for (int i=0; i<particlesLen; i++) {
      for (ParticleArray pa: parrays) {
        Particle p = pa.particles.get(i);
        float[] set = subset(avgs,i*one,one);
        p.freq = sum(set);
        p.fill = fill;
        p.step();
      }
    }
    
  }
  
  void display() {
    //for (ParticleArray pa: parrays) {
    //  pa.display();
    //}
    ParticleArray pa1 = parrays.get(0);
    int particlesLen = pa1.particles.size();
    
    for (int i=particlesLen-1; i>=0; i--) {
      for (ParticleArray pa: parrays) {
        Particle p = pa.particles.get(i);
        if (i < pa.particles.size()-1) {
          Particle next = pa.particles.get(i+1);
          p.connect(next);
        }
      }
    }
    
  }
  
}
