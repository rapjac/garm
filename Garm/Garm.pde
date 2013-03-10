import processing.serial.*;
import procontroll.*;
import net.java.games.input.*;

Configuration config;

XboxController xbox;

ControlThread control;
CommunicationThread communication;

ArmDisplay armDisplay;

PFont titleFont = createFont("Courier New Bold", 80);
PFont subTitleFont = createFont("Courier New", 16);

void setup() {
  
  // Set Windows Size
  size( 960, 700 );
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
    xbox.print();
    
  }
  
  // GUI Elements
  armDisplay = new ArmDisplay( width*5/8, height/2, 480, 384 );
  
  // Costruct Threads
  control = new ControlThread( "control", 10 );
  control.start();
  
  communication = new CommunicationThread( "communication", 15 );
  communication.start();
  
}

void draw() {
  render();
}

void render() {
  renderBackground();
  renderTitle();
  armDisplay.render();
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


