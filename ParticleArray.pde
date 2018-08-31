class ParticleArray {
  
  color fill;
  
  ArrayList<Particle> particles;
  
  ParticleArray(float x, float y, int n, float angle) {
    particles = new ArrayList<Particle>();
    for (int i=0; i<n; i++) {
      Particle p = new Particle(x+cos(angle)*i*50,y-sin(angle)*i*50);
      p.index = i;
      p.angle = angle;
      particles.add(p);
    }
  }
  
  void forward(float s) {
    int particlesLen = particles.size();
    for (int i=0; i<particlesLen; i++) {
      Particle p = particles.get(i);
      p.move(s, p.angle);
    }
  }
  
  //void step() {
  //  int particlesLen = particles.size();
  //  int one = floor(freqs.length/particlesLen);
  //  for (int i=0; i<particlesLen; i++) {
  //    Particle p = particles.get(i);
  //    float[] set = subset(freqs,i*one,one);
  //    p.freq = sum(set);
  //    p.fill = color(red(fill),green(fill)/(1+p.freq),blue(fill));
  //    p.step();
  //  }
  //}
  
  //void display() {
  //  for (int i=0; i<particles.size(); i++) {
  //    Particle p = particles.get(i);
  //    if (i < particles.size()-1) {
  //      Particle next = particles.get(i+1);
  //      p.connect(next);
  //    }
  //    p.display();
  //  }
  //}
  
}
