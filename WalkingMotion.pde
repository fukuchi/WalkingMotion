float phase = 0.0;
WalkingMan man;
void setup() {
  size(500, 500);
  man = new WalkingMan(400);
}


void draw() {
  background(0);
  stroke(255);
  strokeWeight(5);

  phase += 0.01;
  man.update(phase);

  pushMatrix();
  translate(width / 2, height);
  ellipse(man.head.x, man.head.y, 50, 50);
  line(man.head.x, man.head.y, man.shoulder.x, man.shoulder.y);
  line(man.shoulder.x, man.shoulder.y, man.waist.x, man.waist.y);
  line(man.shoulder.x, man.shoulder.y, man.arms[0][0].x, man.arms[0][0].y);
  line(man.arms[0][0].x, man.arms[0][0].y, man.arms[0][1].x, man.arms[0][1].y);
  line(man.shoulder.x, man.shoulder.y, man.arms[1][0].x, man.arms[1][0].y);
  line(man.arms[1][0].x, man.arms[1][0].y, man.arms[1][1].x, man.arms[1][1].y);
  line(man.waist.x, man.waist.y, man.legs[0][0].x, man.legs[0][0].y);
  line(man.legs[0][0].x, man.legs[0][0].y, man.legs[0][1].x, man.legs[0][1].y);
  line(man.waist.x, man.waist.y, man.legs[1][0].x, man.legs[1][0].y);
  line(man.legs[1][0].x, man.legs[1][0].y, man.legs[1][1].x, man.legs[1][1].y);
  popMatrix();
}

