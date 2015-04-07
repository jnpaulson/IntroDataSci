TreeMethods
========================================================
author: Hector Corrada Bravo
date: CMSC498T Intro Data Science



Tree-Based Methods
====================

Very popular, well-known and studied methods in Statistical Learning

- Decision Tree Models
- Random Forests

Regression Trees
==================

![plot of chunk unnamed-chunk-2](TreeMethods-figure/unnamed-chunk-2-1.png) 

***

![plot of chunk unnamed-chunk-3](TreeMethods-figure/unnamed-chunk-3-1.png) 

Regression Trees
==================

![plot of chunk unnamed-chunk-4](TreeMethods-figure/unnamed-chunk-4-1.png) 

***

![plot of chunk unnamed-chunk-5](TreeMethods-figure/unnamed-chunk-5-1.png) 

Prediction by space partitioning
=================================

Prediction by partitioning feature (predictor) space.

1. Partition space into $J$ non-overlapping regions, $R_1, R_2, \ldots, R_J$.
2. For every observation that falls within region $R_j$, predict response as mean of response for training observations in $R_j$.

**Regression Trees create partition recursively**

Regression Trees
===================

1. Find predictor $j$ and value $s$ that minimize RSS:

$$
\sum_{i:\, x_i \in R_1(j,s))} (y_i - \hat{y}_{R_1})^2 +
\sum_{i:\, x_i \in R_2(j,s))} (y_i - \hat{y}_{R_2})^2
$$

Where $R_1$ and $R_2$ are regions resulting from splitting observations on predictor $j$ and value $s$:

$$
R_1(j,s) = \{X|X_j < s\} \mathrm{ and } R_2(j,s) \{X|X_j \geq s\}
$$

$\hat{y}_{R_j}$ is the mean of the response $Y$ of observations in $R_j$.

Regression Trees
=================

![](8.3.png)

Regression Trees
=================

![plot of chunk unnamed-chunk-6](TreeMethods-figure/unnamed-chunk-6-1.png) 

***

![plot of chunk unnamed-chunk-7](TreeMethods-figure/unnamed-chunk-7-1.png) 

Regression Trees
=================

![plot of chunk unnamed-chunk-8](TreeMethods-figure/unnamed-chunk-8-1.png) 

***

![plot of chunk unnamed-chunk-9](TreeMethods-figure/unnamed-chunk-9-1.png) 

Regression Trees
=================

In R, built with similar API as linear models


```r
library(tree)
library(ISLR)
data(Auto)

tree_fit <- tree(mpg~horsepower+weight, data=Auto)
predict(tree_fit)
```
