//import dmxP512.*; //<>//
import org.openkinect.processing.*;

import processing.serial.*;

Serial myPort;  // Create object from Serial class
ElementParticle em; // Call particles class
Kinect2 kinect2; // Kinect Library object
float minThresh = 2750;
float maxThresh = 3350;
PImage img;

void setup() {
  frameRate(23.67);
  fullScreen();
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  em = new ElementParticle();
  printArray(Serial.list());
  String portName = Serial.list()[13];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);
  img.loadPixels();
  int[] depth = kinect2.getRawDepth();  // Get the raw depth as array of integers
  for (int x = 100; x < kinect2.depthWidth-100; x++) {
    for (int y = 0; y < kinect2.depthHeight; y++) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      if (d > minThresh && d < maxThresh) {
        img.pixels[offset] = color(255);
      } else {
        img.pixels[offset] = color(0);
      }
      int r = int(random(10000-(398142200 + (17.02264 - 398142200)/(1 + pow((frameCount/23767.31),3.34363)))));
      if (frameCount < 985){
        if (r == 2 && img.pixels[offset] == color(255)) {
          em.create_element(x*3.75, y*2.547, int(random(200,255)), int(random(50,150)), 0);
          em.update_fire();
          em.draw_fire();
          myPort.write('1');  
        }
      }
      else {
        r = int(random(250));
        if (r == 2 && img.pixels[offset] == color(255)) {
          em.create_element(x*3.75, y*2.547, int(random(100,150)), int(random(200,230)), int(random(230,255)));
          em.update_fire();
          em.draw_fire();
          myPort.write('0');  
      }
    }
  }
  img.updatePixels();
  //image(img,0,0); // draws pixels
  
  //println(frameCount);
  textSize(42);
  text(frameCount, 1000, 300); 
  fill(0, 102, 153);
}}
