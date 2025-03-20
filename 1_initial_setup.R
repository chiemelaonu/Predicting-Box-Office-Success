# Final Project Memo 1  ----
# Examining Data

## loading in packages ----
library(tidyverse)
library(patchwork)
library(car)
library(lubridate)
library(here)
library(splines)
library(tidytext)
library(textdata)
library(outliers)



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
  labs(
    x = "Original Revenue",
    caption = "Data from Kaggle.com"
  ) +
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
  geom_rug(alpha = 0.1) +
  labs(
    x = "Yeo-Johnson Transformed Revenue",
    caption = "Data from Kaggle.com"
    ) +
  theme_minimal()

# boxplot
p2 <- ggplot(movies, aes(yjPower(revenue, lambda = 0.25))) +
  geom_boxplot() +
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


# parsing the overview column to find the number of negative and positive words in the description of the movie
# and adding a column with the overall sentiment
bing_sentiments <- get_sentiments("bing")

movies_sentiments <- movies |>
  unnest_tokens(word, overview) |>
  inner_join(bing_sentiments, by = "word") |>
  count(names, sentiment) |>
  spread(key = sentiment, value = n, fill = 0) |>
  mutate(
    overall_sentiment = case_when(
      positive > negative ~ "Positive",
      negative > positive ~ "Negative",
      TRUE ~ "Neutral"
    )
  )

# merge the sentiment analysis result back into the original movies dataset
movies <- movies |>
  left_join(movies_sentiments, by = "names")

library(purrr)

# function to count the number of crew members
count_crew <- function(crew) {
  sapply(str_split(crew, ", "), function(x) length(x[seq(1, length(x), by = 2)]))
}

# apply function and create new column
movies <- movies |>
  mutate(num_crew = count_crew(crew)) |> glimpse()

# adding transformed target variable and changing date_x column from character to date ----
movies_clean <- movies |>
  mutate(date = mdy(date_x), .keep = "unused") |>
  mutate(
    num_genres = str_count(genre, ",") + 1, # adding a column that counts the number of genres for each movie
    overall_sentiment = factor(overall_sentiment),
    status = factor(status)
    ) |>
  mutate(
    yeo_revenue = yjPower(revenue, lambda = 0.25),
    .keep = "all"
  )
glimpse(movies_clean)


write_csv(movies_clean, "data/movies_clean.csv")
