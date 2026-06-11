/*
  Processing code:
  Receiving two button states connected to an arduino
  Example based on:
  https://docs.arduino.cc/built-in-examples/communication/SerialCallResponse/
*/
import processing.serial.*;

Serial myPort;   

int btnA = 0;
int btnB = 0;

int[] serialInArray = new int[2];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
 
boolean firstContact = false;        // Whether we've heard from the microcontroller

void setup() {
  size(256, 256);  // Stage size
  noStroke();      // No border on the next thing drawn

  println(Serial.list());
  //Pick the right PORT!!!
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);
  
  stroke(255);
  
  noFill();
  if(btnA == 1){
    fill(255);
  }
  ellipse(width/4, height/2, 40, 40);
  
  noFill();
  if(btnB == 1){
    fill(255);
  }
  ellipse(width/4 * 3, height/2, 40, 40);
}

void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    if (serialCount == 2 ) {
      btnA = serialInArray[0];
      btnB = serialInArray[1];
      // print the values (for debugging purposes only):
      println(btnA + "\t" + btnB);
      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
}
