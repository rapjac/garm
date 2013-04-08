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
      println( "Got Request!" );
      sendAction();
      //sendDriveValues();
    }
  }

  void receive() {
    armDisplay.arm.rotator.actuator.presentPosition = armDisplay.arm.rotator.getServoValue();
    armDisplay.arm.links[0].actuator.presentPosition = armDisplay.arm.links[0].getServoValue();
    armDisplay.arm.links[1].actuator.presentPosition = armDisplay.arm.links[1].getServoValue();
    armDisplay.arm.links[2].actuator.presentPosition = armDisplay.arm.links[2].getServoValue();
    armDisplay.arm.gripper.actuator.presentPosition = armDisplay.arm.gripper.getServoValue();
  }
  
  void sendAction() {
    this.serialActive = true;
    xbee.write( (char) armDisplay.action );
    armDisplay.action = 0;
    this.serialActive = false;
  }
  
  void sendArmValues() {
  }
  
  void sendDriveValues() {
    this.serialActive = true;
    for( int i = 0; i < 4; i++ ) {
      if( driveDisplay.drive.motors[i].direction ) xbee.write( '1' );
      else xbee.write( '0' );
      xbee.write( driveDisplay.drive.motors[i].getValue() );
    } 
    this.serialActive = false;
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
