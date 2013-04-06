class ArmGripper {
  Ax12 actuator;
  int grip = 205;
  
  ArmGripper( int servoId ) {
    this.actuator = new Ax12( servoId ) ;
  }
  
  void setPosition( float position ) {
    this.actuator.goalPosition.output( position );
  }
  
  int getServoValue() {
    return (int) this.actuator.goalPosition.processVar;
  }
  
}
