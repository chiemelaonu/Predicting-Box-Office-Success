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
num_cores <- parallel::detectCores(logical = TRUE)
registerDoMC(cores = 6)


# load data ----
load(here("data/movies_folds.rda"))
load(here("data/my_metrics.rda"))

# load recipe
load(here("recipes/movies_recipe_baseline.rda"))

# null model ----

# model spec
null_spec <- null_model() |>
  set_engine("parsnip") |>
  set_mode("regression")

# workflow
null_workflow <- workflow() |>
  add_model(null_spec) |>
  add_recipe(movies_recipe_baseline)

null_results <- fit_resamples(
  null_workflow,
  resamples = movies_folds,
  control = control_resamples(save_workflow = TRUE)
)

# save null
save(null_results, file = here("results/null_results.rda"))

# baseline model ----

# model spec
baseline_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# workflow
baseline_workflow <- workflow() |>
  add_model(baseline_spec) |>
  add_recipe(movies_recipe_baseline)

baseline_results <- fit_resamples(
  baseline_workflow,
  resamples = movies_folds,
  control = control_resamples(save_workflow = TRUE)
)

# save baseline ----
save(baseline_results, file = here("results/baseline_results.rda"))
