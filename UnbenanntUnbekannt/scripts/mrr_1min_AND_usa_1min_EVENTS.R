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

datefr2col = function(col1, col2, data, format =  "%Y-%m-%d %H:%M"){
  time_data = c()
  for(i in dim(data)[1]){
    a = paste(as.character(data[,col1]), as.character(data[,col2]))
    a -> time_data
  }
  data[,1] <- as.POSIXct(time_data,  format)
  return(data)
}




##################### /mrr /usa
######./mrr/20091206_2014111_mrr_RR_1minRes.csv

mrr = read.csv("mrr/20091206_2014111_mrr_RR_1minRes2.csv", header = F)
head(mrr)

#mrr = datefr2col(col1 = 1, col2 = 2, data = mrr, format = "%Y-%m-%d  %H:%M")

as.POSIXct(mrr[,1], format="%Y-%m-%d  %H:%M") -> mrr[,1]

mrr_EVENTS = sammeln(x = mrr, breaks, steps_pro_event)

weristin(mrr_EVENTS)

#saveRDS(mrr_EVENTS, "mrr_EVENTS")

######./usa/20091206_usa_1minRes.csv

usa = read.csv("usa/20091206_usa_1minRes2.csv", header = F)

head(usa)

usa = datefr2col(1, 2, usa)

usa_EVENTS = sammeln(usa, breaks, steps_pro_event)

weristin(usa_EVENTS)

saveRDS(usa_EVENTS, "usa_EVENTS")
