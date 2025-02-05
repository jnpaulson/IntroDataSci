

Exploratory Data Analysis
========================================================
author: Hector Corrada Bravo
date: CMSC498T Spring 2015

For Today
=====================================

- Invited Q&A
- Project I
- Exploratory Data Analysis

Project I
======================================

[http://cbcb.umd.edu/~hcorrada/IntroDataSci/homeworks/hw1_part2.html](http://cbcb.umd.edu/~hcorrada/IntroDataSci/homeworks/hw1_part2.html)

EDA (Exploratory Data Analysis)
===================

Initial exploration of (mostly) variables across observations

1. Exploration of single variables  
2. Exploration of variable pairs  
3. Exploration of multiple variables (later in class)  

EDA
========================================

Purposes:

1. Spot problems in data (as part of data wrangling)
2. Understand variable properties:
  - central trends (mean)
  - spread (variance)
  - skew
  - suggest possible modeling strategies (e.g., probability distributions)
  
EDA
=======================================

Purposes:

3. Understand relationship between pairs of variables
  - correlation
  - covariance
  
Summary Statistics
========================================


```r
summary(flights$carrier)
table(flights$carrier)
summary(flights$dep_delay)
```

- Identify missing variables (last lecture)
- Identify outliers
- Identify skew
- Understand units

Visual Exploration of single variable
=========================================

Boxplots, histograms and densities


```r
boxplot(flights$dep_delay)
boxplot(flights$minute)
hist(flights$dep_delay)
hist(flights$minute)
plot(density(flights$dep_delay, na.rm=TRUE))
plot(density(flights$minute, na.rm=TRUE))
```

Visual Exploration of single variables
=========================================

In many cases modeling methods work better when data is roughly normal.
We can check that using a Quantile-Quantile (Q-Q) plot


```r
qqnorm(flights$dep_delay)
qqnorm(flights$minute)
```

Transforming Data
=========================================

Discretizing continuous values. Uses:

- Easier to compare differences related to continuous measurements: Do doctors prescribe a certain medication to older kids more often?

- A good trick to capture non-linear relationships in data: we will see this in our regression and prediction unit.

Transforming Data
=========================================

Two standard methods:
1. equal-length bins


```r
is.missing <- is.na(flights$dep_delay)
flights %>% 
  mutate(dep_delay_fixed = 
           ifelse(!is.missing, dep_delay, 
                  mean(dep_delay, na.rm=TRUE))) %>%
  mutate(dep_delay_discrete = cut(dep_delay_fixed, 100)) %>%
  ggplot(aes(dep_delay_discrete)) +
  geom_bar()
```

Transforming Data
=========================================

Two standard methods:
2. equal-sized bins


```r
is.missing <- is.na(flights$dep_delay)
flights %>% 
  mutate(dep_delay_fixed = 
           ifelse(!is.missing, dep_delay, 
                  mean(dep_delay, na.rm=TRUE))) %>%
  mutate(dep_delay_discrete = cut(dep_delay_fixed, 
          breaks=quantile(dep_delay_fixed, probs=seq(0,1,len=11)))) %>%
  ggplot(aes(dep_delay_discrete)) +
  geom_bar()
```

Transforming Data
=========================================

Treating discrete values as continuous

- Many modeling algorithms work strictly on numeric (continuous) measurements. 
- In this case, we would transform discrete values into continous. We saw an example of this in our regression example in Baltimore data (where we coded Male as 1 and female as 0). 
- Here, we need to think of *how to interpret* the model we'll use
- We'll see more of this in the regression unit.

Transforming Data
=========================================

Dealing with skewed data




```r
flights %>% ggplot(aes(dep_delay)) + geom_histogram(binwidth=30)
```

![plot of chunk unnamed-chunk-8](eda-figure/unnamed-chunk-8-1.png) 

Transforming Data
=========================================

Dealing with skewed data




```r
library(magrittr)
flights %>% 
  sample_n(100) %>% 
  magrittr::extract2("dep_delay") %T>% 
  qqnorm %>% 
  qqline
```

![plot of chunk unnamed-chunk-10](eda-figure/unnamed-chunk-10-1.png) 

Skewed Data
=========================================

Considerations:
- Long-tail variables hard to incorporate into some modeling procedures, especially in the presence of other variables that are not long-tailed
- Variables may capture *multiplicative* processes: very common in physical and biochemical processes

Skewed Data
=========================================

When a multiplicative process makes sense, then a logarithmic transform is appropriate to handle this.

- If values are all positive: apply `log2` transform
- If some values are negative, two options
  - Started Log: shift all values so they are positive, apply `log2`
  - Signed Log: $sign(x) \times log2(abs(x))$, but set all $|x| < 1$ to $1$.
  
Try them out! Explore result with Q-Q plots!

