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

select_best(rf_tuned_basic, metric = "rmse") |>
  mutate(Model_Type = "Random Forest") |>  
  select(-.config) |>
  knitr::kable()
select_best(knn_tuned_basic, metric = "rmse") |>
  mutate(Model_Type = "Random Forest") |>  
  select(-.config) |>
  knitr::kable()
select_best(bt_tuned_basic, metric = "rmse") |>
  mutate(Model_Type = "Random Forest") |>  
  select(-.config) |>
  knitr::kable()
select_best(en_tuned_basic, metric = "rmse") |>
  mutate(Model_Type = "Random Forest") |>  
  select(-.config) |>
  knitr::kable()

best_params_table <- bind_rows(
  select_best(rf_tuned_basic, metric = "rmse") |>
    mutate(Model_Type = "Random Forest") |>  # Add model name
    select(-.config),  # Remove the .config column
  
  select_best(knn_tuned_basic, metric = "rmse") |>
    mutate(Model_Type = "K-Nearest Neighbors") |>  # Add model name
    select(-.config),
  
  select_best(bt_tuned_basic, metric = "rmse") |>
    mutate(Model_Type = "Boosted Trees") |>  # Add model name
    select(-.config),
  
  select_best(en_tuned_basic, metric = "rmse") |>
    mutate(Model_Type = "Elastic Net") |>  # Add model name
    select(-.config)
)

# Print the final table
best_params_table |> knitr::kable(digits = 4)


# basic workflows ----

# autplots of tuned workflows
knn_basic_auto <- knn_tuned_basic |>
  autoplot(metric = "mae")
ggsave(
  filename = here("figures/knn_basic_auto.png"),
  plot = knn_basic_auto,
  height = 5,
  width = 8
)


rf_basic_auto <- rf_tuned_basic |>
  autoplot(metric = "mae")
ggsave(
  filename = here("figures/rf_basic_auto.png"),
  plot = rf_basic_auto,
  height = 5,
  width = 8
)


en_basic_auto <- en_tuned_basic |>
  autoplot(metric = "mae")
ggsave(
  filename = here("figures/en_basic_auto.png"),
  plot = en_basic_auto,
  height = 5,
  width = 8
)


bt_basic_auto <- bt_tuned_basic |>
  autoplot(metric = "mae")
ggsave(
  filename = here("figures/bt_basic_auto.png"),
  plot = bt_basic_auto,
  height = 5,
  width = 8
)


# workflow set
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




# examine mae
basic_model_results |>
  autoplot(metric = "mae")

basic_autoplot <- basic_model_results |>
  autoplot(metric = "mae", select_best = TRUE)
basic_model_results |> collect_metrics() |> distinct(.metric)


# saving
ggsave(
  filename = here("figures/basic_autoplot.png"),
  plot = basic_autoplot,
  height = 5,
  width = 8
)

# basic fits table 
basic_fits_table <- basic_model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(
    `Model Type` = wflow_id,
    Accuracy = mean,
    `Std Error` = std_err, n = n
  ) |>
  knitr::kable(digits = 4)

basic_fits_table <- basic_model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  select_best(metric == "mae")
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(
    `Model Type` = wflow_id,
    Accuracy = mean,
    `Std Error` = std_err, n = n
  ) |>
  knitr::kable(digits = 4)

# complex workflow ---

# autplots
knn_auto <- knn_tuned |>
  autoplot(metric = "mae")

ggsave(
  filename = here("figures/knn_auto.png"),
  plot = knn_auto,
  height = 5,
  width = 8
)


rf_auto <- rf_tuned |>
  autoplot(metric = "mae")

ggsave(
  filename = here("figures/rf_auto.png"),
  plot = rf_auto,
  height = 5,
  width = 8
)

en_auto <- en_tuned |>
  autoplot(metric = "mae")
ggsave(
  filename = here("figures/en_auto.png"),
  plot = en_auto,
  height = 5,
  width = 8
)

bt_auto <- bt_tuned |>
  autoplot(metric = "mae")
ggsave(
  filename = here("figures/bt_auto.png"),
  plot = bt_auto,
  height = 5,
  width = 8
)


# workflow set
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

# examine mae
model_results |>
  autoplot(metric = "mae")

complex_autoplot <- model_results |>
  autoplot(metric = "mae", select_best = TRUE)

# saving
ggsave(
  filename = here("figures/complex_autoplot.png"),
  plot = complex_autoplot,
  height = 5,
  width = 8
)
model_results |>
  collect_metrics() 

# complex fits table 
fits_table <- model_results |>
  collect_metrics() |>
  filter(.metric == "mae") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean) |>
  select(
    `Model Type` = wflow_id,
    Accuracy = mean,
    `Std Error` = std_err, n = n
  ) |>
  knitr::kable(digits = 4)
