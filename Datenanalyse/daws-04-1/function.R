function(SPALTEMITDERVERWALTUNGSINFO){
  write(as.character(tab[,SPALTEMITDERVERWALTUNGSINFO]), file="bubuu.txt")
  verwaltung = read.table("bubuu.txt", fill=T, sep=",")
  neuetab = data.frame(tab[,1:(SPALTEMITDERVERWALTUNGSINFO-1)],verwaltung,tab[,(SPALTEMITDERVERWALTUNGSINFO+1):length(tab)])
  names(neuetab)[1]="Jahr"
  names(neuetab)[2]="PLZ"
  names(neuetab)[SPALTEMITDERVERWALTUNGSINFO]="Place"
  names(neuetab)[SPALTEMITDERVERWALTUNGSINFO+1]="Admin_unit"
  names(neuetab)[SPALTEMITDERVERWALTUNGSINFO+2]="Admin_misc"
  return(neuetab)
}
