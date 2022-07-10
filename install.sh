#!/bin/bash

#Installation script For Raspbian and RetroPie

#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

SourcePath=https://raw.githubusercontent.com/mafe72/NESPi-Fan-Control-Board/master/scripts
CNF=/boot/config.txt
script=/opt/MiniMods/fan_ctrl.py
RC=/etc/rc.local
DIR=/opt/MiniMods

#-----------------------------------------------------------
#Step 2) Update repository----------------------------------

if grep -q "avoid_warnings=0" "$CNF";
        then
		sed -i '/avoid_warnings=0/d' "$CNF";
fi
if grep -q "avoid_warnings=1" "$CNF";
        then
                echo "warnings already disable. Doing nothing."
        else
                echo "avoid_warnings=1" >> "$CNF"
                echo "warnings disable."
fi
#sudo apt-get update -y
#-----------------------------------------------------------

#Step 3) Install gpiozero module----------------------------
sudo apt-get install -y python-dev python-pip python-gpiozero
sudo pip install psutil pyserial
#-----------------------------------------------------------

#Step 4) Download Python script-----------------------------
sudo mkdir $DIR

if [ -e $script ];
	then
		echo "Fan control already installed. Updating..."
		rm $script
		wget -O $script "$SourcePath/fan_ctrl-retropie.py"
		echo "Fan Control update complete."
	else
		wget -O $script "$SourcePath/fan_ctrl-retropie.py"
                echo "Fan Control download complete."
fi
#-----------------------------------------------------------

#Step 5) Enable Python script to run on start up------------
if grep -q "sudo python \/opt\/MiniMods\/fan_ctrl.py \&" "$RC";
	then
		echo "Fan Control script already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python \/opt\/MiniMods\/fan_ctrl.py \&\n&/g" "$RC"
		echo "Fan Control script configured."
fi
#-----------------------------------------------------------

#Step 6) Reboot to apply changes----------------------------
echo "NESPi Fan Control Board installation complete. Rebooting after 3 seconds."
sleep 4
sudo reboot
#-----------------------------------------------------------
