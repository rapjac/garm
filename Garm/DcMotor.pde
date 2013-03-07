class DcMotor {
  int id = 1;
  int value = 0;
  
  void setValue( int value ) {
    this.value = constrain( value, -127, 127 );
  }
  
}
