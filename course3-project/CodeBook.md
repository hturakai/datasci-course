Getting and Cleaning Data: Course Project: Codebook
===================================================

This Code Book describes data collection and cleanup process executed with the script run_analysis.R.  

## Process the input files

"features.txt": This will be used as the original column names when creating a data frames for the measurement data (for test and train sets). 

"features-new.csv": This file has been created manually and it contains a selected subset of the original 'features.txt' containing only the needed measurement name rows (66 of 561). Also includes a more human readable name for the measurement.

"activity_labels.txt": This file contains more descriptive activity names for the measurements. 

Subject identifiers for both datasets are read from files: "test/subject_test.txt" and "train/subject_train.txt".

Activity identifier information for both datasets are read from files: "test/y_test.txt" and "train/y_train.txt".

Two separate data frames are created, one for each data set (train and test), using data from features.txt as column names.

## Processing of the data frames

Both test and train data frames are processed identically: 
* The identity of the measurement is added as column to the data frame. 
* Column names are changed to a more human readable name as specified in the new_features.txt. 
* Activity identifier is added as a column to the data frame. 
* Subject identifier is added as a column to the data frame. 

The test and train data frames are merged together producing a data frame with 10299 observations and 68 variables.

Unnecessary variables are removed from the environment.

The data frame is summarized by calculating mean values for all the numeric (measurement) columns. This operation produces a data frame with 180 observations and 68 variables.

## Producing the output file

The data frame is output to a CSV file: tidy.csv.

## Activity list

The measured activities are defined in the file "activity_labels.txt". The original data uses the identifier numbers, but the tidy dataset uses the more human readable textual values.

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

## Selected measurement data subset

The script will process only a subset (66 of 561) of the original measurement data values. The selected measurement identifiers, original measurement identifier, and the new more human readable measurement name is specified in the input file: "features-new.csv". The subset includes only the mean and standard deviation measurement values.
