## This script will take the dataset from the accelerometers from Galaxy smartphones and merged all files to create a 
## single dataset. Further, it will tidy the dataset by creating descriptive variables. Lastly, it will create
## a new tidy datset that only contains the means for each activity and subject.  It will also write new 
## dataset to a new text file.

## Read in all text files for test and train
test_X <- read.table("X_test.txt")
test_Y <- read.table("Y_test.txt")
train_X <- read.table("X_train.txt")
train_Y <- read.table("Y_train.txt")
test_sub <- read.table("subject_test.txt")
train_sub <- read.table("subject_train.txt")

## Read in files for activities and labels
activities <- read.table("activity_labels.txt")
variables <- read.table("features.txt")

## Set column names to be the labels in "features"
colnames(test_X) <- variables[,2]
colnames(train_X) <- varibales[, 2]

## Rename the columns to identify activity
colnames(train_Y) <- "activity_id"
colnames(test_Y) <- "activity_id"

## Rename the columns to identify subjects
colnames(test_sub) <- "subject_id"
colnames(train_sub) <- "subject_id"

## Rename the columns in activities to be the activity id and label
colnames(activities) <- c("activity_id", "activity_label")

## Merge all test files 
merged_test <- cbind(test_X, test_Y, test_sub)

## Merge all train files
merged_train <- cbind(train_X, train_Y, train_sub)

## Merge all train and test files together
all_merged <- rbind(merged_test, merged_train)  

## Make vector of all column names
columns <- colnames(all_merged)

## Select only mean and standard deviation measurements
mean_sd <- (grepl("activity_id", columns))| grepl("subject_id", columns)|grepl("mean..", columns)|grepl("std..", columns)
mean_sd_subset <- all_merged [, mean_sd == TRUE]

##Add descriptive labeling to activity id
des_activity <- merge(mean_sd_subset, activities, by="activity_id")

## Cleaning up variable names
columns_sub <- colnames(mean_sd_subset)
for (i in 1:length(columns_sub)) 
{
  columns_sub[i] = gsub("\\()", "",columns_sub[i])
  columns_sub[i] = gsub("()","",columns_sub[i])
  columns_sub[i] = gsub("-std","standard_dev",columns_sub[i])
  columns_sub[i] = gsub("-mean","Mean",columns_sub[i])
  columns_sub[i] = gsub("^(t)","time",columns_sub[i])
  columns_sub[i] = gsub("^(f)","freq",columns_sub[i])
  columns_sub[i] = gsub("Mag","Magnitude",columns_sub[i])
  columns_sub[i] = gsub("Acc", "Accelerometer", columns_sub[i])
  columns_sub[i] = gsub("Gyro", "Gyroscope", columns_sub[i])
  columns_sub[i] = gsub("BodyBody","Body", columns_sub[i])
}

##Re-set variable names to new clean variables
colnames(mean_sd_subset) = columns_sub

## Create new tidy dataset with the average of each variable for each activity and each subject
new_tidy_mean <- aggregate(. ~subject_id + activity_id, mean_sd_subset, mean)

## Write new tidy text file
write.table(new_tidy_mean, "new_tidy_mean.txt", row.name=FALSE)