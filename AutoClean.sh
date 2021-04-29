#!/bin/bash


# Author           : Wojciech Panfil ( s184657@student.pg.edu.pl )
# Created On       : 28.04.2021
# Last Modified By : Wojciech Panfil ( s184657@student.pg.edu.pl )
# Last Modified On : 29.04.2021 
# Version          : 1.1
#
# Description      : Program pozwala na automatyczne
# Opis		     sortowanie plików. Skrypt do prawidlowej
#                    pracy wymaga pliku z funkcjami.
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)


readonly PLIK_Z_FUNKCJAMI="funkcje.rc"
readonly PLIK_Z_MANUALEM="manual.1"
PLIK_WYWOLANIA=$(echo $0 | awk -F/ '{print $NF}')
readonly WERSJA="1.0"
readonly PO_ROZSZERZENIU=0
readonly PO_PIERWSZEJ_LITERZE=1
readonly PO_DACIE=2
OKIENKOWY=0
TRYB_SORTOWANIA=$PO_ROZSZERZENIU

. funkcje.rc

while getopts ":hvf" OPT; do
	case $OPT in
		f) 
		OKIENKOWY=1
		;;
		h) 
		Pomoc
		;;
		v) 
		Wersja
		;;
		q) echo "Koniec"
			exit;;
		*) echo "Nieznana opcja";;
				
	esac
done

QUIT=0
CHOICE=0
EMPTY=""

while [ $QUIT -eq 0 ]; do
	MENU1="1. Tryb automatyczny. Uwaga! Wykonuje się w obecnym katalogu!"
	MENU2="2. Zmień sposób katalogowania trybu automatycznego"
	MENU3="3. Dopisz datę do pliku"
	MENU5="4. Segregowanie automatyczne z podkatalogami"
	MENU6="5. Wyjdz z programu"
	MENU=("$MENU1" "$MENU2" "$MENU3" "$MENU5" "$MENU6")
	CHOICE=$(zenity --list --column="Witamy w AutoClean!" "${MENU[@]}" --height 300 --width 600)
	case "$CHOICE" in
	$MENU1)
		AutoClean1
		;;
	$MENU2)
		AutoClean2	
		;;
	$MENU3)
		AutoClean3
		;;
	$MENU5)
		AutoClean4
		;;
	$MENU6) 
	QUIT=1
	;;
	$EMPTY)
	QUIT=1
	;;
	esac
done
