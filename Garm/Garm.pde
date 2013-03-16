import processing.serial.*;
import procontroll.*;
import net.java.games.input.*;

Configuration config;

ControlThread control;
CommunicationThread communication;

ArmDisplay armDisplay;
DriveDisplay driveDisplay;
DataDisplay dataDisplay;

Serial xbee;

ControllIO io;
ControllDevice device;
XboxController xbox;

PFont titleFont = createFont( "Impact", 80 );
PFont subTitleFont = createFont( "Georgia", 12 );
PFont displayFont = createFont( "Courier New", 12 );

void setup() {
  
  // Set Windows Size
  size( 960, 650 );
  smooth();
  
  // Configuration Settings
  config = new Configuration();
  
  // Establish XBee Wireless Serial Communication
  xbee = new Serial( this, config.COM_PORT, config.BAUD_RATE );
  
  // Connect to Gamepad
  if( !config.DEBUG_MODE ) {
    io = ControllIO.getInstance( this );
    device = io.getDevice( config.GAMEPAD );
    xbox = new XboxController();
  }
  
  // GUI Elements
  armDisplay = new ArmDisplay( width*45/64, height*11/32, 480, 384 );
  driveDisplay = new DriveDisplay( width*45/64, height*27/32, 480, 160 );
  dataDisplay = new DataDisplay( width*7/32, height*20/32, 350, 448 );
  
  // Threads
  control = new ControlThread( "control", 10 );
  control.start();
  
  communication = new CommunicationThread( "communication", 10 );
  communication.start();
  
}

void draw() {
  render();
}

void render() {
  renderBackground();
  renderTitle();
  armDisplay.render();
  driveDisplay.render();
  dataDisplay.render();
}

void renderTitle() {
  textFont( titleFont );
  textAlign( LEFT, CENTER );
  fill( #868686 );
  text( "g.arm", width/16, height/16 );
  fill( #434343 );
  textFont( subTitleFont );
  text( "Rover Controller Application", width/16 + 45, height/16 + 48 );
}

void renderBackground() {
  background( #ACACAC );
  if( config.SPECIAL_EFFECTS ) generateParticles();
}

void keyPressed() {
  switch( key ) {
    case 'w':
      driveDisplay.value1 = constrain( driveDisplay.value1 - 0.2, -1, 1 );
    break;
    case 'a':
      driveDisplay.value0 = constrain( driveDisplay.value0 - 0.2, -1, 1 );
    break;
    case 's':
      driveDisplay.value1 = constrain( driveDisplay.value1 + 0.2, -1, 1 );
    break;
    case 'd':
      driveDisplay.value0 = constrain( driveDisplay.value0 + 0.2, -1, 1 );
    break;
    case 'r':
      armDisplay.rotatorAngle += 100;
    break;
    case 'f':
      armDisplay.rotatorAngle -= 100;
    break;
    case ' ':
      communication.serialActive = !communication.serialActive;
    break;
  }
}
