#include <SparkFun_MAG3110.h>

MAG3110 mag = MAG3110(); //Instantiate MAG3110

unsigned long lasttime;
unsigned long thistime;
unsigned long looptime;
unsigned long rev;
unsigned long pointTime = 1000;
unsigned long stopTime;

const int button1Pin = 4;     // the number of the pushbutton pin
const int button2Pin = 5;
// variables will change:
int button1State = 0;         // variable for reading the pushbutton status
int button2State = 0;
int i = 0;
int a = 0;

void setup() {
 Serial.begin(9600);

 pinMode(button1Pin, INPUT);
 pinMode(button2Pin, INPUT);

 mag.initialize(); //Initializes the mag sensor
 mag.start();      //Puts the sensor in active mode
}

void loop() {
 int x, y, z;
 //Only read data when it's ready
 if(mag.dataReady()) {
   //Read the data
   mag.readMag(&x, &y, &z);
   if( z > 2000 ) {
     digitalWrite(13,HIGH);
     
     thistime = millis();
     looptime = thistime - lasttime;
     lasttime = thistime;
     rev = 60000 / looptime;
     pointTime = millis();
     a = 0;
     //Serial.println(z);
     //Serial.println(looptime);
     Serial.println(rev);
     delay(500);
   }
   else{
    digitalWrite(13, LOW );
    if(millis() - pointTime > 2000)
    {
      if(a == 0)
      {
        Serial.println(0);
        a = 1;
        }
      }
    }
}
   //Serial.println(z);


 // read the state of the pushbutton value:
  button1State = digitalRead(button1Pin);
  button2State = digitalRead(button2Pin);

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (button1State == HIGH) {
    // turn LED on:
    Serial.println("1111");
    delay(1000);
    } 
  if (button2State == HIGH) {
    // turn LED on:
    if(i == 0){
    Serial.println("2222");
    i = 1;
    }
    else
    {
     Serial.println("3333");
      i =0;
      }
    delay(1000);
    } 
}

