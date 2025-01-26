library(tidyverse)
movies <- read_csv("data/final_dataset.csv")

sum(is.na(movies$grossWorldWide))

