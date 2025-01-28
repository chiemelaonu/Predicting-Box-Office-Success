# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)

# resolve conflicts
tidymodels_prefer()


# initial split ----
movies_split <- movies |>
  initial_split(prop = 0.8, strata = grossWW_log10)

movies_training <- movies_split |> training()
movies_testing <- movies_plit |> testing()


# write out/save outputs ----
save(movies_split, file = here::here("data/movies_split.rda"))
save(movies_training, file = here::here("data/movies_training.rda"))
save(movies_testing, file = here::here("data/movies_testing.rda"))
