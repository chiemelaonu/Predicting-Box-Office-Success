# Final Project Memo 1  ----
# Tuning, Fitting KNN Model

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

# load in data ----
load(here("data/movies_folds.rda"))
load(here("data/keep_wflow.rda"))
load(here("data/my_metrics.rda"))


# load in recipe ----
load(here("recipes/movies_recipe_tree_basic.rda"))
load(here("recipes/movies_recipe_tree.rda"))

# BASIC MODEL TUNING ----