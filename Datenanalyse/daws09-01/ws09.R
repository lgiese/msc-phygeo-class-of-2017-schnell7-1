getwd()
setwd("Datenanalyse/")
dwd = read.table("produkt_synop_Terminwerte_20060701_20151231_03164.txt", header =T, sep=";")
dwd$MESS_DATUM <- as.POSIXct(as.character(dwd$MESS_DATUM), format = "%Y%m%d%H")

plot( dwd$MESS_DATUM, dwd$NIEDERSCHLAGSHOEHE, type = "h")

#
dwd$AGG_M <- substr(dwd$MESS_DATUM, 6, 7)
boxplot(dwd$NIEDERSCHLAGSHOEHE ~ dwd$AGG_M)

par_org <- par()
par(mfrow = c(1,2))
hist(dwd$NIEDERSCHLAGSHOEHE, prob = TRUE)
lines(density(dwd$NIEDERSCHLAGSHOEHE))
qqnorm(dwd$NIEDERSCHLAGSHOEHE)

#############################################################################
#
par(mfrow = c(1,1))
acf(dwd$NIEDERSCHLAGSHOEHE, lag.max = 100)

dwd$AGG_JM <- substr(dwd$MESS_DATUM, 1, 6)
tam <- aggregate(dwd$NIEDERSCHLAGSHOEHE, by = list(dwd$AGG_JM), FUN = mean)
colnames(tam) <- c("Date", "Ta")
acf(tam$Ta)

pacf(tam$Ta)

Box.test(tam$Ta, lag = 10, type = "Box-Pierce")
Box.test(tam$Ta, lag = 10, type = "Ljung-Box")

############################################################################
#
dTa <- diff(diff(tam$Ta))
acf(dTa)

#autoregressives modell
armod <- ar(dTa, aic = TRUE, order.max = 15, method = "yule-walker")
armod
plot(0:15, armod$aic, type = "o")

par_org <- par()
par(mfrow = c(1,2))
acf(dTa)
pacf(dTa)
par(mfrow= c(1,1))

arpred <- predict(armod, n.ahead = 100)

plot(dTa, type = "l", xlim = c(0, length(dTa)+100))
lines(arpred$pred, col = "red")
lines(arpred$pred + arpred$se, col = "grey")
lines(arpred$pred - arpred$se, col = "grey")

# ARIMA
#p between 0 and 5
#d between 0 and 2
#q between 0 and 5
for(i in 1:dim(e_grid)[1]){
armod <- arima(tam$Ta, order = c(e_grid[i,][,1],e_grid[i,][,2],e_grid[i,][,3]), method = "ML")  # the order is p, d, q
print(armod)
summary(armod)
}
e_grid = expand.grid(p=c(0:5), d=(0:2), q=(0:5))


lapply(e_grid, )