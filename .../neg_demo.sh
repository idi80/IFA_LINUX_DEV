#!/bin/bash     
# neg_demo.sh   :Demonstriert den Einsatz des Negationsoperators !
#date           :20180828
#version        :1.0    
#notes          :       
#bash_version   :3.2.57(1)-release
#============================================================================

# neg_demo: Demonstriert die Negation mit !

file=$1

if [ ! -e $file ] 
then 
    if ! touch $file 
    then 
        echo "touch $file fehlgeschlagen" 
        exit 1
    else
        echo "$file angelegt" 
    fi 
else
    echo "$file existiert schon" 
fi
echo "$file vorhanden!"

