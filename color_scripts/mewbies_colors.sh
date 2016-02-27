#!/bin/bash
###############################################################################
#   ANSI Color Script modified by mewbie at http://mewbies.com 06-06-2013     #
#   The original initializeANSI() part of the script is from pfh at           #
#   http://crunchbang.org/forums/viewtopic.php?id=13645                       #
#   pfh's script and the following contributions from many inspired this      #
#                                                                             #
#   The Console Color Codes part of the script is from                        #
#   Daniel Crisman's ANSI color chart script in                               #
#   The Bash Prompt HOWTO: 6.1. Colours at                                    #
#   http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html                     #
#                                                                             #
#   I combined the two, added on, and use for my own reference                #
#   This same output can be found in HTML format at http://mewbies.com/       #
#   motd_console_codes_color_chart_in_color_black_background.htm              #
#   P.S I purposely left off the 'Chart' the blinking demonstration  :)       #
###############################################################################

initializeANSI()
{
  esc=""

  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   magentaf="${esc}[35m"
  cyanf="${esc}[36m";    grayf="${esc}[37m"
  
  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
  yellowb="${esc}[43m"   blueb="${esc}[44m";   magentab="${esc}[45m"
  cyanb="${esc}[46m";    grayb="${esc}[47m"

  boldon="${esc}[1m";    boldof="${esc}[22m"
  italicson="${esc}[3m"; italicsoff="${esc}[23m"
  ulon="${esc}[4m";      uloff="${esc}[24m"
  invon="${esc}[7m";     invoff="${esc}[27m"

  reset="${esc}[0m"
}
initializeANSI
cat << EOF
${boldon}
${redf} █████   █████${greenf} █████████${yellowf} ████   ██   ████${bluef} ██████████ ${magentaf} ████${cyanf} █████████${boldof}${grayf}  ████████ 
${redf}${boldof}░░${boldon}█████ █████ ${greenf}${boldof}░░${boldon}██${boldof}░░░░░${boldon}█${yellowf}${boldof}░░${boldon}██   ${boldof}░${boldon}██  ${boldof}░░${boldon}██ ${bluef}${boldof}░░${boldon}██${boldof}░░░░░${boldon}███${magentaf}${boldof}░░${boldon}██ ${cyanf}${boldof}░░${boldon}██${boldof}░░░░░${boldon}█${boldof}${grayf} ███${boldon}${blackf}░░░░${boldof}${grayf}███
${redf}${boldof} ░${boldon}██${boldof}░${boldon}█████${boldof}░${boldon}██ ${greenf} ${boldof}░${boldon}██  █ ${boldof}░${boldon} ${yellowf} ${boldof}░${boldon}██   ${boldof}░${boldon}██   ${boldof}░${boldon}██ ${bluef} ${boldof}░${boldon}██    ${boldof}░${boldon}███${magentaf} ${boldof}░${boldon}██ ${cyanf} ${boldof}░${boldon}██  █ ${blackf}░ ░${boldof}${grayf}███   ${boldon}${blackf}░░░ 
${redf}${boldof} ░${boldon}██${boldof}░░${boldon}███ ${boldof}░${boldon}██ ${greenf} ${boldof}░${boldon}█████   ${yellowf} ${boldof}░${boldon}██   ${boldof}░${boldon}██   ${boldof}░${boldon}██ ${bluef} ${boldof}░${boldon}█████████ ${magentaf} ${boldof}░${boldon}██ ${cyanf} ${boldof}░${boldon}█████   ${blackf}░░${boldof}${grayf}████████ 
${redf}${boldof} ░${boldon}██${boldof} ░░░  ░${boldon}██ ${greenf} ${boldof}░${boldon}██${boldof}░░${boldon}█   ${yellowf} ${boldof}░░${boldon}██  ████  ██  ${bluef} ${boldof}░${boldon}██${boldof}░░░░░${boldon}███${magentaf} ${boldof}░${boldon}██ ${cyanf} ${boldof}░${boldon}██${boldof}░░${boldon}█    ${boldon}${blackf}░░░░░░░${boldof}${grayf}███
${redf}${boldof} ░${boldon}██${boldof}      ░${boldon}██ ${greenf} ${boldof}░${boldon}██ ${boldof}░${boldon}   █${yellowf}  ${boldof}░░${boldon}██████████${boldof}░  ${bluef} ░${boldon}██    ${boldof}░${boldon}███${magentaf} ${boldof}░${boldon}██ ${cyanf} ${boldof}░${boldon}██ ${boldof}░${boldon}   █${boldof}${grayf} ███   ${boldon}${blackf}░${boldof}${grayf}███
${redf}${boldon} ████     ████${greenf} █████████${yellowf}   ${boldof}░░${boldon}███ ${boldof}░${boldon}███    ${bluef} ██████████ ${magentaf} ████${cyanf} █████████${boldon}${blackf}░░${boldof}${grayf}████████
${redf}░░░░     ░░░░ ${greenf}░░░░░░░░░ ${yellowf}    ░░░  ░░░     ${bluef}░░░░░░░░░░  ${magentaf}░░░░ ${cyanf}░░░░░░░░░ ${boldon}${blackf} ░░░░░░░░ ${boldof}${reset} 


                        ${boldon}├──  SOME ANSI CHARACTERS ───┤${boldof}
        █ ▓ ▒ ░ ▄ ▀ ▐ ▌ ● ═ ║ ╔ ╦ ╗ ╚ ╩ ╝ ■ ▬ ▲ ▼ ◄ ► ┌┼└┼└ ┐┌ ─ ┤├


              ╔═══════════════════════════════════════════════════╗
              ║                ${boldon}CONSOLE CODE'S CHART${boldof}               ║
              ║                                                   ║
              ║  ${boldon}COLOR    TEXT BACKGROUND  COLOR          TEXT${boldof}    ║
              ║  ${grayb}${blackf}Black      30${reset}     40      ${boldon}${blackf}Dark Gray      1;30${boldoff}${reset}    ║
              ║  ${redf}Red        31     41      ${boldon}${redf}Light Red      1;31${boldof}${reset}    ║
              ║  ${greenf}Green      32     42      ${boldon}${greenf}Light Green    1;32${boldof}${reset}    ║
              ║  ${yellowf}Yellow     33     43      ${boldon}${yellowf}Light Yellow   1;33${boldof}${reset}    ║
              ║  ${bluef}Blue       34     44      ${boldon}${bluef}Light Blue     1;34${boldof}${reset}    ║
              ║  ${magentaf}Magenta    35     45      ${boldon}${magentaf}Light Magenta  1;35${boldof}${reset}    ║
              ║  ${cyanf}Cyan       36     46      ${boldon}${cyanf}Light Cyan     1;36${boldoff}${reset}    ║
              ║  ${grayf}Light Gray 37     47      ${blackb}${boldon}${grayf}White          1;37${boldof}${reset}    ║
              ║                                                   ║
              ║  ${boldon}FORMAT         FORMAT${boldof}                            ║
              ║  reset          0            underscore on,       ║
              ║  ${boldon}bold           1${boldof}  default foreground color 38    ║
              ║  half-bright    2           underscore off,       ║
              ║  ${ulon}underline${uloff}      ${ulon}4${uloff}  default foreground color 39    ║
              ║  blink          5  default background color 49    ║
              ║  inverse        7                                 ║
              ║  conceal        8                                 ║
              ║  normal        22            ${boldon}man console_codes${boldof}    ║
              ║  underline off 24                                 ║
              ║  blink off     25                                 ║
              ║  inverse off   27                  mewbies.com    ║
              ║                                                   ║
              ╚═══════════════════════════════════════════════════╝


                          ${boldon}├── CONSOLE COLOR CODES ───┤${boldof}
EOF

T='Mew'

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo
