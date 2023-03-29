# ezChromato CDS

ezChromato is a very simple open source DIY chromatography data system

based on an Arduino / ADS1220 24-bit ADC for data acquisition

and a linux bash script UI for data recording and live graph


- captures from any chromatograph 0/1Volt output

- no drivers (except arduino), no card, no special cable needed

- very simple wiring (just needs one Arduino UNO, one ADS1220 and 3 discrete components)

- up to 20 samples/seconde (20Hz)

- uses plain text ASCII files/stream

- autosampler compatible*

- chromatography file post-processing on any ASCII file compatible software

- successfully tested on Perkin Elmer Autosampler XL and HP5890

---

## arduino acquisition

The acquisition is made by the ADS1220 24-bit ADC from the 0/1Volt output of any chromatograph

Computer is simply connected trough the Arduino USB cable :)

In order to have minimum automation (auto start, ready init) the arduino must also be wired to the READY and START NC/NO connectors of your chromatograph (mandatory for autosampler use)

If you don't have them, it's not a dead end, just put a permanent wire between pin D4 and GND. ezChromato will then work in degraded mode (mainly because the arduino will send measurements all the time, even in idle mode), in this case you will have to launch aquisition on the chromatograph and ezChromato at the exact same time

## bash script

- ezchromato.sh is the main script and provides a simple UI to make single analysis
- ezchromato_multi.sh is the autosampler version and will loop indefinitely (i mainly use this one in the lab)

At the end of each acquisition, measurements are saved in the ./ezChromato/data folder in text files (.fid) and are optionally  uploaded to an smb server (for post-processing on another computer)

## visualisation and post-processing

Any software able to import text files can be used, i've only tried two so far :
 
- ezData : unmaintened old freeware but i love its simplicity, works well to visualize graphs and quickly identify products
- Unichrom : far more advanced software with calibration curves, internal standard management, pdf reports, etc...

Note that you can directly do live capture with Unichrom without using the linux script (and this is one of the possibilities to use ezChromato hardware on Windows), in this case you have to put a permanent wire between pin D4 and GND, in order to set the arduino in continuous mode (ATTENTION : Unichrom offers full post-processing for free, but capture is limited to 3mn without licence)

---

If you have a question, have successfully tested on a chromatograph or simply enjoyed, don't hesitate to contact me, it's always a pleasure having feeback
