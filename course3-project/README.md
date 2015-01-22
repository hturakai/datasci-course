Getting and Cleaning Data: Course Project
=========================================

This project consists of the R script [run_analysis.R](run_analysis.R) which can be used to read and process the input data files. The script produces a tidy dataset showing summary data (mean values) for the collected accelometer data from Samsung Galaxy S smartphones. The output data is stored to a CSV file: tidy.csv to the same directory where the script is located.

The code book file [CodeBook.md](CodeBook.md) documents the data collection and cleanup process.

# Input files

The input files are stored in the 'UCI HAR Dataset' directory in two different subdirectories: 'train' and 'test'. 

## General files

* features.txt: Contains the original names for the measurements (561)
* features-new.csv: The selected subset of the original 'features.txt' containing only the needed measurement name rows (66 of 561). Also includes a more human readable name for the measurement.
* ativity_labels.txt: Contains the activity indexes and labels.

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

## Test data files (2947 rows)

* test/subject_test.txt: Subjects for the test measurements
* test/y_test.txt: Activities for the test measurements
* test/X_test.txt: Measurement data for the test set

## Train data files (7352 rows)

* train/subject_train.txt: Subjects for the test measurements
* train/y_train.txt: Activities for the test measurements
* train/X_train.txt: Measurement data for the test set
