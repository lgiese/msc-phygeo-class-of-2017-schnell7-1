anscombe
names(anscombe)
dep = names(anscombe)[1]
vars = names(anscombe)[5:8]

test = function(dep, vars, dataset = anscombe){
  formel = paste(dep, "~", paste(vars, collapse = " + "))
  lmod = lm(formel, data = dataset )
  return(summary(lmod)$adj.r.squared)
}

matze = data.frame()
for(i in 1:length(vars)){
  a = paste(vars[-i], collapse = "+")
  b = test(dep, vars[-i], dataset = anscombe)
  a -> matze[i,1]
  b -> matze[i,2]
}

# Gesamtmodell wird an letzte stelle von matze gestellt
a = paste(vars, collapse = "+")
b = test(dep, vars, dataset = anscombe)
a -> matze[length(vars)+1,1]
b -> matze[length(vars)+1,2]

#matze[which(matze[,2] == max(matze[,2])),]
neuevars = unlist(strsplit(matze[which(matze[,2] == min(matze[,2])),1], split = "+", fixed = T))

if(matze[dim(matze)[1],2] < matze[dim(matze)[1]-1,2] ){
  print("STOPP!")
}


while(matze[dim(matze)[1], 2] > max(matze[dim(matze)[1]-1, 2 && length(neuevars) > 1])) {
  for (i in 1:length(neuevars)) {
    a = paste(neuevars[-i], collapse = "+")
    b = test(dep, neuevars[-i], dataset = anscombe)
    a -> matze[i, 1]
    b -> matze[i, 2]
    
  }
  neuevars = unlist(strsplit(matze[which(matze[, 2] == min(matze[, 2])), 1], split = "+", fixed = T))
}
