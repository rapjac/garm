#include <Wire.h>

#define CH1_DIR 2
#define CH1_PWM 3
#define CH2_DIR 4
#define CH2_PWM 5
#define CH3_DIR 7
#define CH3_PWM 6
#define CH4_DIR 8
#define CH4_PWM 9

int directionPins[4] = { 2, 4, 7, 8 };
int speedPins[4] = { 3, 5, 6, 9 };
boolean directions[4] = { true, true, false, false };
int speeds[4] = { 0, 0, 0, 0 };

void setup() {
  
  // Initiate Communication
  Wire.begin( 2 );
  Wire.onReceive( readData );
  Serial.begin(9600);
  
  //Set Pin Modes
  pinMode( CH1_DIR, OUTPUT );
  pinMode( CH1_PWM, OUTPUT );
  pinMode( CH2_DIR, OUTPUT );
  pinMode( CH2_PWM, OUTPUT );
  pinMode( CH3_DIR, OUTPUT );
  pinMode( CH3_PWM, OUTPUT );
  pinMode( CH4_DIR, OUTPUT );
  pinMode( CH4_PWM, OUTPUT );
  
}

void loop() {
  updateMotors();
}

void readData( int byteCount ) {
    for( int i = 0; i < 4; i++ ) {
      int direction = (char) Wire.read();
      int speed = Wire.read();
      if( direction == '1' ) directions[i] = true;
      else directions[i] = false;
      speeds[i] = constrain( speed, 0, 255 );
    }
}

void updateMotors() {
  for( int i = 0; i < 4; i++ ) {
    if( directions[i] ) digitalWrite( directionPins[i], LOW );
    else digitalWrite( directionPins[i], HIGH );
    analogWrite( speedPins[i], speeds[i] );
  }
  
  Serial.println( "----------" );
  for( int i = 0; i < 4; i++ ) {
    Serial.print( "Motor " );
    Serial.print( i );
    Serial.print(": ");
    if( directions[i] ) Serial.print( "+" );
    else Serial.print("-");
    Serial.print( speeds[i] );
    Serial.print( "\t" );
  }
  Serial.println("\n");
}
