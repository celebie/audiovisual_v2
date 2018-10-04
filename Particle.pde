
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
    float m = .2+constrain(index,0,20)/2;
    return x + cos(angle+HALF_PI)*(m*smoothFreq)/20 - cos(angle)*(smoothFreq*3);
  }
  float getY() {
    float m = .2+constrain(index,0,20)/2;
    return y - sin(angle+HALF_PI)*(m*smoothFreq)/20 + sin(angle)*(smoothFreq*3);
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
    //vX += cos(angleTo)*.1/(1+freq);
    //vY += sin(angleTo)*.1/(1+freq);
    
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
    float m = 1+constrain(index,0,5)/2;
    float m2 = 1+index/10;
    
    float red = 5/(.5+m2);
    float green = (1+m2);
    float blue = (.5+m2);
    fill = color(red(fill)*red, green(fill)*green, blue(fill)*blue);
    
    // thick outer line
    stroke(fill, freq/10 * m);
    strokeWeight(freq/5 * m);
    line(getX(),getY(), next.getX(),next.getY());
    
    fill = color(red(fill)*red/2, green(fill)*green/2, blue(fill)*blue/2);
    
    // thin inner line
    stroke(fill, freq*pow(1+m,2));
    strokeWeight(.1+(freq/20) * m);
    line(getX(),getY(), next.getX(),next.getY());
  }
  
}
