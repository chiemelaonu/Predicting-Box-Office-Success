## loading in data ----
library(tidyverse)
library(tidymodels)

# resolve conflicts
tidymodels_prefer()
movies <- read_csv("data/final_dataset.csv")

# finding how many NAs in target variable
sum(is.na(movies$grossWorldWide))

## EDA ----

# density plot of grossWorldWide profit
movies |>
  ggplot(aes(grossWorldWide)) +
  geom_density()


# boxplot of grossWorldWide profit
ggplot(movies, aes(grossWorldWide)) +
  geom_boxplot() +
  geom_rug(alpha = 0.2) +
  xlab("log10 of price")




# density plot of log10 of grossWorldWide profit
ggplot(movies, aes(grossWorldWide)) +
  geom_density() +
  geom_rug(alpha = 0.2) +
  scale_x_log10() +
  xlab("log10 of price")


# boxplot of log10 of grossWorldWide profit
ggplot(movies, aes(grossWorldWide)) +
  geom_boxplot() +
  geom_rug(alpha = 0.2) +
  scale_x_log10() +
  xlab("log10 of price")


# adding transformed variable ----
movies <- movies |>
  mutate(
    grossWW_log10 = log10(grossWorldWide)
  )
