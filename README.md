# ezChromato

ezChromato is a very simple open source DIY chromatography solution based on :

- an Arduino / ADS1220 24-bit ADC for acquisition
- a linux bash script UI for data recording and live graph

---

acquisition from any chromatograph 0/1Volt output

no drivers (except arduino), no card, no special cable needed

very simple wiring (just need one Arduino UNO, one ADS1220 and 3 discrete components)

up to 20 samples/seconde (20Hz)

uses simple ASCII files/stream

network file transfer at the end of each acquisition

final visualisation and post-processing on any software compatible with ASCII files

autosampler compatible if you have access to READY and START NC/NO outputs on your chromatograph

successfully tested on Perkin Elmer Autosampler XL and HP5890

---

## arduino acquisition

The acquisition is made from the 0/1Volt output of any chromatograph by the ADS1220 24-bit ADC

Computer is simply connected trough the Arduino USB cable (main schema in the ./ezChromato/docs folder, SPI wiring in .ino file)

In order to have a minimal automation, the chromatograph should also be connected via the READY and START NC/NO connectors, but if you don't have those it's not a problem, just put a permanent cable beetwen pin D4 and GND of the arduino and it will send measures in continuous mode

## bash script

- ezchromato.sh is the main script and provide an simple UI to name and set analyse time
- ezchromato_multi.sh is an autosampler/continuous script that will indefinitely loop and is meant to be used with an autosampler in autonomous mode

At the end of each acquisition, measures are recorded on the computer in ASCII files (.fid) in the folder ./ezChromato/data and are also uploaded to an smb server for post-processing on another computer

## visualisation and post-processing

Any software able to import ASCII files can be use, i only have experienced two for now :
 
- ezData : unmaintened old freeware, i love his ultra simplicity, works well to visualize graphs or quickly identify products
- Unichrom : far more advanced software with calibration curves, internal standard management, pdf reports, etc...
you can directly make acquisition from Unichrom with the Arduino / ADS1220 without using the linux script
(free full post-processing / acquisition limited to 3mn in free mode)

---

If you have a question, have successfully tested on a chromatograph or simply enjoyed, don't hesitate to contact me, it's always a pleasure having feeback
