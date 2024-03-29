## ezChromato installation

### hardware

when Arduino and ADS1220 wiring is done, connect the USB cable and flash the arduino with the ezchromato.ino file

schematics are located in the ./ezChromato/docs folder and SPI wiring is detailled in the ezchromato.ino file

test process : put a wire between pin D4 and GND, and the arduino should start sending measurements on the virtual port /dev/ttyUSB0, open Arduino IDE serial monitor (or any serial software) at 115200 bauds (8N1)

received data should look like this :

```
0.02436
0.02392
0.02419
0.02381
0.02439
...
```

if nothing appends, check wiring, linux permissions, and be sure there is a connection on the START connector (pin D4 / GND) during tests

### sofware

**1) install needed apps**
```
sudo apt install gnuplot-qt smbclient
```
**2) add your user to the 'dialout' group to access usb (debian & ubuntu)**
```
sudo usermod -a -G dialout $USER
```
(needs reboot)

**3) avoid /dev/ttyUSB0 disconnections on ubuntu**
```
sudo apt remove brltty
```
**4) give execution rights to both .sh files**
```
chmod 777 ezchromato.sh
chmod 777 ezchromato_multi.sh
```

output files are stored in ./ezChromato/data folder (and are sent via network to a smb server if you activated the option)

et voilà !

## usage examples

### single analysis

```
 ./ezchromato.sh
 ```
this will launch the main console UI

at the first prompt (gc id) you have two choices :

- just type enter to use timestamp as filename

- provide complete informations (gc_id/column/method/attenuation/standard) that will be used in the filename

then you have to give the duration of the analysis (in upper rounded minutes)

the live graph windows (gnuplot-qt) opens in fullscreen, and shows the message "waiting for data" in the right upper corner

graph starts automatically when analysis begins, and the windows closes after specified analysis time

### multiple analysis

```
./ezchromato_multi.sh 7
```
this will start an infinite acquisition loop (for autosampler) with an analysis time of 7 minutes

timestamp + autoincremented number are used as filename

you can now let the machine work by itself and go to the beach :)

to stop it, minimize the gnuplot windows and ctrl-c the console

---

