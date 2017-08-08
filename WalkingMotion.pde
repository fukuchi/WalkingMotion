float phase = 0.0;
WalkingMan[] men;
float[] speed = {0.01, 0.018};
int currentMan;
int counter;
int interval = 300;

PGraphics buttonPanel;

void setup() {
  size(500, 500);
  men = new WalkingMan[2];
  men[0] = new WalkingMan(400);
  men[1] = new RunningMan(400);
  currentMan = 0;
  buttonPanel = createGraphics(60, 100);
  drawButtonPanel(buttonPanel, currentMan);
  frameRate(60);
  counter = interval;
}

void draw() {
  WalkingMan man;

  counter--;
  if (counter < 0) {
    counter = interval;
    currentMan ^= 1;
    drawButtonPanel(buttonPanel, currentMan);
  }

  background(0);
  stroke(255);
  strokeWeight(5);

  phase += speed[currentMan];
  man = men[currentMan];
  man.update(phase);

  pushMatrix();
  translate(width / 2, height - 20);

  // left side of the body
  line(man.shoulder.x, man.shoulder.y, man.arms[0][0].x, man.arms[0][0].y);
  line(man.arms[0][0].x, man.arms[0][0].y, man.arms[0][1].x, man.arms[0][1].y);
  line(man.waist.x, man.waist.y, man.legs[0][0].x, man.legs[0][0].y);
  line(man.legs[0][0].x, man.legs[0][0].y, man.legs[0][1].x, man.legs[0][1].y);

  // trunk of the body
  ellipse(man.head.x, man.head.y, 50, 50);
  line(man.head.x, man.head.y, man.shoulder.x, man.shoulder.y);
  line(man.shoulder.x, man.shoulder.y, man.waist.x, man.waist.y);

  // right side of the body
  line(man.shoulder.x, man.shoulder.y, man.arms[1][0].x, man.arms[1][0].y);
  line(man.arms[1][0].x, man.arms[1][0].y, man.arms[1][1].x, man.arms[1][1].y);
  line(man.waist.x, man.waist.y, man.legs[1][0].x, man.legs[1][0].y);
  line(man.legs[1][0].x, man.legs[1][0].y, man.legs[1][1].x, man.legs[1][1].y);

  popMatrix();
  line(0, height-20, width, height-20);
  image(buttonPanel, 0, 0);
}

void drawButtonPanel(PGraphics panel, int currentMan) {
  panel.beginDraw();
  panel.background(0);
  panel.textSize(12);
  panel.stroke(255);
  if (currentMan == 0) {
    panel.fill(64, 64, 255);
  } else {
    panel.fill(0);
  }
  panel.rect(10, 10, buttonPanel.width - 20, 30);
  if (currentMan == 1) {
    panel.fill(64, 64, 255);
  } else {
    panel.fill(0);
  }
  panel.rect(10, 40, panel.width - 20, 30);
  panel.fill(255);
  panel.text("Walk", 15, 30);
  panel.text("Run", 15, 60);
  panel.endDraw();
}