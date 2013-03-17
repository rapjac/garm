class CommunicationThread extends Thread {
  
  String id;
  int wait;
  boolean running;
  boolean serialActive = false;
  int count = 0;
  
  CommunicationThread( String id, int wait ) {
    this.id = id;
    this.wait = wait;
  }
  
  void start() {
    this.running = true;
    super.start();
  }
  
  void run() {
    while( running ) {
      send();
      receive();
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
  }
  
  void send(){
      if( xbee.available() > 0 && xbee.read() == config.ARBOTIX_READY_CHAR ) {
        sendInt( armDisplay.arm.rotator.getServoValue() );
        sendInt( armDisplay.arm.links[0].getServoValue() );
        sendInt( armDisplay.arm.links[1].getServoValue() );
        sendInt( armDisplay.arm.links[2].getServoValue() );
        sendInt( armDisplay.arm.gripper.getServoValue() );
      }
  }
  
  void receive() {
    armDisplay.arm.rotator.actuator.presentPosition = armDisplay.arm.rotator.getServoValue();
    armDisplay.arm.links[0].actuator.presentPosition = armDisplay.arm.links[0].getServoValue();
    armDisplay.arm.links[1].actuator.presentPosition = armDisplay.arm.links[1].getServoValue();
    armDisplay.arm.links[2].actuator.presentPosition = armDisplay.arm.links[2].getServoValue();
    armDisplay.arm.gripper.actuator.presentPosition = armDisplay.arm.gripper.getServoValue();
  }
  
  void sendInt( int data ) {
    this.serialActive = true;
    xbee.write( ( data >> 8 ) & 0xFF );
    xbee.write( ( data & 0xFF ) );
    this.serialActive = false;
  }
  
  void quit() {
    xbee.stop();
    running = false;
    interrupt();
  }
  
}
