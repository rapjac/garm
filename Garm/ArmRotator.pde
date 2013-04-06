class ArmRotator {
  Ax12 actuator;
  int position = 511;
  
  ArmRotator( int servoId ) {
    actuator = new Ax12( servoId );
  }
  
  void setPosition( float position ) {
    this.actuator.goalPosition.output( position );
  }
  
  int getServoValue() {
    return (int) this.actuator.goalPosition.processVar;
  }
}
