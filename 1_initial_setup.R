# Final Project Memo 1  ----
# Examining Data, Initial Data Splitting

## loading in packages ----
library(tidyverse)
library(patchwork)


# load in data ----
cancer_data <- read_csv("data/pancreatic_cancer_prediction_sample.csv")


# missingness check ----
cancer_data |>
  select(Survival_Time_Months) |>
  skimr::skim_without_charts() |>
  knitr::kable()

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

# D=display as a table
summary_table <- knitr::kable(summary, caption = "Dataset Summary")




# count variable types
variable_types <- sapply(cancer_data, class)

# summarize counts
num_numerical <- sum(variable_types %in% c("integer", "numeric"))
num_categorical <- sum(variable_types %in% c("factor", "character"))

# print results
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

p1 <- ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  scale_x_log10() +
  xlab("log10 of Survival_Time_Months") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())

ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_density() +
  geom_smooth(
    formula = y ~ ns(x, df = 5)
  ) 
# boxplot
p2 <- ggplot(cancer_data, aes(Survival_Time_Months)) +
  geom_boxplot() +
  scale_x_log10() +
  xlab("log10 of Survival_Time_Months") +
  theme_void()


# boxplot over density
graphic_2 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))

# saving 
ggsave(
  filename = here::here("figures/graphic_2.png"),
  plot = graphic_2,
  height = 5,
  width = 5
)


# adding transformed target variable and changing columns to factor
cancer_data <- cancer_data |>
  mutate(
    Survival_Time_Months = log10(Survival_Time_Months),
    Smoking_History = factor(Smoking_History),
    Obesity = factor(Obesity),
    Diabetes = factor(Diabetes),
    Chronic_Pancreatitis = factor(Chronic_Pancreatitis),
    Family_History = factor(Family_History),
    Hereditary_Condition = factor(Hereditary_Condition),
    Jaundice = factor(Jaundice),
    Abdominal_Discomfort = factor(Abdominal_Discomfort),
    Back_Pain = factor(Back_Pain),
    Weight_Loss = factor(Weight_Loss),
    Development_of_Type2_Diabetes = factor(Development_of_Type2_Diabetes),
    Stage_at_Diagnosis = factor(Stage_at_Diagnosis),
    Treatment_Type = factor(Treatment_Type),
    Survival_Status = factor(Survival_Status),
    Alcohol_Consumption = factor(Alcohol_Consumption),
    Physical_Activity_Level = factor(Physical_Activity_Level),
    Diet_Processed_Food = factor(Diet_Processed_Food),
    Access_to_Healthcare = factor(Access_to_Healthcare),
    Urban_vs_Rural = factor(Urban_vs_Rural),
    Economic_Status = factor(Economic_Status)
  )

write_csv(cancer_data, "data/cancer_data.csv")
