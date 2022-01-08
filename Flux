

// Created by RadBench: youtube.com/radbenchyt
// Enhanced by Starbuxed
// Made for A flux Capacitor with a 10 light NanoLed strip

// DFPlayer Stuff
#include "Arduino.h"
#include "SoftwareSerial.h"
#include "DFPlayerMini_Fast.h"

SoftwareSerial mySoftwareSerial(10, 11); // RX, TX
DFPlayerMini_Fast myMP3;


void printDetail(uint8_t type, int value);


///////////////////////////////////////////////////////////////////////////////////////////


//IR

uint32_t Previous;
#include <IRremote.h>
int receiver = 3; // initialize pin 3 as the receiver pin
IRrecv irrecv(receiver); //Create new instance of receiver
decode_results results;

//Remote

#define button_0 0xFF6897
#define button_1 0xFF30CF
#define button_2 0xFF18E7
#define button_3 0xFF7A85
#define button_4 0xFF10EF
#define button_5 0xFF38C7
#define button_6 0xFF5AA5
#define button_7 0xFF42BD
#define button_8 0xFF4AB5
#define button_9 0xFF52AD
#define buttonStop 0xFFE21D
#define volUp 0xFF629D
#define volDwn 0xFFA857
#define btnUp 0xFF906F 
#define btnDown 0xFFE01F
#define powerButton 0xFFA25D





///////////////////////////////////////////////////////////////////////////////////////////

// LEDS

uint8_t hue = 0;

#include <FastLED.h>
#define NUM_LEDS 22


#define DATA_PIN 5
#define CLOCK_PIN 13
#define ledColor Yellow
int delaySpeed = 80;
const unsigned long eventInterval = 1000;
unsigned long previousTime = 0;

   int timeTravel;
  int smoothChase;
  int movieChase;
  int movieSpeed = 34.45;
  int movieChaseSimple;
  int thirtyChase;
  int radChase;
  int radChase2;
  int rainbowChase;
  int flash;

// This is an array of leds.  One item for each led in your strip.
CRGB leds[NUM_LEDS];




///////////////////////////////////////////////////////////////////////////////////////////


void setup() {


  // Single LED
  pinMode(12, OUTPUT);

  // DFPlayer Setup
  mySoftwareSerial.begin(9600);
  Serial.begin(115200);

  Serial.println();
  Serial.println(F("DFRobot DFPlayer Mini Demo"));
  Serial.println(F("Initializing DFPlayer ... (May take 3~5 seconds)"));

  if (!myMP3.begin(mySoftwareSerial)) {  //Use softwareSerial to communicate with mp3.
    Serial.println(F("Unable to begin:"));
    Serial.println(F("1.Please recheck the connection!"));
    Serial.println(F("2.Please insert the SD card!"));
    while (true);
  }
  Serial.println(F("DFPlayer Mini online."));

  myMP3.volume(29);  //Set volume value. From 0 to 30
  
  // STARTUP SOUND AND CHASE
  delay(600);
  myMP3.playFromMP3Folder(1);  //Play mp3 
  delay(600);
  radChase2 = 1;

  // End DFPLayer Setup

  // IR setup
  //Serial.begin(9600);
  irrecv.enableIRIn(); //Start the receiver

  // LED Setup ///////////////////////////////////////////////////////

  FastLED.addLeds<WS2812B, DATA_PIN, GRB>(leds, NUM_LEDS);  // GRB ordering is typical
  FastLED.setMaxPowerInVoltsAndMilliamps(5, 500);
  FastLED.clear();
  FastLED.setCorrection(UncorrectedColor);

}

