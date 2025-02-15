## Datasets

The IMDB movie dataset was sourced from [Kaggle.com](https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset/data).

- `imdb_movies.csv`: the original dataset
- `movies_clean.csv`: the dataset with modifications (transformed target variable, transformed date variable). This is the data we performed the split on.
- `movies_split.rda`: the initial split proportions of the data
- `movies_train.rda`: the training data used for modeling
- `movies_test.rda`: the testing data used for predicting

Below is the codebook for `movies_clean.csv`:

| variable      | Description                                            |
|---------------|--------------------------------------------------------|
|`names`           |Where the patient is from                           |
|`score`| Gender of the patient|
|`genre`| Smoking history where 0 means they do not smoke and 1 means they do smoke|
|`overview`| Whether the patient is obese or not (0 = not obese, 1 = obese)|
|`crew`| Whether the patient has been diagnosed with diabetes or not (0 = not diagnosed, 1 = diagnosed)|
|`orig_title`| Whether the patient has been diagnosed with chronic pancreatitis or not (0 = not diagnosed, 1 = diagnosed)|
|`status`| Whether the patient has a family history of pancreatic cancer or not (0 = no history, 1 = history)|
|`orig_lang`| Whether the cancer is hereditary or not (0 = not hereditary, 1 = hereditary)|
|`budget_x`| Whether the patient has experienced jaundice or not (0 = no jaundice, 1 = jaundice)|
|`revenue`| Whether the patient has abdominal discomfort (0 = no, 1 = yes)|
|`country`| Whether the patient has back pain or not (0 = no back pain, 1 = back pain)|
|`yeo_revenue`| Whether the patient has experience weight loss (0 = no, 1 = yes)|
|`date`| Whether the patient has developed Type 2 Diabetes (0 = no, 1 = yes)|
