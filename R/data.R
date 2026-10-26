library(tidyverse)
library(scales)

europe <- read_csv("data/hotels-europe.csv")
europe

hotels <- europe |>
  filter(
    year == 2017, month == 11, weekend == 0) |>
  mutate(
    star_tier = factor(floor(stars + 0.5), 
                       levels = 1:5,
                       labels = paste(1:5, "stars")))
nrow(hotels)
