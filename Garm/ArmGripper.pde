class ArmGripper {
  Ax12 actuator;
  int grip = 1023;
  
  ArmGripper( int servoId ) {
    this.actuator = new Ax12( servoId ) ;
  }
  
  void update( int grip ) {
    this.grip = (int) constrain( grip, 205, 512 );
  }
  
  void setPosition( float position ) {
    this.actuator.goalPosition.output( position );
  }
  
  int getServoValue() {
    return (int) this.actuator.goalPosition.processVar;
  }
  
}
