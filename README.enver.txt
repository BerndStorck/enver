
========================== README.enver.txt ==============================

Wozu soll man sich, fragt sich mancher Linuxneuling sicherlich, in
Terminalbefehle einarbeiten?  Kann man damit als normaler Mensch überhaupt
irgendetwas anfangen?

Ich habe versucht, mit diesem kleinen Projekt eine Antwort auf diese Fragen
zu geben.

Mein Skript "enver" (wie "englische Verben") demonstriert die Leistung des
Linux-Programms grep und soll ein alltagsnahes Beispiel geben, wozu man grep
nutzen kann. 

---------------------------------------------------------------------------
   enver beantwortet die Frage, was ein englisches Zeitwort bedeutet.
---------------------------------------------------------------------------

Das Programm grep kann ganze Dateien Zeile für Zeile darauf untersuchen,
in welchen Zeilen eine bestimmter Zeichenfolge vorkommt. grep gibt dann
die Zeilen aus, in denen die Zeichenfolge gefunden wurde - oder es listet,
wenn man dies möchte, nur alle Dateien auf, in denen die gesuchte
Zeichenfolge auftaucht. Die besondere Stärke von grep besteht darin, dass es
nicht nur nach eindeutig bekannten Zeichenfolgen suchen kann, sondern nach
Suchmustern, also beispielsweise nach allen Zeichenfolgen, welche die Form
einer E-Mail-Adresse oder einer Telefonnummer oder einer Website-Adresse
haben. Solche Suchmuster nennen Programmierer "reguläre Ausdrücke" oder 
"regex" für das Englische "regular expression"

Linguistische Perfektion habe ich nicht angestrebt.  Ich hoffe trotzdem,
dass mein Shell-Skript Euch oder Euren Kindern helfen wird, ein englisches
Verb bei Gelegenheit schnell erklärt zu bekommen.

"enver 1.0" habe ich im Februar 2018 auf "https://www.facebook.com/BStLinux/" 
veroeffentlicht.

Bernd Storck, Berlin am 20. Februar 2018


EINSATZVORBEREITUNGEN

DER DATENBESTAND, DIE DATEI "dictverbs.txt" IST URHEBERRECHTICH GESCHUETZT,
es handelt sich um einen geringfuegig vereinfachten Auszug aus einer
Woerterbuchdatei von dict.cc.

1.  Damit die Datei "dictverbs.txt" auf Ihrem Rechner generiert wird,
muessen Sie zuerst die Woerterbuchdatei von "dict.cc" herunterladen.  
Gehen Sie dafuer bitte auf die folgende Webseite:

https://www1.dict.cc/translation_file_request.php

Laden Sie von dort die Datei "EN -> DE" (tab-delimited, UTF-8)" herunter!

2.  Wenn noch nicht vorhanden, installieren Sie bitte das Programm unzip,
mit dem die Archivdatei entpackt wird, die Sie von dict.cc bekommen haben,
mit dem Kommando:

# apt install unzip

oder:

$ sudo apt-get -y install unzip

3.  Das Skript "mkbase.sh" kann fuer Sie die Archivdatei entpacken und die
gekürzte und vereinfachte Datendatei zu erzeugen, mit der das Skript "enver"
arbeitet.  Starten Sie dazu das Skript mit dem Namen der Archivdatei, die
Sie heruntergeladen haben.  Beispielsweise:

$ ./mkbase.sh cmcskfksrtk-9123454237-e9oi3u.zip

Am Ende sollten die Skriptdatei "enver" und eine Datei namens "dictverbs.txt" 
gemeinsam in einem Verzeichnis liegen, das möglichst in den Suchpfad ihres
Linux-Systems eingetragen sein sollte.
