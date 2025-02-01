## Datasets

The Pancreatic Cancer data was sourced from [Kaggle.com](https://www.kaggle.com/datasets/ankushpanday1/pancreatic-cancer-prediction-dataset/data).

- `final_dataset.csv`: the original dataset
- `cancer_data_split.rda`: the initial split proportions of the data
- `cd_training.rda`: the training data used for modeling
- `cd_testing.rda`: the testing data used for predicting

Quick reference for `cancer_data_codebook.csv`:

| variable      | Description                                            |
|---------------|--------------------------------------------------------|
|`Country`           |Where the patient is from                           |
|`Age`| Age of the patient|
|`Gender`| Gender of the patient|
|`Smoking_History`| Smoking history where 0 means they do not smoke and 1 means they do smoke|
|`Obesity`| Whether the patient is obese or not (0 = not obese, 1 = obese)|
|`Diabetes`| Whether the patient has been diagnosed with diabetes or not (0 = not diagnosed, 1 = diagnosed)|
|`Chronic_Pancreatitis`| Whether the patient has been diagnosed with chronic pancreatitis or not (0 = not diagnosed, 1 = diagnosed)|
|`Family_History`| Whether the patient has a family history of pancreatic cancer or not (0 = no history, 1 = history)|
|`Heriditary_Condition`| Whether the cancer is hereditary or not (0 = not hereditary, 1 = hereditary)|
|`Jaundice`| Whether the patient has experienced jaundice or not (0 = no jaundice, 1 = jaundice)|
|`Abdominal_Discomfort`| Whether the patient has abdominal discomfort (0 = no, 1 = yes)|
|`Back_Pain`| Whether the patient has back pain or not (0 = no back pain, 1 = back pain)|
|`Weight_Loss`| Whether the patient has experience weight loss (0 = no, 1 = yes)|
|`Development_of_Type_2_Diabetes`| Whether the patient has developed Type 2 Diabetes (0 = no, 1 = yes)|
|`Stage_at_Diagnosis`|The stage of Pancreatic Cancer at diagnosis, ranging from I to IV|
|`Survival_Time_Months`| The survival time of the patient in months|
|`Treatment_Type`| The Treatment the patient received, being either Surgery, Chemotherapy, or Radiation|
|`Survival_Status`|Whether the patient survived or not (0 = did not survive, 1 = survived|
|`Alcohol_Consumption`| Whether the patient consumes alcohol or not (0 = does not consume, 1 = consumes)|
|`Physical_Activity_Level`|The patient's physical activity levels, ranging from Low to High|
|`Diet_Processed_Food`| The frequency of the patient's processed food consumption, ranging from Low to High|
|`Access_to_Healthcare`| Whether the patient has access to healthcare or not (0 = no access, 1 = access)|
|`Urban_vs_Rural`| Whether the patient is from an Urban or Rural area|
|`Economic_Status`| The patient's economic status, ranging from Low to High|
|`survival_time_log10`| The log 10 transformed survival time of the patient in months |


