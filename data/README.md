## Datasets

The Pancreatic Cancer data was sourced from [Kaggle.com](https://www.kaggle.com/datasets/ankushpanday1/pancreatic-cancer-prediction-dataset/data).

- `final_dataset.csv`: the original dataset
- `cancer_data_split.rda`: the initial split proportions of the data
- `cd_training.rda`: the training data used for modeling
- `cd_testing.rda`: the testing data used for predicting

Quick reference for `cancer_data_codebook.csv`:

| variable      | Description                                            |
|---------------|--------------------------------------------------------|
|`Country`           |Unique ID for each home sold                            |
|`Age`| Date of the home sale|
|`Gender`| Price of each home sold|
|`Smoking_History`| Number of bedrooms|
|`Obesity`| Number of bathrooms, where 0.5 accounts for a room with a toilet but no shower|
|`Diabetes`| Square footage of the apartments interior living space|
|`Chronic_Pancreatitis`| Square footage of the land space|
|`Family_History`| Number of floors|
|`Heriditary_Condition`| A dummy variable for whether the apartment was overlooking the waterfront or not|
|`Jaundice`| An index from 0 to 4 of how good the view of the property was|
|`Abdominal_Discomfort`| An index from 1 to 5 on the condition of the apartment|
|`Back_Pain`| An index from 1 to 13, where 1-3 falls short of building construction and design, 7 has an average level of construction and design, and 11-13 have a high quality level of construction and design.|
|`Weight_Loss`| The square footage of the interior housing space that is above ground level|
|`Development_of_Type_2_Diabetes`| The square footage of the interior housing space that is below ground level|
|`Stage_at_Diagnosis`| The year the house was initially built|
|`Survival_Time_Months`| The year of the house’s last renovation|
|`Treatment_Type`| What zipcode area the house is in|
|`Survival_Status`| Latitude|
|`Alcohol_Consumption`| Longitude|
|`Physical_Activity_Level`| The square footage of interior housing living space for the nearest 15 neighbors|
|`Diet_Processed_Food`| The square footage of the land lots of the nearest 15 neighbors|
|`Access_to_Healthcare`| The square footage of the land lots of the nearest 15 neighbors|
|`Urban_vs_Rural`| The square footage of the land lots of the nearest 15 neighbors|
|`Economic_Status`| The square footage of the land lots of the nearest 15 neighbors|
|`survival_time_log10`| The square footage of the land lots of the nearest 15 neighbors|


