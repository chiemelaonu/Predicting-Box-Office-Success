## Overview
This is a folder for the R scripts used in my final project 

## R-scripts
- `1_inital_setup.R`: R script that holds the initial loading in of data, a quick EDA, target variable analysis, the Yeo-Johnson transformation of the target variable, and re-writing out the dataset.
- `1_initial_split.R`: R script that holds the initial splitting of the data
- `2_recipes_lm.R`: R script that holds the building of the linear recipes used to fit the OLS and tune the EN workflows
- `2_recipes_null_base.R`: R script that holds the building of the Null/Baseline models
- `2_recipes_tree.R`: R script that holds the building of the tree-based recipes used to tune KNN, Random Forest, and Boosted Trees
- `3_fit_baseline.R`: R script for fitting the baseline model
- `3_fit_lm.R`: R script for fitting the OLS model
- `3_tune_bt.R`: R script for tuning the Boosted Trees model
- `3_tune_en.R`: R script for tuning and fitting the Lasso and Ridge models
- `3_tune_knn.R`: R script for tuning the K-Nearest Neighbors model
- `3_tune_rf.R`: R script for tuning the Random Forest model
- `4_model_analysis.R`: R script for analyzing the results of the fitted/tuned workflows and picking the best performing model
- `5_train_final_model.R`: R script for training the best performing model
- `6_assess_final_model.R`: R script for finding the predicting the final values and exploring the results



