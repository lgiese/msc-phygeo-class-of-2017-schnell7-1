tab = read.table(file="115-46-4_feldfruechte.txt", fileEncoding = "ISO-8859-1", skip = 6, sep=";", header = T, na.strings = c("", ".", "-", "/"), fill = T, dec=",")
lastline = 8925
tab = data.frame(tab[1:lastline,])

x = tab$Winterweizen
y = tab$Wintergerste
par(mfrow=c(1,1))
plot(x, y, xlab = 'Winterweizen', ylab = 'Wintergerste')
mod = lm(y ~ x)
abline (mod, col = 'red')
library(car)
regLine(mod, col = 'red')
#points(x,mod$fitted.values, col= 'blue')

par(mfrow = c(2,2))
plot(mod, main = "W.Gerste ~ W.Weizen")
summary(mod)
anova(mod)

#modell muss model sein, durchl die anzahl an durchlaeufen, leange die anzahl der ausgewaehlten residuen max 5000 wgn shapiro 7020 bei gerste ~ weizen 
ha5 = function(modell, durchl, laenge) {
  h0abgelehnt = c()
  
  for ( k in 1:durchl){
    lis = list()
    p.val = c()
    for (i in 1:laenge) {
      sam = sample(1 : length(modell$residuals), laenge)
      sha = shapiro.test(modell$residuals[sam])
      #sam -> lis[[i]]
      sha$p.value -> lis[[i]]
      sha$statistic -> lis[[i]][2]
      lis[[i]][1] -> p.val[i]
    }
    
    length(which(p.val > 0.05)) -> h0abgelehnt[k]
  }
  
  par(mfrow=c(1,3))
  hist(h0abgelehnt, main= "Verteilung der Anzahl abgelehnter H0")
  plot(1:durchl, h0abgelehnt/100, xlab = "x", ylab = "% der abgelehnten H0 pro Durchlauf", main="sd als schw. Linie; mean rot")
  abline(h = mean(h0abgelehnt/100), col = 'red')
  abline(h = mean(h0abgelehnt/100) + sd(h0abgelehnt/100), col = 'black' )
  abline(h = mean(h0abgelehnt/100) - sd(h0abgelehnt/100), col = 'black' )
  boxplot(h0abgelehnt/100, main = 'h0abgelehnt')
}