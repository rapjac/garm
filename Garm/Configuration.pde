class Configuration {
  
  static final boolean DEBUG_MODE = false;
  static final boolean SPECIAL_EFFECTS = true;
  
  //static final String COM_PORT = "COM10";
  static final String COM_PORT = "COM8";
  static final int BAUD_RATE = 38400;
  
  static final String GAMEPAD = "Controller (XBOX 360 For Windows)";
  //static final String GAMEPAD = "Controller (Xbox 360 Wireless Receiver for Windows)";
  static final float INPUT_TOLERANCE = 0.115f;
  static final int ARM_CONTROL_SCHEME = 0;
  
  static final char ARBOTIX_READY_CHAR = 'A';
  
  static final float KP = 0.2;
  static final float KI = 0.2;
  static final float KD = 0.2;
  
}
