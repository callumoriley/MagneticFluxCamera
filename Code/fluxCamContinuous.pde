import processing.serial.*;
Serial port;
float[][] points = new float[8][8];
StringList data = new StringList();
PrintWriter output;
boolean updateImage = false;
float brightness = 1.0;

void setup()
{
  output = createWriter("data.txt");
  size(320,320);
  port = new Serial(this,"/dev/ttyUSB0",9600);
}
void draw()
{
  background(0);
  if (port.available() > 0)
  {
    String currVal = port.readStringUntil('\n');
    if (currVal != null)
    {
      data.append(currVal);
    }
    if (data.size() > 10 && updateImage == true) // seperate if statements, because the second statement will crash the program if evaluated without the first statement being true
    {
      if (data.get(data.size()-9).charAt(0) == 's')
      {
        for (int i = 0; i < 8; i++)
        {
          String[] currLine = split(data.get(data.size()-8+i)," ");
          for (int j = 0; j < 8; j++)
          {
            points[j][i] = brightness*Float.parseFloat(currLine[j]);
          }
        }
        updateImage = false;
        println("Data loaded");
      }
    }
  }
  for (int i = 0; i < 8; i++)
  {
    for (int j = 0; j < 8; j++)
    {
      fill((points[j][i]-minimum(points))/(maximum(points)-minimum(points))*255,75,256-(points[j][i]-minimum(points))/(maximum(points)-minimum(points))*255); // send data from Arduino as 0-256
      rect(j*40,i*40,40,40);
    }
  }
}
void keyPressed()
{
  if (key == 's')
  {
    for (int i = 0; i < 8; i++)
    {
      String currline = "";
      for (int j = 0; j < 8; j++)
      {
        currline += str(points[j][i]);
        currline += " ";
      }
      output.println(currline);
    }
    output.flush();
    output.close();
    exit();
  }
  else
  {
    updateImage = true;
    println("Loading data");
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