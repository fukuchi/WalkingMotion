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

  WalkingMan(float height) {
    this.height = height;
    neckLength *= height;
    upperBodyLength *= height;

    head = new PVector(0, 0);
    shoulder = new PVector(0, 0);
    waist = new PVector(0, 0);
    arms = new PVector[2][2];
    legs = new PVector[2][2];
    for (int i=0; i<2; i++) {
      for (int j=0; j<2; j++) {
        arms[i][j] = new PVector(0, 0);
        legs[i][j] = new PVector(0, 0);
      }
      armLengths[i] *= height;
      legLengths[i] *= height;
    }
    update(0.0);
  }

  float arm1(int side, float phase) {
    phase += side * 0.5;
    return HALF_PI + sin(phase * TWO_PI) * HALF_PI / 3;
  }

  float arm2(int side, float phase) {
    phase += side * 0.5 - 0.01;
    return (sin(phase * TWO_PI) - 1) * HALF_PI * 0.1;
  }

  float leg1(int side, float phase) {
    phase += side * 0.5 + 0.08;
    return HALF_PI + sin(phase * TWO_PI) * HALF_PI * 0.3 - HALF_PI / 15;
  }

  float leg2(int side, float phase) {
    phase += side * 0.5 - 0.29;
    return sin(phase * TWO_PI) * HALF_PI * 0.25 + HALF_PI / 4;
  }

  void update(float phase) {
    float angle;

    head.set(0, 0);
    shoulder.set(0, neckLength);
    waist.set(0, upperBodyLength);

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

    float ymax = max(legs[0][1].y, legs[1][1].y);
    head.sub(0, ymax, 0);
    shoulder.sub(0, ymax, 0);
    waist.sub(0, ymax, 0);
    for (int i=0; i<2; i++) {
      for (int j=0; j<2; j++) {
        arms[i][j].sub(0, ymax, 0);
        legs[i][j].sub(0, ymax, 0);
      }
    }
  }
}
