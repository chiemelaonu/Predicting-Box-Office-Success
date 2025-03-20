## Datasets

The IMDB movie dataset was sourced from [Kaggle.com](https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset/data).

- `imdb_movies.csv`: the original dataset
- `keep_wflow.rda`: object that holds the argument for saving the workflow after the model is fitted to resamples
- `movies_clean_codebook.csv`: codebook for the cleaned/mutated data set
- `movies_clean.csv`: the dataset with modifications (transformed target variable, transformed date variable). This is the data we performed the split on.
- `movies_folds.rda`: the V-folded data
- `movies_split.rda`: the initial split proportions of the data
- `movies_test.rda`: the testing data used for predicting
- `movies_train.rda`: the training data used for modeling
- `my_metrics.rda`: our defined metric set used to calculate RMSE
