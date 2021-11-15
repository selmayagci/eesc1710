PImage image1, image2, image3;
ArrayList<Dot> dots;
ArrayList<PVector> targets1, targets2, targets3;
int scaler = 1;
int threshold = 200;
boolean imageToggled = false;
color color1, color2, color3;

void setup() {
  size(50, 50, P2D);  
  image1 = loadImage("friends.jpeg");
  image2 = loadImage("door.jpeg");
  image3 = loadImage("logo.jpeg");

  int w, h;
  if (image1.width > image2.width) {
    w = image1.width;
  } else if(image2.width > image3.width) {
    w = image2.width;
  } else{
    w = image3.width;
  }
  
  
  if (image1.height > image2.height) {
    h = image1.height;
  } else if(image2.height > image3.height){
    h = image2.height;
  } else{
    h = image3.height;
  }
  surface.setSize(w, h);
  
  image1.loadPixels();
  image2.loadPixels();
  image3.loadPixels();

  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  targets3 = new ArrayList<PVector>();

  color1 = color(255, 127, 0, 63);
  color2 = color(165, 105, 189, 63);
  color3 = color(118, 215, 196, 63);
  
  dots = new ArrayList<Dot>();

  for (int x = 0; x < image3.width; x += scaler) {
    for (int y = 0; y < image3.height; y += scaler) {
      int loc = x + y * image3.width;

      if (brightness(image3.pixels[loc]) > threshold) {
        targets3.add(new PVector(x, y));
      }
    }
  }
  
  
  for (int x = 0; x < image2.width; x += scaler) {
    for (int y = 0; y < image2.height; y += scaler) {
      int loc = x + y * image2.width;

      if (brightness(image2.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }


  for (int x = 0; x < image1.width; x += scaler) {
    for (int y = 0; y < image1.height; y += scaler) {
      int loc = x + y * image1.width;
      
      if (brightness(image1.pixels[loc]) > threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        Dot dot = new Dot(x, y, color1, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() { 
  background(144, 108, 154);
  
  blendMode(ADD);
  
  boolean flipTargets = true;

  for (Dot dot : dots) {
    dot.run();
    if (!dot.ready) flipTargets = false;
  }
  
  if (flipTargets) {
    for (Dot dot : dots) {
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        dot.target = targets1.get(targetIndex);
        dot.col = color1;
      } else if(!imageToggled) {
        int targetIndex = int(random(0, targets2.size()));
        dot.target = targets2.get(targetIndex);
        dot.col = color2;
      } else {
        int targetIndex = int(random(0, targets3.size()));
        dot.target = targets3.get(targetIndex);
        dot.col = color3;
      }
    }
    imageToggled = !imageToggled;
  }
    
  surface.setTitle("" + frameRate);
}
