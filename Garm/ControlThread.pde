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
    xbox.plug( xbox.rightBumper, "switchMode", "ON_PRESS" );
  }
  
  void run() {
    while( running ) {
      if( !config.DEBUG_MODE ) {
        if( this.armControlMode ) {
          driveDisplay.drive.update( 0, 0 );
          switch( config.ARM_CONTROL_SCHEME ) {
            case 1:
              armDisplay.targetX += -3*xbox.leftStick.getY();
              armDisplay.grip = (int) map( xbox.rightTrigger.getValue(), -1, 0, 205, 512 );
              if( xbox.leftBumper.getValue() ) {
                armDisplay.wristAngle = constrain( armDisplay.wristAngle += PI/120 * xbox.rightStick.getY(), -radians(150), radians(150) );
                armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle - 3*xbox.leftStick.getX(), 0, 1023 );
              }
              else armDisplay.targetY += 3*xbox.rightStick.getY();
            break;
            default:
              armDisplay.targetX += 2*xbox.leftStick.getX();
              armDisplay.targetY += 2*xbox.leftStick.getY();
              armDisplay.grip = (int) map( xbox.rightTrigger.getValue(), -1, 0, 205, 512 );
            
              if( xbox.leftBumper.getValue() ) armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle - 2*xbox.rightStick.getX(), 0, 1023 );
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
