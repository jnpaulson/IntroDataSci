library(rvest)
library(stringr)
library(magrittr)
library(dplyr)

# abrir html
hottrends <- html("hottrends3.html")

entradas <- hottrends %>%
  html_nodes(".hottrends-trends-list-trend-container")

tabla <- entradas %>%
  html_attr("id") %>%
  str_split_fixed(pattern="-", n=2) %>%
  as.data.frame()
colnames(tabla) <- c("fecha", "topico")

busquedas <- entradas %>%
  html_nodes(".hottrends-single-trend-info-line-number") %>%
  html_text()

tabla <- tabla %>%
  mutate(busquedas=busquedas)
  

#####


topicos <- hottrends %>%
  html_nodes(".hottrends-single-trend-title-container") %>%
  html_children() %>%
  html_nodes("span") %>%
  html_text()



  html_text()

  html_attr("id") %>%
  str_split(pattern="-")

  