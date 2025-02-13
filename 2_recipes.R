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

# build recipe ----
movies_recipe <- recipe(yeo_revenue ~ score + budget_x + date, movies_train) |>
  step_sqrt(budget_x) |>
  step_date(date, features = "year", keep_original_cols = FALSE)

# five <- movies_recipe |>
#   prep() |>
#   bake(new_data = NULL) |> glimpse()

# save results ----
save(movies_recipe, file = here("recipes/movies_recipe.rda"))
