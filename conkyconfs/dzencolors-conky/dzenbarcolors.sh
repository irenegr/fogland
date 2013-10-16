#! /bin/bash
#RC="$HOME/.conky/conkyrc_dzen_full"
RC="$HOME/.conky/conkyrc_dzen"
FG="#F4EED7"
BG="#222222"
ALIGN="left"
WIDTH="1366"
HEIGHT="14"
FONT="Pragmata:size=8"
XPOS="0"
YPOS="0"
# to use with conkyrc_dzen_full
#LIN="22" #number of lines in conky_dzen output

conky -c $RC | dzen2 -fg $FG -bg $BG -ta $ALIGN -h $HEIGHT -x $XPOS -y $YPOS -fn "$FONT" &
# to use with conkyrc_dzen_full
#conky -c $RC | dzen2 -e 'button1=togglecollapse;button2=exec:$HOME/bin/dzenbar_reload.sh;button3=exec:geany $HOME/.conky/conkyrc_dzen $HOME/bin/dzenbar.sh' -fg $FG -bg $BG -ta $ALIGN -h $HEIGHT -x $XPOS -y $YPOS -fn "$FONT" -l $LIN -u &
exit 0
