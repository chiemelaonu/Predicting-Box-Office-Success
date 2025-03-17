# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(DT)

# resolve conflicts
tidymodels_prefer()

# read in data ----
movies_data <- read_csv("data/movies_clean.csv")


# set seed ----
set.seed(17382015)


# initial split ----
movies_split <- movies_data |>
  initial_split(prop = 0.8, strata = yeo_revenue)

movies_train <- movies_split |> training()
movies_test <- movies_split |> testing()

# setup resamples ----
movies_folds <- movies_train |> 
  vfold_cv(
    v = 5, 
    repeats = 3,
    strata = yeo_revenue
  )


# controls for fitting to resamples ----
keep_wflow <- control_grid(save_workflow = TRUE)
my_metrics <- metric_set(rmse, mae)

# write out/save outputs ----
save(movies_split, file = here("data/movies_split.rda"))
save(movies_train, file = here("data/movies_train.rda"))
save(movies_test, file = here("data/movies_test.rda"))
save(my_metrics, file = here("data/my_metrics.rda"))
save(keep_wflow, file = here("data/keep_wflow.rda"))
save(movies_folds, file = here("data/movies_folds.rda"))
