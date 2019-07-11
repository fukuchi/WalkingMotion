class Runner extends Walker {

  Runner(float height) {
    super(height);
    params = new float[] {
      0.08, // arm1
      0.68, 
      0.16, 
      0.15, // arm2
      0.5, 
      -HALF_PI * 0.5, 
      0.55, // leg1
      0.58, 
      -HALF_PI * 0.05, 
      0.5 - 0.288, // leg2
      0.34, 
      HALF_PI * 0.35
    };
  }

  float calcYOffset(float phase) {
    int ip = (int)(phase * 2);
    float dp = phase * 2 - ip - 0.5;
    float offset = height * (1.11 - (dp * dp) * 0.18);
    float lowest = max(legs[0][1].y, legs[1][1].y);
    if(offset > lowest) {
      return offset;
    }
    return lowest;
  }

  void setBasicPositions() {
    float angle;

    angle = 0.2;
    head.set(sin(angle) * upperBodyLength, 0);
    shoulder.set(sin(angle) * (upperBodyLength - neckLength), cos(angle) * neckLength);
    waist.set(0, cos(angle) * upperBodyLength);
  }
}
