// Pines de los botones del joystick shield
const int btnA = 2;  // Botón A
const int btnB = 3;  // Botón B
const int btnC = 4;  // Botón C
const int btnD = 5;  // Botón D

// Estados anteriores de cada botón
bool lastA = HIGH;
bool lastB = HIGH;
bool lastC = HIGH;
bool lastD = HIGH;

void setup() {
  Serial.begin(57600);  // Debe coincidir con el baudrate del receptor UART

  pinMode(btnA, INPUT_PULLUP);
  pinMode(btnB, INPUT_PULLUP);
  pinMode(btnC, INPUT_PULLUP);
  pinMode(btnD, INPUT_PULLUP);
}

void loop() {
  // Leer el estado actual de los botones
  bool currA = digitalRead(btnA);
  bool currB = digitalRead(btnB);
  bool currC = digitalRead(btnC);
  bool currD = digitalRead(btnD);

  // Botón A
  if (currA == LOW && lastA == HIGH) Serial.write(1);  // Presionado
  if (currA == HIGH && lastA == LOW) Serial.write(0);  // Soltado
  lastA = currA;

  // Botón B
  if (currB == LOW && lastB == HIGH) Serial.write(2);  
  if (currB == HIGH && lastB == LOW) Serial.write(0);  
  lastB = currB;

  // Botón C
  if (currC == LOW && lastC == HIGH) Serial.write(3);  
  if (currC == HIGH && lastC == LOW) Serial.write(0);  
  lastC = currC;

  // Botón D
  if (currD == LOW && lastD == HIGH) Serial.write(4); 
  if (currD == HIGH && lastD == LOW) Serial.write(0); 
  lastD = currD;

  delay(20);  // Tiempo de antirebote
}
