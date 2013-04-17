class Arm {
  
  ArmRotator rotator;
  ArmLink[] links;
  ArmGripper gripper;
  
  int targetX = 0;
  int targetY = 0;
  
  int grip = 512;
  int wristAngle = 512;
  int rotatorAngle = 512;
  
  Arm( int[] lengths ) {
    this.rotator = new ArmRotator( 1 );
    this.links = new ArmLink[3];
    this.gripper = new ArmGripper( 5 );
    for( int i = 0; i < this.links.length; i++ ) this.links[i] = new ArmLink( lengths[i], i+2 );
    pose( 512, 670, 40, 512, 512 );
  }
  
  void update( int rotatorAngle, int x, int y, int wristAngle, int grip ) {
    
    int a = this.links[1].length;
    int b = this.links[0].length;
    
    float c = min( sqrt(x*x+y*y), a + b );
     
    float B = acos( ( b*b - a*a - c*c ) / ( -2*a*c) );
    float C = constrain( acos( (c*c - a*a - b*b ) / (-2*a*b) ), radians(30), radians(330) );
     
    float D = atan2(y,x);
    float E = D + B + C - PI;
    
    if( !(Float.isNaN( E ) && Float.isNaN( D + B ) ) ) {
      float angle = constrain( (-( E - HALF_PI ) > 0 ? -( E - HALF_PI ) : -( E - HALF_PI ) + TWO_PI), radians(30), radians(330) );
      this.links[0].setPosition( map( degrees( angle ) - 30, 0, 300, 0, 1023 ) );
      this.links[1].setPosition( map( degrees( C )- 30, 0, 300, 0, 1023 ) );
    }
    
    this.links[2].setPosition( wristAngle );
    this.rotator.setPosition( (float) rotatorAngle );
    this.gripper.setPosition( grip );
    
  }
  
  void pose( int rotatorAngle, int link0Angle, int link1Angle, int link2Angle, int grip ) {
    
    int[] angles = { link0Angle, link1Angle, link2Angle };
    int x = 0;
    int y = 0;
    
    float anchor = 0;
    
    for( int i = 0; i < 2; i++ ) {
      float angle = -( PI/6 + map( angles[i], 0, 1023, radians(0), radians(300) ) ) + HALF_PI + anchor + i*HALF_PI;
      x += this.links[i].length*cos( angle );
      y += this.links[i].length*sin( angle );
      anchor = angle;
    }
    
    this.targetX = x;
    this.targetY = y;
    this.rotatorAngle = rotatorAngle;
    this.wristAngle = link2Angle;
    this.grip = grip;
    
  }
  
  void setPose( int pose ) {
    switch( pose ) {
      case 1:
        pose( 512, 80, 375, 770, 512 );
      break;
      case 2:
        
      break;
      case 3:
      
      break;
      case 4:
        pose( 512, 670, 40, 512, 512 );
      break;
    }
  }
  
  int getTotalLength() {
    int sum = 0;
    for( int i = 0; i < this.links.length - 1; i++ ) sum += links[i].length;
    return sum;
  }
  
}
