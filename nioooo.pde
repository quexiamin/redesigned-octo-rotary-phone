import processing.pdf.*;
int num = 90; // 线条数量
int num1 = 8000;
float[] y = new float[num]; // 线条的纵坐标
float sunY; // 太阳的纵坐标
int t=0;
float mountainSpeed = 1; // 山脉运动的速度
Curve[] curves;

boolean savePDF;

void setup() {
  size(900, 300);
  //surface.setLocation(98, 70);
  //colorMode(HSB, 360, 100, 100);

  curves = new Curve[num];

  for (int i=0; i<curves.length; i++) {
    PVector fP = new PVector(i, 0);
    curves[i] = new Curve(fP);
    float ph = noise(i*0.01)*TWO_PI;
    curves[i].phase = ph;
  }

  for (int n = 0; n < num; n++) {
    y[n] = height / num * n;
  }
  
  sunY = height * 2/5; // 太阳的初始位置
}

void sunSettingt(){
  colorMode ( HSB, 150);
  color c1= color (#FF5050);
  color c2= color (#F5A119);
  float maxr =500;
  for ( int r =0; r < maxr; r ++) {
    float n = map ( r, 0, maxr, 0, 1);
    color newc = lerpColor(c1, c2, n);
    pushMatrix();
    strokeWeight(2);
    stroke ( newc );
    noFill();
    ellipse (width / 2, sunY,r/5, r/5);
    popMatrix();
  }
}

void draw() {
  background(#9BC5D8); // 天空颜色

  // 绘制运动的线条
  for (int n = 0; n < num; n++) {
    float alpha = map(y[n], 100, height, 0, 20); // 线的透明度
    stroke(#6FA5FA, alpha); // 线的颜色和透明度
    strokeWeight(40);
    line(0, y[n], width, y[n]);
    y[n] += 2; // 线的速度
    if (y[n] > height) y[n] = 0; // 线超过画布高度时重置到顶部
  }
  
  // 绘制运动的山脉

    for (int i=1; i<curves.length; i++) {
    float xNow = curves[i].cvt.get(curves[i].cvt.size()-1).x;
    float xPre = xNow += noise(i*.05, t*.01)-0.48/10;
    PVector cv = new PVector(xPre, t);
    curves[i].cvt.add(cv);
  }
    fill(#3D637C); // 山脉的颜色
    noStroke();
   for (int x = 0; x < width; x += mountainSpeed) {
     float mountainTop = noise(x * 0.02, frameCount * 0.05) * (height/2 ); // 使用噪声生成山脉的高度
     triangle(x, height, x + mountainSpeed, height, x + mountainSpeed / 2, height - mountainTop); // 绘制三角形表示山脉的轮廓
  }
   
   sunSettingt();
   
  sunY -= 1; // 太阳上升的速度
  if (sunY < -100) {
    sunY = height * 2/5 ; // 太阳下降到一定位置时，重新回到画布的底部
  }
  
  //saveFrame("frames01/###.png");
  t++;

  if (savePDF) {
    beginRecord(PDF, "curves.pdf");
  }

  for (Curve c : curves) {
    c.drawCurve();
  }

  if (savePDF) {
    endRecord();
    savePDF = false;
  }
}

void keyPressed() {
  if (key == 'p') savePDF=true;
}



class Curve {
  ArrayList<PVector> cvt;//curve
  float phase;

  Curve(PVector cv) {//构造函数
    cvt = new ArrayList<PVector>();
    //PVector tcv = new PVector(random(width), 0);
    cvt.add(cv);
    //phase = random(TWO_PI);
  }

  void drawCurve() {
    noFill();
    //stroke(0, 24);
    strokeWeight(1);
    beginShape();
    for (int i = 1; i < cvt.size(); i++) {
      float ang = TWO_PI/num1;

      //float h = 260/2 + 180 *sin(phase+ang*i);
      //stroke(h, 100, 100, 24);
      stroke(#44A3F0,50);
      line(cvt.get(i-1).y, cvt.get(i-1).x, cvt.get(i).y, cvt.get(i).x);
    }
    endShape();
  }
}
