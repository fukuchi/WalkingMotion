class SillyWalker extends Walker {
  SillyWalker(float height) {
    super(height);
    params = new float[] {
      0.00, // arm1
      0.01, 
      0.12, 
      -0.01, // arm2
      0.12, 
      -HALF_PI * 0.18, 
      0.4, // leg1
      0.9, 
      -HALF_PI * 0.9, 
      0.4, // leg2
      0.1, 
      HALF_PI * 0.5
    };
  }
}
