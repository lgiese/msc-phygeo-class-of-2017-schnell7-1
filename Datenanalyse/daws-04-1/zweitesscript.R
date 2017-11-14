tab = read.table(file = "AI001_gebiet_flaeche.txt", fill=T, sep=";", skip = 4, header=T, fileEncoding = "ISO-8859-1", dec = ",", na.strings = c("", "."))
write(as.character(tab[,3]), file="bubuu.txt")
verwaltung = read.table("bubuu.txt", fill=T, sep=",")
neuetab = data.frame(tab[,1:2],verwaltung,tab[,4:7])
names(neuetab)[1]="Jahr"
names(neuetab)[2]="PLZ"
names(neuetab)[3]="Place"
names(neuetab)[4]="Admin_unit"
names(neuetab)[5]="Admin_misc"

tabmitverwaltung = verwaltungstrenner(3)
saveRDS(tabmitverwaltung, "neuetab.RDS")
