class ArmGripper {
  int grip = 1023;
  
  ArmGripper() {
  }
  
  void update( int grip ) {
    this.grip = (int) map( constrain( grip, 0, 1023), -1, 0, 0, 1023 );
  }
}
