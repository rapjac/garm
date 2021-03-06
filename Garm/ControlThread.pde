class ControlThread extends Thread {
  String id;
  int wait;
  boolean running;
  boolean testMode = false;
  boolean armControlMode = false;
  boolean controllerMode = true;
  
  int cameraX = 127;
  int cameraY = 150;
  
  ControlThread( String id, int wait ) {
    this.id = id;
    this.wait = wait;
  }
  
  void start() {
    if( !config.DEBUG_MODE ) {
      xbox.plug( xbox.rightBumper, "switchMode", "ON_PRESS" );
      xbox.plug( xbox.y, "setPose1", "ON_PRESS" );
      xbox.plug( xbox.b, "setPose2", "ON_PRESS" );
      xbox.plug( xbox.a, "setPose3", "ON_PRESS" );
      xbox.plug( xbox.x, "setPose4", "ON_PRESS" );
    }
    addMouseWheelListener(new MouseWheelListener() { 
      public void mouseWheelMoved(MouseWheelEvent mwe) { 
        mouseWheel(mwe.getWheelRotation());
    }});
    this.running = true;
    super.start();
  }
  
  void run() {
    while( running ) {
      if( !this.testMode ) {
        if( this.armControlMode ) {
          if( this.controllerMode || !config.DEBUG_MODE ) {
            drive.update( 0, 0 );
            arm.targetX += 2*xbox.leftStick.getX();
            arm.targetY += 2*xbox.leftStick.getY();
            arm.grip = (int) map( xbox.rightTrigger.getValue(), -1, 0, 205, 512 );
            if( xbox.leftBumper.getValue() ) arm.rotatorAngle = (int) constrain( arm.rotatorAngle - 2*xbox.rightStick.getX(), 0, 1023 );
            else arm.wristAngle = (int) constrain( arm.wristAngle - 2*xbox.rightStick.getY(), 204, 820 );
          } else {
            arm.targetX = mouseX - armDisplay.x;
            arm.targetY = mouseY - armDisplay.y;
            if( mousePressed ) arm.grip = 205;
            else arm.grip = 512;
            if( keyPressed && ( key == 'a' || key == 'A' ) ) arm.rotatorAngle = (int) constrain( arm.rotatorAngle + 3, 0, 1023 );
            if( keyPressed && ( key == 'd' || key == 'D' ) ) arm.rotatorAngle = (int) constrain( arm.rotatorAngle - 3, 0, 1023 );
          }
        } else {
          if( !config.DEBUG_MODE ) {
            drive.update( xbox.leftStick.getX(), xbox.leftStick.getY() );
            if( xbox.dpad.getValue() ) {
              this.cameraX = 127;
              this.cameraY = 150;
            }
            if( xbox.rightClick.getValue() ) drive.maxPower = constrain( drive.maxPower -= xbox.rightStick.getY(), 0, 127 );
            else {
              this.cameraX = constrain( cameraX += (int) xbox.rightStick.getX(), 0, 255 );
              this.cameraY = constrain( cameraY -= (int) xbox.rightStick.getY(), 0, 255 );
            }
          }
        }
        
        arm.update( arm.rotatorAngle, arm.targetX, arm.targetY, arm.wristAngle, arm.grip );
      } else {
        float value = millis()*TWO_PI/2000;
        drive.update( sin(value), cos(value) );
        float value2 = sin( value ) + 1;
        arm.update( int( 512 + 100*( sin( millis()*TWO_PI/4000 ) ) ), int( 35 + 20*value2 ), -40, int( 442 + 100*value2 ), int( 359 + 414*value2 ) );
      }
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
  }
  
  void test() {
    this.testMode = !this.testMode;
  }
  
  void quit() {
    running = false;
    interrupt();
  }
  
  void mouseWheel( int delta ) {
    if( armControlMode && !this.controllerMode ) {
      arm.wristAngle = constrain( arm.wristAngle + delta, 204, 820 );
    }
  }
  
  
}
