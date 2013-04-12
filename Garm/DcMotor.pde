class DcMotor {
  
  int id = 0;
  PidOutput speed;
  
  DcMotor( int id ) {
    this.id = id;
    this.speed = new PidOutput( config.KP, config.KI, config.KD, 0 );
  }
  
  void setMotorSpeed( float setPoint ) {
    this.speed.output( constrain( setPoint, -127,  127 ) );
  }
  
  int getValue() {
    return (int) this.speed.processVar;
  }
  
}
