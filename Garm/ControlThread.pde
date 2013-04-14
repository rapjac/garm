class ControlThread extends Thread {
  String id;
  int wait;
  boolean running;
  boolean armControlMode = false;
  boolean controllerMode = true;
  
  int cameraX = 127;
  int cameraY = 127;
  
  ControlThread( String id, int wait ) {
    this.id = id;
    this.wait = wait;
  }
  
  void start() {
    if( !config.DEBUG_MODE ) {
      xbox.plug( xbox.rightBumper, "switchMode", "ON_PRESS" );
      xbox.plug( xbox.y, "setAction1", "ON_PRESS" );
      xbox.plug( xbox.b, "setAction2", "ON_PRESS" );
      xbox.plug( xbox.a, "setAction3", "ON_PRESS" );
      xbox.plug( xbox.x, "setAction4", "ON_PRESS" );
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
      if( this.armControlMode ) {
        if( this.controllerMode || !config.DEBUG_MODE ) {
          drive.update( 0, 0 );
          armDisplay.targetX += 2*xbox.leftStick.getX();
          armDisplay.targetY += 2*xbox.leftStick.getY();
          armDisplay.grip = (int) map( xbox.rightTrigger.getValue(), -1, 0, 205, 512 );
          if( xbox.leftBumper.getValue() ) armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle - 2*xbox.rightStick.getX(), 0, 1023 );
          else armDisplay.wristAngle = constrain( armDisplay.wristAngle += PI/120 * xbox.rightStick.getY(), -radians(150), radians(150) );
        } else {
          armDisplay.targetX = mouseX - armDisplay.x;
          armDisplay.targetY = mouseY - armDisplay.y;
          if( mousePressed ) armDisplay.grip = 205;
          else armDisplay.grip = 512;
          if( keyPressed && ( key == 'a' || key == 'A' ) ) armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle + 3, 0, 1023 );
          if( keyPressed && ( key == 'd' || key == 'D' ) ) armDisplay.rotatorAngle = (int) constrain( armDisplay.rotatorAngle - 3, 0, 1023 );
        }
      } else {
        if( !config.DEBUG_MODE ) {
          drive.update( xbox.leftStick.getX(), xbox.leftStick.getY() );
          this.cameraX = (int) map( xbox.rightStick.getX(), -1, 1, 255, 0 );
          this.cameraY = (int) map( xbox.rightStick.getY(), -1, 1, 0, 255 );
        }
      }
      
      arm.update( armDisplay.rotatorAngle, armDisplay.targetX, armDisplay.targetY, armDisplay.wristAngle, armDisplay.grip );
      
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
  
  void mouseWheel( int delta ) {
    if( armControlMode && !this.controllerMode ) {
      //if( mousePressed ) armDisplay.grip = constrain( armDisplay.grip += 20 * delta, 205, 512 );
      //else
      armDisplay.wristAngle = constrain( armDisplay.wristAngle += PI/45 * delta, -radians(150), radians(150) );
    }
  }
  
  
}
