#!/bin/bash

SLP=1
BG=\#de002b36
FG=\#de839496
PX=1
FT="-*-terminus-medium-r-normal-*-12-*"

{ #looknfeel
    OPACITY=85
    BACKGROUND=232c31
    FOREGROUND=c5c8c6
    COLOR0=2d3c46
    COLOR1=ac4142
    COLOR2=90a959
    COLOR3=de935f
    COLOR4=6a9fb5
    COLOR5=aa759f
    COLOR6=75b5aa
    COLOR7=6c7a80
    COLOR8=425059
    COLOR9=cc6666
}


makecolor()
{
    echo $(printf "#%x%s" $((OPACITY*255/100)) "$1")
}

{ #GLOB VARS
    USER=$(whoami)
    GRP=$(id -g)
    HOST=$(hostname)
    DOMAIN=$(domainname)
    BATF="/sys/class/power_supply/BAT1/capacity"
    LDAVGF="/proc/loadavg"
    # static colors:
    USRC=\#ff000000
    DATEC=$(makecolor $COLOR3)
    test $GRP -eq 0 && USRC=darkred
    test $GRP -eq 2 && USRC=yellow
    test $GRP -eq 4 && USRC=maroon
    test $GRP -eq 3 && USRC=gray
    test $GRP -eq 5 && USRC=black
    test $GRP -eq 29 && USRC=green
    LDAVGC=$(makecolor $COLOR6)
    DESKCL=$(makecolor $COLOR1)
    FG=$(makecolor $FOREGROUND)
    BG=$(makecolor $BACKGROUND)
}

NAT=`hostname`
while sleep $SLP; do
    test $(($(date +%s)%20)) -eq 0 && NAT=$(curl --connect-timeout $((SLP*2)) -s icanhazip.com || echo "(no-*net)")
    echo
    {
        INET=$(ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | cut -d\  -f10 | tr \\n '|')
        BATS=$(cat $BATF)
        BATC=gray
        test $BATS -gt 80 && BATC=green
        test $BATS -lt 40 && BATC=yellow
        test $BATS -lt 20 && BATC=red
        BAT=$(printf "%3d" $BATS)
        LOADAVG=$(cat $LDAVGF | cut -d\  -f1-3)
        DESKC=$(xprop -root _NET_CURRENT_DESKTOP | sed -e 's/_NET_CURRENT_DESKTOP(CARDINAL) = //')
        test $DESKC -eq 0 && DESKB=9 || DESKB=$((DESKC-1))
        test $DESKC -eq 9 && DESKA=0 || DESKA=$((DESKC+1))
        # sep
        echo "%{c}%{+o}%{U-}"
        echo " < %{U$LDAVGC}%{A:xterm -e htop &:}$LOADAVG%{A}%{U-} > "
        echo " < %{U$BATC}%{A:xterm -e powertop &:}BAT: $BAT%%%{A}%{U-} >"
        echo " < %{U$DATEC}%{A:xclock &:}$(date +'%A, %Y-%m-%d | %H:%M:%S')%{A}%{U-} > "
        echo " < $DESKB |%{U$DESKCL} $DESKC %{U-}| $DESKA > "
        echo " < %{U$USRC}%{A:systemsettings &:}$USER@$INET$NAT%{A}%{U-} > "
    } | tr -d \\n | tr -s \ 
done | lemonbar -u$PX -F$FG -B$BG -f$FT -d

exit 0