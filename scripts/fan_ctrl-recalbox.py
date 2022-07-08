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
#Adjust MIN and MAX TEMP as needed

#Turn off fan when under
minTEMP=40

#Turn on fan when exceeded
maxTEMP=55

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
	#on and off with only a one second loop
	cpuTemp = int(float(getCPUtemp())/1000)
	fanOnTemp = maxTEMP
	fanOffTemp = minTEMP
	if cpuTemp >= fanOnTemp:
		fan.start(90) #90% duty cycle
	if cpuTemp < fanOffTemp:
		fan.stop()
	time.sleep(1.00)

