#!/bin/bash

# Brightness adjuster script by Joinemm
#
# Why?
# My brightness adjustments werent working through xbacklight so i made this as a replacement.
# Just bind this to your brightness keys
#
# To remove sudo requirement, add this to /etc/udev/rules.d/backlight.rules
#
# ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", RUN+="/bin/chgrp wheel /sys/class/backlight/%k/brightness"
# ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
#
# Usage:
#     ./brightness.sh <change>
#     ./brightness.sh 200
#     ./brightness.sh -200

old=`cat /sys/class/backlight/intel_backlight/brightness`
max=`cat /sys/class/backlight/intel_backlight/max_brightness`
new=`expr $old + $1`

# make sure not to go below 0
if [ $new -lt 0 ]
then
	new=0
fi

# make sure not to go over the maximum brightness
if [ $new -gt $max ]
then
	new=$max
fi

echo $new | tee /sys/class/backlight/intel_backlight/brightness
