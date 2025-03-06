# Final Project Memo 1  ----
# Model Analysis

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

# load in results ----
list.files(
  here("results/"),
  pattern = ".rda",
  full.names = TRUE
) |>
  map(load, envir = .GlobalEnv)

# examine results
basic_model_results <-
  as_workflow_set(
    lm = lm_basic_fit,
    null = null_results,
    baseline = baseline_results,
    knn = knn_tuned_basic,
    rf = rf_tuned_basic,
    bt = bt_tuned_basic,
    en = en_tuned_basic
  ) 

# examine rmse
basic_model_results |>
  autoplot(metric = "rmse")

basic_model_results |>
  autoplot(metric = "rmse", select_best = TRUE)

basic_model_results |>
  collect_metrics() 

basic_fits_table <- basic_model_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(
    `Model Name` = wflow_id,          
    `Metric Type` = .metric,          
    `Mean RMSE` = mean,               
    `Standard Error` = std_err,
    n              
  ) |> knitr::kable()


# examine results
model_results <-
  as_workflow_set(
    lm = lm_fit,
    null = null_results,
    baseline = baseline_results,
    knn = knn_tuned,
    rf = rf_tuned,
    bt = bt_tuned,
    en = en_tuned
  ) 

# examine rmse
model_results |>
  autoplot(metric = "rmse")

model_results |>
  autoplot(metric = "rmse", select_best = TRUE)

model_results |>
  collect_metrics() 

fits_table <- model_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(
    `Model Name` = wflow_id,          
    `Metric Type` = .metric,          
    `Mean RMSE` = mean,               
    `Standard Error` = std_err,
    n              
  ) |> knitr::kable()
