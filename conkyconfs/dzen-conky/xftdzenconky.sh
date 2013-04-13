#!/bin/sh
RC="$HOME/.dzenconkyrc"
FG="#606060"
BG="#030406"
ALIGN="center"
WIDTH="1366"
HEIGHT="15"
#FONT="-artwiz-smoothansi-*-*-normal-*-13-*-*-*-*-*-*-*"
#FONT="-artwiz-snap-*-*-normal-*-10-*-*-*-*-*-*-*"
FONT="Monofur:size=10"
XPOS="0" 
YPOS="753"

exec conky -d -c $RC | dzen2 -fg $FG -bg $BG -ta $ALIGN -w $WIDTH -h $HEIGHT -x $XPOS -y $YPOS -fn $FONT &
exit 0