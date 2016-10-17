/* UART Example, any character received on either the real
   serial port, or USB serial (or emulated serial to the
   Arduino Serial Monitor when using non-serial USB types)
   is printed as a message to both ports.

   This example code is in the public domain.
*/

// set this to the hardware serial port you wish to use
const int ledPin = 11;

int matchValues[4] = {48, 53, 54, 55};
bool isProcessing[4] = {false, false, false, false};
int timer[4] = {0, 0, 0, 0};
unsigned int maxTime[4] = {50000, 53000, 54000, 65000};
int relayPin[4] = {0, 1, 2, 3};

void setup() {
	Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  for (int i = 0; i < 4; i++) {
    pinMode(relayPin[i], OUTPUT);
    digitalWrite(relayPin[i], LOW);
  }
}

void loop() {
  int incomingByte = 0;
  
	if (Serial.available() > 0) {
	  incomingByte = Serial.read();
    
    for (int i = 0; i < 4; i++) {
      if (incomingByte == matchValues[i] && isProcessing[i] == false){
        digitalWrite(relayPin[i], HIGH);
        isProcessing[i] = true;
      }
    }
	}

  for (int i = 0; i < 4; i++) {
    if (isProcessing[i] == true) {
      timer[i]++;
      if (timer[i] >= maxTime[i]) {
        isProcessing[i] = false;
        digitalWrite(relayPin[i], LOW);
        timer[i] = 0;
      }
    }
  }

 
}

