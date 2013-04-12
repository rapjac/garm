import processing.video.*;
import processing.serial.*;
import procontroll.*;
import net.java.games.input.*;
import java.awt.event.*;

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

Capture camera;

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
  armDisplay = new ArmDisplay( width*45/64, height*11/32, width/2, height*3/5 );
  driveDisplay = new DriveDisplay( width*45/64, height*27/32, width/2, height/4 );
  dataDisplay = new DataDisplay( width*7/32, height*20/32, width*9/25, height*7/10 );
  
  // Threads
  control = new ControlThread( "control", 10 );
  control.start();
  
  communication = new CommunicationThread( "communication", 10 );
  communication.start();
  
  camera = new Capture( this, Capture.list()[1] );
  camera.start();
  background( #ACACAC );
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
  text( "g.arm", width/8, height*3/32 );
  fill( #434343 );
  textFont( subTitleFont );
  text( "Rover Controller Application", width/8 + config.WINDOW_WIDTH/21, height*3/32 + config.WINDOW_HEIGHT/13 );
}

void renderBackground() {
  background( #ACACAC );
  if( config.SPECIAL_EFFECTS ) generateParticles();
}

void keyPressed() {
  switch( key ) {
    case '1':
      armDisplay.setAction(1);
    break;
    case '2':
      armDisplay.setAction(2);
    break;
    case '3':
      armDisplay.setAction(3);
    break;
    case '4':
      armDisplay.setAction(4);
    break;
    case ' ':
      control.armControlMode = !control.armControlMode;
    break;
  }
}

void keyReleased() {
  switch( key ) {
    case '1':
      armDisplay.setAction(0);
    break;
    case '2':
      armDisplay.setAction(0);
    break;
    case '3':
      armDisplay.setAction(0);
    break;
    case '4':
      armDisplay.setAction(0);
    break;
  }
}
