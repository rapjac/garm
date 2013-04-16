class Arm {
  
  ArmRotator rotator;
  ArmLink[] links;
  ArmGripper gripper;
  
  int targetX = 30;
  int targetY = -45;
  
  int grip = 512;
  int rotatorAngle = 511;
  float wristAngle;
  
  
  Arm( int[] lengths ) {
    this.rotator = new ArmRotator( 1 );
    this.links = new ArmLink[3];
    this.gripper = new ArmGripper( 5 );
    for( int i = 0; i < this.links.length; i++ ) this.links[i] = new ArmLink( lengths[i], i+2 );
  }
  
  void update( int rotatorAngle, int x, int y, float wristAngle, int grip ) {
    
    wristAngle = constrain( wristAngle, -HALF_PI, HALF_PI );
    
    int a = this.links[1].length;
    int b = this.links[0].length;
    
    float c = min( sqrt(x*x+y*y), a + b );
     
    float B = acos( ( b*b - a*a - c*c ) / ( -2*a*c) );
    float C = constrain( acos( (c*c - a*a - b*b ) / (-2*a*b) ), radians(30), radians(330) );
     
    float D = atan2(y,x);
    float E = D + B + C - PI;
    
    if( !(Float.isNaN( E ) && Float.isNaN( D + B ) ) ) {
      float angle = constrain( (-( E - HALF_PI ) > 0 ? -( E - HALF_PI ) : -( E - HALF_PI ) + TWO_PI), radians(30), radians(330) );
      this.links[0].setPosition( map( constrain( degrees( angle ) - 30, 10, 195 ), 0, 300, 0, 1023 ) );
      this.links[1].setPosition( map( constrain( degrees( C)- 30, 20, 150 ), 0, 300, 0, 1023 ) );
      this.links[2].setPosition( map( degrees( wristAngle ), 150, -150, 0, 1023 ) );
    }
    
    this.rotator.setPosition( (float) rotatorAngle );
    this.gripper.setPosition( grip );   
    
  }
  
  void pose( int rotatorAngle, int link0Angle, int link1Angle, int link2Angle, int grip ) {
    
    int[] angles = { link0Angle, link1Angle, link2Angle };
    int x = 0;
    int y = 0;
    
    float anchor = 0;
    
    for( int i = 0; i < 3; i++ ) {
      float angle = -( PI/6 + map( angles[i], 0, 1023, radians(0), radians(300) ) ) + HALF_PI + anchor + i*HALF_PI;
      x += this.links[i].length*cos( angle );
      y += this.links[i].length*sin( angle );
      anchor = angle;
    }
    
    this.targetX = x;
    this.targetY = y;
    this.rotatorAngle = rotatorAngle;
    this.grip = grip;
    
  }
  
  int getTotalLength() {
    int sum = 0;
    for( int i = 0; i < this.links.length - 1; i++ ) sum += links[i].length;
    return sum;
  }
  
}
