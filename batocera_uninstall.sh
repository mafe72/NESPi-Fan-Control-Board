#!/bin/bash

#Step 1)make /boot writable---------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /
#-----------------------------------------------------------

CNF=/userdata/system/batocera.conf
DIR=/userdata/system/custom.sh
MDIR=/userdata/MiniMods
script=/userdata/MiniMods/fan_ctrl.py

#-----------------------------------------------------------
#Step 2) Remove Installation directory and configration-----
echo "Cleaning configration files..."

rm -r $MDIR

if grep -q 'system.fan.ctrl=FANCTRL' $CNF
	then
	sed -i '/system.fan.ctrl=FANCTRL/c ' $CNF
fi
sleep 2s
#-----------------------------------------------------------

#Step 3) Remove configuration script -----------------------
if grep -q 'python $script &' $DIR
        then
        sed -i '/python $script &/c ' $DIR
fi
sleep 2s
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo 'NESPi Fan Control Board un-install complete. Rebooting after 3 seconds.'
sleep 4
reboot
