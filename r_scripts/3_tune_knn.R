# Final Project Memo 1  ----
# Tuning, Fitting KNN Model

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)
library(doMC)

# resolve conflicts
tidymodels_prefer()

# set seed
set.seed(7187519)

# parallel processing ----
num_cores <- parallel::detectCores(logical = FALSE)
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
knn_spec_basic <- nearest_neighbor(neighbors = tune()) |>
  set_engine("kknn") |> 
  set_mode("regression")

# define workflows ----
knn_wflow_basic <- workflow() |>
  add_model(knn_spec_basic) |>
  add_recipe(movies_recipe_tree_basic)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(knn_spec_basic)

# change hyperparameter ranges
knn_params_basic <- hardhat::extract_parameter_set_dials(knn_spec_basic) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    neighbors = neighbors()
  ) 

# build tuning grid
knn_grid_basic <- grid_regular(knn_params_basic, levels = 5)

# rf_grid <- grid_random(rf_params, size = 10)


# fit workflows/models ----
knn_tuned_basic <- 
  knn_wflow_basic |> 
  tune_grid(
    movies_folds, 
    grid = knn_grid_basic, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(knn_tuned_basic, file = here("results/knn_tuned_basic.rda"))



# COMPLEX MODEL TUNING ----


# model specifications ----
knn_spec <- nearest_neighbor(neighbors = tune()) |>
  set_engine("kknn") |> 
  set_mode("regression")

# define workflows ----
knn_wflow <- workflow() |>
  add_model(knn_spec) |>
  add_recipe(movies_recipe_tree)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(knn_spec)

# change hyperparameter ranges
knn_params <- hardhat::extract_parameter_set_dials(knn_spec) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    neighbors = neighbors()
  ) 

# build tuning grid
knn_grid <- grid_regular(knn_params, levels = 5)

# rf_grid <- grid_random(rf_params, size = 10)


# fit workflows/models ----
knn_tuned <- 
  knn_wflow |> 
  tune_grid(
    movies_folds, 
    grid = knn_grid, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(knn_tuned, file = here("results/knn_tuned.rda"))


