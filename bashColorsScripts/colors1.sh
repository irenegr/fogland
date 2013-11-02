#!/bin/bash

#setterm -regtabs 4
COLS="$(xrdb -query| grep -Ei [.*]color[01-9] | sort -n -tr -k2  | tr -d [*[:blank:]])"

for i in {0..7}; do echo -en "\e[0;3${i}m$(echo -e "$COLS" | sed -n $(($i+1))'p' | cut -d ':' -f 1)\e[0m\t"; done; echo
for i in {0..7}; do echo -en "\e[0;3${i}m$(echo -e "$COLS" | sed -n $(($i+1))'p' | cut -d ':' -f 2)\e[0m\t"; done; echo
for i in {0..7}; do echo -en "\e[0;3${i}m▉▉▉▉▉▉▉\t"; done; echo
for i in {0..7}; do echo -en "\e[0;9${i}m$(echo -e "$COLS" | sed -n $(($i+9))'p' | cut -d ':' -f 1)\e[0m\t"; done; echo
for i in {0..7}; do echo -en "\e[0;9${i}m$(echo -e "$COLS" | sed -n $(($i+9))'p' | cut -d ':' -f 2)\e[0m\t"; done; echo
for i in {0..7}; do echo -en "\e[0;9${i}m▉▉▉▉▉▉▉\t"; done; echo -e "\033[0m"
echo
