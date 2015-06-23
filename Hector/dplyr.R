library(nycflights13)
data("flights")

View(flights)

# 1. filter flights with arrival delay
# greater than 2 hours (delays are
# measured in minutes)
flights %>%
  filter(arr_delay > 120) %>% View()

# 2. promedio atraso total en la guardia
flights %>%
  mutate(delay = arr_delay + dep_delay) %>%
  group_by(origin)  %>% 
  summarize(delay=mean(delay, na.rm=TRUE))

# 3. promedio atraso vuelas llegan a mexico
flights %>%
  mutate(delay=arr_delay + dep_delay) %>%
  filter(dest=="SJU")  %>%
  group_by(origin) %>%
  summarize(delay=mean(delay, na.rm=TRUE))

# 4. (a) calcule el retraso total
#   (b) re-emplaze aquellos valores nulos
#        con el promedio de retraso
flights_fixed <- flights %>% 
  mutate(delay = arr_delay + dep_delay)

is_missing <- is.na(flights_fixed$delay)
mean_delay <- mean(flights_fixed$delay, na.rm=TRUE)

flights_fixed <- flights_fixed %>% 
  mutate(delay_fixed = ifelse(is_missing, mean_delay, delay))
 

# EDA

# five number summary
summary(flights$dep_delay)
boxplot(flights$dep_delay, ylab="Dep. Delay")
hist(flights$dep_delay)
plot(density(flights$dep_delay, na.rm=TRUE))
plot(density(flights$minute, na.rm=TRUE))

# qq plot
qqnorm(flights$dep_delay)

# bivariate plot
plot(flights$dep_delay, flights$arr_delay)

# MA plot
dep_m <- flights$dep_delay - flights$arr_delay
dep_a <- (flights$dep_delay + flights$arr_delay) / 2
plot(dep_a, dep_m)

cor(flights$dep_delay, flights$arr_delay,
    use="complete.obs")

###
boxplot(log(flights$dep_delay)~flights$carrier)
mosaicplot(flights$origin~flights$carrier)

hist(log2(flights$dep_delay))

library(Lahman)
library(ggplot2)
batting <- tbl_df(Batting)
batting %>% 
  filter(yearID == "2010") %>%
  ggplot(aes(x=AB, y=R, label=teamID, 
             color=lgID, size=G)) +
  geom_text() +
  geom_point()

batting %>%
  filter(yearID == "2010") %>%
  sample_n(100) %>%
  ggplot(aes(x=AB, y=H,color=lgID)) +
  geom_line()



