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
      //sendParity();
      xbee.write( '\0' );
    }
    xbee.clear();
  }

  void receive() {
    armDisplay.arm.rotator.actuator.presentPosition = armDisplay.arm.rotator.getServoValue();
    armDisplay.arm.links[0].actuator.presentPosition = armDisplay.arm.links[0].getServoValue();
    armDisplay.arm.links[1].actuator.presentPosition = armDisplay.arm.links[1].getServoValue();
    armDisplay.arm.links[2].actuator.presentPosition = armDisplay.arm.links[2].getServoValue();
    armDisplay.arm.gripper.actuator.presentPosition = armDisplay.arm.gripper.getServoValue();
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
    sendInt( armDisplay.arm.rotator.getServoValue() );
    sendInt( armDisplay.arm.links[0].getServoValue() );
    sendInt( armDisplay.arm.links[1].getServoValue() );
    sendInt( armDisplay.arm.links[2].getServoValue() );
    sendInt( armDisplay.arm.gripper.getServoValue() );
    println( armDisplay.arm.gripper.getServoValue() );
  }
  
  void sendDriveData() {
    this.serialActive = true;
    for( int i = 0; i < 4; i++ ) {
      xbee.write( driveDisplay.drive.motors[i].getValue() );
    } 
    this.serialActive = false;
  }
  
  void sendParity() {
    int sum = armDisplay.action;
    byte parity = 0;
    for( int i = 0; i < 4; i++ ) sum += driveDisplay.drive.motors[i].getValue();
    parity = (byte) ( ( sum % 2 ) == 0 ? 0 : 1 );
    println( sum );
    println( parity );
    xbee.write( parity );
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
