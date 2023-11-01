import geomerative.*;



RShape grp;
RPoint[] points;
void setup() {

  size(1000, 1000);
  frameRate(33);

  

  RG.init(this);
  
 

   grp = RG.getText("mooncake", "FreeSans.ttf", 200, CENTER);
}

void draw(){
  background(255);
  translate(width/2, height/2);

  //noStroke();
  //fill(250,100,0);
  //grp.draw();
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  float length=map(mouseX,0,width,10,200);
  RG.setPolygonizerLength(length);
  //drawCurve();
  drawBrush();
}
void drawBrush(){
 for(int i=0;i<grp.countChildren();i++){
    points=grp.children[i].getPoints();
    if(points!=null){
      noStroke();
      fill(#FFC246);
      strokeWeight(2);
      beginShape();
      for(int j=0; j<points.length; j++){
        curveVertex(points[j].x, points[j].y);
    }
    endShape();
    }
  }
}

//void drawCurve(){
//  for(int i=0;i<grp.countChildren();i++){
//    points=grp.children[i].getPoints();
//    if(points!=null){
//      noFill();
//      stroke(#FF8C0F);
//      strokeWeight(2);
//      beginShape();
//      for(int j=0; j<points.length; j++){
//        curveVertex(points[j].x, points[j].y);
//    }
//    endShape();
//    }
//  }

//void drawLine(){
// points = grp.getPoints();
  
//  if(points != null){
  
//  }
//}
