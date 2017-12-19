getwd()
setwd("Dokumente/UniMR/GIT/Datenanalyse/data/")

tab = read.csv("feldfrucht.csv")
dep = names(tab)[7]
vars = names(tab)[8:16]


test = function(dep, vars, dataset = tab){
  formel = paste(dep, "~", paste(vars, collapse = " + "))
  lmod = lm(formel, data = dataset )
  return(summary(lmod)$adj.r.squared)
}

matze = data.frame()
for(i in 1:length(vars)){
  a = paste(vars[-i], collapse = "+")
  b = test(dep, vars[-i], dataset = tab )
  a -> matze[i,1]
  b -> matze[i,2]
}

# Gesamtmodell wird an letzte stelle von matze gestellt
a = paste(vars, collapse = "+")
b = test(dep, vars, dataset = tab)
a -> matze[length(vars)+1,1]
b -> matze[length(vars)+1,2]

#matze[which(matze[,2] == max(matze[,2])),]
neuevars = unlist(strsplit(matze[which(matze[,2] == max(matze[,2])),1], split = "+", fixed = T))

if(matze[dim(matze)[1],2] > max(matze[,2]) ){
  print("STOPP!")
}


k = 1
while(max(matze[1:(dim(matze)[1]-k), 2]) >= matze[(dim(matze)[1]-k+1),2] && length(neuevars) > 1) {
  for (i in 1:length(neuevars)) {
    a = paste(neuevars[-i], collapse = "+")
    b = test(dep, neuevars[-i], dataset = tab)
    a -> matze[i, 1]
    b -> matze[i, 2]
    
  }
  matze[which(matze[, 2] == max(matze[, 2])),] -> matze[length(neuevars)+1, ]
  neuevars = unlist(strsplit(matze[which(matze[, 2] == max(matze[, 2])), 1][1], split = "+", fixed = T))
  k = k+1
}

#beschreiben am besten das model
unlist(strsplit(matze[which(matze[, 2] == max(matze[, 2])), 1][1], split = "+", fixed = T))
#mit folgendem adj R squ
max(matze[,2])
