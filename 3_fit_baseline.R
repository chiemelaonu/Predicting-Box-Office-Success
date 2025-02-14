# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)

# resolve conflicts
tidymodels_prefer()

# load in data ----
load(here("data/movies_train.rda"))
load(here("data/movies_test.rda"))



# define baseline model ----
baseline_model <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# workflow ----
baseline_workflow <- workflow() |>
  add_model(baseline_model) |>
  add_recipe(recipe(yeo_revenue ~ 1, data = movies_train))

# fit model ----
baseline_fit <- fit(baseline_workflow, data = movies_train)

# predictions and rmse ----
baseline_predictions <- predict(baseline_fit, new_data = movies_test) %>%
  bind_cols(movies_test)

baseline_predictions |>
  rmse(truth = yeo_revenue, estimate = .pred)

