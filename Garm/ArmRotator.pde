class ArmRotator {
  int servoValue = 511;
  
  ArmRotator() {
  }
  
  void update( int servoValue ) {
    this.servoValue = constrain( servoValue, 0, 1023 );
  }
}
