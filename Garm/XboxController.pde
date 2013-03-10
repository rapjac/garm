ControllIO io;
ControllDevice device;

class XboxController {
  
  
  //Internal Classes
  class AnalogStick {
    ControllStick stick;
    AnalogStick( int xId, int yId ) {
      this.stick = new ControllStick( device.getSlider( xId ), device.getSlider( yId ) );
      this.stick.setTolerance( config.INPUT_TOLERANCE );
    }
    float getX() {
      return this.stick.getX();
    }
    float getY() {
      return this.stick.getY();
    }
  }
  
  class Button {
    ControllButton button;
    Button( int id ) {
      this.button = device.getButton( id );
    }
    boolean getValue() {
      return this.button.pressed();
    }
  }
  
  class Trigger {
    ControllSlider trigger;
    Trigger( int id ) {
      this.trigger = device.getSlider( id );
      this.trigger.setTolerance( config.INPUT_TOLERANCE );
    }
    float getValue() {
      return this.trigger.getValue();
    }
  }
  
  class DPad {
    ControllCoolieHat dpad;
    DPad( int id ) {
      this.dpad = device.getCoolieHat( id );
    }
    boolean getValue() {
      return this.dpad.pressed();
    }
    float getX() {
      return this.dpad.getX();
    }
    float getY() {
      return this.dpad.getY();
    }
  }
  
  AnalogStick leftStick;
  AnalogStick rightStick;
  Trigger leftTrigger;
  Trigger rightTrigger;
  Button a;
  Button b;
  Button x;
  Button y;
  Button leftBumper;
  Button rightBumper;
  Button back;
  Button start;
  Button leftClick;
  Button rightClick;
  DPad dpad;
  
  XboxController() {
    this.leftStick = new AnalogStick( 1, 0 );
    this.rightStick = new AnalogStick( 3, 2 );
    this.leftTrigger = new Trigger( 4 );
    this.rightTrigger = new Trigger( 4 );
    this.a = new Button( 0 );
    this.b = new Button( 1 );
    this.x = new Button( 2 );
    this.y = new Button( 3 );
    this.leftBumper = new Button( 4 );
    this.rightBumper = new Button( 5 );
    this.back = new Button( 6 );
    this.start = new Button( 7 );
    this.leftClick = new Button( 8 );
    this.rightClick = new Button( 9 );
    this.dpad = new DPad( 10 );
  }
  
  void print() {
    device.printButtons();
    device.printSliders();
    device.printSticks();
  }
  
}



