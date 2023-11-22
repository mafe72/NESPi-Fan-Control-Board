#####################################
# RecalBox NESPi Control Board Script
#####################################
# Hardware:
# Board by Eladio Martinez
# http://mini-mods.com
#
#####################################
# Wiring:
#  GPIO 17 Fan ON/OFF signal (OUTPUT)
#
#####################################
# Basic Usage:
#  FAN ON
#	Fan will turn ON when temperature exceeded 55C
#  FAN OFF
#	Fan will turn OFF when temperature under 40C
#
#
#----------------------------------------------------
#Edit these values to change the fan control settings
#Adjust Incremental Fan Speed TEMP as needed

# Fan temperature range
offTEMP=40
minTEMP=55
midTEMP=70
maxTEMP=85


#NOTE:Reboot Raspberry Pi after changing these values
#----------------------------------------------------
#Edit this value to change the default GPIO Fan Signal

#GPIO 17 default Fan ON/OFF Signal
fanGPIO=17

#NOTE:Reboot Raspberry Pi after changing these values
#----------------------------------------------------

import RPi.GPIO as GPIO
import time
import os
import socket

GPIO.setmode(GPIO.BCM)
GPIO.setup(fanGPIO, GPIO.OUT)
GPIO.setwarnings(False)

fan = GPIO.PWM(fanGPIO, 50) #PWM frequency set to 50Hz

#Get CPU Temperature
def getCPUtemp():
	res = os.popen('cat /sys/class/thermal/thermal_zone0/temp').readline()
	return (res.replace("temp=","").replace("'C\n",""))
	
while True:
	#Fan control
	#Adjust MIN and MAX TEMP as needed to keep the FAN from kicking
	#Temp is checked on a one second loop
	cpuTemp = int(float(getCPUtemp())/1000)
        if cpuTemp >= minTEMP:
                fan.start(45) #min duty cycle
        elif cpuTemp >= midTEMP:
                fan.start(65) #mid duty cycle
        elif cpuTemp >= maxTEMP:
                fan.start(90) #max duty cycle
        elif cpuTemp < offTEMP:
                fan.stop()
        time.sleep(1.00)

