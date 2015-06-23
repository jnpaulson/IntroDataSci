data_dir <- "../materials/lectures/Tidy"
data_dir <- file.path(data_dir, "tidyr/vignettes")

# paquetes para limpiar paquetes
library(dplyr)
library(tidyr)

# pew dataset
pew <- read.csv(file.path(data_dir, "pew.csv"), 
         stringsAsFactor=FALSE, 
         check.names=FALSE)

# problema: valores como nombres de columna
# solucion: nuevas columnas "income" y "frequency"
tidy_pew <- gather(pew, income, 
                   frequency, -religion)

#dataset de caonciones
billboard <- read.csv(file.path(data_dir,
                                "billboard.csv"),
                    stringsAsFactors=FALSE)
# nuevas columnas week y rank
tidy_billboard <- gather(billboard,
                         week, rank,
                         wk1:wk76)


# Problema: multiples variables en una columna
tb <- read.csv(file.path(data_dir,
                   "tb.csv"),
         stringsAsFactors=FALSE)

# Problema: nombres de columnas son valores
tidy_tb <- gather(tb, demo, n, -year, -iso2)
tidy_tb <- separate(tidy_tb, demo, 
                    c("sex", "age"), 
                    sep=1)

tidy_tb <- tb %>%
  gather(demo, n, -year, -iso2) %>%
  separate(demo, c("sex", "age"), sep=1)

#### 
# Problema: valores en nombres de columnas y
#  en filas
weather <- read.csv(file.path(data_dir,
                              "weather.csv"),
                    stringsAsFactors = FALSE)

# Solucion: crear columnas day y value
#   luego crear tmax y tmin
tidy_weather <- weather %>%
  gather(day, value, d1:d31, na.rm=TRUE) %>%
  spread(element, value) 

# Multiples tablas
billboard <- read.csv(file.path(data_dir,
                                "billboard.csv"),
                      stringsAsFactors=FALSE)

# nuevas columnas week y rank
tidy_billboard <- gather(billboard,
                         week, rank,
                         wk1:wk76)

# separar en dos tables: rank y song

# seleccione variables de cancion
# añadarle song_id
song <- tidy_billboard %>%
  select(artist, track, year, time, date.entered) %>%
  unique() %>%
  mutate(song_id = row_number())

# junte song y tidy_billboard para añadir song_id
# seleccione variables del ranking
rank <- tidy_billboard %>%
  left_join(song, c("artist", "year", "track", "time", "date.entered")) %>% 
  select(song_id, week, rank)





  
  
  
  


















