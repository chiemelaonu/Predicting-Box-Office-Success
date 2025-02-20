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
load(here("results/lm_fit.rda"))
load(here("results/baseline_fit.rda"))


# calculate metrics for each fitted model (fitted with kc_folds) ----
linear_metrics <- collect_metrics(lm_fit)
baseline_metrics  <- collect_metrics(baseline_fit)
# ridge_metrics  <- collect_metrics(ridge_fit)
# rf_metrics     <- collect_metrics(rf_fit)
# knn_metrics    <- collect_metrics(knn_fit)

performance_table <- bind_rows(
  linear_metrics |> mutate(Model = "Linear Regression"),
  baseline_metrics |> mutate(Model = "Baseline Regression")
) |>
  knitr::kable()

performance_table