#!/bin/bash

SourcePath=https://raw.githubusercontent.com/mafe72/NESPi-Fan-Control-Board/master/scripts

#Step 1)make /boot writable---------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /
#-----------------------------------------------------------

#Step 2)Download Python script-----------------------------
mkdir /opt/MiniMods
sleep 2s

script=/opt/MiniMods/fan_ctrl.py
if [ -e $script ];
	then
		echo "Script fan_ctrl.py already exists. Updating..."
		rm $script
		wget -O  $script "$SourcePath/fan_ctrl_recalbox.py"
		echo "Update complete."
	else
		wget -O  $script "$SourcePath/fan_ctrl_recalbox.py"
        echo "Download complete."
fi
#-----------------------------------------------------------

sleep 2s

#Step 3) Enable Python script to run on start up------------
DIR=/etc/init.d/S99NESPiFanCTRL

if grep -q "python $script &" "$DIR";
	then
		if [ -x $DIR ];
			then 
				echo "Executable S99NESPiFanCTRL already configured. Doing nothing."
			else
				chmod +x $DIR
		fi
	else
		echo "python $script &" >> $DIR
		chmod +x $DIR
		echo "Executable S99NESPiFanCTRL configured."
fi
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo "NESPi Fan Control Board installation done. Will now reboot after 3 seconds."
sleep 3
reboot
#-----------------------------------------------------------
