# ezChromato installation

**app needed**

sudo apt install gnuplot-qt smbclient

**add your user to the 'dialout' group to access usb**

sudo usermod -a -G dialout $USER

(need reboot)

**avoid /dev/ttyUSB0 disconnections on ubuntu**

sudo apt remove brltty

**give execution rights to both .sh files**

chmod 777 ezchromato.sh

chmod 777 ezchromato_multi.sh

## usage examples


 ./ezchromato.sh
 
will launch the console UI, at the first input (gc id) you have two naming choices :
give an id of your choice, or just type enter to use timestamp 

then you have to give the time of analysis in round minutes

the live graph windows (gnuplot-qt) will open in fullscreen, and shows the message "waiting for data" in the right upper corner

graph begins automatically when cromatography begins, the windows close after specified analysis time


./ezchromato_multi.sh 7

will launch infinite acquisition loop with 7 minutes analysis time

in all cases, files are stored in ./ezChromato/data folder, and send via network to smb server if you activated the option
