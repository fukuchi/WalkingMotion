class WalkingMan {
  float height;
  PVector head, shoulder, waist;
  PVector[][] arms;
  PVector[][] legs;

  float neckLength = 0.13;
  float upperBodyLength = 0.52;
  float[] armLengths = {
    0.24, 0.25
  };
  float[] legLengths = {
    0.28, 0.3
  };

  float[] params = {
    0, // arm1
    0.35, 
    0, 
    -0.01, // arm2
    0.12, 
    -HALF_PI * 0.18, 
    0.58, // leg1
    0.32, 
    -HALF_PI * 0.05, 
    0.5 - 0.288, // leg2
    0.26, 
    HALF_PI * 0.27
  };

  WalkingMan(float height) {
    this.height = height;
    neckLength *= height;
    upperBodyLength *= height;

    head = new PVector();
    shoulder = new PVector();
    waist = new PVector();
    arms = new PVector[2][2];
    legs = new PVector[2][2];
    for (int i=0; i<2; i++) {
      for (int j=0; j<2; j++) {
        arms[i][j] = new PVector();
        legs[i][j] = new PVector();
      }
      armLengths[i] *= height;
      legLengths[i] *= height;
    }
    update(0.0);
  }

  float arm1(int side, float phase) {
    phase += side * 0.5 + params[0];
    return HALF_PI + sin(phase * TWO_PI) * HALF_PI * params[1] + params[2];
  }

  float arm2(int side, float phase) {
    phase += side * 0.5 + params[3];
    return sin(phase * TWO_PI) * HALF_PI * params[4] + params[5];
  }

  float leg1(int side, float phase) {
    phase += side * 0.5 + params[6];
    return HALF_PI + sin(phase * TWO_PI) * HALF_PI * params[7] + params[8];
  }

  float leg2(int side, float phase) {
    phase += side * 0.5 + params[9];
    return sin(phase * TWO_PI) * HALF_PI * params[10] + params[11];
  }

  float calcYOffset() {
    return max(legs[0][1].y, legs[1][1].y);
  }

  void setBasicPositions() {
    head.set(0, 0);
    shoulder.set(0, neckLength);
    waist.set(0, upperBodyLength);
  }

  void update(float phase) {
    float angle;

    setBasicPositions();

    for (int i=0; i<2; i++) {
      angle = arm1(i, phase);
      arms[i][0].set(cos(angle) * armLengths[0], sin(angle) * armLengths[0]);
      arms[i][0].add(shoulder);

      angle += arm2(i, phase);
      arms[i][1].set(cos(angle) * armLengths[1], sin(angle) * armLengths[1]);
      arms[i][1].add(arms[i][0]);

      angle = leg1(i, phase);
      legs[i][0].set(cos(angle) * legLengths[0], sin(angle) * legLengths[0]);
      legs[i][0].add(waist);

      angle += leg2(i, phase);
      legs[i][1].set(cos(angle) * legLengths[1], sin(angle) * legLengths[1]);
      legs[i][1].add(legs[i][0]);
    }

    float yoffset = calcYOffset();
    head.sub(0, yoffset, 0);
    shoulder.sub(0, yoffset, 0);
    waist.sub(0, yoffset, 0);
    for (int i=0; i<2; i++) {
      for (int j=0; j<2; j++) {
        arms[i][j].sub(0, yoffset, 0);
        legs[i][j].sub(0, yoffset, 0);
      }
    }
  }
}
