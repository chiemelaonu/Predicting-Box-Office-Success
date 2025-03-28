# Final Project Memo 1  ----
# Building Tree Recipes

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(lubridate)


# resolve conflicts
tidymodels_prefer()

# load in training data ----
load(here("data/movies_train.rda"))

# first tree recipe ----
movies_recipe_tree_basic <- recipe(yeo_revenue ~ score + budget_x + date
                             + negative + positive + overall_sentiment + num_crew + num_genres + revenue, data = movies_train) |>
  update_role(revenue, new_role = "ID") |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(overall_sentiment) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

movies_recipe_tree_basic |>
  prep() |>
  bake(new_data = NULL) |> glimpse()


# complex tree recipe ----
# categorize by seasons
movies_recipe_tree <- recipe(yeo_revenue ~ score + budget_x + date
                             + negative + positive + overall_sentiment + num_crew + num_genres + revenue, data = movies_train) |>
  update_role(revenue, new_role = "ID") |>
  step_impute_mean(all_numeric_predictors()) |>
  step_impute_mode(overall_sentiment) |>
  step_mutate(season = case_when(
    month(date, label = TRUE, abbr = FALSE) %in% c("December", "January", "February")  ~ "Winter",
    month(date, label = TRUE, abbr = FALSE) %in% c("March", "April", "May")   ~ "Spring",
    month(date, label = TRUE, abbr = FALSE) %in% c("June", "July", "August")   ~ "Summer",
    month(date, label = TRUE, abbr = FALSE) %in% c("September", "October", "November") ~ "Fall",
    TRUE ~ NA_character_  
  )) |>
  step_mutate(season = factor(season, levels = c("Winter", "Spring", "Summer", "Fall"))) |>
  step_date(date, features = c("year", "month"), keep_original_cols = FALSE) |> 
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

movies_recipe_tree |>
  prep() |>
  bake(new_data = NULL) |> glimpse()

# save results ----
save(movies_recipe_tree_basic, file = here("recipes/movies_recipe_tree_basic.rda"))
save(movies_recipe_tree, file = here("recipes/movies_recipe_tree.rda"))
