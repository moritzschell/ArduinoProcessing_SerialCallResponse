/*
  Arduino Code: 
  2 buttons connected to Pin 2 and 4 of Arduino I/O Pins 
  Sending button state via serial connection (to processing app)
  Example based on:
  https://docs.arduino.cc/built-in-examples/communication/SerialCallResponse/
*/

int btnA = 0;   // first analog sensor
int btnB = 0;  // second analog sensor

int inByte = 0;        // incoming serial byte

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  while (!Serial) {
    ;  // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(2, INPUT);   // digital sensor is on digital pin 2
  pinMode(4, INPUT);
  establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
  
  // if we get a valid byte, read digital ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    //delay(10);
    // read btnA
    btnA = digitalRead(2);
    // read btnB
    btnB = digitalRead(4);
    // send sensor values:
    //Serial.write(firstSensor);
    Serial.write(btnA);
    Serial.write(btnB);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');  // send a capital A
    delay(300);
  }
}