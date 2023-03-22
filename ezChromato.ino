//////////////////////////////////////////////////////////////////////////////////////////
//
//   ezChromato is a very simple open source DIY chromatography solution by Loic F4HBG
//
//   based on ADS1220 24-bit ADC breakout board
//
//   ADS1220 / Chromatograph / Arduino connections :
//
//  -------------------------------------------------------------
//  |ADS1220 pin label| Pin Function         |Arduino Connection|
//  |-----------------|----------------------|------------------|
//  | DRDY            | Data ready Output pin|  D2              |
//  | MISO            | Slave Out            |  D12             |
//  | MOSI            | Slave In             |  D11             |
//  | SCLK            | Serial Clock         |  D13             |
//  | CS              | Chip Select          |  D7              |
//  | DVDD            | Digital VDD          |  +5V             |
//  | DGND            | Digital Gnd          |  Gnd             |
//  | AN0             | Analog Input         |  0/1V Input      |
//  | AVDD            | Analog VDD           |  -               |
//  | AGND            | Analog Gnd           |  -               |
//  |                 |                      |                  |
//  | -               | START (NO)           |  D4              |
//  | -               | READY (NO)           |  D5              |
//  | -               | Gnd                  |  Gnd             |
//  -------------------------------------------------------------
//
//   This software is licensed under the MIT License(http://opensource.org/licenses/MIT).
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//   NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//
//   For more information and how to use, visit :
//    https://f4hbg/ezchromato
//    https://github.com/f4hbg/ezchromato
//
//   Original ADS1220 code by Ashwin Whitchurch :
//    https://github.com/Protocentral/Protocentral_ADS1220
//
//
/////////////////////////////////////////////////////////////////////////////////////////

#include "Protocentral_ADS1220.h"
#include <SPI.h>

#define PGA          1                 // Programmable Gain = 1
#define VREF         2.048            // Internal reference of 2.048V
#define VFSR         VREF/PGA
#define FULL_SCALE   (((long int)1<<23)-1)

#define ADS1220_CS_PIN    7
#define ADS1220_DRDY_PIN  6

Protocentral_ADS1220 pc_ads1220;
int32_t adc_data;
volatile bool drdyIntrFlag = false;

unsigned long mtime;
unsigned long mtime_diff;
unsigned long tstamp;
unsigned long startTime;

//---configuration---

int refreshRate = 20; //data refresh rate in Hz (max 100Hz)
int refreshRatems = 1000/refreshRate;

int startPin = 4; //start acquisition when start signal is detected
int readyPin = 5; //stops acquisition when ready signal is detected

unsigned long totalMinutes = 999; //max time, anyway arduino will stop sending data if the ready signal is detected

//-------------------

void drdyInterruptHndlr()
{
  drdyIntrFlag = true;
}


void enableInterruptPin()
{
  attachInterrupt(digitalPinToInterrupt(ADS1220_DRDY_PIN), drdyInterruptHndlr, FALLING);
}

void setup()
{
    Serial.begin(115200);

    pinMode(startPin, INPUT_PULLUP);
    pinMode(readyPin, INPUT_PULLUP);

    pc_ads1220.begin(ADS1220_CS_PIN,ADS1220_DRDY_PIN);

    pc_ads1220.set_data_rate(DR_330SPS);
    pc_ads1220.set_pga_gain(PGA_GAIN_1);
}

void loop()
{
  if(digitalRead(startPin) == LOW)
  {
    //max time (and ready reset) loop
    while(mtime < startTime + ((totalMinutes*1000*60)-10))
    {
      mtime = millis();
            
      //send data at the right time every 'refreshRatems' (in ms)
      if(mtime - tstamp >= refreshRatems)
      {
        tstamp = millis();
        
        pc_ads1220.select_mux_channels(MUX_SE_CH0);
        adc_data=pc_ads1220.Read_Data_Samples();
        
        Serial.println(convertToVolt(adc_data),5);
      }
           
      //if ready signal is detected, stops sending data even if time is not complete 
      if(digitalRead(readyPin) == LOW){asm volatile ("  jmp 0");} //reset the arduino if cg ready
      //if(digitalRead(readyPin) == LOW){break;} //break the loop if cg ready (2nd method)
    }
  }
  else
  {
    //waiting for start signal
    startTime = millis();
    //Serial.println("data aquisition stop");
  }
}

float convertToMilliV(int32_t i32data)
{
    return (float)((i32data*VFSR*1000)/FULL_SCALE);
    //return (float)(((i32data*VFSR*1000)/FULL_SCALE)-0.45); //use if you want to add or retrieve an offset value
}

float convertToVolt(int32_t i32data)
{
    return (float)((i32data*VFSR)/FULL_SCALE);
    //return (float)(((i32data*VFSR)/FULL_SCALE)-0.00045); //use if you want to add or retrieve an offset value
}
