#!/bin/bash

#Step 1)make /boot writable---------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /
#-----------------------------------------------------------

SourcePath=https://raw.githubusercontent.com/mafe72/NESPi-Fan-Control-Board/master/scripts
script=/opt/MiniMods/fan_ctrl.py
DIR=/etc/init.d/S99NESPiFanCTRL

#-----------------------------------------------------------
#Step 2)Download Python script-----------------------------
mkdir /opt/MiniMods
sleep 2s

if [ -e $script ];
	then
		echo "Fan control already installed. Updating..."
		rm $script
		wget -O  $script "$SourcePath/fan_ctrl-recalbox.py"
		echo "Fan Control update complete."
	else
		wget -O  $script "$SourcePath/fan_ctrl-recalbox.py"
        	echo "Fan Control download complete."
fi
#-----------------------------------------------------------

sleep 2s

#Step 3) Enable Python script to run on start up------------

if grep -q "python $script &" "$DIR";
	then
	if [ -x $DIR ];
	then 
		echo "Fan Control S99NESPiFanCTRL already configured. Doing nothing."
	else
		chmod +x $DIR
	fi
	else
		echo "python $script &" >> $DIR
		chmod +x $DIR
		echo "Fan Cotnrol S99NESPiFanCTRL configured."
fi
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo "NESPi Fan Control Board installation complete. Rebooting after 3 seconds."
sleep 3
reboot
#-----------------------------------------------------------

