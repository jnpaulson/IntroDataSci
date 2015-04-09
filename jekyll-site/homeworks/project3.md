---
layout: default
title:  "Project 3: Classification"
---

**Due**: April 22nd, 2015
**Posted**: April 9th, 2015
**Last Update**: April 9th, 2015


Note: All required packages and datasets needed for this should be
available in the class Docker image. [More info here](http://cbcb.umd.edu/~hcorrada/IntroDataSci/resources.html)

### Question 1
(This is a modified question 10 Chapter 4 of ISLR)

This question should be answered using hte `Weekly` data set, which is
part of the `ISLR` package. This data is similar in nature to the
`Smarket` data from this chapter's lab, except that it contains 1,089
weekly returns for 21 years, from the beginning of 1990 to the end
of 2010. You can load this data using:

{% highlight r %}
library(ISLR)
data(Weekly)
{% endhighlight %}

a. Produce some numerical and graphical summaries of the `Weekly`
data. Do there appear to be patterns?

b. Use the full data set to perform a logistic regression with
`Direction` as the response and the five lag variables plus `Volume`
as predictors. Use the `summary` function to print the results. Do any
of the predictors appear to be statistically significant? If so, which
ones?

c. Compute the confusion matrix and overall fraction of correct
predictions. Explain what the confusion matrix is telling you about
the types of mistakes made by logistic regression.

d. Now fit the logistic regression model using a training data period
from 1990 to 2008, with `Lag2` as the only predictor. Compute the
confusion matrix and the overall fraction of correct predictions for
the held out data (that is, the data from 2009 and 2010).

e. Repeat (d) using LDA

f. Repeat (d) using KNN with K=1

g. Repeat (d) using a decision tree

h. Repeat (d) using a Support Vector Machine with quadratic (degree 2
polynomial) kernel

i. Which of these methods appears to provide the best results on this
data?

k. Experiment with different combinations of predictors, including
possible transformations and interactions, for each of the
methods (logistic regression, LDA, KNN, decision tree, SVM). Also
experiment with a random forest.

Report the variables, method and associated confusion matrix
that appears to provide the best results on the held out data. Note
that you should also experiment with values for K in the KNN
classifier, size of decision trees, number of trees in random forest,
number of features to try in random forest, and kernel type in SVM
(including a linear kernel).

###Question 2
(This is question 7 from Chapter 5 from ISLR)

a. Fit a logistic regression model that predicts `Direction` using
`Lag1` and `Lag2`.

b. Fit a logistic regression model that predicts `Direction` using
`Lag1` and `Lag2` _using all but the first observation_.

c. Use the model from (b) to predict the direction of the first
observation. You can do this by predicting that the first observation
will go up if \\( P(\mathtt{Direction}=\mathtt{"Up"}|\mathtt{Lag1,Lag2})
> 0.5 \\). Was this observation correctly classified?

d. Write a for loop from \\( i=1 \\) to \\( i=n \\), where \\( n \\) is the number of
observations in the data set that performs each of the following
steps:

i. Fit a logistic regression model using all but the \\(i\\)th observation
to predict `Direction` using `Lag1` and `Lag2`.

ii. Compute the posterior probability of the market moving up for the
\\(i\\)th observation.
iii. Use the posterior probability for the \\( i\\)th observation in order
to predict whether or not the market moves up.

iv. Determine whether or not an error was made in predicting the
direction for the \\(i\\)th observation. If an error was made, then
indicate this as a 1, otherwise indicate it as a 0.

e. Take the average of the \\(n\\) numbers obtained in (d)iv in order to
obtain the LOOCV estimate for the test error. Comment on the results.

###Question 3

a. Use 10-fold cross validation to estimate prediction error for a
random forest that predicts `Direction` using all predictors in the
`Weekly` dataset. 

b. Do the same for an SVM using a "radial" kernel.

c. Do the same for an SVM using a "polynomial" kernel.

d. Using a t-test (see lecture notes), is prediction error for the
SVM with "radial" kernel significantly better than the SVM with "polynimal" kernel.

e. Using a t-test, is prediction error for the random forest
significantly better than the SVM with "radial" kernel? Is it
significantly better than the SVM with "polynomial" kernel?

###Hading in
Submit your answers (including both code and text as appropriate) as
a knitted R markdown file (call it `project3.pdf`).

