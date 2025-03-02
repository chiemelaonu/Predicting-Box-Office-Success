# Final Project Memo 1  ----
# Tuning, Fitting Elastic Net Models

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)
library(doMC)

# resolve conflicts
tidymodels_prefer()

# parallel processing ----
num_cores <- parallel::detectCores(logical = FALSE)
registerDoMC(cores = 6)

# load in training data ----
load(here("data/movies_folds.rda"))
load(here("data/keep_wflow.rda"))
load(here("data/my_metrics.rda"))


# load in recipe ----
load(here("recipes/movies_recipe_lm.rda"))

# model specifications ----
lasso_spec <- linear_reg(penalty = tune(), mixture = tune())|> 
  set_engine("glmnet") |> 
  set_mode("regression")

# define workflows ----
lasso_wflow <- workflow() |>
  add_model(lasso_spec) |>
  add_recipe(movies_recipe_lm)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(lasso_spec)

# change hyperparameter ranges
lasso_params <- hardhat::extract_parameter_set_dials(lasso_spec) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    penalty = penalty(trans = NULL, range = 10^c(-10, 0)),
    mixture = mixture()
  ) 

# build tuning grid
lasso_grid <- grid_regular(lasso_params, levels = 5)

# lasso_grid <- grid_random(lasso_params, size = 10)


# fit workflows/models ----
lasso_tuned <- 
  lasso_wflow |> 
  tune_grid(
    movies_folds, 
    grid = lasso_grid, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(lasso_tuned, file = here("results/lasso_tuned.rda"))