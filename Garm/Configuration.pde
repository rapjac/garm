class Configuration {
  
  //static final int WINDOW_WIDTH = 960;
  //static final int WINDOW_HEIGHT = 650;
  
  static final int WINDOW_WIDTH = 1062;
  static final int WINDOW_HEIGHT = 720;
  
  static final boolean DEBUG_MODE = false;
  static final boolean SPECIAL_EFFECTS = true;
  static final boolean PID_ENABLE = true;
  
  static final String VIDEO_FEED = "name=USB 2861 Device,size=640x480,fps=30";
  
  static final String COM_PORT = "COM10";
  static final int BAUD_RATE = 38400;
  
    
  static final String CAPTURE_DEVICE = "";
  static final String GAMEPAD = "Controller (XBOX 360 For Windows)";
  //static final String GAMEPAD = "Controller (Xbox 360 Wireless Receiver for Windows)";
  static final float INPUT_TOLERANCE = 0.11;
  
  static final char ARBOTIX_READY_CHAR = 'A';
  
  static final float KP = 0.2;
  static final float KI = 0.2;
  static final float KD = 0.2;
  
}
