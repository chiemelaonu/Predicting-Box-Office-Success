# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)

# resolve conflicts
tidymodels_prefer()

# load in training data ----
load(here("data/movies_train.rda"))


# load in recipe ----
load(here("recipes/movies_recipe.rda"))

# TUNING PROCESS TO FIND BEST PENALTY ----

# cross validation
cv_folds <- vfold_cv(movies_train, v = 10)

# define lasso spec ----
lasso_spec <- linear_reg(penalty = tune(), mixture = 1) |>
  set_engine("glmnet") |>
  set_mode("regression")

# define workflow ----
lasso_wflow <- workflow() |>
  add_model(lasso_spec) |>
  add_recipe(movies_recipe)

my_grid <- tibble(penalty = 10^seq(-2, -1, length.out = 10))

my_res <- lasso_wflow |> 
  tune_grid(resamples = cv_folds,
            grid = my_grid,
            control = control_grid(verbose = FALSE, save_pred = TRUE),
            metrics = metric_set(rmse))

# showing best penalty
best_mod <- my_res |> select_best(metric = "rmse")
best_mod

# fitting workflow ----
lasso_fit <- finalize_workflow(lasso_wflow, best_mod) |>
  fit(data = movies_train)

# predict(lasso_fit, movies_train)

# save ----
save(lasso_fit, file = here("results/lasso_fit.rda"))
