class CommunicationThread extends Thread {
  
  static final char ARBOTIX_READY_CHAR = 'A';
  
  String id;
  int wait;
  boolean running;
  
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
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
  }
  
  void send(){
    if( xbee.available() > 0 && xbee.read() == ARBOTIX_READY_CHAR ) {
      sendInt( armDisplay.arm.rotator.servoValue );
      sendInt( armDisplay.arm.links[0].servoValue );
      sendInt( armDisplay.arm.links[1].servoValue );
      sendInt( armDisplay.arm.links[2].servoValue );
      sendInt( armDisplay.arm.gripper.grip );
    }
  }
  
  void sendInt( int data ) {
    xbee.write( ( data >> 8 ) & 0xFF );
    xbee.write( ( data & 0xFF ) );
  }
  
  void quit() {
    running = false;
    interrupt();
  }
  
}
