class food{
  int x, y;
  
  public food(int x, int y){
    this.x = x;
    this.y = y;
  }

  void drawFood(){
    fill(255);
    ellipse(x, y, 10, 10);
  }
}
