#!/bin/bash

#tmp Ordner erstellen
mkdir -p Rtmp

#raussuchen der Nebelereignisse
ls lindendata_preprocess/fog_events_by_vis/2009/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2010/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2011/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2012/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2013/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2014/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2015/ >> Rtmp/nebelEREIGNISSE.txt; 
ls lindendata_preprocess/fog_events_by_vis/2016/ >> Rtmp/nebelEREIGNISSE.txt;

#raussuchen der sensoren (unterordner von 'lindendata_preprocess')
ls lindendata_preprocess/ >> Rtmp/sensoren.txt;

#Rscript laden um Kommandobefehle zu erzeugen
Rscript --vanilla sortieR.R

#tmp Ordner löschen
# rm -r Rtmp

# hier entkommentieren, um direkt zu sortieren; legt sortiert/... an (vgl sortieR.R)
# sh sortierbat.sh
