class Ax12 {

  //Basic Information
  int id = 1;

  //Output Values
  PidOutput goalPosition;
  int movingSpeed = 0;

  //Value Limits
  int maxTemperature = 1023;
  int maxTorque = 1023;
  int maxVoltage = 190;
  int minVoltage = 60;

  //Feedback Values
  boolean led = false;
  boolean moving = false;
  int presentSpeed = 0;
  int presentPosition = 0;
  int presentLoad = 0;
  int presentVoltage = 0;
  int presentTemperature = 0;
  
  Ax12( int id ) {
    this.id = id;
    goalPosition = new PidOutput( config.KP, config.KI, config.KD, 0 );
  }
  
  void setPosition( float position ) {
    this.goalPosition.output( constrain( position, 0, 1023 ) );
  }
  
  int getServoValue() {
    return constrain( (int) this.goalPosition.processVar, 0, 1023 );
  }

}
