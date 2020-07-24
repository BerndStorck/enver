#! /bin/bash
#
# mkbase.sh 1.3.1  (2020-07-24)
#
# Erzeugt eine vereinfachte, kuerzere Datendatei aus der Woerterbuchdatei von dict.cc.
#
# Die Ausgabedatei bekommt den Dateinamen dictverbs.txt und enthaelt nur Datensaetze ueber
# englische Zeitwoerter.

script_name="mkbase.sh"
version="1.3.1"

display_help_screen() {
 	echo "$script_name"
	echo -e "\t\"$script_name\" erzeugt aus einer Archivdatei von \"dict.cc\""
	echo -e "\tdie Datenbasis fuer \"enver\"."
	echo -e "\nAUFRUFFORMATE:"
	echo -e "\t$script_name [--help|-h|--hilf]"
	echo -e "\t$script_name ARCHIVDATEI"
	echo -e "\nBEISPIEL:"
	echo -e "\t$script_name cmcskgksbk-9165184237-e6oi6u.zip"
	echo -e "\nAUFRUFPARAMETER:";
	echo -e "\t--help, -h oder --hilf zeigt diese Hilfeseite an."
}


if [ "$1" ]; then

	case $1 in
		-h|--help|--hilf|-hilf|--hilfe)
			display_help_screen
			;;
		--version|-version|-\#)
			echo "$version"
			;;
		*)
			dict_archive="$1"
			;;
	esac

else
	dict_archive="$(ls -A1 cm*.zip)"

fi


if [ "$dict_archive" ]; then

	if ! unzip "$dict_archive"; then

		echo "FEHLER: Die Woerterbuchdatei konnte nicht entpackt werden." > /dev/stderr

	else

		inputfile="${1//.zip/.txt}"
		if [ "$inputfile" ]; then

			grep --color=never -E "[[:blank:]]verb[[:blank:]]*$" "$inputfile" | \
			cut -f1,2 | grep "^[^#]" > dictverbs.txt
			# 2020-03-21: For enver 3.5.0 or newer versions:
			grep --color=never -E "^\[you\] " "$inputfile" >> dictverbs.txt

			echo -e "\nDIE VOKABELDATEI IST URHEBERRECHTLICH GESCHUETZT,"
			echo -e "SIE DARF NUR PRIVAT GENUTZT WERDEN:\n"
			head -n12 "$inputfile" | grep '^#'
			rm "$inputfile"
			sleep 4
			echo -e "\nDas Kommando \"enver --help\" zeigt die Bedienungsanleitung an."

		else
			echo "FEHLER: Die entpackte Woerterbuchdatei von \"dict.cc\" fehlt." > /dev/stderr
		fi

	fi

fi
