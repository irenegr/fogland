#!/bin/bash
# simple dual monitor detection and configuration
# run 'xrandr' to query informations, then edit this script
###########################################################
SCREENSTATE=`xrandr | grep VGA-0 | awk '{print $2}'`
if [ "$SCREENSTATE" == "connected" ]; then
    xrandr --output VGA-0 --mode 1920x1080 --pos 1366x0 --rotate normal --output LVDS --mode 1366x768 --pos 0x0 --rotate normal --output S-video --off --output DVI-0 --off
else
    xrandr --output VGA-0 --off --output LVDS --mode 1366x768 --pos 0x0 --rotate normal --output S-video --off --output DVI-0 --off
fi
exit
