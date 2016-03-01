---
layout: page
title: "Wrangling/EDA Project"
---

In this project you will apply your data wrangling and exploratory data analysis
skills to baseball data. In particular, we want to know how well did Moneyball work
for the Oakland A's. Was it worthy of a movie?

![](moneyball.jpg)

### A bit of background

We'll be looking at data about teams in Major League Baseball. A couple of important points:

- Major League Baseball is a professional baseball league, where teams pay players to play baseball.
- The goal of each team is to win as many games out of a 162 game season as possible.
- Teams win games by scoring more runs than their adversary.
- In principle, better players are costlier, so teams that want good players need to spend more money.
- Teams that spend the most, frequently win the most.

So, the question is, how can a team that can't spend so much win? The basic idea that Oakland (and other teams)
used is to *redefine* what makes a player *good*. I.e., figure out what player characteristics translated into *wins*. Once they
realized that teams were not really pricing players using these characteristics, they could exploit this to pay for undervalued players,
players that were *good* according to their metrics, but were not recognized as such by other teams, and therefore not as expensive.

You can get more information about this period in baseball history from:

- [Wikipedia](http://en.wikipedia.org/wiki/Moneyball)  
- [The Moneyball book](http://www.amazon.com/Moneyball-The-Winning-Unfair-Game/dp/0393324818)  
- [The Moneyball movie](http://www.imdb.com/title/tt1210166/)  

## The Data

You will be using data from a very useful database on baseball teams, players and seasons curated by Sean Lahman available at [http://www.seanlahman.com/baseball-archive/statistics/](http://www.seanlahman.com/baseball-archive/statistics/). The database has been made available as a `sqlite` database [https://github.com/jknecht/baseball-archive-sqlite](https://github.com/jknecht/baseball-archive-sqlite). `sqlite` is a light-weight, file-based database management system that is well suited for small projects and prototypes. Both `sqlite` and the Lahman `sqlite` database are installed in the Docker container we are using in class [http://www.hcbravo.org/IntroDataSci/homeworks/rocker.html](http://www.hcbravo.org/IntroDataSci/homeworks/rocker.html). You can read more about the dataset here: [http://seanlahman.com/files/database/readme2014.txt](http://seanlahman.com/files/database/readme2014.txt).

There are a number of ways you can use SQL to interact with this dataset:

1) Using the `sqlite3` command line interface. For example, given the running Docker container for class, you can start a `sqlite3` command line session by running the following on your host machine:

{% highlight bash %}
docker exec -i -t -u rstudio ids sqlite3 /home/ids_materials/lahman_sqlite/lahman2014.sqlite
{% endhighlight %}

There you can run SQL queries on the database. You can see documentation for the `sqlite3` command line interface here:
[https://www.sqlite.org/cli.html](https://www.sqlite.org/cli.html).

2) Using the `dplyr` R package:

{% highlight r %}
library(dplyr)
lahman_con <- src_sqlite("/home/ids_materials/lahman_sqlite/lahman2014.sqlite")

# this is how to run a sql query
result <- lahman_con %>%
  tbl(sql("SELECT * FROM Salaries where lgID == 'AL'")) %>%
  head()
{% endhighlight %}

There is more information about `dplyr` database connections here: [https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html](https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html). Be sure to read carefully the section on lazy evaluation and the purpose of the `collect` function.

3) Using the `RSQLite` R package:

{% highlight r %}
library(RSQLite)

lahman_con <- dbConnect(RSQLite::SQLite(), "/home/ids_materials/lahman_sqlite/lahman2014.sqlite")

query <- lahman_con %>%
  dbSendQuery("SELECT * FROM Salaries where lgID == 'AL'") %>%

result <- dbFetch(query) %>% head()

# some cleanup code
dbClearResults(query)
dbDisconnect(lahman_con)
{% endhighlight %}

This implements the core database API `DBI` for SQLite.
## The question

We want to understand how efficient teams have been historically at spending money and getting wins in return. In the case of Moneyball, one would expect that Oakland was not much more efficient than other teams in their spending before 2000, were much more efficient (they made a movie about it after all) between 2000 and 2005, and by then other teams may have caught up. Your job in this project is to see if this is true.

## Wrangling

The data you need to answer these questions is in the `Salaries` and `Teams` tables of the database.

**Problem 1** Using SQL compute a relation containing the total payroll and winning percentage (number of wins / number of games) for each team (that is, for each `teamID` and `yearID` combination). You should include other columns that will help when performing EDA later on (e.g., franchise ids, number of wins, number of games).

Include the SQL code you used to create this relation in your writeup. Also, if applicable, describe how you dealt with any missing data in the dataset, e.g., what type of join did you use and why.

## Exploratory data analysis

**Problem 2**. Write code to produce plots that illustrate the distribution of payrolls across time from 1990-2013.

**Question 1**. What statements can you make about the distribution of payrolls across time based on these plots? Remember you can make statements in terms of central tendency, spread, etc.

**Problem 3**. Write code to produce plots that specifically show at least one of the statements you made in Question 1. For example, if you make a statement that there is a trend for payrolls to decrease over time, make a plot of a statistic for central tendency (e.g., mean payroll) vs. time to show that directly.

**Problem 4**. Write code to discretize year into five time periods (using the `cut` function with parameter `breaks=5`) and then make scatterplots showing mean winning percentage (y-axis) vs. mean payroll (x-axis) in each time period. You could add a regression line (using `geom_smooth(method=lm)`) in each scatter plot to ease interpretation.

**Question 2**. What can you say about team payrolls across these periods? Are there any teams that standout as being particularly good at paying for wins across these time periods? What can you say about the Oakland A's spending efficiency across these time periods.

## Data transformations

It looks like comparing payrolls across years is problematic so let's do a scaling transformation that will help with these comparisons.

**Problem 5**. Write `dplyr` code to create a new variable in your dataset. It should contain the number (and direction) of standard deviations away from the average payroll in a given year for each team. So, this column for team $$i$$ in year $$j$$ should equal

$$
\mathrm{scaled\_payroll}_{ij}=\frac{\mathrm{payroll}_{ij} - \overline{\mathrm{payroll}_{\cdot j}}}{s_{\cdot j}}
$$

where $$\overline{\mathrm{payroll}_{\cdot j}}$$ is the average payroll for year $$j$$, and $$s_{\cdot j}$$ is the
standard deviation of payroll for year $$j$$.

**Problem 6**. Repeat the same plots as Problem 4, but use this new scaled payroll variable.

**Question 3**. Answer Question 2 again, but based on these new plots.

It's hard to compare across time periods using these multiple plots, so let's try to create a single plot that makes this comparison easier. The idea is to create a new measurement unit for each team that we can plot across time summarizing how efficient each team is in their spending. We'll use the number of wins a team got per standard deviation of payroll:

**Problem 4**. Calculate the  per dollar spent on payroll for each team in each year.

$$
\mathrm{efficiency}_{ij} = \frac{\mathrm{wins}_{ij}}{\mathrm{scaled\_payroll}_{ij}}
$$

for team $$i$$ in year $$j$$.

Make a line plot with year on the x-axis and efficiency on the y-axis. A good set of teams to plot are Oakland, the New York Yankees, Boston, Atlanta and Tampa Bay (teamIDs `OAK`, `BOS`, `NYA`, `ATL`, `TBA`). That plot can be hard to read since there is so much season to season variation for each team. One way to improve is to use `geom_smooth` instead of `geom_line`.

**Question 4**. What can you learn from this plot compared to the set of plots you looked at in Question 2 and 3?

## What to turn in

Create a pdf file with Rmarkdown containing all code and text to solve each problem and answer each question. Submit to ELMS at [https://myelms.umd.edu/courses/1177854/assignments/4131990](https://myelms.umd.edu/courses/1177854/assignments/4131990).
