#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'

BACKUP=2
 
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

one(){
	echo "one() called"
        pause
}

reset(){
	echo "Reset resolv.conf with backup file"
	mv /etc/resolv.conf.default /etc/resolv.conf
	sed -i 's/BACKUP=2/BACKUP=2/g' main.sh
	exit
} 

two(){
	echo "two() called"
        pause
}
 
show_menus() {
	clear
	echo "=================="	
	echo " Easy-DNSChanger"
	echo "==================="
	echo "[1.] Set DNS to Localhost (127.0.0.1)"
	echo "[2.] Reset Terminal"
	echo "[3.] Reset To Default"
	echo "[4.] Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) reset ;;
		4|q) exit 0;;
		*) echo -e "${RED}Invalid Input Option ${choice} ...${STD}" && sleep 1
	esac
}
 
trap '' SIGINT SIGQUIT SIGTSTP

if [ $BACKUP == 1 ]
then
    echo "Creating resolv.conf backup files...." && sleep 1
    cp /etc/resolv.conf /etc/resolv.conf.default 
    sed -i 's/BACKUP=2/BACKUP=2/g' main.sh
fi

while true
do
	show_menus
	read_options
done
