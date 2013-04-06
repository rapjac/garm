class ArmLink {
  Ax12 actuator;
  int length = 80;
  
  ArmLink( int length, int servoId ) {
    this.length = length;
    actuator = new Ax12( servoId );
  }
  
  void setPosition( float position ) {
    this.actuator.goalPosition.output( position );
  }
  
  int getServoValue() {
    return (int) this.actuator.goalPosition.processVar;
  }
  
}
