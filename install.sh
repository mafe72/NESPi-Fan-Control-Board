#!/bin/bash

#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

#Step 2) Update repository----------------------------------
sudo apt-get update -y
#-----------------------------------------------------------

#Step 3) Install gpiozero module----------------------------
sudo apt-get install -y python-dev python-pip python-gpiozero
sudo pip install psutil pyserial
#-----------------------------------------------------------

#Step 4) Download Python script-----------------------------
cd /opt/
sudo mkdir RetroFlag
cd /opt/RetroFlag
script=fan_ctrl-retroflag.py

if [ -e $script ];
	then
		echo "Script fan_ctrl-retroflag.py already exists. Updating..."
		rm $script
		wget "https://raw.githubusercontent.com/mafe72/Retroflag-NESPi-Fan-Control-Board/master/scripts/fan_ctrl-retroflag.py"
		echo "Update complete."
	else
		wget "https://raw.githubusercontent.com/mafe72/Retroflag-NESPi-Fan-Control-Board/master/scripts/fan_ctrl-retroflag.py"
                echo "Download  complete."
fi
#-----------------------------------------------------------

#Step 5) Enable Python script to run on start up------------
cd /etc/
RC=rc.local

#Cleaning deprecated configuration----
if grep -q "sudo python3 \/opt\/RetroFlag\/fan_ctrl.py \&" "$RC";
        then
               sed -i '/sudo python3 \/opt\/RetroFlag\/fan_ctrl.py \&/c\' "$RC";
fi

if grep -q "sudo python3 \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&" "$RC";
        then
               sed -i '/sudo python3 \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&/c\' "$RC";
fi

#Adding new configuration----------- 
if grep -q "sudo python \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&" "$RC";
	then
		echo "File /etc/rc.local already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&\n&/g" "$RC"
		echo "File /etc/rc.local configured."
fi
#-----------------------------------------------------------

#Step 6) Reboot to apply changes----------------------------
echo "Retroflag NESPi Fan Control Board installation done. Will now reboot after 3 seconds."
sleep 4
sudo reboot
#-----------------------------------------------------------

