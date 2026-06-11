# ArduinoProcessing_SerialCallResponse
Reading two button states (Pin 2, 4) on [__Arduino__](https://www.arduino.cc) and sending the values to [__Processing__](https://processing.org) via _Serial Connection_.

Based on this example: [Serial Call and Response (handshaking)](https://docs.arduino.cc/built-in-examples/communication/SerialCallResponse/)


Slightly modified:
- reading two button states on I/O pin 2 and 4
- add a handshake call on processing setup, so it will work everytime processing starts. 
