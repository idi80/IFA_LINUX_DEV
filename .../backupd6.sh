#!/bin/bash     
# backupd6.sh   : Variante von backupd1.sh
#description    :Backup-Kopie eines Quellverzeichnisses $1 unterhalb
#                eines Zielverzeichnisses, das entweder durch $BACKDIR
#                vorgegeben ist, oder alternativ im aktuellen Verzeichnis
#                An den Namen des Zielverzeichnisses wird das Datum angehängt§
#date           :20180618
#version        :1      
#usage          :./backupd6 Zielverzeichnis
#notes          :verbessert  backupd5 wie folgt       
#                1.: Prüfung Schreibberechtigung im Verzeichnis $1?
#                    Dann Fehlermeldung und exit 2
#bash_version   :3.2.57(1)-release
#============================================================================

# wurde genau ein Parameter übergeben?
if [ $# != 1 ] 
then
	echo Benutzung: $0 Quellverzeichnis
	exit 1
fi

# existiert das Quellverzeichnis?
if [ ! -d $1 ] 
then
	echo Quellverzeichnis $1 existiert nicht oder ist kein Verzeichnis
	exit 2
fi

# Ist die Variable BACKDIR leer oder nicht gesetzt?
# Dann wird die Variable zielpfad hier auf den Default-Wert "." gesetzt 
zielpfad=${BACKDIR:=.}

# Test ob in $zielpfad geschrieben werden darf
if [ ! -w $zielpfad ]
then
	echo Keine Schreibberechtigung in $zielpfad
	exit 3
fi

# Schrittweises Zusammensetzen des Kopierziels
# basename liefert den Verzeichnisnamen ohne Pfad
quellname=/`basename $1`
datum=`date +%Y_%m_%d`
ziel=$zielpfad$quellname.$datum

# Existiert das Zielverzeichnis oder eine Datei mit dem gleichen Namen?
if [ -e $ziel ]
then
 
	# Abfrage, ob Zielverzeichnis überschrieben werden soll
	antwort=n
	echo -n "$ziel existiert bereits, überschreiben? (y/n): "
	read -r antwort

	if [ "$antwort" != "y" ]
	then
		# Zielverzeichnis/Datei löschen und neu anlegen
		# Bei Misserfolg Abbruch
		rm -rf $ziel || exit 4
	fi
fi

# Die eigentliche Kopieraktion
# Bei Misserfolg Abbruch
cp -R $1  $ziel || exit 5

# Nur jetzt wird der Returncode 0 zurückgegeben
exit 0
