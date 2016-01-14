library(gapminder)
library(readxl)
library(tidyr)
library(dplyr)

fertility_dat <- read_excel("indicator undata total_fertility.xlsx")
colnames(fertility_dat)[1] <- "country"

tidy_fertility <- fertility_dat %>%
  gather(year, fertility, -country) %>%
  mutate(year=as.numeric(year)) %>%
  mutate(country=factor(country))

gapminder2 <- gapminder %>%
  inner_join(tidy_fertility, c("country", "year"))