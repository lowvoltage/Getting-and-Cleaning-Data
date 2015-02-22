## This script relies on 'dplyr' and 'reshape2' libraries being available

library(dplyr)
library(reshape2)

## String constants for the URL and local filename of the dataset .ZIP file

datasetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datasetFilename <- "getdata_projectfiles_UCI HAR Dataset.zip"

## This script automatically runs the analysis on source()

run.analysis()


## Loads, merges, annotates and filters the original data. 
## Returns a tidy data set (as of pt. 5), in "tall" format
## i.e. an Average is computed for each Subject, Activity and Measurement

run.analysis <- function() {
    # Preparatory step
    download.dataset()
    
    # Step 1: Merges the training and the test sets to create one data set
    #
    # Within each of the test & train sets, columns are joined with cbind()
    # The two sets themselves are joined with rbind()
    fullSet <- rbind(load.dataset("train"), load.dataset("test"))
    
    # Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
    # 
    # Column filtering (selection) is based on a regular expression
    renameScheme <- build.rename.scheme()
    subSet <- fullSet[, renameScheme$Index]
    
    # Step 4: Appropriately labels the data set with descriptive variable names.
    names(subSet) <- renameScheme$Name
    
    # Step 3: Uses descriptive activity names to name the activities in the data set
    activityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
    subSet$Activity <- factor(subSet$Activity, levels = 1:6, labels = activityNames)
    
    # Step 5: From the data set in step 4, creates a second, independent tidy data set 
    # with the average of each variable for each activity and each subject.
    melted <- melt(subSet, id.vars=c("Subject", "Activity"), variable.name="Measurement")
    tidy <- melted %>% group_by(Subject, Activity, Measurement) %>% summarize(Average = mean(value))
    
    write.table(tidy, "tidy.txt", row.names = FALSE)
    
    tidy
}


## Utility function to download the dataset into the working directory
## As it is fairly large, if the local file already exists, it is not re-downloaded

download.dataset <- function() {
    if (!file.exists(datasetFilename)) {
        message("Downloading dataset")
        download.file(url = datasetURL, destfile = datasetFilename, method = "auto", mode = "wb")
    }
}


## Loads all relevant raw data from a sub-folder inside the ZIP file.
## Produces a data frame, containing the numeric data, as well as the "Subject" and "Activity" columns
## The resulting DF has 563 columns with auto-generated names

load.dataset <- function(subfolder) {
    # Define relative paths inside the ZIP file
    pathToX <- paste("UCI HAR Dataset/", subfolder, "/X_", subfolder, ".txt", sep = "")
    pathToSubject <- paste("UCI HAR Dataset/", subfolder, "/subject_", subfolder, ".txt", sep = "")
    pathToActivity <- paste("UCI HAR Dataset/", subfolder, "/y_", subfolder, ".txt", sep = "")
    
    # Load raw data, adjust Subject & Activity column names
    datasetX <- read.table(unz(datasetFilename, pathToX))
    datasetSubject <- read.table(unz(datasetFilename, pathToSubject))    
    datasetActivity <- read.table(unz(datasetFilename, pathToActivity))    
    
    # Bind into a single data frame
    cbind(datasetX, datasetSubject, datasetActivity)
}

## Builds a composite column subsetting & renaming scheme
## Returns a data frame with two columns: "Index" and "Name" for all columns we're interested in
## "Index" is the column index in the original columns' vector
## "Name" is the nice, descriptive column name

build.rename.scheme <- function() {
    regexp <- "\\-(std|mean)\\(\\)|Subject|Activity"
    
    columnNamesTable <- read.table(unz(datasetFilename, "UCI HAR Dataset/features.txt"))
    columnNames <- c(as.vector(columnNamesTable[[2]]), "Subject", "Activity")
    indexes <- grep(regexp, columnNames)
    
    niceNames <- gsub("^t", "Time", columnNames[indexes])
    niceNames <- gsub("^f", "Freq", niceNames)
    niceNames <- gsub("\\-", "", niceNames)
    niceNames <- gsub("std\\(\\)", "Std", niceNames)
    niceNames <- gsub("mean\\(\\)", "Mean", niceNames)
    niceNames <- gsub("BodyBody", "Body", niceNames)
    
    data.frame(Index = indexes, Name = niceNames)
}
