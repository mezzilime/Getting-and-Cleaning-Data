CodeBook.md
=================

This CodeBook outlines data and variable transformations used in run_analysis.R

### Raw data files
The raw data files are measurement data from Samsung sensor movements. Over 500 variables are included in the original set.

The following files are read by the script:
   1. activity_labels.txt
   2. features.txt
   3. X_test.txt
   4. y_test.txt
   5. subject_test.txt
   6. X_train.txt
   7. y_train.txt
   8. subject_train.txt

Data in folders "Inertial Signal" is not read.

### Renaming and cleaning
For activity label, the numerical data is replaced with the activity label in the following manner:

    "1" becomes "WALKING",
    "2" becomes "WALKING_UPSTAIRS",
    "3" becomes "WALKING_DOWNSTAIRS",
    "4" becomes "SITTING",
    "5" becomes "STANDING", and
    "6" becomes "LAYING".

Numbers and leading zereos are removed. Punctuation is removed. This is done to eliminate potential reading errors for further calculations.

Abbreviations are expanded:

    "t" becomes "Time",
    "f" becomes "Fourier",
    "Acc" becomes "Acceleration",
    "Mag" becomes "Magnitude",
    "mean" becomes "Mean", and
    "std" becomes "Std".

For example, the original variable "1 tBodyAcc-mean()-X" will be modified to "TimeBodyAccelerationMeanX".
 
### Final tidy dataset
The final dataset is a narrow tidy dataset. See the Tidy Data document for reference:
http://vita.had.co.nz/papers/tidy-data.pdf

Four final columns are created for the final text file with the following labels:

    1. "subject" -- the user subject number.
    2. "activity" -- the activity engaged in (walking, sitting, etc).
    3. "variable" -- the sensor measurement variable.
    4. "mean" -- the mean of the variable.

The final tidy.txt file will have 14220 observations in narrow format.

The first few lines of the tidy.txt file should look like this:

    "subject" "activity" "variable" "mean"
    "1" "LAYING" "TimeBodyAccelerationMeanX" 0.22159824394
    "1" "LAYING" "TimeBodyAccelerationMeanY" -0.0405139534294
    "1" "LAYING" "TimeBodyAccelerationMeanZ" -0.11320355358
    "1" "LAYING" "TimeGravityAccelerationMeanX" -0.24888179828


