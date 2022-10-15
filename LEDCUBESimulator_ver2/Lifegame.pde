//ライフゲームのような動きをするようにメインクラスにあるVitrualBoxの配列の要素に変更を与えるクラス

class Lifegame{
  int[][] array_point; 
  
  Lifegame(){
    array_point = new int[3][3]; //3つの配列を用意し，その3つにそれぞれVitualBoxの要素を格納する
    
    array_point[0][0] = (int)random(5);
    array_point[0][1] = (int)random(5);
    array_point[0][2] = (int)random(5);
    for(int i=1; i<3; i++){ //初期化
      for(int j=0; j<3; j++){
        if(random(1)>0.5){
          array_point[i][j] = array_point[i-1][j]-1;
        }
        else{
          array_point[i][j] = array_point[i-1][j]+1;
        }
        
        if(array_point[i][j]<0){
         array_point[i][j] = 0;
       }
       else if(array_point[i][j]>4){
         array_point[i][j] = 4;
       }
      }
    }
  }
  
  void update(){
      int n = (int)random(3); 
      int p1,p2;
      p1 = 0;
      p2 = 0;
      if(n==0){
        p1 = 1;
        p2 = 2;
      }
      else if(n==1){
        p1 = 0;
        p2 = 2;
      }
      else if(n==2){
        p1 = 0;
        p2 = 1;
      }
      
      float p = random(1);
     if(p>0.75){
       array_point[n][0] = array_point[p1][0]-1;
     }
     else if(p<=0.75 && p>0.5){
       array_point[n][0] = array_point[p1][0]+1;
     }
     else if(p<=0.5 && p>0.25){
       array_point[n][0] = array_point[p2][0]-1;
     }
     else{
       array_point[n][0] = array_point[p2][0]+1;
     }
     
     p = random(1);
     if(p>0.75){
       array_point[n][1] = array_point[p1][1]-1;
     }
     else if(p<=0.75 && p>0.5){
       array_point[n][1] = array_point[p1][1]+1;
     }
     else if(p<=0.5 && p>0.25){
       array_point[n][1] = array_point[p2][1]-1;
     }
     else{
       array_point[n][1] = array_point[p2][1]+1;
     }
     
     p = random(1);
     if(p>0.75){
       array_point[n][2] = array_point[p1][2]-1;
     }
     else if(p<=0.75 && p>0.5){
       array_point[n][2] = array_point[p1][2]+1;
     }
     else if(p<=0.5 && p>0.25){
       array_point[n][2] = array_point[p2][2]-1;
     }
     else{
       array_point[n][2] = array_point[p2][2]+1;
     }
     
     for(int i=0; i<3; i++){
       if(array_point[n][i]<0){
         array_point[n][i] = 0;
       }
       else if(array_point[n][i]>4){
         array_point[n][i] = 4;
       }
     }
  }
}
