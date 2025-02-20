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

# parallel processing ----
num_cores <- parallel::detectCores(logical = FALSE)
registerDoMC(cores = 6)

# load data ----
load(here("data/keep_wflow.rda"))
load(here("data/movies_folds.rda"))
load(here("data/my_metrics.rda"))



# load in recipe ----
load(here("recipes/movies_recipe.rda"))

# define model spec ----
lm_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# define workflow ----
lm_wflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(movies_recipe)


# fit workflow ----
lm_fit <- fit_resamples(lm_wflow, resamples = movies_folds, metrics = my_metrics, control = keep_wflow)

# save results ----
save(lm_fit, file = here("results/lm_fit.rda"))
