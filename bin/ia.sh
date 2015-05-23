#!/bin/bash
# graphics.sh - prints out the name of the graphics chipset in use
#   For laptops with switchable/hybrid graphics.
#
# This is part of a larger collection of Conky scripts and configurations:
# https://entropicassembly.com/conky

#dis_line=`cat /sys/kernel/debug/vgaswitcheroo/switch | grep DIS`
#selected=${dis_line:6:1}

OUTPUT="$(amdconfig --pxl)"
selected=${OUTPUT:13:1}

if [ "$selected" = "I" ]; then
    conky -c .conkyrci
else
    conky -c .conkyrca
fi