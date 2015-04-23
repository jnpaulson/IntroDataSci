---
layout: default
title: Recap Unit 2
---

Unit 2 of the course presented methods for statistical and machine learning, and how these methods would be used as part of a data analysis project.

## General Concepts

- Inference vs. prediction
- Classification vs. regression
- Supervised vs. unsupervised learning
- Expected prediction error and the need to build models that generalize
- Bias vs. Variance tradeoff

## Regression Methods

- Least squares: linear and polynomial
  - Intepretation of parameters
  - Estimating accuracy of parameter estimates (SE)
  - Inference using hypothesis testing 
  - Estimating accuracy of fit (R squared)
- K-nearest neighbor regression
- Non-linear regression methods (loess)
- Tree based methods:
  - Regression Trees 
  - Random Forests
- Support Vector Machines:
  - linear
  - non-linear (kernel methods, based on similarity between observations)
  
## Classification Methods
- Logistic regression: linear and polynomial
  - Interpretation of parameters
  - Estimating accuracy of parameter estimates (SE)
  - Inference using hypothesis testing
- K-nearest neighbor classification
- Tree based methods:
  - Classification Trees 
  - Random Forests
- Support Vector Machines:
  - linear
  - non-linear (kernel methods, based on similarity between observations)

## Model complexity

Many of the methods above have _hyper-parameters_ that determine complexity of learned model:

- K-nearest neighbors: parameter is K determining the number of neighbors
- Classification/Regression Trees: parameter is tree depth, pruning methods used to determine proper tree depth
- Random Forests: number of trees and number of variables to sample at each recursive split
- Support Vector Machines: in both linear and non-linear cases there is the **cost** parameter, in non-linear case, there are kernel parameters, e.g., _degree_ for a polynomial kernel and _bandwidth_ (gamma) for an RBF (radial) kernel.

## Evaluation

In general we want to measure expected prediction error and use cross-validation methods to estimate that from a single dataset.

- Validation test: split into train and test once
- LOOCV: for each observation, train on all other observations, predict left out observation
- k-fold CV: partition observations into k groups, for each group, train on all other observations, test on left out group

All three of these can be used in either _model selection_ where hyper-parameters above are chosen, or _model assessment_ where the entire training procedure (including model selection) is evaluated. For the latter we prefer either LOOCV or k-fold CV

For classification we introduced a more sophisticated evaluation vocabulary beyond overall error. Based on the _confusion matrix_ and quantities derived from it, e.g., _False Positive Rate_, _True Positive Rate_, _Precision_, _Recall_, and corresponding _ROC_ curves, and _Precision-recall_ curves.

## Large-scale learning

We discussed gradient-descent based algorithms and how they can be parallelized, and it's _stochastic_ variant, frequently used for large datasets and as the basis of _streaming_ algorithms.
