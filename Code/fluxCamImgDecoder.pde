float[][] points = new float[8][8];
String[] lines;
boolean grid = false;
boolean blur = false;

// add brightness

void setup()
{
  lines = loadStrings("data.txt");
  size(320,320);
}
void draw()
{
  for (int i = 0; i < 8; i++)
  {
    String[] currLine = split(lines[i]," ");
    for (int j = 0; j < 8; j++)
    {
      points[j][i] = float(currLine[j]);
    }
  }
  background(0);
  for (int i = 0; i < 8; i++)
  {
    for (int j = 0; j < 8; j++)
    {
      if (grid == false)
      {
        stroke((points[j][i]-minimum(points))/(maximum(points)-minimum(points))*255,75,256-(points[j][i]-minimum(points))/(maximum(points)-minimum(points))*255);
      }
      else
      {
        stroke(0);
      }
      fill((points[j][i]-minimum(points))/(maximum(points)-minimum(points))*255,75,256-(points[j][i]-minimum(points))/(maximum(points)-minimum(points))*255); // send data from Arduino as 0-256
      rect(j*40,i*40,40,40); 
    }
  }
  if (blur == true)
  {
    filter(BLUR,20); // change number to adjust blur
  }
}
float minimum(float[][]inputArr)
{
  float[]mins = new float[8];
  for (int i = 0; i < 8; i++)
  {
    mins[i] = min(inputArr[i]);
  }
  return min(mins);
}
float maximum(float[][]inputArr)
{
  float[]maxs = new float[8];
  for (int i = 0; i < 8; i++)
  {
    maxs[i] = max(inputArr[i]);
  }
  return max(maxs);
}
void keyPressed()
{
  if (key == 'b')
  {
    blur = !blur;
  }
  else if (key == 'g')
  {
    grid = !grid;
  }
}