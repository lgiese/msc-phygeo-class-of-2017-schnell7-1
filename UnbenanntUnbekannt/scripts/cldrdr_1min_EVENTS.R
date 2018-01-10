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


sammeln = function(x, breaks = breaks, steps_por_event = steps_por_event){
  x_EVENTS = list()
  
  for(i in 1:dim(breaks)[1]) {
    if (length(which(x[, 1] == breaks[i, 1])) >= 1) {
      a = x[which(x[, 1] == breaks[i, 1]) : (which(x[, 1] == breaks[i, 1]) + steps_pro_event[i]) , ]
      a -> x_EVENTS[[i]]
    }
    else{
      "NA" -> x_EVENTS[[i]]
    }
  }
  return(x_EVENTS)
}


weristin = function(x){
  which(sapply(x, length) > 1)
}

datefr2col = function(col1, col2, data){
  time_data = c()
  for(i in dim(data)[1]){
    a = paste(as.character(data[,col1]), as.character(data[,col2]))
    a -> time_data
  }
  data[,1] <- as.POSIXct(time_data,  format =  "%Y-%m-%d %H:%M")
  return(data)
}

##################cloudradar
###prepocessed

cldrdr_preprocessed = read.csv("cloudradar/20091206_20140307_rcr002_mod_preprocessed2.csv", header = F)
#zeit / datum aus 2 spalten erstellen
time_cldrdr_preprocessed = c()
for(i in dim(cldrdr_preprocessed)[1]){
  a = paste(cldrdr_preprocessed$V1, cldrdr_preprocessed$V2)
  a -> time_cldrdr_preprocessed
}

#datum formatieren
cldrdr_preprocessed[,1] <- as.POSIXct(time_cldrdr_preprocessed, format = "%Y-%m-%d %H:%M")


cldrdr_preproc_EVENTS = sammeln(cldrdr_preprocessed, breaks, steps_pro_event)
weristin(cldrdr_preproc_EVENTS)

saveRDS(cldrdr_preproc_EVENTS, "cldrdr_preproc_EVENTS")


######./cloudradar/20091206_20140430_rcr002_mod_CloudInfo_1min.csv
cldrdr_cldinfo = read.csv("cloudradar/20091206_20140430_rcr002_mod_CloudInfo_1min.csv")

cldrdr_cldinfo = datefr2col(col1 = 1, col2 = 2, data = cldrdr_cldinfo)

cldrdr_cldinfo_EVENTS = sammeln(cldrdr_cldinfo, breaks, steps_pro_event )

weristin(cldrdr_cldinfo_EVENTS)

saveRDS(cldrdr_cldinfo_EVENTS, "cldrdr_cldinfo_EVENTS")

####./cloudradar/20091206_20140430_rcr002_mod_Zrangecorrected_1minRes.csv

cldrdr_Zrangecor = read.csv("cloudradar/20091206_20140430_rcr002_mod_Zrangecorrected_1minRes.csv", header = T)
head(cldrdr_Zrangecor)
cldrdr_Zrangecor = datefr2col(1, 2, data=cldrdr_Zrangecor)

cldrdr_Zrangecor_EVENTS = sammeln(cldrdr_Zrangecor, breaks, steps_pro_event)

weristin(cldrdr_Zrangecor_EVENTS)

saveRDS(cldrdr_Zrangecor_EVENTS, "cldrdr_Zrangecor_EVENTS")
