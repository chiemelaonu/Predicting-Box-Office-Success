# Final Project Memo 1  ----
# Fitting OLS Model

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)
library(doMC)

# resolve conflicts
tidymodels_prefer()

# set seed 
set.seed(8160082)

# parallel processing ----
num_cores <- parallel::detectCores(logical = TRUE)
registerDoMC(cores = 6)

# load data ----
load(here("data/movies_folds.rda"))


# load in recipe ----
load(here("recipes/movies_recipe_lm_basic.rda"))
load(here("recipes/movies_recipe_lm.rda"))


# BASIC FIT ----
# define model spec ----
lm_basic_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# define workflow ----
lm_basic_wflow <- workflow() |>
  add_model(lm_basic_spec) |>
  add_recipe(movies_recipe_lm_basic)


# fit workflow ----
lm_basic_fit <- fit_resamples(
  lm_basic_wflow,
  resamples = movies_folds,
  control = control_resamples(save_workflow = TRUE)
)

# save results ----
save(lm_basic_fit, file = here("results/lm_basic_fit.rda"))




# COMPLEX FIT ----

# define model spec ----
lm_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# define workflow ----
lm_wflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(movies_recipe_lm)


# fit workflow ----
lm_fit <- fit_resamples(
  lm_wflow,
  resamples = movies_folds,
  control = control_resamples(save_workflow = TRUE)
  )

# save results ----
save(lm_fit, file = here("results/lm_fit.rda"))

