#!/bin/sh
#AccuWeather (r) RSS weather tool for conky
#
#USAGE: weather.sh <locationcode>
#
#(c) Michael Seiler 2007
#requires curl

METRIC=1 #Should be 0 or 1; 0 for F, 1 for C

if [ -z $1 ]; then
    echo
    echo "USAGE: weather.sh "EUR|GR|GR007|Athens""
    echo
    exit 0;
fi

curl -s http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=${METRIC}\&locCode\=$1 \
| sed -n '/Currently:/ s/.*: \(.*\): \([-0-9]*\)\([CF]\).*/\1\ \2°\3/p'

#Source = https://bbs.archlinux.org/viewtopic.php?pid=567663#p567663