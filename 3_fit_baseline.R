# Final Project Memo 1  ----
# Baseline Model Fitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)

# resolve conflicts
tidymodels_prefer()

# load in data ----
load(here("data/movies_train.rda"))
load(here("data/movies_test.rda"))

# load recipe
load(here("recipes/null_recipe.rda"))


# define baseline model ----
baseline_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# workflow ----
baseline_workflow <- workflow() |>
  add_model(baseline_spec) |>
  add_recipe(null_recipe)

# fit model ----
baseline_fit <- fit(baseline_workflow, data = movies_train)

tidy(baseline_fit)

# save baseline fit ----
save(baseline_fit, file = here("results/baseline_fit.rda"))



# predictions and rmse ----
baseline_predictions <- predict(baseline_fit, new_data = movies_test) |>
  bind_cols(movies_test)

baseline_predictions |>
  rmse(truth = yeo_revenue, estimate = .pred)

