NESPi Fan Control Board
===============================
This is a temperature control board for the RetroFlag NESPi Case and the YIKESHU Black NES Case, this PCB add the ability to cooldown your system during game play.

License
-------
<div align="center"><a rel="license" href="https://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Attribution-NonCommercial-ShareAlike" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /></div>

This project is licensed under the Attribution-NonCommercial-ShareAlike CC BY-NC-SA 4.0 license. The full legal text of the license may be found in the LICENSE.txt file in this repository. For more information about this license, please visit 
the Creative Commons Foundation (https://creativecommons.org/licenses/by-nc-sa/4.0/).

Features
--------

* Small footprint (NESPi 25.3mm x 10.7mm - SUPERPi-U 23.2mm x 10.6mm - NESPi-4 24.2mm x 11.8mm)

* Easy Temperature Control

* 1 wire fan control

* Compatible with 5V Fans

* 2.0mm 2-Pin Right-Angle JST Socket Fan Connector

* 2x 1.25mm 2-Pin Right-Angle JST Socket Fan Connector (NESPi-4 only)

* Minimal hardware modification

* One-line script installation

* Compatible with RetroFlag NESPi-4, SNESPi Case U/J, MEGAPi Case, NESPi Case/NESPi Case +, and the YIKESHU Black NES Case or any Raspberry Pi Case

* You can buy the latest version of this board fully assembled from [http://mini-mods.com](https://mini-mods.com/product-category/fan-control-kits/)

----------
* NESPi Fan Control Compatible with: MEGAPi Case, NESPi Case/NESPi Case + and the YIKESHU Black NES Case.
![Fan Control](pictures/RetroflagNESPi-FanCtrl-SMD_iso.png)

* SUPERPi-U Fan Control Compatible with: SNESPi Case U and SNESPi Case J.
![Fan Control](pictures/SUPERPi-U-FanCtrl-SMD_iso.png)

* NESPi-4 Fan Control Compatible with: NESPi-4 Case.
![Fan Control](pictures/NESPi-4-FanCtrl-SMD_iso.png)
----------

Prerequisites
---------------------

1. RetroPie

      To install Retropie you may download the image for [Raspberry Pi 3](https://github.com/RetroPie/RetroPie-Setup/releases/download/4.2/retropie-4.2-rpi2_rpi3.img.gz "RetroPie for version RPi 2/3/4")/4 and follow the installation instruction at the [retropie website](https://retropie.org.uk/docs/First-Installation/#installation "RetroPie installation instructions").

2. Internet connection

      Internet access via Ethernet or to set up your internet via WiFi, you can follow the instructions [here](https://retropie.org.uk/docs/Wifi/ "RetroPie WiFi Setup").

3. Keyboard and screen, or any computer/laptop (via SSH)

      To access your Pi via SSH, you can also follow this instructions [here](https://retropie.org.uk/docs/SSH/ "Raspberry Pi SSH Setup").

4. Basic soldering skills

      This PCB need to be solder directly into the built-in fan connector.
	  
Hardware Installation
---------------------
It's very important to follow the right pin configuration to prevent damage to your Pi.

  * `FAN_CT Pin` - Connect to GPIO 17 (RPI pin 11)
  * `SOURCE Pin` - Connect to the built-in fan connector (follow polarity markings)
  
![Pin Connection](pictures/nespicase_fan_ctrl_connection.png)

Software Installation
---------------------

**NOTE**: This assumes that you have already connected the jumper wires to the correct PINS and ports;
If you haven't, see the [Hardware Installation](#hardware-installation) section.

This instructions are a *step-by-step guide* to install necessary software for your **NESPi Fan Control Board**.
You can setup this via SSH or using the command line interface in your RetroPie. To enter the command line interface of RetroPie, *PRESS* ***F4*** just after booting up.

----------

Open your terminal and type the one-line installation command below:
```bash
$ wget -O - "https://github.com/mafe72/NESPi-Fan-Control-Board/raw/master/install.sh" | sudo bash
```

The script will automatically install pertinent files and configure your Raspberry Pi to enable **NESPi Fan Control Board.**
Installation will automatically reboot once all processes is completed.

After rebooting, your **NESPi Fan Control Board** is now fully functional.

Software Uninstall
---------------------

This instructions are a *step-by-step guide* to uninstall necessary software for your **NESPi Fan Control Board**.
You can setup this via SSH or using the command line interface in your RetroPie. To enter the command line interface of RetroPie, *PRESS* ***F4*** just after booting up.

----------

Open your terminal and type the one-line installation command below:
```bash
$ wget -O - "https://github.com/mafe72/NESPi-Fan-Control-Board/raw/master/uninstall.sh" | sudo bash
```

The script will automatically uninstall all configuration files from your Raspberry Pi to disable the **NESPi Fan Control Board.**
The uninstall script will automatically reboot once all processes are completed.

After rebooting, your **NESPi Fan Control Board** will be fully deactivated.

----------
	
Basic Usage
-----------

* FAN ON
			
		Fan will turn ON when temperature exceeded 55C
		
* FAN OFF
		
		Fan will turn OFF when temperature under 40C

----------

Change log of versions
-----------
V_20200917

* Add compatibility with NESPi-4 Case.

V_03302018

* ACT_LED will only light-up when the fan is active.

V_02012018

* Initial release.