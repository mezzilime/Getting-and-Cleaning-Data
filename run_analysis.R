# run.analysis.R processes data from the UCI sensor measurement dataset
# See README.md for data source and CodeBook.md for variable descriptions

# Load required packages
library(data.table)
library(dplyr)
library(reshape2)

# Read label and features data from UCI dataset
activity_labels <- read.table(file("./UCI HAR Dataset/activity_labels.txt"), sep = "")
features <- data.table(readLines(file("./UCI HAR Dataset/features.txt")))

# Read test data
X_test <- read.table(file("./UCI HAR Dataset/test/X_test.txt"), sep = "")
y_test <- data.table(readLines(file("./UCI HAR Dataset/test/y_test.txt")))
subject_test <- data.table(readLines(file("./UCI HAR Dataset/test/subject_test.txt")))

# Read training data
X_train <- read.table(file("./UCI HAR Dataset/train/X_train.txt"), sep = "")
y_train <- data.table(readLines(file("./UCI HAR Dataset/train/y_train.txt")))
subject_train <- data.table(readLines(file("./UCI HAR Dataset/train/subject_train.txt")))

# Merge test and training sets
test <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)
data <- rbind(train, test)

# Name activities in the dataset with descriptive variable names
setnames(data, 1:2, c("subject", "activity"))
setnames(data, 3:ncol(data), t(features))
data$activity <- mapvalues(data$activity, from = c(1:6), to = c(t(activity_labels[2])))

# Extract mean and standard deviation columns while dropping angle columns
data <- dplyr::select(data, c(1, 2), contains("mean"), contains("std"), -contains("angle"))

# Label dataset with descriptive variable names
setnames(data, (gsub("[[:digit:]]", "", names(data))))
setnames(data, (gsub("\\s", "", names(data))))
setnames(data, (gsub("[[:punct:]]", "", names(data))))
setnames(data, (gsub("^t", "Time", names(data))))
setnames(data, (gsub("^f", "Fourier", names(data))))
setnames(data, (gsub("Acc", "Acceleration", names(data))))
setnames(data, (gsub("Mag", "Magnitude", names(data))))
setnames(data, (gsub("mean", "Mean", names(data))))
setnames(data, (gsub("std", "Std", names(data))))

# Create tidy dataset with average of each variable for each activity and each subject
melted <- melt(data, id.vars=c("subject", "activity"))
tidy <- ddply(melted, c("subject", "activity", "variable"), summarise, mean = mean(value))
write.table(tidy, file="tidy.txt", row.name=FALSE)

