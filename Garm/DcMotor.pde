class DcMotor {
  
  int id = 0;
  boolean direction;
  PidOutput speed;
  
  DcMotor( int id ) {
    this.id = id;
    this.direction = false;
    this.speed = new PidOutput( config.KP, config.KI, config.KD, 0 );
  }
  
  void setMotorSpeed( float setPoint ) {
    if( setPoint > 0 ) this.direction = false;
    else this.direction = true;
    this.speed.output( constrain( abs(setPoint), 0, 255 ) );
  }
  
  int getValue() {
    return (int) this.speed.processVar;
  }
  
}
