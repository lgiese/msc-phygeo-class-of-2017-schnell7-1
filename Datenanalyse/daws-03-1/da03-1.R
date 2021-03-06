getwd()
setwd("/home/hans/Dokumente/UniMR/Datenanalyse/Aufgaben/")

tab = read.csv(file = "hessen_holzeinschlag_1997-2014.csv", skip = 4, sep = ";")

# tab = tab[1:18,]
# which(tab == "Buntholz ab 2010 in Buche enthalten")-1

# tab = tab[- which(tab == "Buntholz ab 2010 in Buche enthalten"),]

# as.character(tab$FWJ)-> tab[,1]
# as.Date.character(tab$FWJ, format="%Y") -> tab[,1]
# as.numeric(tab$FWJ) -> tab[,1]
# as.Date.factor(tab$FWJ, format="%Y") -> tab[,1]
# as.Date(tab$FWJ, format="%Y") -> tab[,1]
# c(1997:2014) -> tab$FWJ


# write.csv(x = tab, file = "hessen_holzeinschlag_1997-2014_clean.csv")
# ctab = read.csv(file = "hessen_holzeinschlag_1997-2014_clean.csv")



par(mfrow=c(2,3))

for (i in 2:7){
  hist(tab[,i], main = names(tab[i]), xlab="Anzahl")
}

for (i in 2:7)  {
  boxplot(tab[,i], main = paste("boxplot", names(tab[i])))
}

for (i in 2:7)  {
  plot(x = tab[,1], y = tab[,i], type="l", main = names(tab[i]), xlab ="Jahr", ylab="Anzahl")
}




par(mfrow=c(2,2))
for (i in c(2,4,5,6)){
  plot(x = c(1:18), y=tab$Buche, type="l", main= paste("Buche (schwarz) mit", names(tab[i]), "(rot)"), ylim=c(0,6524), xlab="Jahr", ylab = "Anzahl")
  points(x = tab[,i], col="red", type="l")
}

par(mfrow=c(2,2))
for (i in c(2,4,5,6)){
  plot(x = tab$FWJ, y=tab$Buche, type="l", main= paste("Buche (schwarz) mit", names(tab[i]), "(rot)"), ylim=c(0,6524), xlab="Jahr", ylab = "Anzahl")
  points(x = tab[,i], col="red", type="l")
}










