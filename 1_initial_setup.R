# Final Project Memo 1  ----
# Examining Data, Initial Data Splitting

## loading in packages ----
library(tidyverse)
library(tidymodels)
library(patchwork)
library(DT)
# resolve conflicts
tidymodels_prefer()

# load in data ----
movies <- read_csv("data/final_dataset.csv")


## EDA ----

# Calculate values
missing_rows <- sum(!complete.cases(movies))
num_rows <- nrow(movies)
num_cols <- ncol(movies)

# Create a table
summary <- data.frame(
  Metric = c("Rows with Missing Values", "Number of Observations", "Number of Variables"),
  Value = c(missing_rows, num_rows, num_cols)
)

# Display as a table
summary_table <- knitr::kable(summary, caption = "Dataset Summary")



#Calculate the number of missing values per column
missing_values <- colSums(is.na(movies))

# Filter columns with missing values (those with more than 0 missing values)
missing_summary <- data.frame(
  Column = names(missing_values),
  Missing_Values = missing_values
)

# Filter rows where there are missing values
missing_summary <- missing_summary[missing_summary$Missing_Values > 0, ]

# Display the table with knitr
knitr::kable(missing_summary, caption = "Columns with Missing Values")



## Target Variable Analysis ----

# on original scale ----

# density plot
p1 <- ggplot(movies, aes(grossWorldWide)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(movies, aes(grossWorldWide)) +
  geom_boxplot() +
  theme_void()


# boxplot over density
graphic_1 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))


ggsave(
  filename = here::here("figures/graphic_1.png"),
  plot = graphic_1,
  height = 5,
  width = 5
  )



## on log10 scale ----

p1 <- ggplot(movies, aes(grossWorldWide)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  scale_x_log10() +
  xlab("log10 of grossWorldWide") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(movies, aes(grossWorldWide)) +
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


# finding how many NAs in target variable
sum(is.na(movies$grossWorldWide))


# adding transformed variable ----
movies <- movies |>
  mutate(
    grossWW_log10 = log10(grossWorldWide)
  )
