# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)

# resolve conflicts
tidymodels_prefer()

# load in training data ----
load(here("data/movies_train.rda"))
glimpse(movies_train)
movies_train |>
  mutate(budget_x = yjPower(budget_x, lambda = 0.35)) |>
  ggplot(aes(budget_x)) +
  geom_density()

movies_train |>
  mutate(budget_x = log1p(budget_x)) |>
  ggplot(aes(budget_x)) +
  geom_density()
  
# build recipe ----
movies_recipe <- recipe(yeo_revenue ~ score + genre_list + budget_x + country + date, movies_train) |>
  step_dummy(all_nominal_predictors()) |>
  step_naomit(genre_list) |>
  step_date(date, features = "year", keep_original_cols = FALSE)

# write out/save outputs ----
save(movies_split, file = here("data/movies_split.rda"))
save(movies_training, file = here("data/movies_training.rda"))
save(movies_testing, file = here("data/movies_testing.rda"))
