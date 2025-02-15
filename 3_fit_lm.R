# Final Project Memo 1  ----
# Fitting OLS Model

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

# define model spec ----
lm_spec <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# define workflow ----
lm_wflow <- workflow() |>
  add_model(lm_spec) |>
  add_recipe(movies_recipe)


# fit workflow ----
lm_fit <- fit(lm_wflow, movies_train)

# save results ----
save(lm_fit, file = here("results/lm_fit.rda"))
