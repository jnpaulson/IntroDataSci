


Tyding Data
========================================================
author: Hector Corrada Bravo
date: CMSC498T Spring 2015

Catching up with Baltimore Analysis
========================================================

**Reminder**: You can check current status of Baltimore analysis
here: [http://htmlpreview.github.io/?https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.html](http://htmlpreview.github.io/?https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.html)

Some thoughts
- Make sure your analysis is reproducible: i.e., your classmates must be able to add to it and have it run. I always update 
the `html` file before merging your analysis. I will not accept pull requests that are not reproducible.
- If you use new data in the analysis add it to the repository using `git add`

Catching up with Baltimore Analysis
========================================================

**Reminder**: You can check current status of Baltimore analysis
here: [http://htmlpreview.github.io/?https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.html](http://htmlpreview.github.io/?https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.html)

Some thoughts
- Always pull from my repository `https://github.com/hcorrada/IntroDataSciBaltimore`, and fix any conflicts
before making your pull request. 
- I've updated [homework description](http://cbcb.umd.edu/~hcorrada/IntroDataSci/homeworks/hw1_part1.html) with workflow.



Best Practices
========================================================

Don't overwrite original data frames. Especially when filtering
rows. One way to avoid this is to make use of lexical scoping.


```r
x <- 300
f <- function() {x <- 3; x}
f()
```

```
[1] 3
```

```r
x
```

```
[1] 300
```

Example: [https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.Rmd#krishna-pai](https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.Rmd#krishna-pai)

Best Practices
========================================================

Avoid loops that operate on one data element at a time

```r
labelDataType <- function(lon, lat, df) {
  for (i in 1:nrow(df)) {
    if (lon > df[i,]$minlon & 
          lon <= df[i,]$maxlon & 
          lat > df[i,]$minlat & 
          lat <= df[i,]$maxlat ) {
  	return(2) # label as in camera area
          break
      } 
  }
  return(1) # label as not in camera area
}

labelDataType <- function(lon, lat, df) {
  any(lon > df$minlon & lon <= df$maxlon 
      & lat > df$minlat & lat <= df$maxlat)
}
```

Best Practices
========================================================

Avoid loops that operate on one data element at a time

```r
for (i in 1:nrow(arrest_tab)) {
  arrest_tab[i,18] <- labelDataType(arrest_tab[i,]$lon,
    arrest_tab[i,]$lat, camLocs)
}

arrest_tab[,18] <- mapply(labelDataType, 
                          arrest_tab$lon, 
                          arrest_tab$lat, 
                          MoreArgs=list(df=camLocs))
```

Tidy Data
========================================================

[H. Wickham (2014). Tidy Data. *Journal of Statistical Software*.](http://www.jstatsoft.org/v59/i10/paper)

Principles of preparing and organizing data in a way that is amenable to analysis, modeling and visualization.

- **Structure**: Data organized in rectangular tables (rows and columns)
- **Semantics**: Values, variables, observations

Tidy Data
========================================================

Let's look at example tidy data

```r
library(nycflights13)
head(flights)
```

Tidy Data
========================================================

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table

*Note*: Related to Codd's 3rd normal form (DB theory) with different language

Tidy Data
====================================

Common problems

- Column headers are values, not variable names (gather)
- Multiple variables stored in one column (split)
- Variables stored in both rows and column (rotate)
- Multiple types of observational units are stored in the same table (normalize)
- Single observational unit stored in multiple tables (join)

Manipulation
==================================

Common verbs:

- Subsetting or removing observations based on some condition: 
- Adding or modifying variables: 
- Collapsing multiple values into a single value: 
- Changing order of observations: 

Manipulation
======================================

The `dplyr` package: one of the most beautiful tools created for data analysis

- Clearly defines and efficiently implements most common data manipulation operations (verbs)
- Built around tidy data principles
- Uniform treatment of multiple backends (in memory files, partially loaded files, databases)
- Pipes can be used to elegantly chain multiple manipulation operations

What we haven't covered
=========================================

- How to deal with missing data?
- When and how to transform observational units?

Read Section 4.1 of Zumen & Mount

