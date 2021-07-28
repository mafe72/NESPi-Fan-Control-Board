#!/bin/bash

#Un-install script For Raspbian and RetroPie

#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

DIR=/opt/MiniMods
RC=/etc/rc.local
script=/opt/MiniMods/fan_ctrl.py

#-----------------------------------------------------------
#Step 2) Remove Installation directory ---------------------

sudo rm -r $DIR

#-----------------------------------------------------------

#Step 3) Remove configuration script -------------

#Cleaning deprecated configration files --------------------
echo Cleaning configration files from rc.local

if grep -q "sudo python3 \/opt\/RetroFlag\/fan_ctrl.py \&" "$RC";
        then
               sed -i '/sudo python3 \/opt\/RetroFlag\/fan_ctrl.py \&/c\' "$RC";
fi

if grep -q "sudo python \/opt\/RetroFlag\/fan_ctrl.py \&" "$RC";
        then
               sed -i '/sudo python3 \/opt\/RetroFlag\/fan_ctrl.py \&/c\' "$RC";
fi

if grep -q "sudo python3 \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&" "$RC";
        then
               sed -i '/sudo python3 \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&/c\' "$RC";
fi

if grep -q "sudo python \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&" "$RC";
        then
               sed -i '/sudo python \/opt\/RetroFlag\/fan_ctrl-retroflag.py \&/c\' "$RC";
fi

if grep -q "sudo python \/opt\/MiniMods\/fan_ctrl.py \&" "$RC";
        then
               sed -i '/sudo python \/opt\/MiniMods\/fan_ctrl.py \&/c\' "$RC";
fi

#-----------------------------------------------------------
#Step 4) Reboot to apply changes----------------------------
echo "NESPi Fan Control Board un-install complete. Rebooting after 3 seconds."
sleep 4
sudo reboot
#-----------------------------------------------------------
