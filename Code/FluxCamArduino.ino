static const uint8_t analog_pins[] = {A0,A1,A2,A3,A4,A5,A6,A7}; // this version just keeps sending data
int delayTime = 500;

void setup() {
  Serial.begin(9600);
  //while (!Serial);
  for (int i = 2; i < 10; i++)
  {
    pinMode(i,OUTPUT);
  }
}
void loop() {
  Serial.println("s");
  for (int i = 0; i < 8; i++)
  {
    digitalWrite(i+2,HIGH);
    String printStr = "";
    for (int j = 0; j < 8 ; j++)
    {
      //printStr += (String(random(0,256))+" ");
      printStr += (String(255*(float)analogRead(analog_pins[j])/1024)+" ");
    }
    Serial.println(printStr);
    delay(delayTime);
    digitalWrite(i+2,LOW);
  }
}