#! /bin/bash

RC="$HOME/.conky/conkyrc_dzen_mine"
FG="#dedede"
BG="#262626"
ALIGN="center"
WIDTH="1366"
HEIGHT="12"
FONT="Pragmata:size=8"
XPOS="0"
YPOS="756"

conky -c $RC | dzen2 -e 'button2=;' -fg $FG -bg $BG -ta $ALIGN -h $HEIGHT -x $XPOS -y $YPOS -fn "$FONT" &

exit 0
