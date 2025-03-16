# Final Project Memo 1  ----
# Tuning, Fitting Elastic Net Models

## loading in data ----
library(tidyverse)
library(tidymodels)
library(here)
library(car)
library(doMC)
library(VGAM)

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

# predictions on original scale ----
test_preds_orig <- predict(final_fit, movies_test) |>
  mutate(.pred_orig = yeo.johnson(.pred, lambda = 0.25, derivative = 0, inverse = TRUE)) |>
  bind_cols(movies_test)

rmse_result_orig <- rmse(test_preds_orig, truth = revenue, estimate = .pred_orig)

rmse_result_orig
# plot ----
final_plot <- test_preds |>
  ggplot(aes(x = yeo_revenue, y = .pred)) +
  geom_point(alpha = 0.5, color = "black" ) +  
  geom_abline(linetype = "dashed", linewidth = 0.5) +
  coord_obs_pred() +
  labs(
    x = "Actual Revenue
    (with YJ Transformation)",
    y = "Predicted Revenue 
    (with YJ Transformation)"
  ) +
  theme_minimal()

ggsave(
  filename = here("figures/final_plot.png"),
  plot = final_plot,
  width = 5,
  height = 3.5
)

