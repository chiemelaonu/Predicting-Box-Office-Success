# Final Project Memo 1  ----
# Building Recipes

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)

# resolve conflicts
tidymodels_prefer()

# load in training data ----
load(here("data/movies_train.rda"))

# build null/baseline recipe ----
movies_recipe_baseline <- recipe(yeo_revenue ~ score + budget_x + date
                                 + negative + positive + overall_sentiment + num_crew + num_genres, data = movies_train) |>
  step_impute_mean(positive, negative) |>
  step_impute_mode(overall_sentiment) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE)

movies_recipe_baseline |>
  prep() |>
  bake(new_data = NULL) |> glimpse()


# first OLS recipe ----
movies_recipe <- recipe(yeo_revenue ~ score + budget_x + date
                                 + negative + positive + overall_sentiment + num_crew + num_genres, data = movies_train) |>
  step_impute_mean(positive, negative) |>
  step_impute_mode(overall_sentiment) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
  step_interact(terms = ~ budget_x:num_crew ) |> 
  step_dummy(all_nominal_predictors())


# movies_recipe |>
#   prep() |>
#   bake(new_data = NULL) |> glimpse()

# save results ----
save(movies_recipe, file = here("recipes/movies_recipe.rda"))

save(movies_recipe_baseline, file = here("recipes/movies_recipe_baseline.rda"))
