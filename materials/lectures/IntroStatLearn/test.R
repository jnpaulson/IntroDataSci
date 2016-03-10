# proportion of spam in the the tweet population
p <- 0.75

# let's sample 100 tweets
x <- sample(c(0,1), size=100, replace=TRUE, prob=c(1-p,p))

# and the proportion that are spam
phat <- mean(x)

# if we had an oracle that let's us do this cheaply,
# we could replicate our experiment 1000 times

# first let's write a function that gets an estimate
# from a random sample
get_estimate <- function(n) mean(sample(c(0,1), size=n, replace=TRUE, prob=c(1-p,p)))
phats_100 <- replicate(1000, get_estimate(100))
hist(phats_100, main="100 tweets", xlab="p hat", xlim=c(0,.2))

pdf("replication_example.pdf", width=7,height=7)
par(mfrow=c(2,3))
# what if we sample 10 tweets
phats_10 <- replicate(1000, get_estimate(10))
hist(phats_10, main="10 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)

# what if we sample 100 tweets
phats_100 <- replicate(1000, get_estimate(100))
hist(phats_100, main="10 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)

# what if we sample 500 tweets
phats_500 <- replicate(1000, get_estimate(500))
hist(phats_500, main="500 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)

# what about 1000 tweets
phats_1000 <- replicate(1000, get_estimate(1000))
hist(phats_1000, main="1000 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)

# what about 5000 tweets
phats_5000 <- replicate(1000, get_estimate(5000))
hist(phats_5000, main="5000 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)

# what about 10000 tweets
phats_10000 <- replicate(1000, get_estimate(10000))
hist(phats_10000, main="10000 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
dev.off()


# we can calculate standard error for each of the
# above settings, and compare these replications
# to the normal distribution given by the CLT

se <- sqrt(p*(1-p))/sqrt(10000)
hist(phats_10000, main="10000 tweets", probability = TRUE, xlab="p hat", xlim=c(0.5,1))
f <- dnorm(seq(0.5,1,len=1000), mean=p, sd=se)
lines(seq(0.5,1,len=1000), f, col="red", lwd=1.6)

# let's write a function that adds a normal density
# plot for a given sample size
draw_normal_density <- function(n) {
  se <- sqrt(p*(1-p))/sqrt(n)
  f <- dnorm(seq(0.5,1,len=1000), mean=p, sd=se)
  lines(seq(0.5,1,len=1000), f, col="red", lwd=1.6)
}

pdf("replication_example2.pdf", width=7,height=7)
par(mfrow=c(2,3))
# what if we sample 10 tweets
phats_10 <- replicate(1000, get_estimate(10))
hist(phats_10, main="10 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
draw_normal_density(10)

# what if we sample 100 tweets
phats_100 <- replicate(1000, get_estimate(100))
hist(phats_100, main="10 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
draw_normal_density(100)

# what if we sample 500 tweets
phats_500 <- replicate(1000, get_estimate(500))
hist(phats_500, main="500 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
draw_normal_density(500)

# what about 1000 tweets
phats_1000 <- replicate(1000, get_estimate(1000))
hist(phats_1000, main="1000 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
draw_normal_density(1000)

# what about 5000 tweets
phats_5000 <- replicate(1000, get_estimate(5000))
hist(phats_5000, main="5000 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
draw_normal_density(5000)

# what about 10000 tweets
phats_10000 <- replicate(1000, get_estimate(10000))
hist(phats_10000, main="10000 tweets", xlab="p hat", xlim=c(.5,1), probability=TRUE)
draw_normal_density(10000)
dev.off()

