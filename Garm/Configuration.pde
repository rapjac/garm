class Configuration {
  
  //static final int WINDOW_WIDTH = 960;
  //static final int WINDOW_HEIGHT = 650;
  
  static final int WINDOW_WIDTH = 1062;
  static final int WINDOW_HEIGHT = 474;
  
  static final boolean DEBUG_MODE = true;
  static final boolean SPECIAL_EFFECTS = true;
  static final boolean PID_ENABLE = true;
  
  // XBEE:
  // Ultrabook: COM7
  // Giles's PC: COM10
  // Rafael's PC: COM3
  static final String COM_PORT = "COM7";
  static final int BAUD_RATE = 38400;
  
  static final String GAMEPAD = "Controller (XBOX 360 For Windows)";
  //static final String GAMEPAD = "Controller (Xbox 360 Wireless Receiver for Windows)";
  static final float INPUT_TOLERANCE = 0.10;
  
  static final char ARBOTIX_READY_CHAR = 'A';
  
  static final float KP = 0.2;
  static final float KI = 0.2;
  static final float KD = 0.2;
  
}
