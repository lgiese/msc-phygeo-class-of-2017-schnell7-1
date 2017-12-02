x = anscombe$x1
y = anscombe$y1
plot(x, y)
mod = lm(y ~ x)
abline (mod)
library(car)
regLine(mod, col = 'red')
points(x,mod$fitted.values, col= 'blue')



mod = lm(neuetab$Anteil.Erholungsfl�che.an.Gesamtfl�che ~ neuetab$Anteil.Siedlungs..und.Verkehrsfl�che.an.Gesamtfl.)
par(mfrow=c(1,1))
plot(mod$model$`neuetab$Anteil.Siedlungs..und.Verkehrsfl�che.an.Gesamtfl.`, mod$model$`neuetab$Anteil.Erholungsfl�che.an.Gesamtfl�che`)
abline(mod, col = 'red')
par(mfrow = c(2,2))
plot(mod)
summary(mod)
anova(mod)


mod2 = lm(neuetab$Anteil.Siedlungs..und.Verkehrsfl�che.an.Gesamtfl. ~ neuetab$Anteil.Erholungsfl�che.an.Gesamtfl�che)
par(mfrow=c(1,1))
plot(mod2$model$`neuetab$Anteil.Erholungsfl�che.an.Gesamtfl�che`, mod2$model$`neuetab$Anteil.Siedlungs..und.Verkehrsfl�che.an.Gesamtfl.`)
abline(mod2, col = 'red')
par(mfrow = c(2,2))
plot(mod2)
summary(mod2)
anova(mod2)



summary(mod)
summary(mod2)

anova(mod)
anova(mod2)


sied = neuetab$Anteil.Siedlungs..und.Verkehrsfl�che.an.Gesamtfl.