class DcMotor {
  int id = 0;
  PidOutput motorSpeed;
  
  DcMotor( int id ) {
    this.id = id;
    this.motorSpeed = new PidOutput( config.KP, config.KI, config.KD, 0 );
  }
  
  void setMotorSpeed( float setPoint ) {
    this.motorSpeed.output( constrain( setPoint, -255, 255 ) );
  }
  
  int getValue() {
    return (int) this.motorSpeed.processVar;
  }
  
}
