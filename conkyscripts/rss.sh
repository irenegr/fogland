 # RSS Feed Display Script by Hellf[i]re v0.1
#
# This script is designed for most any RSS Feed. As some feeds may not be
# completely compliant, it may need a bit of tweaking
#
# This script depends on curl.
# Gentoo: emerge -av net-misc/curl
# Debian: apt-get install curl
# Homepage: http://curl.haxx.se/
#
# Usage:
# .conkyrc: ${execi [time] /path/to/script/conky-rss.sh}
#
# Usage Example
# ${execi 300 /home/youruser/scripts/conky-rss.sh}

#RSS Setup
URI=http://www.foxnews.com/xmlfeed/rss/0,4313,1,00.rss #URI of RSS Feed
LINES=6 #Number of headlines

#Environment Setup
EXEC="/usr/bin/curl -s" #Path to curl

#Work Start
$EXEC $URI | grep title |\
sed -e :a -e 's/<[^>]*>//g;/</N' |\
sed -e 's/[ \t]*//' |\
sed -e 's/\(.*\)/ \1/' |\
sed -e 's/\.//' |\
sed -e 's/\"//' |\
sed -e 's/\"//' |\
head -n $(($LINES + 2)) |\
tail -n $(($LINES))