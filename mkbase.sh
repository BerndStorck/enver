#!/usr/bin/env bash
#
# mkbase.sh
# Version: Look at the first constant definitions below!
#
# Project Description:
#   de: Erzeugt eine vereinfachte, kuerzere Datendatei aus der Woerterbuchdatei von dict.cc.
#       Die Ausgabedatei bekommt den Dateinamen dictverbs.txt und enthaelt nur Datensaetze
#       ueber englische Zeitwoerter.
#   en: Creates a simplified, shorter data file from the dict.cc dictionary file.
#       The issuing file receives the file name 'dictverbs.txt' and 
#       only contains data records about English time words.
#
# Usage:
#   enver --help
#
# Dependencies:
#   - unzip
#   - awk
#   - find
#
# Author:    Bernd Storck
# Contact:   https://www.facebook.com/BStLinux/
#
# History:  2020-07-24, 2023-07-01, 2025-03-11
#
# Copyright: 2025, Bernd Storck
# License:   GNU General Public License 3.0
#

script_name="mkbase.sh"
version="1.3.3"

display_help_screen() {
  printf "%s\n" "$script_name"
  printf "\t\"%s\" erzeugt aus einer Archivdatei von \"dict.cc\"\n" "$script_name"
  printf "\tdie Datenbasis fuer \"enver\".\n"
  printf "\nAUFRUFFORMATE:\n"
  printf "\t%s [--help|-h|--hilf]\n" "$script_name"
  printf "\t%s ARCHIVDATEI\n" "$script_name"
  printf "\nBEISPIEL:\n"
  printf "\t%s cmcskgksbk-9165184237-e6oi6u.zip\n" "$script_name"
  printf "\nAUFRUFPARAMETER:\n"
  printf "\t--help, -h oder --hilf zeigt diese Hilfeseite an.\n"
  printf "\nKONTAKT:\n"
  printf "\thttps://www.facebook.com/BStLinux/\n"
}

display_error() {
    printf "FEHLER: %s\n" "$1" > /dev/stderr
}

extract_verb_records () {
  if command -v awk > /dev/null; then
    awk -F'\t' '{
        if ($0 ~ /[[:blank:]]verb[[:blank:]]*$/ && $0 !~ /^#/) {
            print $1, $2
        }
        if ($0 ~ /^\[you\] /) {  # For enver 3.5.0 (2020-03-21) or newer versions.
            print $0
        }
    }' "$inputfile" > dictverbs.txt
  else
    grep --color=never -E "[[:blank:]]verb[[:blank:]]*$" "$inputfile" | \
    cut -f1,2 | grep "^[^#]" > dictverbs.txt
    # 2020-03-21: For enver 3.5.0 or newer versions:
    grep --color=never -E "^\[you\] " "$inputfile" >> dictverbs.txt
  fi
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
  # Sucht nach der neuesten ZIP-Datei im aktuellen Verzeichnis
  dict_archive=$(find . -maxdepth 1 -name 'cm*.zip' -print0 | xargs -0 ls -1t | head -n 1)

fi


if [ "$dict_archive" ]; then

  if ! unzip "$dict_archive"; then

    display_error "FEHLER: Die Woerterbuchdatei konnte nicht entpackt werden."
    exit 1

  else

    inputfile="${1//.zip/.txt}"
    if [ "$inputfile" ]; then

      extract_verb_records

      printf "\nDIE VOKABELDATEI IST URHEBERRECHTLICH GESCHUETZT,"
      printf "SIE DARF NUR PRIVAT GENUTZT WERDEN:\n"
      head -n12 "$inputfile" | grep '^#'
      rm "$inputfile"
      sleep 4
      printf "\nDas Kommando \"enver --help\" zeigt die Bedienungsanleitung an.\n"

    else
      display_error "FEHLER: Die entpackte Woerterbuchdatei von \"dict.cc\" fehlt."
      exit 1
    fi

  fi

fi

exit 0
