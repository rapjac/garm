class Drive {
  
  int maxPower = 127;
  DcMotor[] motors;
  
  Drive() {
    motors = new DcMotor[4];
    for( int i = 0; i < 4; i++ ) {
      motors[i] = new DcMotor(i);
    }
  }
  
  void update( float x, float y ) {
    float angle = atan2( y, x );
    float magnitude = sqrt( sq( x ) + sq( y ) );
    
    switch( getQuadrant( angle ) ){
      case 0:
        for( int i = 0; i < 4; i++ ) motors[i].setMotorSpeed( 0 );
        break;
      case 1:
        motors[0].setMotorSpeed( maxPower*cos(2*angle)*magnitude );
        motors[1].setMotorSpeed( -maxPower*magnitude );
        motors[2].setMotorSpeed( -maxPower*cos(2*angle)*magnitude );
        motors[3].setMotorSpeed( maxPower*magnitude );
        break;
      case 2:
        motors[0].setMotorSpeed( -maxPower*magnitude );
        motors[1].setMotorSpeed( maxPower*cos(2*angle)*magnitude );
        motors[2].setMotorSpeed( maxPower*magnitude );
        motors[3].setMotorSpeed( -maxPower*cos(2*angle)*magnitude );
        break;
      case 3:
        motors[0].setMotorSpeed( -maxPower*cos(2*angle)*magnitude );
        motors[1].setMotorSpeed( maxPower*magnitude );
        motors[2].setMotorSpeed( maxPower*cos(2*angle)*magnitude );
        motors[3].setMotorSpeed( -maxPower*magnitude );
        break;
      case 4:
        motors[0].setMotorSpeed( maxPower*magnitude );
        motors[1].setMotorSpeed( -maxPower*cos(2*angle)*magnitude );
        motors[2].setMotorSpeed( -maxPower*magnitude );
        motors[3].setMotorSpeed( maxPower*cos(2*angle)*magnitude );
        break;
    }
  }
  
  int getQuadrant( float angle ){
  if( angle >= 0 && angle < HALF_PI ) return 1;
  else if( angle >= HALF_PI && angle <= PI ) return 2;
  else if( angle >= -PI && angle < -HALF_PI ) return 3;
  else if( angle >= -HALF_PI && angle < 0 ) return 4; 
  else return 0;
}
  
}
