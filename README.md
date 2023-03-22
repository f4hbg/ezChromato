# ezChromato

ezChromato is a very simple open source DIY chromatography solution based on :

- an Arduino / ADS1220 24-bit ADC for acquisition
- a linux bash script UI for data recording and live graph

acquisition from any 0/1Volt output machine

up to 20 samples/seconde (20Hz)

use simple ASCII files/stream

no card, no drivers (except arduino), no special cable needed

Arduino / ADS1220 wiring very simple and straightforward (Fritzing schema provided)

auto file network transfer after each acquisition

## Arduino acquisition

The acquisition is made from the 0/1Volt output of any chromatograph trough the ADS1220 24-bit ADC - Arduino USB cable.

Schema and wiring are given in the ./ezChromato/docs folder

Autosampler compatible if you have access to READY and START NC/NO outputs of the chromatograph

## bash script

- ezchromato.sh is the main script and provide an simple UI to name and set analyse time
- ezchromato_multi.sh autosampler/continuous script will indefinitely loop and is meant to be used with an autosampler in autonomous mode

Data are recorded on the computer in ASCII files in the folder ./ezChromato/data

File can be uploaded to an smb server at the end of each acquisition, for post-processing on another computer

## visualisation and post-processing

Any software able to import ASCII files can be use, i only have experienced two for now :
 
- ezData freeware : i like his ultra simplicity, it's ok to rapidly identify products but that's almost all
- Unichrom : works very well and is far more advanced, calibration curves, internal standard management, pdf reports, etc...
(free full post-processing / acquisition limited to 3mn in free mode)
(if you have a licence you can directly make acquisition from Unichrom with the Arduino / ADS1220 without using the linux script)


If you enjoy or have a question, don't hesitate to contact me, it's always a pleasure having feeback
