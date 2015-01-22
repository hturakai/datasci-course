# run_analysis.R: Coursera data cleaning course assignment
#
# TASK:
# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 6. From the second data set, create a 'text' file. 

setwd("D:\\projects\\datasci-course\\course3-project\\")
library("dplyr")
require(plyr)

# Read GENERIC data for both data sets
#
# Read the features.txt. This will be used as the original column names for the data frame. 
# New column names will be used later according to the codebook.
filePath <- "UCI HAR Dataset/features.txt"
features <- read.table(filePath, header = FALSE, sep = " ", stringsAsFactors = FALSE)

# Read the new measurement labels from the codebook features-new.csv. 
# This file only includes the labels for the mean and std measurements (66 columns).
filePath <- "UCI HAR Dataset/features-new.csv"
features_new <- read.csv(filePath, header = TRUE, stringsAsFactors = FALSE)

# Read the activity_labels.txt. These will be used as descriptive activity names for the measurements. 
filePath <- "UCI HAR Dataset/activity_labels.txt"
activities <- read.table(filePath, header = FALSE, sep = " ", col.names = c("activity_id","activity"), stringsAsFactors = FALSE)


# Read the TEST data:
#
# Read the test subject information from "subject_test.txt"
filePath <- "UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.delim(filePath, header = FALSE, sep = " ")

# Read the test activity information from "y_test.txt"
filePath <- "UCI HAR Dataset/test/y_test.txt"
test_y <- read.delim(filePath, header = FALSE, sep = " ", col.names = c("activity_id"))

# Read the "X_test.txt" file to a data frame. 
# Include only the mean and std measurement columns.
# Set the column names from the codebook (new_features). 
filePath <- "UCI HAR Dataset/test/X_test.txt"
test_x <- read.table(filePath, header = FALSE, sep="", quote="\"", dec=".", col.names = as.vector(features$V2))
#%>% select(contains("mean()"), contains("std()"))
test_x <- test_x[, as.vector(features_new$measurement.index)]
colnames(test_x) <- as.vector(features_new$new.name)

# Add the subject as a column to the data frame
test_x$subject <- as.numeric(subject_test$V1) 

# Add the activity as a column to the data frame
test_x$activity_id <- as.numeric(test_y$activity_id) 

# Read the TRAIN data:
#
# Read the test subject information from "subject_test.txt"
filePath <- "UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.delim(filePath, header = FALSE, sep = " ")

# Read the test activity information from "y_test.txt"
filePath <- "UCI HAR Dataset/train/y_train.txt"
train_y <- read.delim(filePath, header = FALSE, sep = " ", col.names = c("activity_id"))

# Read the "X_train.txt" file to a data frame. 
# Set the column names from the codebook (new_features). 
# Include only the first six columns.
filePath <- "UCI HAR Dataset/train/X_train.txt"
train_x <- read.table(filePath, header = FALSE, sep="", quote="\"", dec=".", col.names = as.vector(features$V2))
#%>% select(contains("mean()"), contains("std()"))
train_x <- train_x[, as.vector(features_new$measurement.index)]
colnames(train_x) <- as.vector(features_new$new.name)

# Add the subject as a column to the data frame
train_x$subject <- as.numeric(subject_train$V1) 

# Add the activity as a column to the data frame
train_x$activity_id <- as.numeric(train_y$activity_id) 


# Merge the test and train data frames
m <- merge(test_x, train_x, all = TRUE)

# Remove obsolete objects
rm(test_x)
rm(test_y)
rm(train_x)
rm(train_y)
rm(features)
rm(subject_test)
rm(subject_train)

# Merge the data frame and activity labels to get descriptive activity names
# and then remove the unnecessary activity_id column.
m <- merge(m, activities, by = "activity_id") %>% select(-activity_id)

# Summarize the number columns in the dataframe with the mean values.
m <- ddply(m, .(subject,activity), numcolwise(mean))

# Write the tidy dataset the CSV output file
write.csv(m,file="tidy.csv",row.names=FALSE)
