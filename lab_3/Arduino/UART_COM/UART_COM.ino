// Pines de los botones del joystick shield
const int btnA = 2;  // Botón A
const int btnB = 3;  // Botón B

// Estados anteriores de cada botón
bool lastA = HIGH;
bool lastB = HIGH;

void setup() {
  // Inicializacion de comunicacion serial
  Serial.begin(57600);  
  // Configurar pines de los botones
  pinMode(btnA, INPUT_PULLUP);
  pinMode(btnB, INPUT_PULLUP);
}

void loop() {
  // Leer el estado actual de los botones
  bool currA = digitalRead(btnA);
  bool currB = digitalRead(btnB);

  // Botón A
  if (currA == LOW && lastA == HIGH) Serial.write(1);  // Presionado
  if (currA == HIGH && lastA == LOW) Serial.write(0);  // Soltado
  lastA = currA;

  // Botón B
  if (currB == LOW && lastB == HIGH) Serial.write(2);  
  if (currB == HIGH && lastB == LOW) Serial.write(0);  
  lastB = currB;

  delay(20);  // Tiempo de antirebote
}
