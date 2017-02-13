float diameter = 30;

void setup() {
  size(1280, 720);
  //frameRate(4);
  noLoop();
  background(#111111);
  noStroke();
  colorMode(HSB,1.0,1.0,1.0);
}

void draw() {
  for (int x=0; x<width; x+=diameter) {
    for (int y=0; y<height; y+=diameter) {
      spot(x, y);
    }
  }
  //filter(BLUR, 2);
  filter(INVERT);
  saveFrame("export/bg_circles-####.png");
}

void spot(int x, int y) {
  float dist = pitag(width/2-x, height/2-y);
  float dens = dist / pitag(width/2, height/2);
  
  float angle = atan2(y - height/2, x - width/2) / 6.28;
  angle += (angle < 0.0) ? 1.0 : 0.0; 
  
  color cl = color(angle, 
                   map(dens, 0.0, 1.0, 0.0, 0.7), 
                   map(dens, 0.0, 1.0, 0.3, 0.0) + random(0.4));
             
  float d = map(dens, 0.0, 1.0, 0.3, 1.0) + random(0.2) - 0.1;
  my_circle(x + diameter/2,
            y + diameter/2,
            diameter * d, 
            cl);
}

void my_circle(float x, float y, float d, color c) {
  PGraphics img = createGraphics(int(3 * d), int(3 * d));
  
  img.beginDraw();
    img.noStroke();
  
    img.fill(c);
    img.ellipse(d, d, d, d);
  
    img.filter(BLUR, 2);
  
    img.endDraw();
  
  image(img, x - d, y - d);
}

float pitag(float a, float b) {
  return sqrt(pow(a, 2.0) + pow(b, 2.0));
}