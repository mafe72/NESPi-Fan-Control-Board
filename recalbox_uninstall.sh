#!/bin/bash

#Un-install script For RecalBox

#Step 1)make /boot writable---------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /
#-----------------------------------------------------------

#Step 2) Remove Installation directory ---------------------
rm -r /opt/MiniMods
sleep 2s

#-----------------------------------------------------------

#Step 3) Remove configuration script ------------
rm /etc/init.d/S99NESPiFanCTRL

#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
echo "NESPi Fan Control Board un-install complete. Rebooting after 3 seconds."
sleep 4
reboot
#-----------------------------------------------------------
