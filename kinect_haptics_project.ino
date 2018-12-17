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
