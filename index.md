## Kinect Visual Effetcs: Haptics Final Project

### Project Video
## Embed video here.

### Project Description
Our group plans on using the depth and skeleton tracking technology found in the Microsoft Xbox Kinect camera.  One user at a time will be hooked up to our device, which will be a wearable.  An Arduino will be mounted to the chest of the participant and connected to a motion sensor and photo-resistor on both the participants hands.  One hand will be in control of the "ice" effect, and the other hand will control the "fire".  As the user closes one of their hands, they will see a visual representation of ice, for example, moving up their arms and into their body.  We will animate the facial expression to change with the temperature as well.  Along with visual representations of fire and ice, the participant will also be wearing 2 Peltier elements on each arm, which will change temperature and heat the user's skin up according to what the user is seeing on the screen.  If we get this project working quickly and have the ability to purchase more materials it would be nice to add the ability to have a second user and have two participants battle each other, but for now the game will be one user trying to balance their own temperature so that they don't freeze or catch on fire.

### Resource List
- Xbox Kinect v2
- Microsoft Kinect software for PC
- Processing code
- Projector
- Projector screen
- Arduino
- Photoresistors
- Elastic bands
- Wire
- Peltier elements

### Sketch
## Insert sketch here

### Processing Code (Kinect Communication)
```markdown
//import dmxP512.*;
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
```

### Processing Code (Particles)
```markdown
int num = 500;
float[][] fire = new float [num][12];

class ElementParticle {

  void update_fire(){
    for(int i=num-1; i>0; i--){
      for(int fireprop=0;fireprop<12;fireprop++){
      fire[i][fireprop]=fire[i-1][fireprop];
      }
    }
    for(int flame=0 ; flame<num ; flame++){
      if(fire[flame][0]==1){
    fire[flame][1]=fire[flame][1]+fire[flame][5]*cos(fire[flame][3]);
    fire[flame][2]=fire[flame][2]+fire[flame][5]*sin(fire[flame][3]);
      }
      fire[flame][7]+=1;
      if(fire[flame][7]>fire[flame][6]){
    fire[flame][0]=0;
      }
    }
  }
  void draw_fire(){
    for(int flame=0 ; flame<num ; flame++){
      if(fire[flame][0]==1){
    fill(fire[flame][9],fire[flame][10],fire[flame][11],180); //controls red, green, blue, opacity
    pushMatrix();
    translate(fire[flame][1],fire[flame][2]);
    rotate(fire[flame][8]);
    rect(0,0,fire[flame][4],fire[flame][4]);
    popMatrix();
      }
    }
  }
  void create_element(float locX, float locY, int r, int g, int b)
    {
      fire[0][0]=1;
      fire[0][1]=locX;
      fire[0][2]=locY;
      fire[0][3]=random(0,PI*2);//angle
      fire[0][4]=random(20,35);//size
      fire[0][5]=random(1,2);//speed
      fire[0][6]=random(5,20);//maxlife
      fire[0][7]=0;//currentlife
      fire[0][8]=random(0,TWO_PI);
      fire[0][9]=r;//red
      fire[0][10]=g;//green
      fire[0][11]=b;//blue    
  }
}
```

### Arduino Code (Peltier)
```markdown
// Adafruit Motor shield library
// copyright Adafruit Industries LLC, 2009
// this code is public domain, enjoy!

#include <AFMotor.h>
char val;

AF_DCMotor motor2(2);
AF_DCMotor motor3(3);


void setup() {
  Serial.begin(9600);           // set up Serial library at 9600 bps
  Serial.println("Motor test!");
}

void loop() {
  if (Serial.available()) { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == '1') { // If 1 was received
    motor2.run(FORWARD); 
    motor3.run(FORWARD); 
    motor2.setSpeed(220);
    motor3.setSpeed(220);
  }
  if (val == '0') { // If 1 was received
    motor2.run(BACKWARD); 
    motor3.run(BACKWARD); 
    motor2.setSpeed(220);
    motor3.setSpeed(220);
  }
  delay(10);
}
```

### Team Members
- Joss Gitlin
- Julian Torres
- Ben Gillespie
- Alex Lightman
