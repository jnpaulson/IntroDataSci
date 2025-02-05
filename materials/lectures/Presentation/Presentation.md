Communicating Results of Data Analysis
========================================================
author: Hector Corrada Bravo
date: CMSC498T: Introduction Data Science, Spring 2015

For Today
========================================================

Deliverables:
  - Written analyses
  - R packages

Written analyses
========================================================

Components:

1. Title
2. Introduction and motivation
3. Description of design
4. Description of dataset
5. Description of statistical and machine learning models used (Methods)
6. Results (including measures of uncertainty)
7. Conclusions (including potential problems)
8. References


Introduction and Motivation
========================================================

Always lead with the question (task) you are addressing.

E.g.: "Can we use tweets about stocks to predict stock prices?"
Not: "Can we use the Random Forest algorithm to learn a classifier that predicts stock prices"

E.g: "What are good predictors of student performance?"
Not: "Can we use linear regression to predict student performance"

Description of dataset
============================

Size: observations and variables
Important: describe what you did to 1) obtain, 2) tidy the dataset.

Description of statistical methods
======================================

Be specific, use equations when appropriate:

$$
W = a + b H + e
$$

where $W$ is _weight_, $H$ is _height_ and $e$ is an error term.

When appropriate mention distributional assumptions on $e$.

Results
=========

- Report estimates in the appropriate units
- Report estimates with uncertainty

We saw confidence intervals on our regression lecture

- Summarize importance of estimate (i.e., refer to the question you originally posed in introduction)

End matter
==========

- Include potential problems with the analysis you carried out.
- Include references to the analysis methods used.

Graphics
=========

Karl Broman's presentation on bad graphics:

[https://www.biostat.wisc.edu/~kbroman/presentations/IowaState2013/graphs_combined.pdf](https://www.biostat.wisc.edu/~kbroman/presentations/IowaState2013/graphs_combined.pdf)

Graphics
==========

A few other notes on style:
- Make titles legible
- Annotate in plot if possible (see PCA lecture example)
- Include units in axis titles when appropriate
  - E.g., not appropriate in PC scatterplot

R packages
===========

Case study: suppose you used data to create a classifier for diagnostic purposes. How do you share?

R packages is a reproducible, high-visibility way of publishing these types of results

R packages
===========

- Consistent organization
- Standardized deployment

R packages
===========

Hadley's presentation on R packages

[http://www.slideshare.net/hadley/r-packages](http://www.slideshare.net/hadley/r-packages)

[The book](http://proquest.safaribooksonline.com.proxy-um.researchport.umd.edu/book/programming/r/9781491910580)
