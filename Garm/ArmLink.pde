class ArmLink {
  int servoValue;
  int length = 80;
  int x;
  int y;
  float angle = 0;
  
  ArmLink( int length ) {
    this.length = length;
    this.update( this.angle );
  }
  
  void update( float angle ) {
    this.angle = angle;
    this.x = int((cos(this.angle) * this.length));
    this.y = int((sin(this.angle) * this.length));
  }
}
