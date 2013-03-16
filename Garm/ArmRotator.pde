class ArmRotator {
  Ax12 actuator;
  int position = 511;
  
  ArmRotator( int servoId ) {
    actuator = new Ax12( servoId );
  }
  
  void update( int position ) {
    this.position = constrain( position, 0, 1023 );
  }
  
  void setPosition( float position ) {
    this.actuator.goalPosition.output( position );
  }
  
  int getServoValue() {
    return (int) this.actuator.goalPosition.processVar;
  }
}
