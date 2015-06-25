library(Lahman)
library(dplyr)
library(ggplot2)

salaries <- tbl_df(Salaries) %>%
  filter(yearID >= 1990 & yearID <= 2013)

teams <- tbl_df(Teams) %>%
  filter(yearID >= 1990 & yearID <= 2013)


# payroll
payroll <- salaries %>%
  group_by(yearID, teamID) %>%
  summarize(payroll=sum(salary)/1e6)

teams_payroll <- teams %>%
  left_join(payroll, c("yearID", "teamID"))

payroll_plot <- function(low_year, hi_year, include.high=FALSE) {
    teams_payroll %>%
    filter(yearID >= low_year,
            if (include.high) {
               yearID <= hi_year
            } else {
               yearID < hi_year
            }) %>%
    group_by(teamID) %>%
    summarize(wins=mean(W), payroll=mean(payroll)) %>%
    ggplot(aes(x=payroll,y=wins,label=teamID)) +
      geom_text() +
      geom_smooth(method=lm) +
      labs(title=paste0("Wins and Payroll, ", low_year, "-", hi_year), 
         x="Payroll (millions)", y="Wins")
}
payroll_plot(1990, 1995)
payroll_plot(1995, 2000)
payroll_plot(2000, 2005)
payroll_plot(2005, 2010)
payroll_plot(2010, 2013)
  

teams_payroll <- teams_payroll %>%
  mutate(wpd=W/payroll) %>%
  select(yearID, teamID, wpd, payroll, W)

teams_payroll %>%
  filter(teamID %in% c("OAK", "BOS", "NYA", "NYN", "TBA")) %>%
  ggplot(aes(x=yearID,y=wpd,color=teamID)) +
    geom_line() +
    labs(title="Wins per Dollar Trend", x="Year", y="Wins per Million Dollar")

resid_tab <- teams_payroll %>%
  group_by(yearID) %>%
  mutate(average_wpd=mean(wpd)) %>%
  mutate(expected_wins=average_wpd * payroll,
         residual_wins=W-expected_wins)
 
resid_tab %>%
  filter(teamID %in% c("OAK", "BOS", "NYA", "NYN", "TBA")) %>%
  ggplot(aes(x=yearID, y=residual_wins, color=teamID)) +
    geom_line() +
    labs(title="Residual Wins", x="Year", y="Residual Wins")






