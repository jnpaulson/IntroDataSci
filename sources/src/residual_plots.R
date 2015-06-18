fit <- lm(dist~speed, data=cars)
plot(fitted(fit), residuals(fit), xlab="fitted values", ylab="residuals")
abline(h=0, lty=2)

rfit <- lm(residuals(fit)~bs(fitted(fit), 4))
lines(fitted(fit), fitted(rfit), col="red", lwd=1.5)

library(quantreg)
library(splines)

qfit1 <- rq(residuals(fit)~bs(fitted(fit), 4), tau=.1)
lines(fitted(fit), fitted(qfit1), col="blue", lwd=1.5)
qfit2 <- rq(residuals(fit)~bs(fitted(fit), 4), tau=.9)
lines(fitted(fit), fitted(qfit2), col="blue", lwd=1.5)
