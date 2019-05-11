float phase = 0.0;
Walker [] movers;
float[] speed = {0.01, 0.018, 0.012};
int currentMover;
int counter;
int interval = 300;
String[] labels = {"Walk", "Run", "Silly walk"};

PGraphics buttonPanel;

void setup() {
  size(500, 500);
  movers = new Walker[3];
  movers[0] = new Walker(400);
  movers[1] = new Runner(400);
  movers[2] = new SillyWalker(400);
  currentMover = 0;
  buttonPanel = createGraphics(120, 110);
  drawButtonPanel(buttonPanel, currentMover);
  frameRate(60);
  counter = interval;
}

void draw() {
  Walker mover;

  counter--;
  if (counter < 0) {
    counter = interval;
    currentMover++;
    if (currentMover >= movers.length) {
      currentMover = 0;
    }
    drawButtonPanel(buttonPanel, currentMover);
  }

  background(0);
  stroke(255);
  strokeWeight(5);

  phase += speed[currentMover];
  mover = movers[currentMover];
  mover.update(phase);

  pushMatrix();
  translate(width / 2, height - 20);

  // left side of the body
  line(mover.shoulder.x, mover.shoulder.y, mover.arms[0][0].x, mover.arms[0][0].y);
  line(mover.arms[0][0].x, mover.arms[0][0].y, mover.arms[0][1].x, mover.arms[0][1].y);
  line(mover.waist.x, mover.waist.y, mover.legs[0][0].x, mover.legs[0][0].y);
  line(mover.legs[0][0].x, mover.legs[0][0].y, mover.legs[0][1].x, mover.legs[0][1].y);

  // trunk of the body
  ellipse(mover.head.x, mover.head.y, 50, 50);
  line(mover.head.x, mover.head.y, mover.shoulder.x, mover.shoulder.y);
  line(mover.shoulder.x, mover.shoulder.y, mover.waist.x, mover.waist.y);

  // right side of the body
  line(mover.shoulder.x, mover.shoulder.y, mover.arms[1][0].x, mover.arms[1][0].y);
  line(mover.arms[1][0].x, mover.arms[1][0].y, mover.arms[1][1].x, mover.arms[1][1].y);
  line(mover.waist.x, mover.waist.y, mover.legs[1][0].x, mover.legs[1][0].y);
  line(mover.legs[1][0].x, mover.legs[1][0].y, mover.legs[1][1].x, mover.legs[1][1].y);

  popMatrix();
  line(0, height-20, width, height-20);
  image(buttonPanel, 0, 0);
}

void drawButtonPanel(PGraphics panel, int currentMover) {
  panel.beginDraw();
  panel.background(0);
  panel.textSize(12);
  panel.stroke(255);
  for (int i=0; i<movers.length; i++) {
    if (currentMover == i) {
      panel.fill(64, 64, 255);
    } else {
      panel.fill(0);
    }
    panel.rect(10, i * 30 + 10, buttonPanel.width - 20, 30);
    panel.fill(255);
    panel.text(labels[i], 15, 30 * (i + 1));
  }
  panel.endDraw();
}
