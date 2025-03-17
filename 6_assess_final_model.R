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
test_preds <- movies_test |>
  bind_cols(predict(final_fit, movies_test)) |>
  select(yeo_revenue, .pred) 



# transformed scale ----

# compute metrics
rmse_result <- rmse(test_preds, truth = yeo_revenue, estimate = .pred)
mae_result <- mae(test_preds, truth = yeo_revenue, estimate = .pred)
rsq_result <- rsq(test_preds, truth = yeo_revenue, estimate = .pred)

# create a table
metrics_table <- tibble(
  Metric = c("RMSE", "MAE", "R²"),
  Value = c(rmse_result$.estimate, mae_result$.estimate, rsq_result$.estimate)
) |> knitr::kable()

# print table
metrics_table


# predictions on original scale ----
test_preds_original <- test_preds |>
  mutate(
    price_actual = yeo.johnson(yeo_revenue, lambda = 0.25, derivative = 0, inverse = TRUE),   
    price_predicted = yeo.johnson(.pred, lambda = 0.25, derivative = 0, inverse = TRUE)       
  )

# compute metrics
rmse_orig <- rmse(test_preds_original, truth = price_actual, estimate = price_predicted) 
mae_orig <- mae(test_preds_original, truth = price_actual, estimate = price_predicted) 
rsq_orig <- rsq(test_preds_original, truth = price_actual, estimate = price_predicted) 


# create a table
metrics_table_orig <- tibble(
  Metric = c("RMSE", "MAE", "R²"),
  Value = c(rmse_orig$.estimate, mae_orig$.estimate, rsq_orig$.estimate)
) |> knitr::kable()

# print table
metrics_table_orig


# plot ----
final_plot_yeo <- test_preds |>
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
  filename = here("figures/final_plot_yeo.png"),
  plot = final_plot_yeo,
  width = 5,
  height = 3.5
)

final_plot_orig <- test_preds_original |>
  ggplot(aes(x = price_actual, y = price_predicted)) +
  geom_point(alpha = 0.5, color = "black" ) +  
  geom_abline(linetype = "dashed", linewidth = 0.5) +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma) +
  coord_obs_pred() +
  labs(
    x = "Actual Revenue
    (Original Scale)",
    y = "Predicted Revenue 
    (Original Scale)"
  ) +
  theme_minimal()

ggsave(
  filename = here("figures/final_plot_orig.png"),
  plot = final_plot_orig,
  width = 5,
  height = 3.5
)

final_plot_orig_zoom <- test_preds_original |>
  ggplot(aes(x = price_actual, y = price_predicted)) +
  geom_point(alpha = 0.5, color = "black" ) +  
  geom_abline(linetype = "dashed", linewidth = 0.5) +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma) +
  coord_cartesian(xlim = c(0, 500000000), ylim = c(0, 500000000)) +
  labs(
    x = "Actual Revenue
    (Original Scale)",
    y = "Predicted Revenue 
    (Original Scale)"
  ) +
  theme_minimal()


ggsave(
  filename = here("figures/final_plot_orig_zoom.png"),
  plot = final_plot_orig_zoom,
  width = 6,
  height = 3.5
)

