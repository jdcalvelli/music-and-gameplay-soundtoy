// initialize input pins consts
#define TOUCHPAD_1_PIN 4

// initialize temporary output pins consts
#define BUILT_IN_LED_PIN 13

void setup() {
  //activate touchpad_1_pin as input
  pinMode(TOUCHPAD_1_PIN, INPUT_PULLUP);
  
  //activate built_in_led_pin as output
  pinMode(13, OUTPUT);
  //write starting value of LOW to pin
  digitalWrite(13, LOW);

  //set up serial polling for debugging
  Serial.begin(9600);
}

void loop() {
  //set value to be the result of reading input from touchpad_1_pin
  int value = digitalRead(TOUCHPAD_1_PIN);
  //debug to make sure digital input is working
  Serial.print(value);
  
  //write the result of the digital read (high or low) to the built_in_led_pin
  digitalWrite(BUILT_IN_LED_PIN, value);

  //pause loop execution for 1 millisecond
  delay(10);
}

// current issues
// ISSUE 1:
// pressing all four touchpads at once seems to break it
// it seems like something hardware side, not sure what yet, might just be a limitation
// of the sensor i have
// ISSUE 2:
// need to hook up to oscuino to be able to communicate with sonic pi