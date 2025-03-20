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
registerDoMC(cores = num_cores)

# load data ----
load(here("data/movies_train.rda"))
load(here("results/bt_tuned_basic.rda"))

# train best model (basic bt model) ----
final_wflow <- bt_tuned_basic |> 
  extract_workflow(bt_tuned_basic) |>  
  finalize_workflow(select_best(bt_tuned_basic, metric = "mae"))

# train final model ----

# set seed
set.seed(962719)

final_fit <- fit(final_wflow, movies_train)

# save results ----
save(final_fit, file = here("results/final_fit.rda"))

