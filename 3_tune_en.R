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
num_cores <- parallel::detectCores(logical = TRUE)
registerDoMC(cores = num_cores)

# load in training data ----
load(here("data/movies_folds.rda"))
load(here("data/keep_wflow.rda"))
load(here("data/my_metrics.rda"))


# load in recipe ----
load(here("recipes/movies_recipe_lm.rda"))
load(here("recipes/movies_recipe_lm_basic.rda"))


# BASIC TUNE ----

# model specifications ----
en_spec_basic <- linear_reg(penalty = tune(), mixture = tune())|> 
  set_engine("glmnet") |> 
  set_mode("regression")

# define workflows ----
en_wflow_basic <- workflow() |>
  add_model(en_spec_basic) |>
  add_recipe(movies_recipe_lm_basic)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(en_spec_basic)

# change hyperparameter ranges
en_params_basic <- hardhat::extract_parameter_set_dials(en_spec_basic) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    penalty = penalty(trans = NULL, range = 10^c(-10, 0)),
    mixture = mixture()
  ) 

# build tuning grid
en_grid_basic <- grid_regular(en_params_basic, levels = c(penalty = 5, mixture = 5))

# lasso_grid <- grid_random(lasso_params, size = 10)


# fit workflows/models ----
en_tuned_basic <- 
  en_wflow_basic |> 
  tune_grid(
    movies_folds, 
    grid = en_grid_basic, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(en_tuned_basic, file = here("results/en_tuned_basic.rda"))





# COMPLEX TUNE ----

# model specifications ----
en_spec <- linear_reg(penalty = tune(), mixture = tune())|> 
  set_engine("glmnet") |> 
  set_mode("regression")

# define workflows ----
en_wflow <- workflow() |>
  add_model(en_spec) |>
  add_recipe(movies_recipe_lm)

# hyperparameter tuning values ----

# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(en_spec)

# change hyperparameter ranges
en_params <- hardhat::extract_parameter_set_dials(en_spec) |> 
  # N:= maximum number of random predictor columns we want to try 
  # should be less than the number of available columns
  update(
    penalty = penalty(trans = NULL, range = 10^c(-10, 0)),
    mixture = mixture()
  ) 

# build tuning grid
en_grid <- grid_regular(en_params, levels = c(penalty = 5, mixture = 5))

# lasso_grid <- grid_random(lasso_params, size = 10)


# fit workflows/models ----
en_tuned <- 
  en_wflow |> 
  tune_grid(
    movies_folds, 
    grid = en_grid, 
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(en_tuned, file = here("results/en_tuned.rda"))



