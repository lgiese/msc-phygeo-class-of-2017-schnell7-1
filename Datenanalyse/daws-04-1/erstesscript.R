tab = read.table(file="115-46-4_feldfruechte.txt", fileEncoding = "ISO-8859-1", skip = 6, sep=";", header = T, na.strings = c("", ".", "-", "/"), fill = T, dec=",")
lastline = 8925
tab = data.frame(tab[1:lastline,])