//ボールの位置，速度や反射するときの処理，その描画をもつクラス

class Ball{
  PVector location;
  PVector velocity;
  PVector start; //led-cubeのx,y,z最小値
  PVector end; //led-cubeのx,y,z最大値
  float r; //ボールの半径
  float spead; //ボールの速さ
  
  Ball(PVector start,float endx,float endy,float endz){
    r = 10;
    spead = 5;
    this.start = new PVector();
    this.start.set(start);
    end = new PVector(endx,endy,endz);
    location = new PVector(random(start.x+r,end.x-r),random(start.y+r,end.y-r),random(start.z+r,end.z-r));
    velocity = new PVector(random(-spead,spead),random(-spead,spead),random(-spead,spead));
  }
  
  void run(){
    update();
    display();
  }
  
  void update(){
    location.add(velocity);
    
    reflect();
  }
  
  //反射メゾット
  void reflect(){
    if(location.x<start.x+r || location.x>end.x-r){
      velocity.x *= -1;
    }
    if(location.y<start.y+r || location.y>end.y-r){
      velocity.y *= -1;
    }
    if(location.z<start.z+r || location.z>end.z-r){
      velocity.z *= -1;
    }
  }
  
  void display(){
    pushMatrix();
    translate(location.x,location.y,location.z);
    fill(255);
    noStroke();
    sphere(r);
    popMatrix();
  }
}
