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
    xbee.clear();
    this.running = true;
    super.start();
  }

  void run() {
    while ( running ) {
      send();
      receive();
      try {
        sleep((long)(wait));
      } 
      catch (Exception e) {
      }
    }
  }

  void send() {
    if ( xbee.available() > 0 && (char) xbee.read() == config.ARBOTIX_READY_CHAR ) {
      sendHeader();
      sendArmData();
      //sendActionData();
      sendDriveData();
      sendCameraData();
      xbee.write( '\0' );
    }
    xbee.clear();
  }

  void receive() {
    arm.rotator.actuator.presentPosition = arm.rotator.getServoValue();
    arm.links[0].actuator.presentPosition = arm.links[0].getServoValue();
    arm.links[1].actuator.presentPosition = arm.links[1].getServoValue();
    arm.links[2].actuator.presentPosition = arm.links[2].getServoValue();
    arm.gripper.actuator.presentPosition = arm.gripper.getServoValue();
  }
  
  void sendHeader() {
    xbee.write( 'G' );
    xbee.write( 'R' );
    xbee.write( 'M' );
  }
  
  void sendActionData() {
    this.serialActive = true;
    xbee.write( (char) armDisplay.action );
    armDisplay.action = 0;
    this.serialActive = false;
  }
  
  void sendArmData() {
    sendInt( arm.rotator.getServoValue() );
    sendInt( arm.links[0].getServoValue() );
    sendInt( arm.links[1].getServoValue() );
    sendInt( arm.links[2].getServoValue() );
    sendInt( arm.gripper.getServoValue() );
  }
  
  void sendDriveData() {
    this.serialActive = true;
    for( int i = 0; i < 4; i++ ) {
      xbee.write( drive.motors[i].getValue() );
    } 
    this.serialActive = false;
  }
  
  void sendCameraData() {
    xbee.write( (char) control.cameraX );
    xbee.write( (char) control.cameraY );
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