void loop() {

 
  while (!irrecv.isIdle());  // if not idle, wait till complete

  if (irrecv.decode(&results)) { // if we have received an IR Signal
    Serial.println(results.value, HEX); // display HEX results

    if (results.value == 0xFFFFFFFF) {
      results.value = Previous;
    }
    switch (results.value) {

      case button_1:
      // time travel
         // stop current audio and play audio track
        myMP3.stop();
       
        timeTravel = 1;
        smoothChase = 0;
        movieChase = 0;
        thirtyChase = 0;
        movieChaseSimple = 0;
        radChase = 0;
        radChase2 = 0;
        rainbowChase = 0;
        // set delay speed for time travel
        delaySpeed = 113;
         // play audio track 7
        myMP3.playFromMP3Folder(7); 
        Serial.println("Time travel!!!");
        break;
      case powerButton:  smoothChase = 0; timeTravel = 0;
         timeTravel = 0;
        thirtyChase = 0;
        smoothChase = 0;
        movieChase = 0;
        movieChaseSimple = 0;
        radChase = 0;
        radChase2 = 0;
        rainbowChase = 0;
        FastLED.clear();
        FastLED.show();
         myMP3.stop();
        break;
      case button_9:
        // stop current audio and play audio track
        myMP3.stop();
        myMP3.playFromMP3Folder(0006);
        
        break;
      case button_2:
      // smooth chase
      // stop current audio and play audio track
    
        myMP3.playFromMP3Folder(0003);
        timeTravel = 0;
        smoothChase = 1;
        movieChase = 0;
        movieChaseSimple = 0;
        thirtyChase = 0;
        radChase = 0;
        radChase2 = 0;
        rainbowChase = 0;
        delaySpeed = 80;
        Serial.println("button_2 Pressed. smoothChase:");
        break;
      case button_3:
      // thirty fps
      // stop current audio and play audio track
     
        myMP3.playFromMP3Folder(0004);
          //set movie speed
        movieSpeed = 33.33;
        
        timeTravel = 0;
        smoothChase = 0;
        movieChase = 0;
        movieChaseSimple = 0;
        thirtyChase = 1;
        radChase = 0;
        radChase2 = 0;
        rainbowChase = 0;
        Serial.println("button_3 Pressed. 30fps");

        break;
      case button_4:
       // 24 fps
       //imitating 6 leds from film
       // stop current audio and play audio track
        myMP3.stop();
        myMP3.playFromMP3Folder(0005);
        //set movie speed
        movieSpeed = 22.97;
        // set loop
        timeTravel = 0;
        thirtyChase = 0;
        smoothChase = 0;
        movieChase = 1;
        movieChaseSimple = 0;
        radChase = 0;
        radChase2 = 0;
        rainbowChase = 0;
        Serial.println("button_4 Pressed. Movie Chase 24fps");
        break;
      case button_5:
        //24 fps simple
        // stop current audio and play audio track
        
        myMP3.playFromMP3Folder(0003);
        //set movie speed
        movieSpeed = 34.45;
        // set loop
        timeTravel = 0;
        thirtyChase = 0;
        smoothChase = 0;
        movieChase = 0;
        movieChaseSimple = 1;
        radChase = 0;
        radChase2 = 0;
        rainbowChase = 0;
        Serial.println("button_5 Pressed. 24FPS simple");
        break;
      case button_6:
        //Rad Chase
        // stop current audio and play audio track
    
        myMP3.playFromMP3Folder(0004);
        //set movie speed
        movieSpeed = 66.66;
        // set loop
        timeTravel = 0;
        thirtyChase = 0;
        smoothChase = 0;
        movieChase = 0;
        movieChaseSimple = 0;
        radChase = 1;
        radChase2 = 0;
        rainbowChase = 0;
        Serial.println("button_6 Pressed. rad chase");
        break;
      case button_7:
        //Rad Chase
        // stop current audio and play audio track

        myMP3.playFromMP3Folder(0005);
        //set movie speed
        movieSpeed = 66.66;
        // set loop
        timeTravel = 0;
        thirtyChase = 0;
        smoothChase = 0;
        movieChase = 0;
        movieChaseSimple = 0;
        radChase = 0;
        radChase2 = 1;
        rainbowChase = 0;
        Serial.println("button_7 Pressed. rad chase2");
        break;
      case button_8:
        //Rainbow Chase
        // stop current audio and play audio track
      
        myMP3.playFromMP3Folder(0005);
        //set movie speed
        movieSpeed = 66.66;
        delaySpeed =80;
        // set loop
        timeTravel = 0;
        thirtyChase = 0;
        smoothChase = 0;
        movieChase = 0;
        movieChaseSimple = 0;
        radChase = 0;
        radChase2 = 0;         
        rainbowChase = 1;
        Serial.println("button_8 Pressed. Rainbow 1");
        break;
        // button up pressed, decrease delay timers - go faster
       case btnUp:

         if (movieSpeed > 24) {
           movieSpeed = movieSpeed - 10;
         }
         if (delaySpeed > 20) {
          delaySpeed = delaySpeed - 20;
         }
         // Smaller increments for delay speeds under 20
         if (delaySpeed <= 20 && delaySpeed > 4) {
          delaySpeed = delaySpeed - 4;
         }
        
        Serial.println("BtnUp pressed");
        Serial.println(movieSpeed);
        break;
        // button down pressed increase delays - go slower
       case btnDown:

         if (movieSpeed < 200) {
           movieSpeed = movieSpeed + 10;
         }
         if (delaySpeed < 160) {
          delaySpeed = delaySpeed + 20;
         }
        
        Serial.println("BtnDown pressed");
        Serial.println(movieSpeed);
        break;
    }
    
    while (!irrecv.isIdle());  // if not idle, wait till complete
      irrecv.resume(); // next value
    
  }



  // ----------------- SMOOTH CHASE ------------------------

  if (smoothChase == 1) {
    timeTravel = 0;

//    delaySpeed = 80;
    delay(100);

    // Move LEDS
    for (int i = 0; i < 16; i = i + 1) {

      if(i - 6 >= 0) {
        leds[i - 6] = CHSV(28, 150, 60);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
      }
      if(i - 5 >= 0) {
        leds[i - 5] = CHSV(28, 150, 100);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
      }
      if(i - 4 >= 0) {
        leds[i - 4] = CHSV(28, 150, 160);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
      }
      if(i - 3 >= 0) {
        leds[i - 3] = CHSV(28, 150, 200);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
      }
      if(i - 2 >= 0) {
        leds[i - 2] = CHSV(28, 150, 160);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
      }
      if(i - 1 >= 0) {
        leds[i - 1] = CHSV(28, 150, 100);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
      }
        leds[i] = CHSV(28, 150, 60);
        leds[10] = CRGB::Black;
        leds[11] = CRGB::Black;
        leds[12] = CRGB::Black;
        leds[13] = CRGB::Black;
        leds[14] = CRGB::Black;
        leds[15] = CRGB::Black;
        

      // Show the leds

      FastLED.show();
      
      delay(delaySpeed);
      FastLED.clear();
      FastLED.show();
      smoothChase = 1;
      timeTravel = 0;




    }

    
  }

    // ----------------- MOVIE CHASE - imitates 6 LEDs - matches 24fps speed from the movie------------------------

  if (movieChase == 1) {
    timeTravel = 0;
    smoothChase = 0;


    // Move LEDS
    for (int i = 0; i < 5; i = i + 1) {

      // LED 1
      if(i = 0) {
        leds[0] = CHSV(22, 200, 100);
        leds[1] = CHSV(22, 200, 100);
        
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      // LED 2
      if(i = 1) {
        leds[1] = CHSV(22, 200, 100);
        leds[2] = CHSV(22, 200, 100);

        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      // LED 3
      if(i = 2) {
        leds[2] = CHSV(22, 200, 100);
        leds[3] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      // LED 4
      if(i = 3) {
        leds[4] = CHSV(22, 200, 15);
        leds[5] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      // LED 5
      if(i = 4) {
        leds[6] = CHSV(22, 200, 100);
        leds[7] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      // LED 6
      if(i = 5) {
        leds[8] = CHSV(22, 200, 100);
        leds[9] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
        
      movieChase = 1;
      smoothChase = 0;
      timeTravel = 0;
    }
    
  }

  // ----------------- RAD CHASE ------------------------

  if (radChase == 1) {




    // Move LEDS
    for (int i = 0; i < 6; i = i + 1) {

      if(i = 1) {
        leds[0] = CHSV(28, 120, 100);
        leds[1] = CHSV(28, 120, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 2) {
        leds[2] = CHSV(28, 120, 100);
        leds[3] = CHSV(28, 120, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 3) {
        leds[4] = CHSV(28, 120, 100);
        leds[5] = CHSV(28, 120, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 4) {
        leds[6] = CHSV(28, 120, 100);
        leds[7] = CHSV(28, 120, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 5) {
        leds[8] = CHSV(28, 120, 100);
        leds[9] = CHSV(28, 120, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
        
      radChase = 1;

    }
    
  }




  // ----------------- MOVIE CHASE SIMPLE ------------------------

  if (movieChaseSimple == 1) {

    


    // Move LEDS
    for (int i = 0; i < 5; i = i + 1) {

      if(i = 1) {
        leds[2] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 2) {
        leds[4] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 3) {
        leds[6] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 4) {
        leds[8] = CHSV(22, 200, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
        
      movieChaseSimple = 1;

    }
    
  }

   // ----------------- THIRTY FPS CHASE - For shooting at 30fps------------------------

  if (thirtyChase == 1) {

    // Move LEDS
    for (int i = 0; i < 5; i = i + 1) {

      if(i = 1) {
        leds[0] = CHSV(32, 128, 100);
        leds[1] = CHSV(32, 128, 100);
        leds[2] = CHSV(32, 128, 25);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 2) {
        leds[2] = CHSV(32, 128, 25);
        leds[3] = CHSV(32, 128, 100);
        leds[4] = CHSV(32, 128, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 3) {
        leds[5] = CHSV(32, 128, 100);
        leds[6] = CHSV(32, 128, 100);
        leds[7] = CHSV(32, 128, 25);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
      if(i = 4) {
        leds[7] = CHSV(32, 128, 25);
        leds[8] = CHSV(32, 128, 100);
        leds[9] = CHSV(32, 128, 100);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
        
      thirtyChase = 1;

    }
    
  }


  // ----------------- TimeTravel ------------------------

  if (timeTravel == 1) {

    unsigned long currentTime = millis();


    // Move LEDS
    for (int i = 0; i < 20; i = i + 1) {

      if (i - 6 >= 0) {
        leds[i - 6] = CHSV(28, 150, 60);
      }
      if (i - 5 >= 0) {
        leds[i - 5] = CHSV(28, 150, 100);
      }
      if (i - 4 >= 0) {
        leds[i - 4] = CHSV(28, 150, 160);
      }
      if (i - 3 >= 0) {
        leds[i - 3] = CHSV(28, 150, 220);
      }
      if (i - 2 >= 0) {
        leds[i - 2] = CHSV(28, 150, 160);
      }
      if (i - 1 >= 0) {
        leds[i - 1] = CHSV(28, 150, 100);
      }
      leds[i] = CHSV(28, 200, 60);

      
      leds[10] = CRGB::Black;
      leds[11] = CRGB::Black;
      leds[12] = CRGB::Black;
      leds[13] = CRGB::Black;
      leds[14] = CRGB::Black;
      leds[15] = CRGB::Black;
      leds[16] = CRGB::Black;
      leds[17] = CRGB::Black;
      leds[18] = CRGB::Black;
      leds[19] = CRGB::Black;
      leds[20] = CRGB::Black;


      // Show the leds

      FastLED.show();

      FastLED.clear();
      timeTravel = 1;

      // Wait a little bit
      delay(delaySpeed);

    }

    // Reduce delay time so each sequence is faster than the last
    delaySpeed = delaySpeed * .837;

    if (delaySpeed < 1) {
      // leds[5] = CRGB::Black;

      previousTime = millis();

      
              if (millis() < previousTime + 4000) {
                // ZIIIP!  Moment of time travel
                
                digitalWrite(12, HIGH);
                for(int z = 0; z < 25; z++){
                for(int y = 0; y < 10; y++) {
                 
                leds[y] = CHSV(28, 150, 160);
                FastLED.show();
                
                                
                
                }
                 FastLED.clear();
                 leds[10] = CHSV(28, 150, 160);
        leds[11] = CHSV(28, 150, 160);
        leds[12] = CHSV(28, 150, 160);
        leds[13] = CHSV(28, 150, 160);
        leds[14] = CHSV(28, 150, 160);
        leds[15] = CHSV(28, 150, 160);
        leds[16] = CHSV(28, 150, 160);
        leds[17] = CHSV(28, 150, 160);
        leds[18] = CHSV(28, 150, 160);
        leds[19] = CHSV(28, 150, 160);
        leds[20] = CHSV(28, 150, 160);
                FastLED.show();
                delay(66);

                }
                
               
                FastLED.clear();
                FastLED.show();
//                for(int x = 0; x < 9; x++) {
//                leds[x] = CRGB::Black;
//                FastLED.show();
//                }
                // Single LED
                digitalWrite(12, LOW);
                // Delay after blue light
                 delay(3100);

      // First Burst
        // Single LED
      digitalWrite(12, HIGH);
      for(int y = 180; y > 20; y--){
        for (int i = 0; i < 21; i++) {
      
        leds[i] = CHSV(28, 110, y--);
       leds[10] = CHSV(28, 110, y--);
        leds[11] = CHSV(28, 110, y);
        leds[12] = CHSV(28, 110, y);
        leds[13] = CHSV(28, 110, y);
        leds[14] = CHSV(28, 110, y);
        leds[15] = CHSV(28, 110, y);
        leds[16] = CHSV(28, 110, y);
        leds[17] =  CHSV(28, 110, y);
        leds[18] =  CHSV(28, 110, y);
        leds[19] =  CHSV(28, 110, y);
        leds[20] =  CHSV(28, 110, y);
        leds[21] =  CHSV(28, 110, y);
        FastLED.show();
        
      }
     
      delay(1);}
      
      
      FastLED.clear();
      FastLED.show();
      // Single LED
      digitalWrite(12, LOW);
      delay(400);

      // Second Burst

       // Single LED
      digitalWrite(12, HIGH);
      for(int y = 180; y > 20; y--){
        for (int i = 0; i < 21; i++) {
      
        leds[i] = CHSV(28, 110, y--);
       leds[10] = CHSV(28, 110, y);
        leds[11] = CHSV(28, 110, y);
        leds[12] = CHSV(28, 110, y);
        leds[13] = CHSV(28, 110, y);
        leds[14] = CHSV(28, 110, y);
        leds[15] = CHSV(28, 110, y);
        leds[16] = CHSV(28, 110, y);
        leds[17] =  CHSV(28, 110, y);
        leds[18] =  CHSV(28, 110, y);
        leds[19] =  CHSV(28, 110, y);
        leds[20] =  CHSV(28, 110, y);
        leds[21] =  CHSV(28, 110, y);
        FastLED.show();
        
      }
     
      delay(1);}
      
      
      FastLED.clear();
      FastLED.show();
      // Single LED
      digitalWrite(12, LOW);
      delay(3800);
      delaySpeed = 80;
      timeTravel = 0;
      smoothChase = 1;
       myMP3.playFromMP3Folder(0003);
       delay(1000);
      
      //          chase();
      //          exit(0);
      //          reset();



              }

    }


  } 

  // ------------ END timeTravel --------------------

  // ----------------- RAD CHASE 2------------------------

  if (radChase2 == 1) {




    // Move LEDS
    for (int i = 0; i < 10; i = i + 1) {

      if(i < 10) {
        leds[i] = CHSV(28, 200, 120);
        leds[i - 1] = CHSV(28, 200, 30);
        leds[i + 1] = CHSV(28, 200, 30);
        FastLED.show();
        delay(movieSpeed);
        FastLED.clear();
      }
        
      radChase2 = 1;

    }
    
  }



// ----------------- RAINBOW CHASE ------------------------

 // if (rainbowChase == 1) {
    //  for (int i = 0; i < 10; ) {
     //   leds[i] = CHSV(hue + (i * 10), 255, 150); }
     // for (int y = 10; y > 9 && y < 22; ++y) {
       // leds[y] = CHSV(hue + (y * 10), 255, 250);}
    
      //You can change the pattern speed here
     // EVERY_N_MILLISECONDS(1){hue++;}
      
     // FastLED.show();
      //rainbowChase = 1;
    //}

//}

// -------RAINBOW CHASE 2-------


 if (rainbowChase == 1) {

    //delay(100);

    // Move LEDS
    for (int i = 0; i < 16; i = i + 1) {

      if(i - 6 >= 0) {
        leds[i - 6] = CHSV(hue++ + (i * 10), 255, 70);
        
      }
      if(i - 5 >= 0) {
        leds[i - 5] = CHSV(hue++ + (i * 10), 255,110);
        
      }
      if(i - 4 >= 0) {
        leds[i - 4] = CHSV(hue++ + (i * 10), 255, 130);
        
      }
      if(i - 3 >= 0) {
        leds[i - 3] = CHSV(hue++ + (i * 10), 255, 150);
        
      }
      if(i - 2 >= 0) {
        leds[i - 2] = CHSV(hue++ + (i * 10), 255, 130);
        
      }
      if(i - 1 >= 0) {
        leds[i - 1] = CHSV(hue++ + (i * 10), 255, 10);
        
      }
        
        

         EVERY_N_MILLISECONDS(1){hue++;
          // Show the leds
      for (int y = 10; y > 9 && y < 22; ++y) {
        leds[y] = CHSV(hue + (y * 10), 255, 250);}}

     

      FastLED.show();
     
      delay(delaySpeed);
        FastLED.clear();
      
      


      
      
     
      timeTravel = 0;




    }
    FastLED.clear();

      rainbowChase = 1;

    }

    
    }


 
