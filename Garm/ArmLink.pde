class ArmLink {
  Ax12 actuator;
  int length = 80;
  int x;
  int y;
  float angle = 0;
  
  ArmLink( int length, int servoId ) {
    this.length = length;
    this.update( this.angle );
    actuator = new Ax12( servoId );
  }
  
  void update( float angle ) {
    this.angle = angle;
    this.x = int( (cos(this.angle) * this.length) );
    this.y = int( (sin(this.angle) * this.length) );
  }
  
  void setPosition( float position ) {
    this.actuator.goalPosition.output( position );
  }
  
  int getServoValue() {
    return (int) this.actuator.goalPosition.processVar;
  }
  
}
