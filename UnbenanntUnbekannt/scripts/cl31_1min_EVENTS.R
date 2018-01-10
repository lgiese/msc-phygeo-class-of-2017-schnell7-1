getwd()
setwd("/media/hans/907CE7487CE727A4/ARBEITuniMR/merged_csv/")
########## breaks als Grundlage zum sortieren
breaks = read.csv(file = "../2009_2016_breakpoints.csv")
#sichern der zeiten als character in spalte 5 anfang und 6 ende
breaks[,5] <- as.character(breaks[,1])
breaks[,6] <- as.character(breaks[,4])
#umwandeln in posiX
breaks[,1] <- as.POSIXct(breaks[,5], format = "%d.%m.%Y %H:%M" )
breaks[,4] <- as.POSIXct(breaks[,6],  format = "%d.%m.%Y %H:%M")
#zeitliche dauer der events
FOG_dur = breaks[4]-breaks[1]
#da aufloesung 1min: yeit in stunde * 60 (min/stunde) = anzahl der minuten/ereignis
#entspricht der Anzahl von Zeilen wenn 1min = 1 zeile
steps_pro_event = as.numeric(FOG_dur$fogEnd)*60


##############################
##### ./cl31/20091206_20141111_cl31_1mincldbase.csv
cl31_1min_cldbase = read.csv("cl31/20091206_20141111_cl31_1mincldbase.csv", header = T)
#datum erstellen aus 2 spalten
time_cl31_1min_cldbase = c()
for(i in dim(cl31_1min_cldbase)[1]){
  a = paste(cl31_1min_cldbase$X.date, cl31_1min_cldbase$time)
  a -> time_cl31_1min_cldbase
}
#datum formatieren
cl31_1min_cldbase[,1] <- as.POSIXct(time_cl31_1min_cldbase, format = "%Y-%m-%d %H:%M")
#neue tabelle hat nur noch 2 spalten (datum, cldbase)
cl31_1min_cldbase = cl31_1min_cldbase[,c(1,3)]


cl31_1min_cldbase_EVENTS = list()

for(i in 1:dim(breaks)[1]) {
  if (length(which(cl31_1min_cldbase[, 1] == breaks[i, 1])) >= 1) {
    a = cl31_1min_cldbase[which(cl31_1min_cldbase[, 1] == breaks[i, 1]) : (which(cl31_1min_cldbase[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
    a -> cl31_1min_cldbase_EVENTS[[i]]
  }
  else{
    "NA" -> cl31_1min_cldbase_EVENTS[[i]]
  }
}
# nur folgende events sind in diesem datensatz
which(sapply(cl31_1min_cldbase_EVENTS, length) > 1)
#als rds speichern
saveRDS(cl31_1min_cldbase_EVENTS, "cl31_1min_cldbase_EVENTS")


######./cl31/20091206_20141111_cl31_backscatter_1minRes.csv

cl31_1min_bckscttr = read.csv("cl31/20091206_20141111_cl31_backscatter_1minRes.csv")

#datum erstellen aus 2 spalten
time_cl31_1min_bckscttr = c()
for(i in dim(cl31_1min_bckscttr)[1]){
  a = paste(cl31_1min_bckscttr$date, cl31_1min_bckscttr$time1)
  a -> time_cl31_1min_bckscttr
}
cl31_1min_bckscttr[,1] <- as.POSIXct(time_cl31_1min_bckscttr, format = "%Y-%m-%d %H:%M")

cl31_1min_bckscttr_EVENTS = list()

for(i in 1:dim(breaks)[1]) {
  if (length(which(cl31_1min_bckscttr[, 1] == breaks[i, 1])) >= 1) {
    a = cl31_1min_bckscttr[which(cl31_1min_bckscttr[, 1] == breaks[i, 1]) : (which(cl31_1min_bckscttr[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
    a -> cl31_1min_bckscttr_EVENTS[[i]]
  }
  else{
    "NA" -> cl31_1min_bckscttr_EVENTS[[i]]
  }
}
# nur folgende events sind in diesem datensatz
which(sapply(cl31_1min_bckscttr_EVENTS, length) > 1)
#als rds speichern
saveRDS(cl31_1min_bckscttr_EVENTS, "cl31_1min_bckscttr_EVENTS")


##########cl31 preprocess

cl31_1min_prepro = read.csv("cl31/20091206_20140307_cl31_preprocessed.csv")



#datum erstellen aus 2 spalten
time_cl31_1min_prepro = c()
for(i in dim(cl31_1min_prepro)[1]){
  a = paste(cl31_1min_prepro$TIME, cl31_1min_prepro$X1)
  a -> time_cl31_1min_prepro
}
cl31_1min_prepro[,1] <- as.POSIXct(time_cl31_1min_prepro, format = "%Y-%m-%d %H:%M")

cl31_1min_prepro_EVENTS = list()

for(i in 1:dim(breaks)[1]) {
  if (length(which(cl31_1min_prepro[, 1] == breaks[i, 1])) >= 1) {
    a = cl31_1min_prepro[which(cl31_1min_prepro[, 1] == breaks[i, 1]) : (which(cl31_1min_prepro[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
    a -> cl31_1min_prepro_EVENTS[[i]]
  }
  else{
    "NA" -> cl31_1min_prepro_EVENTS[[i]]
  }
}
# nur folgende events sind in diesem datensatz
which(sapply(cl31_1min_prepro_EVENTS, length) > 1)
#als rds speichern
saveRDS(cl31_1min_prepro_EVENTS, "cl31_1min_prepro_EVENTS")