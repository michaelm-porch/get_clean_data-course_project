
setwd("./GetCleanData/get_clean_data-course_project")
library(dplyr)

if (!file.exists("./source_data/HARUS.zip")) { 
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  dFile <- "source_data/HARUS.zip"
  download.file(fileURL, destfile = dFile)
  unzip(zipfile = dFile, exdir = "./source_data/")
  
  downloadDate <- date()
}
data.dir <- "./source_data/UCI HAR Dataset/"

#readSetData formats filename and loads file into dataframe
#   * dataSet is the base name of the input data focus (train or test in this instance)
#   * context is the perspective of the speciufic data (x, y, subject, or "" in this instance)
#   * useSetSubdir is a boolean value that indicates whether the source data is located in a subdirectory - dataSet name as value
#   * extension is the name of the file's extension 
readSetData <- function(dataSet, context, useColClass, useSetSubdir=TRUE, extension=".txt") {
  dirSep = "/"
  subDir <- dirSep
  fileName <- paste(data.dir, context, dataSet, extension, sep="")
  if (useSetSubdir == TRUE) {
    subDir <- paste(dataSet, dirSep, sep="")
    fileName <- paste(data.dir, subDir, context, dataSet, extension, sep="")
  }
  
  dbgMsg <- sprintf("FileName: %s", fileName); print(dbgMsg)
  
  tabData <- read.table(fileName, colClasses = useColClass)
  tabData
}

CleanAndAggregateStudy <- function(calculateAverages = TRUE) {
    
  #read the observation data into dataframes
  train_x_data <- readSetData("train", "x_", "numeric", useSetSubdir=TRUE)
  train_y_data <- readSetData("train", "y_", "numeric", useSetSubdir=TRUE)
  train_subject_data <- readSetData("train", "subject_", "numeric", useSetSubdir=TRUE)
  test_x_data <- readSetData("test", "x_", "numeric", useSetSubdir=TRUE)
  test_y_data <- readSetData("test", "y_", "numeric", useSetSubdir=TRUE)
  test_subject_data <- readSetData("test", "subject_", "numeric", useSetSubdir=TRUE)
  features_data <- readSetData("features", "", "character", useSetSubdir = FALSE)
  activity_labels_data <- readSetData("activity_labels", "", "character", useSetSubdir = FALSE)
  
  #Generate descriptive labels for the test & training data (Cleanup abbreviations)
  observation_names <- make.names(gsub("BodyBody", "Body", features_data[, 2], fixed = TRUE), unique = TRUE, allow = TRUE)
  observation_names <- make.names(gsub(pattern="^t",replacement="time_", x=observation_names), unique = TRUE, allow = TRUE)
  observation_names <- make.names(gsub(pattern="^f",replacement="freq_", x=observation_names), unique = TRUE, allow = TRUE)
  colnames(train_x_data) <- observation_names
  colnames(test_x_data) <- observation_names
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  train_x_data <- select(train_x_data, contains(".mean."), contains(".std."))
  test_x_data <- select(test_x_data, contains(".mean."), contains(".std."))
  
  #Merge the test and train data sets
  #   first merge the subject and activity data for the two data contexts,
  train_merged <- bind_cols(train_subject_data, train_y_data)
  test_merged <- bind_cols(test_subject_data, test_y_data)
  
  #   next add meaningful column labels to those data
  colnames(train_merged) <- c("Subject", "Activity")
  colnames(test_merged) <- c("Subject", "Activity")
  
  #   then merge the mean and std data for train and test to the merged subject/activity
  train_fully_merged <- bind_cols(train_merged, train_x_data)
  test_fully_merged <- bind_cols(test_merged, test_x_data)
  fully_merged <- merge(train_fully_merged, test_fully_merged, all=TRUE)
  
  #translate activity values (numeric) to corresponding label from activity_labels.txt
  colnames(fully_merged)[2] <- "Activity"
  fully_merged[, 2] <- as.character(factor(fully_merged[, 2], labels = factor(activity_labels_data[, 2])))
  
  #Calculate Averages for each subject by activity - then sort by Subject and Activity
  study_averages <- fully_merged %>% group_by(Subject, Activity) %>% summarise_each(funs(mean), -Subject, -Activity)
  
  if (calculateAverages == TRUE) {
    study_averages_sorted <- study_averages[order(study_averages$Subject, study_averages$Activity), ]
    return(study_averages_sorted)
  }
  
  return (study_averages)
}

#write averages to output file
resultFile <- paste(getwd(), "/results/StudyAveragesTidy.csv", sep="")
write.table(CleanAndAggregateStudy(calculateAverages = TRUE), resultFile, sep=",", row.names = FALSE, )

#resultFile <- paste(getwd(), "/results/StudyMergedTidy.csv", sep="")
#write.table(CleanAndAggregateStudy(calculateAverages = FALSE), "./", sep=",", row.names = FALSE, )

