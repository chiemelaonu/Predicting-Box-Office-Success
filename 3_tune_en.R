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


# load in recipe ----
load(here("recipes/movies_recipe.rda"))

# define lasso spec ----
lasso_spec <- linear_reg() |>
  set_engine("glmnet") |>
  set_mode("regression")

# # define workflow ----
# lasso_wflow <- workflow() |>
#   add_model(lasso_spec) |>
#   add_recipe(movies_recipe)
# 
# 
# # fit workflow ----
# lasso_fit <- fit(lasso_wflow, movies_train)
# 
# # save results ----
# save(lasso_fit, file = here("results/lasso_fit.rda"))
# 
# 
# 
# # define ridge spec ----
# ridge_spec <- linear_reg() |>
#   set_engine("glmnet") |>
#   set_mode("regression")
# 
# # define workflow ----
# ridge_wflow <- workflow() |>
#   add_model(ridge_spec) |>
#   add_recipe(movies_recipe)
# 
# 
# # fit workflow ----
# ridge_fit <- fit(ridge_wflow, movies_train)
# 
# # save results ----
# save(lasso_fit, file = here("results/ridge_fit.rda"))
# 
