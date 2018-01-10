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

####################
######./campbell/20120319_20121029_Campbell_Temp_RH_Radiation_1minRes.csv
cmpb_1min = read.csv("campbell/20120319_20121029_Campbell_Temp_RH_Radiation_1minRes.csv", header = F)
cmpb_1min[,1] <- as.character(cmpb_1min[,1])
cmpb_1min[,1] <- as.POSIXct(cmpb_1min[,1], format = "%Y-%m-%d %H:%M:%S" )


cmpb_1min_EVENTS = list()

for(i in 1:dim(breaks)[1]) {
  if (length(which(cmpb_1min[, 1] == breaks[i, 1])) >= 1) {
    a = cmpb_1min[which(cmpb_1min[, 1] == breaks[i, 1]) : (which(cmpb_1min[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
    a -> cmpb_1min_EVENTS[[i]]
  }
  else{
    "NA" -> cmpb_1min_EVENTS[[i]]
  }
}
# nur folgende events sind in diesem datensatz
which(sapply(cmpb_1min_EVENTS, length) > 1)
#als rds speichern
saveRDS(cmpb_1min_EVENTS, "cmpb_1min_Temp_RH_Radi_EVENTS")

######./campbell/20121111_20141111_Campbell_CNR4_radiation_1minRes.csv
cmpb_1min_CNR4 = read.csv("campbell/20121111_20141111_Campbell_CNR4_radiation_1minRes.csv", header = T)
cmpb_1min_CNR4[,1] <- as.character(cmpb_1min_CNR4[,1])
cmpb_1min_CNR4[,1] <- as.POSIXct(cmpb_1min_CNR4[,1], format = "%Y-%m-%d %H:%M:%S" )

cmpb_1min_CNR4_EVENTS = list()

for(i in 1:dim(breaks)[1]) {
  if (length(which(cmpb_1min_CNR4[, 1] == breaks[i, 1])) >= 1) {
    a = cmpb_1min_CNR4[which(cmpb_1min_CNR4[, 1] == breaks[i, 1]) : (which(cmpb_1min_CNR4[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
    a -> cmpb_1min_CNR4_EVENTS[[i]]
  }
  else{
    "NA" -> cmpb_1min_CNR4_EVENTS[[i]]
  }
}
# nur folgende events sind in diesem datensatz
which(sapply(cmpb_1min_CNR4_EVENTS, length) > 1)
#als rds speichern
saveRDS(cmpb_1min_CNR4_EVENTS, "cmpb_1min_CNR4_EVENTS")

#######./campbell/20121111_20141111_Campbell_Temp_RH_1minRes.csv
cmpb_1min_Temp_RH = read.csv("campbell/20121111_20141111_Campbell_Temp_RH_1minRes.csv", header = F)
cmpb_1min_Temp_RH[,1] <- as.character(cmpb_1min_Temp_RH[,1])
cmpb_1min_Temp_RH[,1] <- as.POSIXct(cmpb_1min_Temp_RH[,1], format = "%Y-%m-%d %H:%M:%S" )

cmpb_1min_Temp_RH_EVENTS = list()

for(i in 1:dim(breaks)[1]) {
  if (length(which(cmpb_1min_Temp_RH[, 1] == breaks[i, 1])) >= 1) {
    a = cmpb_1min_Temp_RH[which(cmpb_1min_Temp_RH[, 1] == breaks[i, 1]) : (which(cmpb_1min_Temp_RH[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
    a -> cmpb_1min_Temp_RH_EVENTS[[i]]
  }
  else{
    "NA" -> cmpb_1min_Temp_RH_EVENTS[[i]]
  }
}
# nur folgende events sind in diesem datensatz
which(sapply(cmpb_1min_Temp_RH_EVENTS, length) > 1)
#als rds speichern
saveRDS(cmpb_1min_Temp_RH_EVENTS, "cmpb_1min_Temp_RH_EVENTS")
