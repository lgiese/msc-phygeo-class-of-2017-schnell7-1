load.all.RDS = function(path = "data/"){
  
  single_str = strsplit(dir(path), split = "_")
  
  var_str = c()
  for(i in 1:length(single_str)){
    single_str[[i]] = single_str[[i]][1:which(single_str[[i]] == "EVENTS")-1]
    var_str[i] = paste(single_str[[i]], collapse = "_")
  }
  
  data_str = dir(path)
  
  export = c()
  for(i in 1:length(data_str)){
    a = paste0(var_str[i], " = readRDS(\"",path , data_str[i], "\")")
    a -> export[i]
  }
  
  write(export, "loadme.R")
  
  #rm(list=ls())
  #.rs.restartR()
  
  source("loadme.R")
  file.remove("loadme.R")
  
} 

load.all.RDS("EVENTS/data/")

by.events = function(){
  tab = read.csv("../Rtmp/nebelEREIGNISSE.txt", header = FALSE)
  
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
  
  for(i in 1:190){
    paste(tage = )
  }
}