//粒子の位置，速度，加速度，質量，そして力を加えるメゾットと生死判定を行うメゾットを持つクラス

class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector location_ground; led-cubeの基準点
  float space;
  float r; //粒子の半径
  float m; //質量
  
  Particle(PVector l,PVector v,float m,PVector location_ground,float space){
    r = 10;
    this.m = m;
    location = new PVector(l.x,l.y,l.z);
    velocity = new PVector(v.x,v.y,v.z);
    acceleration = new PVector(0,0,0);
    this.location_ground = new PVector(location_ground.x,location_ground.y,location_ground.z);
    this.space = space;
  }
  
  void run(){
    update();
    display();
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  void display(){
    pushMatrix();
    translate(location.x,location.y,location.z);
    fill(255);
    noStroke();
    sphere(r);
    popMatrix();
  }
  
  //力のデータが入った引数が渡され，運動方程式F=maより，加速度を求めて，粒子の仮想度に加算している
  void applyForce(PVector f){
    PVector force = PVector.div(f,m);
    acceleration.add(force);
  }
  
  //箱の底辺より下に粒子の位置が来たら粒子が死ぬように，trueを返す(力を右や左，上に発生させる場合，死ぬ処理が適応されないのでオーバーフローする危険性があり注意)
  boolean _isDead(){
    if(location.y>location_ground.y+space*5){
      return true;
    }
    return false;
  }
}
