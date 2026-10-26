here::i_am("R/first_visualization.R")
library(here)
library(tidyverse)
library(scales)

# Data preparation-------------
#  As done in previous sessions

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

# 0. An empty plot without info -------------
empty_plot <- ggplot()
empty_plot

# 1. Add info about underlyding data-------------
p0 <- ggplot(data = hotels)
p0

# 2. Add the mapping to axes-------------
p1 <- ggplot(
  data = hotels, 
  mapping = aes(x = distance, y = price)
  )
p1

# 3. Add first layer of geoms-------------
p2 <- ggplot(
  data = hotels, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point()
p2

# 4. Remove outliers-------------

# Note: this might not be adequate if we found this data point was not 
#. certainly based on a measurement error; we decided to remove it for
#. illustrative purposes:

hotels_filtered <- hotels |> 
  filter(price < 3000)

p4 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point()
p4

# 5. Adjust labels-------------

p5 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point() +
  labs(
    x = "Distanz", y = "Preis", 
    caption = "Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n mit Preis über 3000 EUR entfernt.")
p5

# Note: to keep lines under too many characters, use paste:

p5 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point() +
  labs(
    x = "Distanz", y = "Preis", 
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))
p5

# 6. Use log scale for prices-------------

p6 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point() +
  scale_y_log10() + 
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))
p6

# 7. Make points semi-transparent-------------
p7 <- ggplot(
  data = hotels_filtered, 
  mapping = aes(x = distance, y = price)
) + 
  geom_point(alpha = 0.5) +
  scale_y_log10() + 
  labs(
    x = "Distanz", y = "Preis (log Skala)", 
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))
p7

# Digression: what if we wanted to swap x and y axis?-------------

p8a <- ggplot(
  data = hotels_filtered, 
  mapping = aes(y = distance, x = price)
) + 
  geom_point(alpha = 0.5) +
  scale_x_log10() + 
  labs(
    y = "Distanz", x = "Preis (log Skala)", 
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))
p8a

# 8. Use factets and a subset of cities-------------
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
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))
p8

# 9. Use a nicer color scale-------------
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
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))

# 10. Adjust title and subtitle-------------
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
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt."))

# 11. Use a default theme and modify details -------------
p10 <- ggplot(
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
    caption = paste("Quelle: Békés, G. and Kézdi, G. (2021); ein Ausreißer\n",
                    "mit Preis über 3000 EUR entfernt.")) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(), 
    axis.line = element_line(color="grey"), 
    legend.position = "none")
p10

# 11. Save the plot as pdf -------------

ggsave(plot = p10, 
       filename = here::here("output/DreiCities.pdf"), 
       height = 3, width = 6)


# Note: We rewrote the entire code to produce a chart in every step; in 
#. reality, you may just modify the previously defined version like this:
p9 + theme(strip.text = element_text(face = "bold"))

# or, you just keep one version and add the new specification to the code.
#. We kept the whole code in each step only for pedagogical reasons.
