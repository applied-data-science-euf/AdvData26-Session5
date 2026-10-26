here::i_am("R/first_visualization.R")
library(here)
library(tidyverse)
library(scales)

europe <- read_csv(here("data/hotels-europe.csv"))
europe

hotels <- europe |>
  filter(
    year == 2017, month == 11, weekend == 0) |>
  mutate(
    star_tier = factor(floor(stars + 0.5), 
                       levels = 1:5,
                       labels = paste(1:5, "stars"))
    )
hotels




empty_plot <- ggplot()
empty_plot

p0 <- ggplot(data = hotels)
p0

p1 <- ggplot(
  data = hotels, 
  mapping = aes(x = distance, y = price)
  )
p1

p2 <- ggplot(
  data = hotels, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point()
p2

p3 <- ggplot(
  data = hotels, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point()
p3

hotels_filtered <- hotels |> 
  filter(price < 3000)

p4 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point()
p4

p5 <- p4 +
  labs(x = "Distanz", y = "Preis", caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p5

p5 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point() +
  labs(
    x = "Distanz", y = "Preis", 
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p5

p6 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point() +
  scale_y_log10() + 
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p6

p7 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point(alpha = 0.5) +
  scale_y_log10() + 
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p7

p8 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point(alpha = 0.5) +
  scale_y_log10() + 
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p8

# Einschub: was wenn wir die x und y Achse tauschen wollen?
p8a <- ggplot(
  data = hotels_filtered, 
  mapping = aes(y = distance, x = price)
) + 
  geom_point(alpha = 0.5) +
  scale_x_log10() + 
  labs(
    y = "Distanz", x = "Preis (log Skala)", 
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p8a

p8 <- ggplot(
  data = filter(hotels_filtered, city %in% c("Madrid", "Hamburg", "Stockholm")), 
  mapping = aes(x = distance, y = price)
) + 
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") + 
  scale_y_log10() + 
  facet_wrap(~city) +
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p8

p9 <- ggplot(
  data = filter(hotels_filtered, 
                city %in% c("Madrid", "Hamburg", "Stockholm")), 
  mapping = aes(x = distance, y = price, color = city)
) + 
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") + 
  scale_y_log10() + 
  scale_color_discrete(palette = "viridis") +
  facet_wrap(~city) +
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    title = "Hamburg ist teuer",
    subtitle = "Drei Städte im Vergleich",
    caption = "Quelle: Textbook; ein Ausreißer\n mit Preis über 3000 EUR entfernt.") +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(), 
    axis.line = element_line(color="grey"), 
    legend.position = "none")
  # theme(
  #   panel.background = element_rect(fill = "white"), 
  #   panel.grid = element_line(colour = "grey"))
p9

ggsave(plot = p9, filename = here::here("output/DreiCities.pdf"), 
       height = 3, width = 6)
