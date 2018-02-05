#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# You can change currency here
cur="мкд"

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

date_format=$(date +"%d/%m/%y - %H:%M")

user_inputs() {
    read -p "-> Внесете име: " name
    read -p "-> Внесете локација: " location
    read -p "-> Внесете телефонски број: " contact
    read -p "-> Внесете производител: " manuf
    read -p "-> Внесете модел: " model
    read -p "-> Внесете цена (во $cur): " price
    read -p "-> Дефект: " other
    read -n 1 -r -p "-> Платено? (y/n): "
    if [[ $REPLY =~ [YyДд]$ ]]; then
    paid="Да"
    else
    paid="Не"
    fi
}

print_confirm() {
local final_confirm="--> Дата: ${GREEN}$date_format${NC}
--> Име: ${RED}${name^}${NC}
--> Локација: ${RED}${location^}${NC}
--> Телефонски број: ${RED}$contact${NC}
--> Производител: ${RED}${manuf^^}${NC}
--> Модел: ${RED}${model^^}${NC}
--> Цена: ${RED}$price ${BLUE}${cur,,}${NC}.
--> Дефект: ${RED}${other^^}${NC}
--> Платено: ${RED}${paid^}${NC}"
echo -e "$final_confirm"
}

# Main program
center "$1"
center "$2"
echo
user_inputs

clear
center "$1"
center "$2"
echo
print_confirm
echo

echo -e "${BLUE}-> Дали сте сигурни? (y/n) ${NC}"
read -n 1 -r
echo

if [[ $REPLY =~ [YyДд]$ ]]
then
confirmed=$(print_confirm)
echo -e "$confirmed" >> $DIR/logs.dat || sleep infinity
## send some notification ##
notify-send "Успешно внесен запис"
echo -e "${GREEN}--> Успешно внесен запис${NC}"
echo "" >> $DIR/logs.dat
# sleep 3
fi

# FOR PRINTING To PDF
echo -e "${BLUE}-> Дали сакате да испечатите? (y/n) ${NC}"
read -n 1 -r
echo

if [[ $REPLY =~ [YyДд]$ ]]
then
echo -e "$confirmed" | lpr -P pdf
## send some notification ##
echo -e "${GREEN}--> Ispecateno${NC}"
sleep 3
fi
