---
layout: page
title: "CMSC320: Resources"
---

R
------
* R: [R](http://www.r-project.org) is an open-source environment for data analysis.  
* The [RStudio](http://www.rstudio.com/ide) IDE is highly recommended. The [Revolution IDE](http://www.revolutionanalytics.com/academic-and-public-service-programs) is also very good, only Linux and Windows.  
* R Task Views: The [Machine Learning](http://cran.r-project.org/web/views/MachineLearning.html) and [Optimization](http://cran.r-project.org/web/views/Optimization.html) Task Views list useful packages in R we may use.  
* [swirl](http://swirlstats.com/) is an interactive R (and general data analysis) tutorial  
* R/Matlab references: [A short R guide for Matlab users.](http://mathesaurus.sourceforge.net/octave-r.html) [A longer one.](http://cran.r-project.org/doc/contrib/Hiebeler-matlabR.pdf)  
* R/Python references: [A short R guide for Python users.](http://mathesaurus.sourceforge.net/r-numpy.html)  

Rocker
------

We will use [Rocker](https://github.com/rocker-org/rocker), a project built on top of
[Docker](https://www.docker.com/) to manage our software installation. This will provide you with a working installation of R, and the Rstudio IDE, along with a lot
of packages providing analysis tools and datasets we will use throughout the semester. You
can read more about Rocker in [this introduction](http://dirk.eddelbuettel.com/blog/2014/10/23/)

We will be working from a docker image that extends the `ropensci`
container. To use this please use the following command:

{% highlight bash %}
docker run -d -p 8787:8787 -v <local_path>:/home/rstudio hcorrada/introdatascidocker
{% endhighlight %}

Here `<local_path>` corresponds to a path in your local machine that
will be mapped to the home directory in the docker container running
rstudio.

You can find more information about this docker container
[here](https://registry.hub.docker.com/u/hcorrada/introdatascidocker/)

I will announce updates to the image on piazza.

Data Repositories
---------------

The Rocker container you will install will contain access to a large number of data repositories.
We will list additional ones here as we go along.

* [Kaggle](http://www.kaggle.com/): is a site hosting data competitions. It's a great source of
datasets, questions and tutorials.
* [data.gov](http://www.data.gov/): The U.S. goverment's open data portal
* [Gapminder](http://www.gapminder.org/data/)
* [Global Health Observatory](http://www.who.int/gho/database/en/): World Health Organization's data repository.
* [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/): contains many datasets useful for testing and benchmarking learning algorithms.
* [StatLib](http://lib.stat.cmu.edu/): Statistical software and
dataset portal maintained by CMU.
* Another large list of repositories: [http://www.inside-r.org/howto/finding-data-internet](http://www.inside-r.org/howto/finding-data-internet)
