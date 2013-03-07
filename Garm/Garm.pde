import processing.serial.*;
import procontroll.*;
import net.java.games.input.*;

Configuration config;

ControlThread control;
CommunicationThread communication;

Serial xbee;

ControllIO io;
ControllDevice device;

ControllStick leftStick;
ControllStick rightStick;

ArmDisplay armDisplay;

void setup() {
  
  // Set Windows Size
  size( 800, 600 );
  
  // Configuration Settings
  config = new Configuration();
  
  // Establish XBee Wireless Serial Communication
  xbee = new Serial( this, config.COM_PORT, config.BAUD_RATE );
  
  // Connect to Gamepad
  if( !config.DEBUG_MODE ) {
    io = ControllIO.getInstance( this );
    io.printDevices();
    device = io.getDevice( config.GAMEPAD );
  }
  
  // GUI Elements
  armDisplay = new ArmDisplay( width/2, height/2, 640, 480 );
  
  // Costruct Threads
  control = new ControlThread( "control", 10 );
  control.start();
  
  communication = new CommunicationThread( "communication", 15 );
  communication.start();
  
}

void draw() {
  background( #ACACAC );
  render();
}

void render() {
  armDisplay.render();
}


