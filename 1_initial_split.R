# Final Project Memo 1  ----
# Initial Data Splitting

## loading in data ----
library(tidyverse)
library(tidymodels)

# resolve conflicts
tidymodels_prefer()


# initial split ----
cancer_data_split <- cancer_data |>
  initial_split(prop = 0.8, strata = survival_time_log10)

cd_training <- cancer_data_split |> training()
cd_testing <- cancer_data_split |> testing()


# write out/save outputs ----
save(cancer_data_split, file = here::here("data/cancer_data_split.rda"))
save(cd_training, file = here::here("data/cd_training.rda"))
save(cd_testing, file = here::here("data/cd_testing.rda"))
