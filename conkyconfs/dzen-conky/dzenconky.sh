#!/bin/sh
RC="$HOME/.conkyrc"
FG="white"
BG="#000000"
ALIGN="center"
WIDTH="1366"
HEIGHT="14"
FONT="-artwiz-smoothansi-*-*-normal-*-13-*-*-*-*-*-*-*"
XPOS="0" 
YPOS="754"

exec conky -d -c $RC | dzen2 -fg $FG -bg $BG -ta $ALIGN -w $WIDTH -h $HEIGHT -x $XPOS -y $YPOS -fn $FONT &
exit 0