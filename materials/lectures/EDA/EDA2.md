Exploratory Data Analysis (adding visualization to the chain)
========================================================
author: Hector Corrada Bravo
date: CMSC498T Spring 2015

Visual EDA 
========================================================

- Our goal in EDA is to apply transformations, compute summarizations and visualizations to explore general trends in datasets.

- We have seen some basic examples of statistics we would like to compute and important univariate plots. Let's get a little more complicated. 

- Before we do that, let's step back and formalize some of what we are doing in visual EDA

ggplot2
========================================================

We will build our intuition using the *grammar of graphics* as implemented in `ggplot2`.
The central premise is to characterize the building pieces behind plots:

1. The data that goes into a plot, works best when data is tidy
2. The mapping between data and *aesthetic* attributes
3. The *geometric* representation of these attributes

Simple example
========================================================


```r
library(dplyr)
library(ggplot2)
library(Lahman)
batting <- tbl_df(Batting)

# scatter plot of at bats vs. runs for 2010
batting %>% 
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=R)) +
    geom_point()
```

![plot of chunk unnamed-chunk-1](EDA2-figure/unnamed-chunk-1-1.png) 

Simple example
========================================================


```r
# scatter plot of at bats vs. runs for 2010
batting %>% 
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=R)) +
    geom_point()
```

**Data**: Batting table filtering for year  
**Aesthetic attributes**: 
  - x-axis mapped to variables `AB`
  - y-axis mapped to variable `R`  
  
**Geometric Representation**: points!  

Simple example
===================

Now, you can cleanly distinguish the constituent parts of the plot.
E.g., change the geometric representation


```r
# scatter plot of at bats vs. runs for 2010
batting %>% 
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=R, label=teamID)) +
    geom_text() +
    geom_point()
```

![plot of chunk unnamed-chunk-3](EDA2-figure/unnamed-chunk-3-1.png) 

Simple example
===================

Now, you can cleanly distinguish the constituent parts of the plot.
E.g., change the data.


```r
# scatter plot of at bats vs. runs for 1995
batting %>% 
  filter(yearID == "1995") %>%
  ggplot(aes(x=AB, y=R)) +
    geom_point()
```

![plot of chunk unnamed-chunk-4](EDA2-figure/unnamed-chunk-4-1.png) 

Simple example
===================

Now, you can cleanly distinguish the constituent parts of the plot.
E.g., change the aesthetic.


```r
# scatter plot of at bats vs. hits for 2010
batting %>% 
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=H)) +
    geom_point()
```

![plot of chunk unnamed-chunk-5](EDA2-figure/unnamed-chunk-5-1.png) 

Line Plot 
===============

Let's make a line plot (pg. 52)

What do we change? (data, aesthetic or geometry?)


```r
batting %>%
  filter(yearID == "2010") %>%
  sample_n(100) %>%
  ggplot(aes(x=AB, y=H)) +
  geom_line()
```

Summarizing trend
===============

Let's add a regression line (pg. 54)

What do we add? (data, aesthetic or geometry?)


```r
batting %>%
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=H)) +
  geom_point() + 
  geom_smooth(method=lm)
```

Other aesthetics
==================

- Color: color by categorical variable


```r
batting %>%
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=H, color=lgID)) +
  geom_point() + 
  geom_smooth(method=lm)
```

Other aesthetics
==================

- Size: size by categorical variable


```r
batting %>%
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=R, size=HR)) +
  geom_point() + 
  geom_smooth(method=lm)
```

Faceting
==================

The last major component of exploratory analysis called `faceting` in visualization,
corresponds to `conditioning` in modeling, we've seen it as the motivation of `grouping`
when arranging data.


```r
batting %>%
  filter(yearID %in% c("1995", "2000", "2010")) %>%
  ggplot(aes(x=AB, y=R, size=HR)) +
  facet_grid(lgID~yearID) +
  geom_point() + 
  geom_smooth(method=lm)
```

Faceting
==================

The last major component of exploratory analysis called `faceting` in visualization,
corresponds to `conditioning` in modeling, we've seen it as the motivation of `grouping`
when arranging data.


```r
batting %>%
  filter(yearID %in% c("1995", "2000", "2010")) %>%
  ggplot(aes(x=AB, y=R, size=HR)) +
  facet_grid(lgID~yearID) +
  geom_point() + 
  geom_smooth(method=lm)
```

Link
======
http://catalog.umd.edu/F/BKBIQXGLRMJUEVDRE17SLUQIIGMPFYVSN4M8TN13UGKYFJ5R13-01494?local_base=gl&func=find-c&ccl_term=sys%3D003921336&pds_handle=GUEST
===

Summary
=============

Exploratory analysis:
- Think of statistics that summarize data well (we've seen the five number summary)
- Interpret these statistics relative to other data (analytical or empirical, the q-q plot)
- Data transformations should be interpreted this way as well
- When visually exploring, think of data/aesthetic/geometry separately to organize your exploration.
