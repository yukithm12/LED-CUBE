//簡易的な物理エンジンであり，重力の値や重力を与えるオブジェクトをポップさせるクラスをもつ
class ForceMode{
  ArrayList<Particle> particles; //力を適応する対象の粒子の動的配列
  PVector gravity; //重力
  PVector antiforce;
  PVector location_ground; //led-cubeの基準点
  float space;
  float timeline; //時間の経過を管理する変数(未使用)

  boolean antiGravity_on;
  boolean _isGravity;
  float ag_p;
  
  ForceMode(PVector location_ground,float space){
    particles = new ArrayList<Particle>();
    this.location_ground = new PVector(location_ground.x,location_ground.y,location_ground.z);
    this.space = space;
    
    gravity = new PVector(0,0.5,0);
    antiforce = new PVector(0,0,0);
    timeline = 0;

    antiGravity_on = false;
    _isGravity = false;
    ag_p = 0.999;
  }
  
  void run(){
     for(int i=particles.size()-1; i>=0; i--){
       if(_isGravity==true){
         particles.get(i).applyForce(gravity);
       }
       Particle p = particles.get(i);
       p.run();
       if(p._isDead()){
         particles.remove(i);
       }
     }
  }
  
  //噴水のような動きを各粒子に与えるメゾット
  void add_parabola(){
    _isGravity=true;
    PVector[][] location_set = new PVector[5][5];
    PVector[][] velocity_set = new PVector[5][5];
    float[][] m_set = new float[5][5];
    
    for(int x=0; x<5; x++){
      for(int z=0; z<5; z++){
        location_set[x][z] = new PVector(location_ground.x+x*space+space/2,location_ground.y+space*5,location_ground.z+z*space+space/2);
        velocity_set[x][z] = new PVector(0,-15,0);
        m_set[x][z] = ((1-(abs(x-2)*0.3))+((1-abs(z-2)*0.3)))/2;
        
        particles.add(new Particle(location_set[x][z],velocity_set[x][z],m_set[x][z],location_ground,space));
      }
    }
  }

  String antiGravity(){
    _isGravity=true;
    if(antiGravity_on==false){
      gravity = new PVector(0,-0.1,0);
      antiGravity_on = true;
    }

    if(random(1)>ag_p && ag_p>=0.3){
      PVector location_set = new PVector(random(location_ground.x,location_ground.x+space*5),location_ground.y+space*5,random(location_ground.z,location_ground.z+space*5));
      PVector velocity_set = new PVector(0,0,0);

      particles.add(new Particle(location_set,velocity_set,1,location_ground,space));
    }

    gravity.add(0,-0.0005,0);
    ag_p -= 0.0003;

    if(ag_p<0.3 && !(ag_p==-1)){
      particles.clear();

      return "FINISH";
    }

    return "CONTINUE";
  }

  void rain(){
    _isGravity=true;
    if(random(1)>0.9){
      PVector location_set = new PVector(random(location_ground.x,location_ground.x+space*5),0,random(location_ground.z,location_ground.z+space*5));
      PVector velocity_set = new PVector(0,0,0);

      particles.add(new Particle(location_set,velocity_set,1,location_ground,space));
    } 
  }
  
  PVector antiforce_cult(PVector l){
    PVector center = new PVector(location_ground.x+space*5/2,location_ground.y+space*5/2,location_ground.z+space*5/2);
    PVector f = PVector.sub(l,center);
    f.normalize();
    f.mult(7);
    
    return f;
  }
  
  void antiforce(){
    _isGravity=false;
    if(frameCount%4==0){
      PVector location_set = new PVector(random(location_ground.x+space*2,location_ground.x+space*3),random(location_ground.y+space*2,location_ground.y+space*3),random(location_ground.z+space*2,location_ground.z+space*3));
      PVector velocity_set = new PVector(0,0,0);
      particles.add(new Particle(location_set,velocity_set,1,location_ground,space));
    }
    
    for(int i=0; i<particles.size(); i++){
      PVector velocity = antiforce_cult(particles.get(i).location);
      particles.get(i).location.add(velocity);
    }
  }
}
