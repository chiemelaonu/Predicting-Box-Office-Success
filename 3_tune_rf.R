# Final Project Memo 1  ----
# Tuning, Fitting Random Forest Model

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)
library(doMC)

# resolve conflicts
tidymodels_prefer()

# set seed
set.seed(101932)

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
registerDoMC(cores = num_cores)

# load in data ----
load(here("data/movies_folds.rda"))
load(here("data/keep_wflow.rda"))
load(here("data/my_metrics.rda"))


# load in recipe ----
load(here("recipes/movies_recipe_tree_basic.rda"))
load(here("recipes/movies_recipe_tree.rda"))

# BASIC MODEL TUNING ----

# model specifications ----
rf_spec_basic <- rand_forest(trees = 500, min_n = tune(), mtry = tune()) |>
  set_engine("ranger") |> 
  set_mode("regression")

# define workflows ----
rf_wflow_basic <- workflow() |>
  add_model(rf_spec_basic) |>
  add_recipe(movies_recipe_tree_basic)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(rf_spec_basic)

# change hyperparameter ranges
rf_params <- hardhat::extract_parameter_set_dials(rf_spec_basic) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    mtry = mtry(range = c(1, 10)),
    min_n = min_n(range = c(2, 40))
  ) 

# build tuning grid
rf_grid_basic <- grid_regular(rf_params, levels = 5)

# rf_grid <- grid_random(rf_params, size = 10)


# fit workflows/models ----
rf_tuned_basic <- 
  rf_wflow_basic |> 
  tune_grid(
    movies_folds, 
    grid = rf_grid_basic, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(rf_tuned_basic, file = here("results/rf_tuned_basic.rda"))



# COMPLEX MODEL TUNING ----

# set seed
set.seed(1492781)

# model specifications ----
rf_spec <- rand_forest(trees = 500, min_n = tune(), mtry = tune())|> 
  set_engine("ranger") |> 
  set_mode("regression")

# define workflows ----
rf_wflow <- workflow() |>
  add_model(rf_spec) |>
  add_recipe(movies_recipe_tree)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(rf_spec)

# change hyperparameter ranges
rf_params <- hardhat::extract_parameter_set_dials(rf_spec) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    mtry = mtry(range = c(1, 10)),
    min_n = min_n(range = c(2, 40))
  ) 

# build tuning grid
rf_grid <- grid_regular(rf_params, levels = 5)

# rf_grid <- grid_random(rf_params, size = 10)


# fit workflows/models ----
rf_tuned <- 
  rf_wflow |> 
  tune_grid(
    movies_folds, 
    grid = rf_grid, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(rf_tuned, file = here("results/rf_tuned.rda"))


