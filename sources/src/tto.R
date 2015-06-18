# it's fun to read an article we can reproduce!
# http://valueoverreplacementgrit.com/2012/02/06/applying-three-true-outcomes-to-a-team/

library(Lahman)
library(dplyr)
library(ggplot2)

batting <- tbl_df(Batting)

batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE)) %>%
  mutate(TTO=(BB+HR+SO)/PA) %>%
  filter(yearID >= 1973) %>%
  ggplot(aes(x=yearID, y=TTO)) +
    geom_line() + 
    geom_smooth(method=lm)

batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID, teamID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE)) %>%
  mutate(TTO=(HR+SO+BB)/PA*100) %>%
  filter(yearID > 1973 & TTO >= 33.3) %>%
  ungroup %>%
  arrange(desc(TTO))

batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID, teamID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE)) %>%
  mutate(TTO=(HR+SO+BB)/PA*100) %>%
  filter(yearID > 1973 & TTO <= 20) %>%
  ungroup %>%
  arrange(TTO)

yrtto <- batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE)) %>%
  mutate(YRTTO=(HR+SO+BB)/PA*100) %>%
  filter(yearID >= 1973) %>%
  dplyr::select(yearID, YRTTO)


tmtto <- batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID, teamID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE)) %>%
  mutate(TTO=(HR+SO+BB)/PA*100) %>%
  filter(yearID >= 1973) %>%
  dplyr::select(yearID, teamID, TTO) %>%
  inner_join(yrtto, "yearID")

tmtto %>%
  mutate(DIFF=(TTO-YRTTO)/YRTTO*100) %>%
  ungroup() %>%
  arrange(desc(DIFF)) %>%
  head(n=6)

tmtto %>%
  mutate(DIFF=(TTO-YRTTO)/YRTTO*100) %>%
  ungroup() %>%
  arrange(DIFF) %>%
  head(n=6)

tmtto <- batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID, teamID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE)) %>%
  mutate(TTO=(HR+SO+BB)/PA*100) %>%
  filter(yearID >= 1973) %>%
  dplyr::select(yearID, teamID, TTO)
  
teams <- tbl_df(Teams)
twinpct <- teams %>%
  mutate(WinPct = W / G) %>%
  dplyr::select(yearID, teamID, WinPct)

tmtto %>%
  inner_join(twinpct, c("yearID", "teamID")) %>%
  ggplot(aes(x=WinPct, y=TTO)) +
    geom_point() + 
    geom_smooth(method=lm)

library(tidyr)

tmstats <- batting %>%
  mutate(PA=AB+BB+HBP+SH+SF) %>%
  group_by(yearID, teamID) %>%
  summarize(PA=sum(PA, na.rm=TRUE),
            HR=sum(HR, na.rm=TRUE),
            SO=sum(SO, na.rm=TRUE),
            BB=sum(BB, na.rm=TRUE)) %>%
  mutate(HRPCT=HR/PA*100,
         SOPCT=SO/PA*100,
         BBPCT=BB/PA*100) %>%
  filter(yearID >= 1973) %>%
  dplyr::select(-PA,-HR,-SO,-BB)

tmstats %>%
  inner_join(twinpct, c("yearID", "teamID")) %>%
  gather(stat, pct, HRPCT, SOPCT, BBPCT) %>%
  ggplot(aes(y=pct, x=WinPct, color=stat)) +
    geom_point() +
    geom_smooth(method=lm)

