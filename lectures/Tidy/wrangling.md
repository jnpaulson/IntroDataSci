

Data Wrangling
========================================================
author: Wikum Dinalankara and Hector Corrada Bravo
date: CMSC498T Spring 2015

Catching up with Baltimore Analysis
========================================================

**Reminder**: You can check current status of Baltimore analysis
here: [http://htmlpreview.github.io/?https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.html](http://htmlpreview.github.io/?https://github.com/hcorrada/IntroDataSciBaltimore/blob/master/baltimore.html)

Some thoughts
- Make sure your analysis is reproducible: i.e., your classmates must be able to add to it and have it run. I always update 
the `html` file before merging your analysis. I will not accept pull requests that are not reproducible.
- If you use new data in the analysis add it to the repository using `git add`

Tidy Data
========================================================

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table

For Today
=====================================

- Manipulating tidy data
- Cleaning data
- Transforming data

Manipulation
======================================

The `dplyr` package: one of the most beautiful tools created for data analysis

- Clearly defines and efficiently implements most common data manipulation operations (verbs)
- Built around tidy data principles
- Uniform treatment of multiple backends (in memory files, partially loaded files, databases)
- Pipes can be used to elegantly chain multiple manipulation operations

Subsetting Observations
========================================

Selecting or filtering rows (observations) of a tidy
data table by condition or sampling.

![plot of chunk unnamed-chunk-2](wrangling-figure/unnamed-chunk-2-1.png) 


```r
# include only flights on United Airlines
flights %>% filter(carrier == "UA")
```

Subsetting Variables
========================================
Selecting or filtering columns (variables) of a tidy
data table by condition 

![plot of chunk unnamed-chunk-4](wrangling-figure/unnamed-chunk-4-1.png) 


```r
# select only month carrier and origin variables
flights %>% select(month,carrier,origin)
```

Note: On tidy data tables, subsetting variables at random 
is not commonly done

Creating New Variables
=========================================

Use existing variables to create new observations
- Transformation of single variable
- Functions of multiple variables

![plot of chunk unnamed-chunk-6](wrangling-figure/unnamed-chunk-6-1.png) 

Creating New Variables
=========================================

![plot of chunk unnamed-chunk-7](wrangling-figure/unnamed-chunk-7-1.png) 


```r
# add new variable with total delay
flights %>% mutate(delay=dep_delay + arr_delay)
```

Summarizing Data
==========================================

Summarize multiple observations (rows) for a variable (column) into 
a single value

![plot of chunk unnamed-chunk-9](wrangling-figure/unnamed-chunk-9-1.png) 


```r
# compute mean total delay across all flights
flights %>% 
  mutate(delay = dep_delay + arr_delay) %>%
  summarize(mean(delay, na.rm=TRUE))
```

Grouping Data
=========================================

Group observations (rows) with same value of one or
more variables (columns). Usually used with
`summarize` or `mutate` to aggregate or transform
variables *conditioned* on other variables.

![plot of chunk unnamed-chunk-11](wrangling-figure/unnamed-chunk-11-1.png) 


```r
# compute mean total delay per carrier
flights %>%
  mutate(delay = dep_delay + arr_delay) %>%
  group_by(carrier) %>%
  summarize(delay=mean(delay, na.rm=TRUE))
```


Final note on `dplyr`
========================================
- Very efficient implementation on these operations. Much more efficient than 'standard' R code
- More info: [http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
- Cheatsheet: [http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

Missing Data
========================================

When to remove? When to *impute*?

- missing at random vs. missing systematically

Missing Data
========================================

When to remove? When to *impute*?

- data that is missing systematically can significantly bias
an analysis
- For example: 
  - Want to predict how sick someone is from test result
  - if doctors do not carry out the test because a patient
    is too sick
  - then the fact test is missing is a great predictor of how sick patient is

Missing Data
=====================================

**First step**: understand *why* and *how* data may be missing

I.e., talk to collaborator

**Second step**: if a relatively small fraction of observations
contain have missing values, then remove observations.

Dealing with data missing at random
=====================================

- Categorical: encode missing as value


```r
is.missing <- is.na(tb2$iso2)
tb2 %>% 
  mutate(iso2_fixed=factor(
    ifelse(!is.missing, tb2$iso2, "missing")))
```

Dealing with data missing at random
=======================================

- Numeric: impute
- Simple method: replace missing values for a variable with mean of non-missing values


```r
is.missing <- is.na(flights$dep_delay)
flights %>%
  mutate(dep_delay_fixed = 
           ifelse(!is.missing, dep_delay, 
                  mean(dep_delay, na.rm=TRUE)))
```

Dealing with data missing at random
=======================================

- Numeric: impute
- More complex method: replace missing values for a variable predicting from
other variables when variables are related.


```r
is.missing <- is.na(flights$dep_delay)
# use average delay condition on origin airport
fit <- flights %>% lm(dep_delay~origin, data=.)
flights %>%
  mutate(dep_delay_fixed = 
           ifelse(!is.missing, dep_delay, 
                  predict(fit, newdata=flights)))
```

Dealing with data missing at random
=======================================

- Numeric: impute
- In either case, a common approach is to add an additional indicator
variable stating if continous missing measurement was imputed


```r
flights %>%
  mutate(dep_delay_missing = is.na(dep_delay))
```

Transforming Data
=========================================

Normalization and rescaling

- We'll discuss this in the EDA section.

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

![plot of chunk unnamed-chunk-20](wrangling-figure/unnamed-chunk-20-1.png) 

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
