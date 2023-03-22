#!/bin/bash
#

#-----computer install-----

# app needed
#sudo apt install gnuplot-qt smbclient

# add your user to the 'dialout' group to access usb
#sudo usermod -a -G dialout $USER
# and REBOOT the computer

# to avoid /dev/ttyUSB0 disconnections on ubuntu
#apt remove brltty

#-----script configuration-----

# data refresh rate in Hz (needed for gnuplot x range)
refreshRate=20

# enables network file copy [yes/no]
network_file_copy="yes"

# //server/share/folder (folder is optionnal)
server="serveur"
share="_inbox_"
folder="gc_inbox"

cd data

#-----------------------

# closing ezchromato
killall ezchromato > /dev/null 2>&1
# closing cat
killall cat > /dev/null 2>&1
# closing gnuplot
killall gnuplot > /dev/null 2>&1
killall gnuplot_qt > /dev/null 2>&1

clear

printf "
***********************************************************
            ____ _                               _        
   ___ ____/ ___| |__  _ __ ___  _ __ ___   __ _| |_ ___  
  / _ \_  / |   | '_ \| '__/ _ \| \'_ \` _ \ / _\` | __/ _ \ 
 |  __// /| |___| | | | | | (_) | | | | | | (_| | || (_) |
  \___/___|\____|_| |_|_|  \___/|_| |_| |_|\__,_|\__\___/ 
                                                          
***********************************************************
"
num=$(($2+1))

now=`date +"%Y-%m-%d_%Hh%Mm%S"`

filename=$now"_"$num".fid"

mtime=$1

# echo " ->S1 : "$1
# echo " ->S2 : "$2


if [ -n "$mtime" ]
then
	time=$((mtime*60))
	gpxrange=$((time*$refreshRate))
else
	echo "no time argument specified - exit"
	echo "usage : ezchromato_multi.sh time"
	exit 0
fi

#echo " ->filename : "$filename
#echo " ->time : "$time

echo -n ' '

# ctrl+c exits script but copy file to network share before
trap ctrl_c INT

function ctrl_c() {
	#ctrl_cc $filename
	echo
	echo
	echo " ctrl+c detected -> save and exit"
	# closing cat
	killall cat > /dev/null 2>&1
	# closing gnuplot
	killall gnuplot > /dev/null 2>&1
	killall gnuplot_qt > /dev/null 2>&1
	# closing ezchromato_multi
	#killall ezchromato_multi > /dev/null 2>&1
	exit 1
}

# function ctrl_cc() {
	# echo
	# echo
	# echo " ctrl+c detected -> save and exit"
	# if [ $network_file_copy = "yes" ]; then
		# copy $filename
	# fi
# }

function copy() {
	echo
	echo " copying file, please wait"
	#echo -n " "
	# quiet smbclient upload
	smbclient -d 0 //$server/$share -U guest% -c 'cd '$folder' ; put '$1  > /dev/null 2>&1
	# debug smbclient upload
	#smbclient //$server/$share -U guest% -c 'cd '$folder' ; put '$1
}

# set com port to raw to avoid extra new lines in data
stty raw -F /dev/ttyUSB0 115200 cs8 -cstopb -parenb

# purge old data from com port buffer
timeout 1 cat /dev/ttyUSB0 > /dev/null

# set com port to raw to avoid extra new lines in data
stty raw -F /dev/ttyUSB0 115200 cs8 -cstopb -parenb

echo "file : "$filename
echo -n ' '

# create the file
echo "" > $filename

# realtime data plotting
#gnuplot -e "acquisition_in_progress='$filename'" ezchromato.gp 2> /dev/null &
#gnuplot -e "acquisition_in_progress='$filename'" -e "ezrange='$gpxrange'" ../ezchromato.gp &
gnuplot -e "acquisition_in_progress='$filename'" -e "ezrange='$gpxrange'" ../ezchromato.gp 2> /dev/null &

# acquisition to file
#cat -v /dev/ttyUSB0
cat /dev/ttyUSB0 > $filename &

echo
echo " waiting for data"

# acquisition waiting loop
filesize=0
while [[ $filesize = [0] ]]; do
	# waiting for acquisition
	filesize=$(stat --format=%s $filename)
	sleep 0.01
	#echo -n "."
done

echo
echo " acquisition started"

# waiting while acquisition method 1
sleep $time

# waiting while acquisition method 2 (more precise than sleep)
# wwaEnd=$((SECONDS+$time))
# while [ $SECONDS -lt $wwaEnd ]; do
	# # waiting while acquisition
	# sleep 0.05
	# #echo -n ""
# done

# closing cat
killall cat > /dev/null 2>&1

# closing gnuplot
killall gnuplot > /dev/null 2>&1
killall gnuplot_qt > /dev/null 2>&1

# reset com port to stop arduino acquisition
stty raw -F /dev/ttyUSB0 115200 cs8 -cstopb -parenb

echo
echo " acquisition stopped"

# copy file to network share
if [ $network_file_copy = "yes" ]; then
	copy $filename
fi

echo
echo " all ok - goodbye"

echo "
***********************************************************
"

cd ..

./ezchromato_multi.sh $mtime $num &

#1=''
#2=''
#mtime=''
#num=''

exit 0
