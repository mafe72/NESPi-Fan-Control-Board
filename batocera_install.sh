#!/bin/bash

#Step 1)make /boot writable---------------------------------
mount -o remount, rw /boot
mount -o remount, rw /
#-----------------------------------------------------------

SourcePath=https://raw.githubusercontent.com/mafe72/NESPi-Fan-Control-Board/master/scripts
CNF=/userdata/system/batocera.conf
script=/userdata/MiniMods/fan_ctrl.py
DIR=/userdata/system/custom.sh

#-----------------------------------------------------------
#Step 2)Download Python script-----------------------------
sleep 2s

if grep -q "system.fan.ctrl" $CNF
	then
		sed -i '/system.fan.ctrl/c system.fan.ctrl=FANCTRL' $CNF
		echo "System Fan Control update complete."
	else
		echo "system.fan.ctrl=FANCTRL" >> $CNF
		echo "System Fan Control enabled."
fi

#-----------------------------------------------------------
mkdir /userdata/MiniMods
sleep 2s

if [ -e $script ];
	then
		echo "Fan control already installed. Updating..."
		rm $script
		wget -O  $script "$SourcePath/fan_ctrl-batocera.py"
		echo "Fan Control update complete."
	else
		wget -O  $script "$SourcePath/fan_ctrl-batocera.py"
		echo "Fan Control download complete."
fi
#-----------------------------------------------------------

sleep 2s

#Step 3) Enable Python script to run on start up------------

if grep -q "python $script &" $DIR
	then
		if [ -x $DIR ];
			then 
				echo "Fan Control script already configured. Doing nothing."
			else
				chmod +x $DIR
		fi
	else
		echo "python $script &" >> $DIR
		chmod +x $DIR
		echo "Fan Control script configuration competed."
fi
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo "NESPi Fan Control Board installation complete. Rebooting after 3 seconds."
sleep 3
reboot

