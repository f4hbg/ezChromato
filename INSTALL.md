# ezChromato installation

**1) install needed apps**

sudo apt install gnuplot-qt smbclient

**2) add your user to the 'dialout' group to access usb (debian & ubuntu)**

sudo usermod -a -G dialout $USER

(need reboot)

**3) avoid /dev/ttyUSB0 disconnections on ubuntu**

sudo apt remove brltty

**4) give execution rights to both .sh files**

chmod 777 ezchromato.sh

chmod 777 ezchromato_multi.sh

## usage examples


 ./ezchromato.sh
 
will launch the console UI, at the first step (gc id) you have two choices :
give an name/gc_id of your choice, or just type enter to use timestamp 

then you have to give the time of analysis (in upper round minutes)

the live graph windows (gnuplot-qt) opens in fullscreen, and shows the message "waiting for data" in the right upper corner

graph starts automatically when analysis begins, the windows close after specified analysis time

--

./ezchromato_multi.sh 7

will launch infinite acquisition loop with 7 minutes analysis time

if you are lucky enough to have an autosampler you can leave the machine to run on its own and go to the beach

---

in all cases, files are stored in ./ezChromato/data folder, and send via network to smb server if you activated the option
