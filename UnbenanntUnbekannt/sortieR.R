# Pfad über "lindendata_preprocess"
#deaktiviert weil ueber Konsole aufgerufen wird

#setwd("")
getwd()
tab = read.csv("Rtmp/nebelEREIGNISSE.txt", header = FALSE)

#Anzahl der Ereignisse für Schleifen
lange = dim(tab)[1]

#Für levels(a) (Zeile 16)
a = tab[1,1] 
b = c()

for (i in 1:lange){
  levels(a)[i]->b[i]
}

#trennt Zeichenkette am "_"
splittung = strsplit(b, split = "_")

ersT = c()
zweiT = c()
for (i in 1:lange){
  splittung[[i]][1] -> ersT[i]
  splittung[[i]][4] -> zweiT[i]
}

#Später wird mit levels(tage) doppelt vorkommende Tage ausgeblendet
tage = as.factor(c(ersT, zweiT))

#erfasst auch den Ordner mit den Ereignissen, ist aber harmlos
sensoren = read.csv(file = "Rtmp/sensoren.txt", header = F)
sensor = as.character(sensoren[,1])

#Erstellung der Kommandobefehle
strng1 = "find lindendata_preprocess/"
# sensor
strng2 = "/ -type f -name '"
# tage
strng3 = "*csv.*' -exec cp {} sortiert/"
# sensor
strng4 = "/ \\;"

bat = matrix(nrow = lange, ncol =length(sensor))

for (j in 1:length(sensor)){
  for (i in 1:lange){
     bat[i,j] <- paste(strng1, sensor[j], strng2, levels(tage)[i], strng3, sensor[j], strng4,  sep = "") 
   }
}

#erstellt Ordner nach 'sensor' dort wo hin kopiert wird vgl 'strng3'
mkdir = c()
for (i in 1:length(sensor)){
  mkdir[i] <-paste("mkdir -p sortiert/", sensor[i], " ;", sep="") 
}

#write(x = c("#!/bin/bash", mkdir), file="dirbatch.sh")
write(x = c("#!/bin/bash", mkdir , bat), file = "sortierbat.sh")

