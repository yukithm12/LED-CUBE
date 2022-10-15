//簡易的な物理エンジンであり，重力の値や重力を与えるオブジェクトをポップさせるクラスをもつ

class ForceMode{
  ArrayList<Particle> particles; //力を適応する対象の粒子の動的配列
  PVector gravity; //重力
  PVector location_ground; //led-cubeの基準点
  float space;
  float timeline; //時間の経過を管理する変数(未使用)
  
  ForceMode(PVector location_ground,float space){
    particles = new ArrayList<Particle>();
    this.location_ground = new PVector(location_ground.x,location_ground.y,location_ground.z);
    this.space = space;
    
    gravity = new PVector(0,0.5,0);
    timeline = 0;
  }
  
  void run(){
     for(int i=particles.size()-1; i>=0; i--){
       particles.get(i).applyForce(gravity);
       Particle p = particles.get(i);
       p.run();
       if(p._isDead()){
         particles.remove(i);
       }
     }
  }
  
  void addParticle(){ //追加したいオブジェクト生成クラスを記述
    parabola();
  }
  
  //噴水のような動きを各粒子に与えるメゾット
  void parabola(){
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
}
