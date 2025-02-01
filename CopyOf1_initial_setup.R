# Final Project Memo 1  ----
# Examining Data, Initial Data Splitting

## loading in packages ----
library(tidyverse)
library(patchwork)


# load in data ----
cancer_data <- read_csv("data/pancreatic_cancer_prediction_sample.csv")


## EDA ----

# Calculate values
missing_rows <- sum(!complete.cases(cancer_data))
num_rows <- nrow(cancer_data)
num_cols <- ncol(cancer_data)

# Create a table
summary <- data.frame(
  Metric = c("Rows with Missing Values", "Number of Observations", "Number of Variables"),
  Value = c(missing_rows, num_rows, num_cols)
)

# Display as a table
summary_table <- knitr::kable(summary, caption = "Dataset Summary")




# Count variable types
variable_types <- sapply(cancer_data, class)

# Summarize counts
num_numerical <- sum(variable_types %in% c("integer", "numeric"))
num_categorical <- sum(variable_types %in% c("factor", "character"))

# Print results
cat("Numerical Variables:", num_numerical, "\n")
cat("Categorical Variables:", num_categorical, "\n")




## Target Variable Analysis ----

# on regular scale ----
p1 <- ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_boxplot() +
  theme_void()


# boxplot over density
graphic_1 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))

# saving
ggsave(
  filename = here::here("figures/graphic_1.png"),
  plot = graphic_1,
  height = 5,
  width = 5
)


## on log10 scale ----

ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  scale_x_log10() +
  xlab("log10 of grossWorldWide") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_boxplot() +
  scale_x_log10() +
  xlab("log10 of grossWorldWide") +
  theme_void()


# boxplot over density
graphic_2 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))


ggsave(
  filename = here::here("figures/graphic_2.png"),
  plot = graphic_2,
  height = 5,
  width = 5
)