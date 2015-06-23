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
 
 




