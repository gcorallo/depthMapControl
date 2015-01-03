/*gcrll.net
smoothstep funtion from: https://www.opengl.org/sdk/docs/man/html/smoothstep.xhtml
clamp from: https://www.opengl.org/sdk/docs/man/html/clamp.xhtml


*/
PShader depthShader;
int nparts=500;
Part[] parts=new Part[nparts];
PGraphics pg;
int WW=500;
int HH=500;
float ang=0.0;
void setup() {

  size(WW+400, HH, P3D);
  background(0, 0, 40);
  pg=createGraphics(WW, HH, P3D);
  depthShader = loadShader("frag.glsl", "vert.glsl");
  depthShader.set("farColor", 1.0, 1.0, 1.0, 1.0);
  depthShader.set("nearColor", 0.0, 0.0, 0.0, 1.0);
  controlSet();
  for (int i=0; i<nparts; i++) {
    parts[i]=new Part();
    parts[i].pos=new PVector(random(-width/2, width/2), random(-width/2, width/2), random(-width/2, width/2));
    parts[i].r=random(100, 200);
    parts[i].g=random(10, 100);
    parts[i].b=random(120, 220);
  }
}



void draw() {
  background(0, 0, 40);
  ang+=PI/400;

  depthShader.set("doble", doble);
  depthShader.set("invert", invert);

  float v1=range.getArrayValue(0);
  float v2=range.getArrayValue(1);

  float m_edge1a=map(edge1a, 0, 100, v1, v2);
  float m_edge1b=map(edge1b, 0, 100, v1, v2);
  float m_edge2a=map(edge2a, 0, 100, v1, v2);
  float m_edge2b=map(edge2b, 0, 100, v1, v2);
  depthShader.set("near", m_edge1a);
  depthShader.set("far", m_edge1b);
  depthShader.set("near2", m_edge2a);
  depthShader.set("far2", m_edge2b);

  pg.beginDraw();
  pg.shader(depthShader);
  pg.endDraw();
  drawGeom(pg);

  image(pg, 0, 0);

  float h=200;  
  
  int minX=WW;
  int maxX=width;
  float v,pv=0;
  for (int i=minX; i<maxX; i++) {
    stroke(200);
    float mm_edge1a=map(edge1a,0,100,minX,maxX);
    float mm_edge1b=map(edge1b,0,100,minX,maxX);
    float mm_edge2a=map(edge2a,0,100,minX,maxX);
    float mm_edge2b=map(edge2b,0,100,minX,maxX);
    if (doble) {
      v=smoothStep(i, mm_edge1a, mm_edge1b)*h - smoothStep(i, mm_edge2a, mm_edge2b)*h;
    } else {
      v=smoothStep(i, mm_edge1a, mm_edge1b)*h;
    }

    float c= map(v, 0, h, 0, 255);

    if (invert) {
      c=255-c;
      v=h-v;
    }
    if(i>WW){
      line(i, height/2+100-v,i-1, height/2+100-pv);
    }
    pv=v;
    point(i, height/2+100-v);
    stroke(c);
    line(i, height-20, i, height-120);
  }
  
  
  frame.setTitle(str((int)frameRate));
}




float smoothStep(float x, float edge0, float edge1) {
  float r = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
  return r * r * (3.0 - 2.0 * r);
}


float clamp(float x, float minVal, float maxVal) {
  float r=0.0;
  r = min(max(x, minVal), maxVal);
  return r;
}

void drawGeom(PGraphics temp) {
  //float z=map(mouseX,0,width,-1000,400);
  float z=-250;
  temp.beginDraw();
  temp.stroke(0);
  temp.fill(255);
  temp.lights();
  temp.background(0);
  temp.noStroke();
  temp.translate(temp.width/2, temp.height/2, z);
  temp.rotateY(ang);
  temp.rotateX(PI/2);
  for (int i=0; i<nparts; i++) {
    temp.pushMatrix();
    temp.translate(parts[i].pos.x, parts[i].pos.y, parts[i].pos.z);
    temp.fill(parts[i].r, parts[i].g, parts[i].b);
    temp.box(20);
    //temp.sphere(30);
    temp.popMatrix();
  }
  temp.box(600, 100, 100);

  temp.endDraw();
}
