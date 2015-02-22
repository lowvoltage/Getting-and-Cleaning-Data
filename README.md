Getting and Cleaning Data - Course Project
=========================

This is the course project submission for Coursera's "Getting and Cleaning Data" course

Introduction
-----------

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Script Desciption
-----------------
Submitted is a R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Script Requirements
-------------------
* This script relies on 'dplyr' and 'reshape2' libraries being available.
* It expects the dataset .ZIP file to be available in the R working directory, otherwise downloads it

Script Use
----------
All required operations are executed automatically when the script is source()'ed. Subsequent runs can also be done by calling the run.analysis() function.
The script produces a 'tidy.txt' file in the working directory and also returns the tidy data set, as described at step 5). This data set is in "tall" format, i.e. an "Average" value is computed for each "Subject", "Activity" and "Measurement". There are 30 subjects, 6 activities and 66 measurements, making a total of 11880 rows in the data set.


Naming Convention
-----------------
"CamelCase" naming is used for all variables and measurement names, to facilitate readability. As most of the variable names have 5-6 components, some name-components are shortened, to keep the whole name length within reasonable limits. This is the reason for "Frequency" to appear as "Freq".