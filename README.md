## Basic repo setup for final project
This is a repo for my final project including the final report, executive summary, and supporting code.  
This project utilizes `tidymodels` to build a predictive model on the survival length (in months) of those with pancreatic cancer. The target variable used for this model is `survival_time_log10` 

## R-scripts
- `1_inital_setup.R`: R script that holds the initial loading in of data, a quick EDA, target variable analysis, and the log transformation of the target variable.
- `1_inital_split.R`: holds the initial splitting of the log transformed data (`survival_time_log10`).

## Subfolders
- [`data`](data): holds the initial read-in data for this repo, as well as the initial split, training, and testing sets
- [`figures`](figures): holds the saved plots included in the final HTML
- [`r_scripts`](r_scripts): holds the R scripts for the repo
- [`results`](results): holds the fitted training models
- [`memos`](memos): holds the progress memos 1 and 2