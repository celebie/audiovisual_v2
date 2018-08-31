
class Particle {
  
  float x,y;
  float vX, vY;
  
  float freq;
  float smoothFreq;
  
  int index;
  
  float angle;
  color fill;
  
  
  Particle(float x_, float y_) {
    x = x_;
    y = y_;
    vX = 0;
    vY = 0;
    
    angle = 0;
  }
  
  float getX() {
    return x + cos(angle+HALF_PI)*((.2+index/2)*smoothFreq)/20 - cos(angle)*(smoothFreq*3);
  }
  float getY() {
    return y - sin(angle+HALF_PI)*((.2+index/2)*smoothFreq)/20 + sin(angle)*(smoothFreq*3);
  }
  float getRad() {
    return freq/10;
  }
  
  void move(float s, float a) {
    vX += cos(a)*s;
    vY -= sin(a)*s;
  }
  
  void step() {
    
    //float angleTo = angleBetween(x,y,width/2,height/2);
    //vX += cos(angleTo)*.1;
    //vY += sin(angleTo)*.1;
    
    x += vX;
    y += vY;
    
    if (x > width) {
      angle = -angle+PI;
      x = width;
      vX *= -1;
    } else if (x < 0) {
      angle = -angle+PI;
      x = 0;
      vX *= -1;
    }
    if (y > height) {
      angle *= -1;
      y = height;
      vY *= -1;
    } else if (y < 0) {
      angle *= -1;
      y = 0;
      vY *= -1;
    }
    
    vX *= .8;
    vY *= .8;
    
    smoothFreq = (smoothFreq+freq)/2;
  }
  
  void connect(Particle next) {
    float m = (1+index/20);
    if (index > 1) {
      m += 1;
    }
    if (index > 2) {
      m += 1;
    }
    
    float red = 5/(.5+(index/20));
    float green = (1+index/20);
    float blue = (.5+index/5);
    fill = color(red(fill)*red, green(fill)*green, blue(fill)*blue);
    
    stroke(fill, freq/10 * (1+index/5));
    strokeWeight(freq/5 * m);
    line(getX(),getY(), next.getX(),next.getY());
    
    stroke(fill, freq*(1+index));
    strokeWeight(.1+(freq/20) * m);
    line(getX(),getY(), next.getX(),next.getY());
  }
  
}
