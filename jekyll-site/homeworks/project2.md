---
layout: default
title: "Project 2, Regression and Classification"
---

**Due**: April 9th, 2015  
**Posted**: March 29th, 2015  
**Last Update**: April 3rd, 2015  

In this project you will work on your regression and classification
abilities.


### Regression Analysis

In this part of this project you will practice and experiment with linear regression using
data from [gapminder.org](http://gapminder.org). I recommend spending a little time looking at material there, it is quite an informative site. 

We will use a subset of data provided by gapminder provided by [Jennifer Bryan](http://www.stat.ubc.ca/~jenny/) described in it's [github page](https://github.com/jennybc/gapminder).

I have included this package into the class Docker image. You should get it once you restart the class Docker image. [More info here](http://cbcb.umd.edu/~hcorrada/IntroDataSci/resources.html)

Please [download this R markdown file](gapminder.Rmd), and complete as
required. Knit into a pdf (or html) file and submit as directed below.

### Classification Analysis

Do Question 10 in Chapter 4 and Question 7 in Chapter 5 from
ISLR. These are on the `Weekly` dataset (also
included in the course Docker image), which you can load using

{% highlight r %}
library(ISLR)
data(Weekly)
{% endhighlight %}

You may want to do labs in Chapters 4 and 5 before answering these
questions.

Submit your answers (including both code and text as appropriate) as
an R markdown file (call it `prediction.Rmd`).

### Handing in

Please submit knitted files for each part (`gapminder.pdf` and
`prediction.pdf`) to ELMS
[here](https://myelms.umd.edu/courses/1130499/assignments/3691353).


