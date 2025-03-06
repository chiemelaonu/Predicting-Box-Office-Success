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
load(here("data/movies_test.rda"))
load(here("results/final_fit.rda"))

# load in training data ----
# predictions ----
test_preds <- predict(final_fit, movies_test) |>
  bind_cols(movies_test)


# rmse
rmse_result <- rmse(test_preds, truth = yeo_revenue, estimate = .pred)


rmse_result


# plot ----
graphic_2 <- test_preds |>
  ggplot(aes(x = yeo_revenue, y = .pred)) +
  geom_point(alpha = 0.5, color = "black" ) +  
  geom_abline(linetype = "dashed", linewidth = 0.5) +
  coord_obs_pred() +
  labs(
    x = "Actual Sales",
    y = "Predicted Sales"
  ) +
  theme_minimal()

ggsave(
  filename = here("figures/graphic_2.png"),
  plot = graphic_2,
  width = 5,
  height = 3.5
)

