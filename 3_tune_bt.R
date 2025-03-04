# Final Project Memo 1  ----
# Tuning, Fitting Boosted Trees Model

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)
library(doMC)

# resolve conflicts
tidymodels_prefer()

# set seed
set.seed(6791822)

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


# BASIC TUNE ----

# model specifications ----
bt_spec_basic <- 
  boost_tree(trees = 250,
             min_n = tune(),
             mtry = tune(),
             learn_rate = tune()
             ) |> 
  set_engine("xgboost") |> 
  set_mode("regression")

# define workflows ----
bt_wflow_basic <- workflow() |>
  add_model(bt_spec_basic) |>
  add_recipe(movies_recipe_tree_basic)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(bt_spec_basic)

# change hyperparameter ranges
bt_params_basic <- hardhat::extract_parameter_set_dials(bt_spec_basic) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    mtry = mtry(c(1, 10)),
    min_n = min_n(c(2, 40)),
    learn_rate = learn_rate(range = c(-5, -0.2))
  ) 

# build tuning grid
bt_grid_basic <- grid_regular(bt_params_basic, levels = 5)

# bt_grid <- grid_random(bt_params, size = 10)


# fit workflows/models ----
bt_tuned_basic <- 
  bt_wflow_basic |> 
  tune_grid(
    movies_folds, 
    grid = bt_grid_basic, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(bt_tuned_basic, file = here("results/bt_tuned_basic.rda"))



# COMPLEX TUNE ----

# model specifications ----
bt_spec <- rand_forest(trees = 250, min_n = tune(), mtry = tune())|> 
  set_engine("xgboost") |> 
  set_mode("regression")

# define workflows ----
bt_wflow <- workflow() |>
  add_model(bt_spec) |>
  add_recipe(movies_recipe_tree)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(bt_spec)

# change hyperparameter ranges
bt_params <- hardhat::extract_parameter_set_dials(bt_spec) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    mtry = mtry(c(1, 10)),
    min_n = min_n(c(2, 40)),
    learn_rate = learn_rate(range = c(-5, -0.2))
  ) 

# build tuning grid
bt_grid <- grid_regular(bt_params, levels = 5)

# bt_grid <- grid_random(bt_params, size = 10)


# fit workflows/models ----
bt_tuned <- 
  bt_wflow |> 
  tune_grid(
    movies_folds, 
    grid = bt_grid, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(bt_tuned, file = here("results/bt_tuned.rda"))

