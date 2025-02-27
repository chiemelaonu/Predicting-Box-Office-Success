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
list.files(
  here("results/"),
  pattern = ".rda",
  full.names = TRUE
) |>
  map(load, envir = .GlobalEnv)

# examine results
model_results <-
  as_workflow_set(
    lm = lm_fit,
    null = null_results,
    baseline = baseline_results
  ) 

# examine rmse
model_results |>
  autoplot(metric = "rmse")

model_results |>
  autoplot(metric = "rmse", select_best = TRUE)

model_results |>
  collect_metrics() 
  
# examine rmse
# model_results |>
#   autoplot(metric = "rmse")

# model_results |>
#   autoplot(metric = "rmse", select_best = TRUE)

model_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean)
