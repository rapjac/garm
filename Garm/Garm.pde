import processing.video.*;
import processing.serial.*;
import procontroll.*;
import net.java.games.input.*;
import java.awt.event.*;

Configuration config;

Arm arm;
Drive drive;

ArmDisplay armDisplay;
DriveDisplay driveDisplay;
DataDisplay dataDisplay;

ControlThread control;
CommunicationThread communication;

Serial xbee;

ControllIO io;
ControllDevice device;
XboxController xbox;

PFont titleFont = createFont( "Impact", config.WINDOW_WIDTH/12  );
PFont subTitleFont = createFont( "Georgia", config.WINDOW_WIDTH/60 );
PFont displayFont = createFont( "Courier New", config.WINDOW_WIDTH/60 );

void setup() {
  // Configuration Settings
  config = new Configuration();
  
  // Set Windows Size
  size( config.WINDOW_WIDTH, config.WINDOW_HEIGHT );
  
  // Establish XBee Wireless Serial Communication
  xbee = new Serial( this, config.COM_PORT, config.BAUD_RATE );
  
  // Connect to Gamepad
  if( !config.DEBUG_MODE ) {
    io = ControllIO.getInstance( this );
    device = io.getDevice( config.GAMEPAD );
    xbox = new XboxController();
  }
  
  // GUI Elements
  armDisplay = new ArmDisplay( width*45/64, height/2, width/2, width/8*3 );
  driveDisplay = new DriveDisplay( width*7/32, height*21/32, width*9/25, height*33/64 );
  
  // Models
  int[] lengths = { armDisplay.width/9, armDisplay.width/8, armDisplay.width/13 };
  arm = new Arm( lengths );
  drive = new Drive();
  
  // Threads
  control = new ControlThread( "control", 10 );
  control.start();
  
  communication = new CommunicationThread( "communication", 5 );
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
  
}

void renderTitle() {
  textFont( titleFont );
  textAlign( LEFT, CENTER );
  fill( #868686 );
  text( "g.arm", width/8, height/8 );
  fill( #434343 );
  textFont( subTitleFont );
  text( "Rover Controller Application", width/8 + width/21, height/4 );
}

void renderBackground() {
  background( #ACACAC );
  if( config.SPECIAL_EFFECTS ) generateParticles();
}

void keyPressed() {
  switch( key ) {
    case '1':
      arm.setPose(1);
    break;
    case '2':
      arm.setPose(2);
    break;
    case '3':
      arm.setPose(3);
    break;
    case '4':
      arm.setPose(4);
    break;
    case ' ':
      control.armControlMode = !control.armControlMode;
    break;
    case 't':
      control.test();
    break;
  }
}

void keyReleased() {
  switch( key ) {
    case '1':
      arm.setPose(0);
    break;
    case '2':
      arm.setPose(0);
    break;
    case '3':
      arm.setPose(0);
    break;
    case '4':
      arm.setPose(0);
    break;
  }
}
