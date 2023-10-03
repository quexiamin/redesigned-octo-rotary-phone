int gridSize = 30;
int numCols, numRows;
int[][] colors;
float offset = 0;

void setup() {
  size(600, 600);
  numCols = width / gridSize;
  numRows = height / gridSize;
  colors = new int[numCols][numRows];

  for (int i = 0; i < numCols; i++) {
    for (int j = 0; j < numRows; j++) {
      colors[i][j] = randomColor();
    }
  }
}

void draw() {
  background(#FFFFFF);
  offset += 0.02;
  
  for (int i = 0; i < numCols; i++) {
    for (int j = 0; j < numRows; j++) {
      float x = i * gridSize + sin(offset + i) * 20;
      float y = j * gridSize + sin(offset + j) * 20;
      float size = gridSize - 10;
      
      // 绘制方块
      fill(colors[i][j]);
      noStroke();
      rect(x, y, size, size);
      
      // 绘制线条
      //strokeWeight(2);
      //stroke(25);
      //line(x, y, x + size, y);
      //line(x, y, x, y + size);
    }
  }
}

int randomColor() {
  int randomVal = int(random(4));
  
  if (randomVal == 0) {
    return color(255, 0, 0);  // 红色
  } else if (randomVal == 1) {
    return color(255, 255, 0);  // 黄色
  } else if (randomVal == 2) {
    return color(0, 0, 255);  // 蓝色
  } else {
    return color(255, 255, 0);  // 黄色
  }
}
