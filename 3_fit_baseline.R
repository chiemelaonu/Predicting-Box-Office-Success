# Final Project Memo 1  ----
# Baseline Model Fitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
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

# load recipe
load(here("recipes/null_recipe.rda"))


# define baseline model ----
baseline_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# workflow ----
baseline_wflow<- workflow() |>
  add_model(baseline_spec) |>
  add_recipe(null_recipe)

# fit model ----
baseline_fit <- fit_resamples(baseline_wflow, resamples = movies_folds, metrics = my_metrics, control = keep_wflow)


# save baseline fit ----
save(baseline_fit, file = here("results/baseline_fit.rda"))


