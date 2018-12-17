int num = 500;
float[][] fire = new float [num][12];

class ElementParticle {

  void update_fire(){
    for(int i=num-1; i>0; i--){
      for(int fireprop=0;fireprop<12;fireprop++){
      fire[i][fireprop]=fire[i-1][fireprop];
      }
    }
    for(int flame=0 ; flame<num ; flame++){
      if(fire[flame][0]==1){
    fire[flame][1]=fire[flame][1]+fire[flame][5]*cos(fire[flame][3]);
    fire[flame][2]=fire[flame][2]+fire[flame][5]*sin(fire[flame][3]);
      }
      fire[flame][7]+=1;
      if(fire[flame][7]>fire[flame][6]){
    fire[flame][0]=0;
      }
    }
  }
  void draw_fire(){
    for(int flame=0 ; flame<num ; flame++){
      if(fire[flame][0]==1){
    fill(fire[flame][9],fire[flame][10],fire[flame][11],180); //controls red, green, blue, opacity
    pushMatrix();
    translate(fire[flame][1],fire[flame][2]);
    rotate(fire[flame][8]);
    rect(0,0,fire[flame][4],fire[flame][4]);
    popMatrix();
      }
    }
  }
  void create_element(float locX, float locY, int r, int g, int b)
    {
      fire[0][0]=1;
      fire[0][1]=locX;
      fire[0][2]=locY;
      fire[0][3]=random(0,PI*2);//angle
      fire[0][4]=random(20,35);//size
      fire[0][5]=random(1,2);//speed
      fire[0][6]=random(5,20);//maxlife
      fire[0][7]=0;//currentlife
      fire[0][8]=random(0,TWO_PI);
      fire[0][9]=r;//red
      fire[0][10]=g;//green
      fire[0][11]=b;//blue    
  }
}
