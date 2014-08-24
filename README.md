README.md
=========================


##run_analysis.R
Repository for Getting and Cleaning Data. See CodeBook for variable details.

### Data source
The raw data and source files are from:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

Source zip of raw data is downloaded to the working directory from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the raw data is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Objective
The objective of run_analysis.R is to pull data for the UCI dataset, merge test and trial datasets, modify variable names, and create a tidy dataset.

### Dependencies
The script will load libraries required including data.table, dplyr, and reshape2. The working directory must include the unzipped UCI dataset.

### Read data files
Reads raw data files into data tables. Data in folders "Inertial Signal" is not read.

### Merge
The data is merged into tables of test sets and training sets. Each set will consist of subject, activity, and measurement columns. The test set and training set are then merged into one dataset called "data" with cbind and rbind.

### Label activities
The script uses descriptive activity names to replace activity variables 1-6. See the CodeBook for further detail.

### Extract mean and standard deviation columns
The raw datasets have 561 columns of measurement data. However, we are only interested in the columns with mean and standard deviation measurements. Columns with "mean" and "std" are selected out with dplyr select. Columns with "angle" are dropped. For example, "561 angle(Z,gravityMean)" in features.txt contains "mean" but is an angle measurement.

### Label dataset with descriptive variable names
The script then modifies variable names using gsub. CamelCase is retained for ease of reading. See CodeBook for detailed labelling.
 
### Create tidy dataset with measurement means
Lastly, run_analysis.R melts the data into columns of "subject" and "activity" in a tidy dataset in narrow format. The dataset is then aggregated to derive a mean for each measurement variable by subject and activity. The final, tidy dataset will therefore have a variable column "mean" resulting from the ddply summarise command.
