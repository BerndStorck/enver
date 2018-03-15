#! /bin/bash
#
# mkbase.sh
#
# Erzeugt eine vereinfachte, kuerzere Datendatei aus der Woerterbuchdatei von dict.cc.
# 
# Die Ausgabedatei bekommt den Dateinamen dictverbs.txt und enthaelt nur Datensaetze ueber
# englische Zeitwoerter.

script_name="mkbase.sh"

display_help_screen() {
 	echo "$script_name"
	echo -e "\t\"$script_name\" erzeugt aus einer Archivdatei von \"dict.cc\" die Datenbasis fuer \"enver\"."
	echo -e "\nAUFRUFFORMAT:"
	echo -e "\t$script_name [--help|-h] ARCHIVDATEI"
	echo -e "\nBEISPIEL:"
	echo -e "\t$script_name cmcskgksbk-9165184237-e6oi6u.zip"
	echo -e "\nAUFRUFPARAMETER:";
	echo -e "\t--help oder -h zeigt diese Hilfeseite an."
}


if [ "$1" ]; then

	case $1 in
		-h|--help)
			display_help_screen
			;;
		*)
			dict_archive="$1"
			;;
	esac

else
	dict_archive="$(la -1 cmc*.zip)"

fi 


if [ "$dict_archive" ]; then

	unzip "$dict_archive"

	if [ "$?" -ne 0 ]; then

		echo "FEHLER: Die Woerterbuchdatei konnte nicht entpackt werden." > /dev/stderr

	else
	
		inputfile=$(echo "$1" | sed "s/.zip/.txt/")

		if [ "$inputfile" ]; then

			grep --color=never -E "[[:blank:]]verb$" "$inputfile" | \
			cut -f1,2 > dictverbs.txt

			echo -e "\nDIE VOKABELDATEI IST URHEBERRECHTLICH GESCHUETZT, DARF NUR PRIVAT GENUTZT WERDEN:\n"
			head -n12 "$inputfile" | grep '^#'
			rm "$inputfile"
			sleep 4
			echo -e "\nDas Kommando \"enver --help\" zeigt die Bedienungsanleitung an."

		else
			echo "Die entpackte Woerterbuchdatei von \"dict.cc\" wurde nicht gefunden." > /dev/stderr
		fi

	fi

fi
