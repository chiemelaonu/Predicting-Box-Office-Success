# Final Project Memo 1  ----
# Building LM Recipes

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)

# resolve conflicts
tidymodels_prefer()

# load in training data ----
load(here("data/movies_train.rda"))

# first OLS recipe ----
movies_recipe_lm <- recipe(yeo_revenue ~ score + budget_x + date
                        + negative + positive + overall_sentiment + num_crew + num_genres, data = movies_train) |>
  step_impute_mean(positive, negative) |>
  step_impute_mode(overall_sentiment) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
  step_interact(terms = ~ budget_x:num_crew ) |> 
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

# second OLS recipe (without interactions)
# movies_recipe_lm_basic <- recipe(yeo_revenue ~ score + budget_x + date
#                         + negative + positive + overall_sentiment + num_crew + num_genres, data = movies_train) |>
#   step_impute_mean(positive, negative) |>
#   step_impute_mode(overall_sentiment) |>
#   step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
#   step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
#   step_normalize(all_numeric_predictors())

# movies_recipe_lm |>
#   prep() |>
#   bake(new_data = NULL) |> glimpse()

# save results ----
# save(movies_recipe_lm_basic, file = here("recipes/movies_recipe_lm_basic.rda"))
save(movies_recipe_lm, file = here("recipes/movies_recipe_lm.rda"))