#include <ax12.h>
#include <BioloidController.h>
#include <WireArbotix.h>
#include <Servo.h>

BioloidController bioloid = BioloidController(1000000);

#define NUM_COMM_BYTES 4
#define NUM_AX12S 5
#define NUM_DC_MOTORS 4
#define NUM_CAMERA_SERVOS 2

#define SPEED 380
#define TORQUE 400

int action = 0;

int servoValues[NUMSERVOS] = { 512, 670, 40, 512, 205 };

char driveDirections[4] = { '1', '1', '1', '1' };
uint8_t driveSpeeds[4] = { 0, 0, 0, 0 };

int cameraXValue = 127;
int cameraYValue = 127;

Servo cameraX;
Servo cameraY;

void setup(){
  
  Wire.begin();
  Serial.begin( 38400 );
  
  pinMode( 0, OUTPUT );
  cameraX.attach( 1 );
  cameraY.attach( 2 );

}

void loop(){

   Serial.write( 'A' );
   
   if( Serial.available() >= ( NUM_COM_BYTES + 2*NUM_AX12S + NUM_DC_MOTORS + NUM_CAMERA_SERVOS ) ) {
     if( (char) Serial.read() == 'G' ) {
       if( (char) Serial.read() == 'R' ) {
         if( (char) Serial.read() == 'M' ) {
           
           int tempServoValues[NUMSERVOS];
           char tempSpeeds[4];
           char terminator;
           for( int i = 0; i < 5; i++ ) tempServoValues[i] = ( Serial.read() << 8 ) + Serial.read();
           for( int i = 0; i < 4; i++ ) tempSpeeds[i] = Serial.read();
           cameraXValue = Serial.read();
           cameraYValue = Serial.read();
           terminator = Serial.read();
           
           if( terminator == '\0' ) {
             digitalWrite( 0, HIGH );
             for( int i = 0; i < NUM_AX12S; i++ ) servoValues[i] = tempServoValues[i];
             for( int i = 0; i < NUM_DC_MOTORS; i++ ) {
               if( tempSpeeds[i] < 0 ) driveDirections[i] = '1';
               else driveDirections[i] = '0';
               driveSpeeds[i] = map( abs( tempSpeeds[i] ), 0, 127, 0, 255 );
             }
             digitalWrite( 0, LOW );
           }
         }
       }
      }
    }
    
    updateArm();
    updateDrive();
    positionCamera();
    
}

void initializeArm() {
  ax12SetRegister2( 1, 32, SPEED );
  delay( 20 );
  ax12SetRegister2( 2, 32, SPEED );
  delay( 20 );
  ax12SetRegister2( 3, 32, SPEED );
  delay( 20 );
  ax12SetRegister2( 4, 32, SPEED );
  delay( 20 );
  ax12SetRegister2( 5, 32, SPEED );
  delay( 20 );
  
  ax12SetRegister2( 1, 34, TORQUE );
  delay( 20 );
  ax12SetRegister2( 2, 34, TORQUE );
  delay( 20 );
  ax12SetRegister2( 3, 34, TORQUE );
  delay( 20 );
  ax12SetRegister2( 4, 34, TORQUE );
  delay( 20 );
  ax12SetRegister2( 5, 34, TORQUE );
  delay( 20 );
  
  pose( 512, 670, 40, 512, 205 );
}

void updateArnm() {
  for( int i = 0; i < 5; i++ ) {
     SetPosition( i+1, servoValues[i] );
  }
}

void updateDrive() {
  Wire.beginTransmission( 2 );
    for( int i = 0; i < 4; i++ ) {
      Wire.send( driveDirections[i] );
      Wire.send( driveSpeeds[i] );
    }
  Wire.endTransmission();
}

void positionCamera() {
  cameraX.write( map( cameraXValue, 0, 255, 0, 180 ) );
  cameraY.write( map( cameraYValue, 0, 255, 0, 180 ) );
}

void pose( int value0, int value1, int value2, int value3, int value4 ) {
  SetPosition( 1, value0 );
  SetPosition( 2, value1 );
  SetPosition( 3, value2 );
  SetPosition( 4, value3 );
  SetPosition( 5, value4 );
}
