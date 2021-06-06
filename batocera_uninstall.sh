#!/bin/bash

#Step 1)make /boot writable---------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /
#-----------------------------------------------------------

#Step 2) Remove Installation directory and configration-----
echo "Cleaning configration files..."
CNF=/userdata/system/batocera.conf

rm -r /userdata/MiniMods

if grep -q 'system.fan.ctrl=FANCTRL' $CNF
	then
	sed -i '/system.fan.ctrl=FANCTRL/c ' $CNF
fi
sleep 2s
#-----------------------------------------------------------

#Step 3) Remove configuration script -----------------------
DIR=/userdata/system/custom.sh
script=/userdata/MiniMods/fan_ctrl.py

if grep -q 'python $script &' $DIR
        then
        sed -i '/python $script &/c ' $DIR
fi
sleep 2s
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo 'NESPi Fan Control Board un-install complete. Will now reboot after 3 seconds.'
sleep 4
reboot
