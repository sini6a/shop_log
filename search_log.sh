#!/bin/bash
# USE SEARCH AND REPLACE IF U WANT TO CHANGE SOME STRING
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Center otuput
center() {
  termwidth="$(($(tput cols)-2))"
  padding="$(printf '%0.1s' -{1..500})"
  printf -- '%*.*s> %s <%*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

# Center otuput but for bottom menu
center_cancel() {
  termwidth="$(($(tput cols)))"
  padding="$(printf '%0.1s' " "{1..500})"
  printf -- '\e[31m%*.*s %s %*.*s\n\e[0m' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

# Center otuput but for bottom menu
center_confirm() {
  termwidth="$(($(tput cols)))"
  padding="$(printf '%0.1s' " "{1..500})"
  printf -- '\e[32m%*.*s %s %*.*s\n\e[0m' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

COLS="(($(tput cols)/2))"

calculate_lines() {
if [ "$(grep -ci "$keyword" $DIR/logs.dat)" -gt 0 ]; then
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c -i "Дата")" -gt 0 ]; then
    before='0'
    after='9'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Име")" -gt 0 ]; then
    before='1'
    after='8'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Локација")" -gt 0 ]; then
    before='2'
    after='7'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "број")" -gt 0 ]; then
    before='3'
    after='6'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Производител")" -gt 0 ]; then
    before='4'
    after='5'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Модел")" -gt 0 ]; then
    before='5'
    after='4'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Цена")" -gt 0 ]; then
    before='6'
    after='3'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Дефект")" -gt 0 ]; then
    before='7'
    after='2'
    fi
    if [ "$(grep -i "$keyword" $DIR/logs.dat | grep -c "Платено")" -gt 0 ]; then
    before='8'
    after='1'
    fi
fi
}

while :; do
clear
center "$1"
center "$2"
echo
echo -e "\t${BLUE}--> Притиснете Enter за сите записи.${NC}\n"
read -p $'\e[32m-> Внесете име за пребарување: \e[0m' keyword
calculate_lines
echo
cat $DIR/logs.dat | grep -i "$keyword" -A "$after" -B "$before" --no-group-separator | more
center_cancel "Притиснете 'q' да прекинете со пребарување."
center_confirm "Притиснете било кое копче да пребарате повторно."
read -n 1 -r
if [[ $REPLY =~ [Qq]$ ]]
then
break
fi
done
