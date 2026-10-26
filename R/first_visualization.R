here::i_am("R/first_visualization.R")
library(here)
library(tidyverse)
library(scales)

# Data preparation-------------
# As done in previous sessions

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

# Comments marked with `<--- added` or `<--- changed` show what is new
# compared to the previous step.

# 0. An empty plot without info-------------
p0 <- ggplot()
p0

# 1. Add info about the underlying data-------------
p1 <- ggplot(data = hotels) # <--- added
p1

# 2. Add the mapping to axes-------------
p2 <- ggplot(
  data = hotels,
  mapping = aes(x = distance, y = price) # <--- added
  )
p2

# 3. Add a first layer of geoms-------------
p3 <- ggplot(
  data = hotels,
  mapping = aes(x = distance, y = price)
) +
  geom_point() # <--- added
p3

# 4. Remove outliers-------------

# Note: this might not be adequate unless we know that this data point is
# based on a measurement error; we removed it for illustrative purposes:

hotels_filtered <- hotels |>  # <--- added
  filter(price < 3000)        # <--- added

p4 <- ggplot(
  data = hotels_filtered, # <--- changed
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
  labs( # <--- added
    x = "Distance to city centre", y = "Price (EUR)", # <--- added
    caption = "Source: Békés, G. and Kézdi, G. (2021); one outlier\nwith a price above 3000 EUR removed.") # <--- added
p5

# Note: to keep lines short, use paste():

p5 <- ggplot(
  data = hotels_filtered,
  mapping = aes(x = distance, y = price)
) +
  geom_point() +
  labs(
    x = "Distance to city centre", y = "Price (EUR)",
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n", # <--- changed
                    "with a price above 3000 EUR removed.")) # <--- changed
p5

# 6. Use a log scale for prices-------------

p6 <- ggplot(
  data = hotels_filtered,
  mapping = aes(x = distance, y = price)
) +
  geom_point() +
  scale_y_log10() + # <--- added
  labs(
    x = "Distance to city centre", y = "Price (EUR, log scale)", # <--- changed
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed."))
p6

# 7. Make points semi-transparent-------------
p7 <- ggplot(
  data = hotels_filtered,
  mapping = aes(x = distance, y = price)
) +
  geom_point(alpha = 0.5) + # <--- changed
  scale_y_log10() +
  labs(
    x = "Distance to city centre", y = "Price (EUR, log scale)",
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed."))
p7

# Digression: what if we wanted to swap the x and y axes?-------------

p7_swapped <- ggplot(
  data = hotels_filtered,
  mapping = aes(y = distance, x = price) # <--- changed
) +
  geom_point(alpha = 0.5) +
  scale_x_log10() + # <--- changed
  labs(
    y = "Distance to city centre", x = "Price (EUR, log scale)", # <--- changed
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed."))
p7_swapped

# 8. Use facets and a subset of cities (continuing from step 7)-------------
p8 <- ggplot(
  data = filter(hotels_filtered,                     # <--- changed
                city %in% c("Madrid", "Hamburg", "Stockholm")), # <--- changed
  mapping = aes(x = distance, y = price)
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") + # <--- added
  scale_y_log10() +
  facet_wrap(~city) + # <--- added
  labs(
    x = "Distance to city centre", y = "Price (EUR, log scale)",
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed."))
p8

# 9. Use a nicer color scale-------------
p9 <- ggplot(
  data = filter(hotels_filtered,
                city %in% c("Madrid", "Hamburg", "Stockholm")),
  mapping = aes(x = distance, y = price, color = city) # <--- changed
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") +
  scale_y_log10() +
  scale_color_viridis_d(end = 0.85) + # <--- added*
  facet_wrap(~city) +
  labs(
    x = "Distance to city centre", y = "Price (EUR, log scale)",
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed."))
p9

# *: we used scale_color_discrete() in the course, but I do not know how
#  to avoid the hard to read yellow in that case.

# 10. Add a title and subtitle-------------
p10 <- ggplot(
  data = filter(hotels_filtered,
                city %in% c("Madrid", "Hamburg", "Stockholm")),
  mapping = aes(x = distance, y = price, color = city)
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") +
  scale_y_log10() +
  scale_color_viridis_d(end = 0.85) +
  facet_wrap(~city) +
  labs(
    x = "Distance to city centre", y = "Price (EUR, log scale)",
    title = "Distance to the centre matters in Stockholm, barely in Hamburg", # <--- added
    subtitle = "Hotel prices on weekdays, November 2017", # <--- added
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed."))
p10

# 11. Use a default theme and modify details-------------
p11 <- ggplot(
  data = filter(hotels_filtered,
                city %in% c("Madrid", "Hamburg", "Stockholm")),
  mapping = aes(x = distance, y = price, color = city)
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") +
  scale_y_log10() +
  scale_color_viridis_d(end = 0.85) +
  facet_wrap(~city) +
  labs(
    x = "Distance to city centre", y = "Price (EUR, log scale)",
    title = "Distance to the centre matters in Stockholm, barely in Hamburg",
    subtitle = "Hotel prices on weekdays, November 2017",
    caption = paste("Source: Békés, G. and Kézdi, G. (2021); one outlier\n",
                    "with a price above 3000 EUR removed.")) +
  theme_minimal() + # <--- added
  theme( # <--- added
    panel.grid.major = element_blank(), # <--- added
    axis.line = element_line(color = "grey"), # <--- added
    legend.position = "none") # <--- added
p11

# 12. Save the plot as a PDF-------------

ggsave(plot = p11,
       filename = here("output/three_cities.pdf"),
       height = 3, width = 6)
p11


# Note: We rewrote the entire code to produce a chart in every step; in
# practice, you may just modify the previously defined version like this:
p11 + theme(strip.text = element_text(face = "bold"))

# or you just keep one version and add the new specification to the code.
# We kept the whole code in each step only for teaching purposes.
