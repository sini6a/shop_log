#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

remove_data() {
echo
read -p "-> Напишете 'Да' доколку сте сигурни: " -r
if [[ $REPLY =~ "Да"$ ]]; then
echo "" > $DIR/logs.dat
echo
echo -e "${RED}--> Сите записи се избришани!${NC}"
sleep 3
clear
fi
}

# Center otuput
center() {
  termwidth="$(($(tput cols)-2))"
  padding="$(printf '%0.1s' -{1..500})"
  printf -- '%*.*s> %s <%*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

title="Karcher - TETOVO"
desc="Евиденција на записи."

prompt=\
"\t 1) Внеси запис.
\t 2) Напредно пребарување.
\t d) Избриши ги сите записи.
\t q) Излез.\n"

while :; do
clear
center "$title"
center "$desc"
echo
echo -e "$prompt"
read -n 1 -p $'\e[32m-> Изберете опција: \e[0m' n
case $n in
1) clear && $DIR/new_log.sh "$title" "$desc" ;; 
2) clear && $DIR/search_log.sh "$title" "$desc" ;;
[dD]) remove_data ;;
[qQ]) break ;;
*) echo "Неправилен избор" ;;
esac
done
