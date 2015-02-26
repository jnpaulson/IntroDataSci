---
layout: default
title: "Project 1, Part II: Moneyball"
---

**Due**: March 3rd, 2015  
**Posted**: Feb 21st, 2015  
**Last Update**: Feb 26th, 2015  

In this project you will apply your data wrangling and exploratory data analysis
skills to baseball. In particular, we want to know how well did Moneyball work
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

You will be using data from a very useful database on baseball teams, players and seasons curated by Sean Lahman available at [http://www.seanlahman.com/baseball-archive/statistics/](http://www.seanlahman.com/baseball-archive/statistics/). The database has been made available as an R package by Michael Friendly et al.: [http://cran.r-project.org/web/packages/Lahman/index.html](http://cran.r-project.org/web/packages/Lahman/index.html). It is part of the installed Docker container we have been using in class so far. 


{% highlight r %}
# to load data into current R session
library(Lahman)

# to read about the datebase itself
?'Lahman-package'
{% endhighlight %}

## The question

We want to understand historically how efficient teams are at spending money and getting wins in return. In the case of Moneyball, one would expect that Oakland was not much more efficient than other teams in their spending before 2000, were much more efficient (they made a movie about it after all) between 2000 and 2005, and by then other teams may have caught up. Your job in this project is to see if this is true.

## Wrangling

The data you need to answer these questions is in two tables:

1. `Salaries`: this contains each player's salary for each season and an identifier for the team that paid them. You can calculate each team's yearly payroll using this table.
2. `Teams`: this table contains statistics for each team and season, including wins.

**Problem 1**. Write a `dplyr` expression to calculate yearly payroll for all teams in the `Salaries` table.

**Problem 2**. Write a `dplyr` expression that adds a `payroll` column to the `Teams` table 


## Exploratory data analysis

**Problem 3**. Write code to produce five scatterplots showing mean number of wins per season (y-axis) vs. mean payroll (x-axis) for time periods: 1) [1990,1995), 2) [1995,2000), 3) [2000, 2005), 4) [2005, 2010), 5) [2010, 2013]. You should add a regression line (using `geom_smooth(method=lm)` in each one to ease interpretation).

**Question 1**. What can you say about team payrolls across these periods? How good were teams at paying for wins across these time periods? What can you say about the Oakland A's spending efficiency across these time periods.

## Data transformations

It's hard to compare across time periods using these multiple plots, so let's try to create a single plot that makes this comparison easier. The idea is to create a new measurement unit we can plot across time for each time that summarizes how efficient each team in their spending. We'll use the number of wins a team can get per dollar:

**Problem 4**. Calculate the number of wins per dollar spent on payroll for each team in each year.

$$
wpd_{ij} = \frac{\mathrm{wins}_{ij}}{\mathrm{payroll}_{ij}}
$$

for team $i$ in year $j$.

**Problem 5**. Using the result of problem 4, calculate the average number of wins per dollar for each year between 1990 and 2013:

$$
wpd_{.j} = \mathrm{mean}_i (wpd_{ij})
$$

With the result of problem 5, now we can approximate the number of wins we would expect each team to get given their payroll, and then see how many more (or less) wins they had compared to this expectation. Note: this is a naive version of linear regression that we'll see in better detail later in the semester.

**Problem 6**. Compute the difference between wins and expected wins for each team in each year between 1990 and 2013:

$$
\mathrm{residualWins}_{ij} = \mathrm{wins}_{ij} - wpd_{. j} * payroll_{ij}
$$

**Problem 7**. Plot residual wins (y-axis, computed in Problem 6) for a few teams and year (x-axis). A good set of teams to plot are Oakland, the two New York teams, Boston and Kansas City.

**Question 2**. What can you learn from this plot compared to the set of plots you looked at in Question 1?

## Now on your own.

**Question 3**. What else can you learn from this dataset? Some things you may want to look at:

1. Some analysts prefer to look at runs (the difference in runs scored and runs allowed) instead of wins to summarize a team's performance in a season.
2. We only looked at total payroll per year. Other statistics may be more informative, for example, averge player salary, or the difference between highly paid and lowly paid players (you can get this from IQR for example).

## How to submit.

Write an Rmarkdown file with the code you used to solve each problem, and the answers to each question. Knit as a pdf file (instead of html) and submit to ELMS.

Remember to submit [Part I](homeworks/hw1_part1.html) through github.
