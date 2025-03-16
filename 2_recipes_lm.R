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

# complex OLS recipe ----
# with interactions and budget column transformation
movies_recipe_lm <- recipe(yeo_revenue ~ score + budget_x + date
                        + negative + positive + overall_sentiment + num_crew + num_genres + revenue, data = movies_train) |>
  update_role(revenue, new_role = "ID") |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(overall_sentiment) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
  step_interact(terms = ~ budget_x:num_crew + budget_x:score) |> 
  step_YeoJohnson(budget_x) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_normalize(all_numeric_predictors())

movies_recipe_lm |>
    prep() |>
    bake(new_data = NULL) |> glimpse()


  
# basic ols recipe ----
movies_recipe_lm_basic <- recipe(yeo_revenue ~ score + budget_x + date
                        + negative + positive + overall_sentiment + num_crew + num_genres + revenue, data = movies_train) |>
  update_role(revenue, new_role = "ID") |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(overall_sentiment) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_normalize(all_numeric_predictors())

movies_recipe_lm_basic |>
  prep() |>
  bake(new_data = NULL) |> glimpse()

# save results ----
save(movies_recipe_lm_basic, file = here("recipes/movies_recipe_lm_basic.rda"))
save(movies_recipe_lm, file = here("recipes/movies_recipe_lm.rda"))
