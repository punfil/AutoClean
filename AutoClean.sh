#!/bin/bash


# Author           : Wojciech Panfil ( s184657@student.pg.edu.pl )
# Created On       : 28.04.2021
# Last Modified By : Wojciech Panfil ( s184657@student.pg.edu.pl )
# Last Modified On : 29.04.2021 23:54
# Version          : 1.1
#
# Description      : Program pozwala na automatyczne
# Opis		     sortowanie plików. Skrypt do prawidlowej
#                    pracy wymaga pliku z funkcjami. Dla 
#		     najlepszego doznania zaleca sie posiadanie
#		     zenity.
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)

#Zmienne do funkcji, ktore nie zostana zmienione w trakcie pracy
readonly PLIK_Z_FUNKCJAMI="funkcje.rc"
readonly PLIK_Z_MANUALEM="manual.1"
readonly PLIK_WYWOLANIA=$(echo $0 | awk -F/ '{print $NF}')
readonly WERSJA="1.1"

#Odpowiednik enum, dla opcji drugiej (po czym sortowac)
readonly PO_ROZSZERZENIU=0
readonly PO_PIERWSZEJ_LITERZE=1
readonly PO_DACIE=2

#Odpowiednik enum, czy program w oknie czy w terminalu
readonly W_TERMINALU=0
readonly W_OKNIE=1

#Pozostale zmienne globalne, zmieniane w trakcie pracy
OKIENKOWY=$W_OKNIE
TRYB_SORTOWANIA=$PO_ROZSZERZENIU

. funkcje.rc

while getopts ":hvf" OPT; do
	case $OPT in
	f) 
		OKIENKOWY=$W_TERMINALU
		;;
	h) 
		Pomoc
		;;
	v) 
		Wersja
		;;
	*) 
		echo "Nieznana opcja"
		;;			
	esac
done

QUIT=0
CHOICE=0
EMPTY=""

while [ $QUIT -eq 0 ]; do
	MENU1="1. Tryb automatyczny. Uwaga! Wykonuje się w obecnym katalogu!"
	MENU2="2. Zmień sposób katalogowania trybu automatycznego"
	MENU3="3. Dopisz datę do pliku"
	MENU4="4. Segregowanie automatyczne z podkatalogami"
	MENU5="5. Wyjdz z programu"
	case $OKIENKOWY in
	0)
		echo $MENU1
		echo $MENU2
		echo $MENU3
		echo $MENU4
		echo $MENU5
		read CHOICE
		case "$CHOICE" in
		1)
			AutoClean1
			;;
		2)
			AutoClean2	
			;;
		3)
			AutoClean3
			;;
		4)
			AutoClean4
			;;
		5) 
			QUIT=1
			;;
		*)
			QUIT=1
			;;
		esac
		;;
	1)
		MENU=("$MENU1" "$MENU2" "$MENU3" "$MENU4" "$MENU5")
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
		$MENU4)
			AutoClean4
			;;
		$MENU5) 
			QUIT=1
			;;
		*)
			QUIT=1
			;;
		esac
		;;
	esac
done
