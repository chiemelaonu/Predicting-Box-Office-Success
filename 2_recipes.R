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

# build null recipe ----
null_recipe <- recipe(yeo_revenue ~ 1, movies_train)


# null_recipe |>
#   prep() |>
#   bake(new_data = NULL) |> glimpse()
#   

# build primary recipe ----
movies_recipe <- recipe(yeo_revenue ~ score + budget_x + date, movies_train) |>
  step_sqrt(budget_x) |>
  step_date(date, features = "year", keep_original_cols = FALSE)

# movies_recipe |>
#   prep() |>
#   bake(new_data = NULL) |> glimpse()

# save results ----
save(movies_recipe, file = here("recipes/movies_recipe.rda"))
save(null_recipe, file = here("recipes/null_recipe.rda"))
