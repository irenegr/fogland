#!/bin/bash
# takes an image and creates a color palette from it
# which gets echoed to the console.
#
# made by rhowaldt (fuck you)
#
# depends: imagemagick

PALETTE=$(convert "$1" -colors 16 -format "%c" histogram:info:)
HEXLIST=$(echo "$PALETTE" | sed 's/^.*\#\(.*\) srgb.*/\1/g')
COL=("0" "8" "1" "9" "2" "A" "3" "B" "4" "C" "5" "D" "6" "E" "7" "F");
CLEAN=$(echo $COL | sed 's/^0*//')
x=0

while read line; do
      echo -en *color$x: '#'"${CLEAN}$line\n";
      let x=x+1
done <<< "$HEXLIST"
clear
