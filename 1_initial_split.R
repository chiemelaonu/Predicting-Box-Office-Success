# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)

# resolve conflicts
tidymodels_prefer()

# read in data ----
movies_data <- read_csv("data/movies_clean.csv")

# set seed ----
set.seed(17382015)

# initial split ----
movies_split <- movies_data |>
  initial_split(prop = 0.8, strata = yeo_revenue)

movies_training <- movies_split |> training()
movies_testing <- movies_split |> testing()


# write out/save outputs ----
save(movies_split, file = here("data/movies_split.rda"))
save(movies_training, file = here("data/movies_training.rda"))
save(movies_testing, file = here("data/movies_testing.rda"))
