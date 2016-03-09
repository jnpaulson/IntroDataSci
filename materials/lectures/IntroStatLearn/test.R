# proportion of spam in the the tweet population
p <- 0.05

# let's sample 100 tweets
x <- sample(c(0,1), size=100, replace=TRUE, prob=c(1-p,p))

# and the proportion that are spam
phat <- mean(x)

# now let's do that 1000 times
# first let's write a function that does that
get_sample <- function(n) mean(sample(c(0,1), size=n, replace=TRUE, prob=c(1-p,p)))
phats_100 <- replicate(1000, get_sample(100))
hist(phats_100, main="100 tweets", xlab="p hat", xlim=c(0,.2))

# what if we sample 10 tweets
phats_10 <- replicate(1000, get_sample(10))
hist(phats_10, main="10 tweets", xlab="p hat", xlim=c(0,.2))

# what if we sample 500 tweets
phats_500 <- replicate(1000, get_sample(500))
hist(phats_500, main="500 tweets", xlab="p hat", xlim=c(0,.2))

# what about 1000 tweets
phats_1000 <- replicate(1000, get_sample(1000))
hist(phats_1000, main="1000 tweets", xlab="p hat", xlim=c(0,.2))

# what about 10000 tweets
ys_10000 <- replicate(1000, get_sample(10000))
hist(ys_10000, main="10000 tweets", xlab="p hat", xlim=c(0,.2))


## let's calculate standard error
se <- sqrt(p*(1-p)) / sqrt(10000)

hist(ys_10000, main="10000 tweets", probability = TRUE, xlab="p hat", xlim=c(0,.2))
f <- dnorm(seq(0,.2,len=1000), mean=p, sd=se)
lines(seq(0,.2,len=1000), f, col="red", lwd=1.6)
