class ArmDisplay {
  int width;
  int height;
  int x;
  int y;
  
  int targetX = 35;
  int targetY = -68;
  
  int startX = 0;
  int startY = 0;
  
  int grip = 1024;
  int rotatorAngle = 511;
  float wristAngle;
  
  Arm arm;
  
  ArmDisplay( int x, int y, int width, int height ) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    this.startX = this.x - this.width/2;
    this.startY = this.y - this.height/2;
    
    int[] lengths = { 70, 80, 50 };
    this.arm = new Arm( lengths );
  }
  
  void render() {
    drawWindow();
    drawArm();
    drawRotator();
  }
  
  void drawArm() {
    int x = this.startX + width/2;
    int y = this.startY + height/2;
    for( int i = 0; i < 3; i++ ){
      int dx = x + this.arm.links[i].x;
      int dy = y + this.arm.links[i].y;
      stroke( #232323 );
      strokeWeight( 20 );
      line( x, y, dx, dy );
      stroke( #121212 );
      strokeWeight( 8 );
      fill( #00AC00 );
      ellipse( x, y, 32, 32 );   
      strokeWeight( 10 );
      line( x, y, dx, dy );
      noStroke();
      fill( #121212 );
      ellipse( x, y, 16, 16 );
      x = dx;
      y = dy;
    }
    
    int dist = (int) map( this.arm.gripper.grip, 0, 1023, 2, 30 );
    float angle = this.arm.links[2].angle;
    float gripperTopX = x + dist/2*cos(angle + HALF_PI);
    float gripperTopY = y + dist/2*sin(angle + HALF_PI);
    float gripperBottomX = x - dist/2*cos(angle + HALF_PI);
    float gripperBottomY = y - dist/2*sin(angle + HALF_PI);
    
    noStroke();
    fill(#121212);
    quad(
      gripperTopX - 10*cos(angle),
      gripperTopY - 10*sin(angle),
      gripperTopX + 40*cos(angle),
      gripperTopY + 40*sin(angle),
      gripperTopX + 40*cos(angle) + 5*cos(angle + HALF_PI),
      gripperTopY + 40*sin(angle) + 5*sin(angle + HALF_PI),
      gripperTopX + 15*cos(angle + HALF_PI),
      gripperTopY + 15*sin(angle + HALF_PI)
    );
    quad(
      gripperBottomX - 10*cos(angle),
      gripperBottomY - 10*sin(angle),
      gripperBottomX + 40*cos(angle),
      gripperBottomY + 40*sin(angle),
      gripperBottomX + 40*cos(angle) - 5*cos(angle + HALF_PI),
      gripperBottomY + 40*sin(angle) - 5*sin(angle + HALF_PI),
      gripperBottomX - 15*cos(angle + HALF_PI),
      gripperBottomY - 15*sin(angle + HALF_PI)
    );
    
    stroke( #121212 );
    strokeWeight( 8 );
    fill( #00AC00 );
    ellipse( x, y, 32, 32 );   
    noStroke();
    fill( #121212 );
    ellipse( x, y, 16, 16 );
    
  }
  
  void drawRotator() {
    float angle = PI/6 + map( arm.rotator.servoValue, 0, 1024, radians(0), radians(300) );
    stroke( #121212 );
    strokeWeight( 8 );
    fill( #00AC00 );
    ellipse( this.startX + this.width/6, this.startY + this.height/6, 32, 32 );   
    strokeWeight( 10 );
    line( this.startX + this.width/6, this.startY + this.height/6, this.startX + this.width/6 + 50*cos(-angle+ HALF_PI), this.startY + this.height/6 + 50*sin(-angle+HALF_PI) );
    noStroke();
    fill( #121212 );
    ellipse( this.startX + this.width/6, this.startY + this.height/6, 16, 16 );
  }
  
  void drawWindow() {
    
    rectMode( CORNER );
    stroke( #121212 );
    strokeWeight(5);
    fill( #909090 );
    rect( this.startX, this.startY, this.width, this.height, 20 );
  
  }
  
}
