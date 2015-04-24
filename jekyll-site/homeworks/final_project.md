---
layout: default
title: "CMSC498: Final Project"
---

Our goal of this project is to present an end-to-end analysis using the skills you have learned in class.

## Project Milestones

**Step 1, Due Friday April 24th**: Choose an application domain that interests you (we have seen baseball, economics, finance, etc. in class). Think about possible sources (repositories) for data in this application domain. Identify possible tasks you could perform in this application domain.

Example submission:

I am going to work with financial data. These are repositories containing data I could use:

xxxxx

Possible tasks: predict stock prices, predict market volume, predict house prices, what factors affect house prices the most?

[Make sure you look at our lists of data resources to get ideas]({{ base_url }}/resources.html)

**Step 2, Due Wednesday April 29th**: Choose a specific dataset and task. Describe dataset (number of observations, number of variables), is it in tidy format? Specify the taks you will perform, is it inference or prediction, regression or classification. What will be the deliverable, a descriptive analysis, a classifier others can use (in the form of an R pacakge), an interactive application people can use to explore your dataset (e.g., built with Shiny)?

Example submission:

Dataset: I will use the XXX dataset. It consists of XXX observations and XXX variables. It is not in tidy format since columns correspond to values.

Tasks: I will predict house prices based on XX variables. I will create a web application where users can input variable values for specific houses and predicted house values will be returned.

**Step 3, Due Monday May 4th.**: Collect and tidy your data for analysis. Describe your tidy data. Perform exploratory analysis and visualization (as we did in the first unit of the course). Specify analysis methods (from second course unit) to use for your task.

Example submission:

After tidying the dataset consists of XX tables, with the following characteristics:

Table 1: # of observations, # variables, variable descriptions
Table 2: # of observations, # variables, variable descriptions

I will be using K-nearest neighbors regression to perform prediction. I will use Shiny to create web app.

Include initial exploratory descriptions of dataset and exploratory analysis plots.

**Step 4, Due Friday May 8th**: Perform a preliminary analysis of the dataset using selected methods.

I performed 10-fold cross validation for K-NN regression using a validation set to tune K. I found MSE of $10,000 dollars on average across folds, with standard error of $3,000.

**Step 5, Due Thursday May 7th and Tuesday May 12**: Present a five minute pitch (with one slide) of your project task. Essentially include summary of submissions for previous steps above as you have them at that moment.

**Step 6, Due Monday May 18th**: Prepare a final report of your project. Submit deliverables (reproducible Rmarkdown of your analyses, web app, R package etc., if applicable). You can submit preliminary drafts to instructors any time before the 18th for comment and feedback.

Submission Format:

Summary:
1) Describe the task you performed (in one sentence).
2) Describe the data you used (in one sentence).
3) Describe the analysis method you used (in one sentence).
4) Summarize your results (in one or two sentences).

Introduction (1/2 page):
Describe the task you performed in more detail. Include motivation for performing this task.

Materials and Methods (1.5-2 pages):
Describe the dataset you used in more detail (you can get this from Step 3)
Describe analysis methods you used, and how you are evaluating performance (from Step 3)

Results (about 3 pages):
Describe the results you found. Make sure you quantify your findings (if inference, provide interpretation of resulting model. E.g., we found that house prices increase by $10,000 (P<0.05) on average when they are within 5 miles of a university campus; if prediction, we found we could predict house prices with mean squared error of $10,000.

Conclusion (1/2 page):
Concluding remarks summarizing findings and discussing possible improvements to your analysis.


##Grading

Things that go into consideration when grading.

1) How well is your task defined and described (this will be based on progress through project milestones).
2) How appropriate are the methods you have used to perform this task. You need to use at least one of the methods presented in class.
3) How clearly described is your methodology and results.
4) Are your tables and plots clear and appropriately labeled.
5) Are your conclusions backed reasonably well by your findings.

Things that do not go into consideration when grading.

1) How many different methods you tried.
2) How large is the dataset you used.
3) How long is your final report.
4) How much code you needed to write to perform your analysis.


**You can do this project in groups of at most 4. I highly recommend that you do this in a group. Contact us if you would like us to put a group together.**

Finally: I highly recommend sending questions and updates through Piazza as you go along.

##Submission

Submit all parts on ELMS: [https://myelms.umd.edu/courses/1130499/assignments](https://myelms.umd.edu/courses/1130499/assignments)
