## loading in data ----
library(tidyverse)
library(tidymodels)
library(patchwork)

# resolve conflicts
tidymodels_prefer()
movies <- read_csv("data/final_dataset.csv")

# finding how many NAs in target variable
sum(is.na(movies$grossWorldWide))

## EDA ----

# on original scale ----

# density plot
p1 <- ggplot(movies, aes(grossWorldWide)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(movies, aes(grossWorldWide)) +
  geom_boxplot() +
  theme_void()


# boxplot over density
graphic_1 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))


ggsave(
  filename = here::here("figures/graphic_1.png"),
  plot = graphic_1,
  height = 5,
  width = 5
  )



## on log10 scale ----

p1 <- ggplot(movies, aes(grossWorldWide)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  scale_x_log10() +
  xlab("log10 of grossWorldWide") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(movies, aes(grossWorldWide)) +
  geom_boxplot() +
  scale_x_log10() +
  xlab("log10 of grossWorldWide") +
  theme_void()


# boxplot over density
graphic_2 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))


ggsave(
  filename = here::here("figures/graphic_2.png"),
  plot = graphic_2,
  height = 5,
  width = 5
)



# adding transformed variable ----
movies <- movies |>
  mutate(
    grossWW_log10 = log10(grossWorldWide)
  )
