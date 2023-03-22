# ezChromato

ezChromato is a very simple open source DIY chromatography solution based on :

- an Arduino / ADS1220 24-bit ADC for acquisition
- a linux bash script UI for data recording and live graph

---

acquisition from any chromatograph 0/1Volt output

no drivers (except arduino), no card, no special cable needed

very simple wiring (just needs one Arduino UNO, one ADS1220 and 3 discrete components)

up to 20 samples/seconde (20Hz)

uses plain ASCII files/stream

network file transfer at the end of each acquisition

final visualisation and post-processing on any software compatible with ASCII files

autosampler compatible if you have access to READY and START NC/NO outputs on your chromatograph

successfully tested on Perkin Elmer Autosampler XL and HP5890

---

## arduino acquisition

The acquisition is made from the 0/1Volt output of any chromatograph by the ADS1220 24-bit ADC

Computer is simply connected trough the Arduino USB cable (schematics are in the ./ezChromato/docs folder, SPI wiring is detailled in the ezchromato.ino file)

In order to have minimal automation, the chromatograph should also be connected via the READY and START NC/NO connectors, but if you don't have those it's not a problem, just put a permanent cable beetwen pin D4 and GND, and the arduino will send measures in continuous mode

## bash script

- ezchromato.sh is the main script and provides a simple UI to make a single analysis
- ezchromato_multi.sh is the autosampler version and will indefinitely loop (i mainly use this one in the lab)

At the end of each acquisition, measures are saved on the computer in ASCII files (.fid) in the folder ./ezChromato/data and are also uploaded to an smb server for post-processing on another computer

## visualisation and post-processing

Any software able to import ASCII files can be used, i've only tried two so far :
 
- ezData : unmaintened old freeware but i love his simplicity, works well to visualize graphs or quickly identify products
- Unichrom : far more advanced software with calibration curves, internal standard management, pdf reports, etc...

Note that you can directly do live capture with Unichrom without using the linux script, and this is the only easy way to use ezChromato hardware on Windows (Unichrom offers full post-processing for free but capture is limited to 3mn in free mode)

---

If you have a question, have successfully tested on a chromatograph or simply enjoyed, don't hesitate to contact me, it's always a pleasure having feeback
