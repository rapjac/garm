class Ax12 {

  //Basic Information
  int id = 1;

  //
  boolean led = false;
  int goalPosition = 512;
  int movingSpeed = 0;

  //Value Limits
  int maxTemperature = 1023;
  int maxTorque = 1023;
  int maxVoltage = 190;
  int minVoltage = 60;

  //Feedback Values
  boolean moving = false;
  int presentSpeed = 0;
  int presentPosition = 0;
  int presentLoad = 0;
  int presentVoltage = 6;
  int presentTemperature = 0;
  
  Ax12( int id ) {
    this.id = id;
  }
  
  void setPosition( int position ) {
    this.goalPosition = constrain( position, 0, 1023 );
  }

}
