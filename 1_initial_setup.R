# Final Project Memo 1  ----
# Examining Data

## loading in packages ----
library(tidyverse)
library(patchwork)
library(car)
library(lubridate)
library(here)


# load in data ----
movies <- read_csv("data/imdb_movies.csv")

# missingness check ----
movies |>
  skimr::skim_without_charts() |>
  knitr::kable()

## EDA ----

# calculate values
missing_rows <- sum(!complete.cases(movies))
num_rows <- nrow(movies)
num_cols <- ncol(movies)
target_missing <- sum(!complete.cases(movies$revenue))

# create a table
summary <- data.frame(
  Metric = c("Rows with Missing Values", "Number of Observations", "Number of Variables", "Number of Missing Target Variable Observations (`revenue`)"),
  Value = c(missing_rows, num_rows, num_cols, target_missing)
)

# display as a table
summary_table <- knitr::kable(summary, caption = "Dataset Summary")

summary_table


# count variable types
variable_types <- sapply(movies, class)

# summarize counts
num_numerical <- sum(variable_types %in% c("integer", "numeric"))
num_categorical <- sum(variable_types %in% c("factor", "character"))

# print results
cat("Numerical Variables:", num_numerical, "\n")
cat("Categorical Variables:", num_categorical, "\n")




## Target Variable Analysis ----

# checking for 0 values in target column 
movies |>
  select(revenue) |>
  filter(revenue == 0)

# on regular scale ----
p1 <- ggplot(movies, aes(revenue)) +
  geom_density() +
  geom_rug(alpha = 0.1) +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank())


# boxplot
p2 <- ggplot(movies, aes(revenue)) +
  geom_boxplot() +
  theme_void()


# boxplot over density
target_eda <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))

# saving
ggsave(
  filename = here("figures/target_eda.png"),
  plot = target_eda,
  height = 5,
  width = 5
)


## with yeo-johnson transformation ----

# density plot
p1 <- ggplot(movies, aes(x = yjPower(revenue, lambda = 0.25))) +
  geom_density(alpha = 0.5) +
  labs(
    xlab = "Yeo-Johnson Transformed Revenue"
    ) +
  theme_minimal()

# boxplot
p2 <- ggplot(movies, aes(yjPower(revenue, lambda = 0.25))) +
  geom_boxplot() +
  xlab("Yeo-Johnson Transformed Revenue") +
  theme_void()


# boxplot over density
target_eda_2 <- p2 / p1 +
  plot_layout(heights = unit(c("1", "5"), units = "cm"))

# saving 
ggsave(
  filename = here("figures/target_eda_2.png"),
  plot = target_eda_2,
  height = 5,
  width = 5
)


# adding transformed target variable and changing date_x column from character to date ----
movies <- movies |>
  mutate(yeo_revenue = yjPower(revenue, lambda = 0.25), # transforming target variable
         date = mdy(date_x), # making it a date column
         genre_list = str_split(genre, ",") # making genre column a list
         ) |>
  select(-date_x) 

str(movies)
# Check the result
write_csv(movies, "data/movies_clean.csv")
  