class ControlThread extends Thread {
  String id;
  int wait;
  boolean running;
  boolean armControlMode;
  
  ControlThread( String id, int wait ) {
    this.id = id;
    this.wait = wait;
  }
  
  void start() {
    this.running = true;
    super.start();
  }
  
  void run() {
    while( running ) {
      int r = armDisplay.arm.getTotalLength();
      
      if( xbox.rightBumper.getValue() ) armControlMode = !armControlMode;
      
      if( !config.DEBUG_MODE ) {
        if( armControlMode ) {
          driveDisplay.drive.update( 0, 0 );
          switch( config.ARM_CONTROL_SCHEME ) {
            case 1:
              armDisplay.targetX += -3*xbox.leftStick.getY();
              armDisplay.grip = (int) map( xbox.rightTrigger.getValue(), -1, 0, 0, 1023 );
              if( xbox.leftBumper.getValue() ) {
                armDisplay.wristAngle = constrain( armDisplay.wristAngle += PI/120 * xbox.rightStick.getY(), -radians(150), radians(150) );
                armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle - 3*xbox.leftStick.getX(), 0, 1023 );
              }
              else armDisplay.targetY += 3*xbox.rightStick.getY();
            break;
            default:
              armDisplay.targetX += 3*xbox.leftStick.getX();
              armDisplay.targetY += 3*xbox.leftStick.getY();
              armDisplay.grip = (int) map( xbox.rightTrigger.getValue(), -1, 0, 0, 1023 );
            
              if( xbox.leftBumper.getValue() ) armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle - 3*xbox.rightStick.getX(), 0, 1023 );
              else armDisplay.wristAngle = constrain( armDisplay.wristAngle += PI/120 * xbox.rightStick.getY(), -radians(150), radians(150) );
            break;
          }
        } else driveDisplay.drive.update( xbox.leftStick.getX(), xbox.leftStick.getY() );
      } else {
        armDisplay.targetX = mouseX - width/2;
        armDisplay.targetY = mouseY - height/2;
      }
      
      armDisplay.arm.update( armDisplay.rotatorAngle, armDisplay.targetX, armDisplay.targetY, armDisplay.wristAngle, armDisplay.grip );
      
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
  }
  
  void quit() {
    running = false;
    interrupt();
  }
  
}
