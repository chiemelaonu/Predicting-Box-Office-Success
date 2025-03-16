## Datasets

The IMDB movie dataset was sourced from [Kaggle.com](https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset/data).

- `imdb_movies.csv`: the original dataset
- `movies_clean.csv`: the dataset with modifications (transformed target variable, transformed date variable). This is the data we performed the split on.
- `movies_split.rda`: the initial split proportions of the data
- `movies_train.rda`: the training data used for modeling
- `movies_test.rda`: the testing data used for predicting
- `movies_folds.rda`: the V-folded data
- `my_metrics.rda`: our defined metric set used to calculate RMSE
- `keep_wflow.rda`: object that holds the argument for saving the workflow after the model is fitted to resamples

Below is the codebook for `movies_clean.csv`:

| variable      | Description                                            |
|---------------|--------------------------------------------------------|
|`names`           |The names of the movies                           |
|`score`| The score given to each movie on IMDB (score is out of 100)|
|`genre`| The genre of the movie|
|`overview`| A synopsis of the movie|
|`crew`| The names of the crew who worked on the movie|
|`orig_title`| The original title of the movies (more applicable to movies that are not in English and were translated)|
|`status`| The status of the movie (released or unreleased)|
|`orig_lang`| The original language the movie is in|
|`budget_x`| The budget of the movie (in dollars)|
|`revenue`| The revenue of the movie (in dollars)|
|`yeo_revenue`| The Yeo-Johnson transformed revenue|
|`date`| The release date for the movie|
