class ControlThread extends Thread {
  String id;
  int wait;
  boolean running;
  
  ControllSlider rightTrigger;
  ControllStick leftStick;
  ControllStick rightStick;
  
  ControlThread( String id, int wait ) {
    this.id = id;
    this.wait = wait;
    
    if( !config.DEBUG_MODE ) {
      this.leftStick = new ControllStick( device.getSlider(1), device.getSlider(0) );
      this.leftStick.setTolerance(0.12f);
      this.rightStick = new ControllStick( device.getSlider(3), device.getSlider(2) );
      this.rightStick.setTolerance(0.12f);
      this.rightTrigger = device.getSlider(4);
      this.rightTrigger.setTolerance(0.12f);
    }
  }
  
  void start() {
    this.running = true;
    super.start();
  }
  
  void run() {
    while( running ) {
      
      int r = armDisplay.arm.getTotalLength();
      
      if( !config.DEBUG_MODE ) {
        armDisplay.targetX += 3*this.leftStick.getX();
        armDisplay.targetY += 3*this.leftStick.getY();
        armDisplay.grip = (int) map( this.rightTrigger.getValue(), -1, 1, 0, 1023 );
      
        if( device.getButton(4).pressed() ) armDisplay.rotatorAngle = constrain( armDisplay.rotatorAngle += -5*rightStick.getX(), 0, 1023 );
        else armDisplay.wristAngle = constrain( armDisplay.wristAngle += PI/120*rightStick.getY(), -radians(150), radians(150) );
      
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
