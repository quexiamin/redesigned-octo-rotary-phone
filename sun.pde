int num = 45; // 线条数量
float[] y = new float[num]; // 线条的纵坐标
float sunY; // 太阳的纵坐标
float mountainSpeed = 1; // 山脉运动的速度

void setup() {
  size(900, 600);
  surface.setLocation(987, 70);

  for (int n = 0; n < num; n++) {
    y[n] = height / num * n;
  }
  
  sunY = height * 2/3; // 太阳的初始位置
}

void draw() {
  background(#a6c0fe); // 天空颜色

  // 绘制太阳
  fill(#FF5050); // 
  noStroke();
  ellipse(width / 2, sunY, 100, 100); // 太阳的位置和大小
  
  // 绘制运动的线条
  for (int n = 0; n < num; n++) {
    float alpha = map(y[n], 100, height, 0, 200); // 线的透明度
    stroke(#fda085, alpha); // 线的颜色和透明度
    strokeWeight(40);
    line(0, y[n], width, y[n]);
    y[n] += 2; // 线的速度
    if (y[n] > height) y[n] = 0; // 线超过画布高度时重置到顶部
  }
  
    // 绘制运动的山脉
  fill(#4466a4); // 山脉的颜色
  noStroke();

  for (int x = 0; x < width; x += mountainSpeed) {
    float mountainTop = noise(x * 0.02, frameCount * 0.05) * (height/2 ); // 使用噪声生成山脉的高度
    triangle(x, height, x + mountainSpeed, height, x + mountainSpeed / 2, height - mountainTop); // 绘制三角形表示山脉的轮廓
  }
  
  
  sunY -= 1; // 太阳上升的速度
  if (sunY < -100) {
    sunY = height + 100; // 太阳下降到一定位置时，重新回到画布的底部
  }
  
  saveFrame("frames01/###.png");
}
