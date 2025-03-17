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
skimr::skim(movies_test$yeo_revenue)
# load in training data ----
# predictions ----
test_preds <- movies_test |>
  bind_cols(predict(final_fit, movies_test)) |>
  select(yeo_revenue, .pred) 



# rmse
rmse_result <- rmse(test_preds, truth = yeo_revenue, estimate = .pred)


rmse_result

# predictions on original scale ----
test_preds_original <- test_preds |>
  mutate(
    price_actual = yeo.johnson(yeo_revenue, lambda = 0.25, derivative = 0, inverse = TRUE),   
    price_predicted = yeo.johnson(.pred, lambda = 0.25, derivative = 0, inverse = TRUE)       
  )
rmse(test_preds_original, truth = price_actual, estimate = price_predicted) |> knitr::kable()
mae(test_preds_original, truth = price_actual, estimate = price_predicted) |> knitr::kable()


test_preds_original |> 
  mutate(residuals = price_actual - price_predicted) |> 
  summarise(mean_residual = mean(residuals), sd_residual = sd(residuals))


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

