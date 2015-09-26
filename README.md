<<<<<<< HEAD
getting-and-cleaning-data-course-project
========================================

Course project deliverables for the Coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata)

## Installation
* create a new directory named (assuming linux style directory structure): ~/dev/Coursera/datasciencecoursera/GetCleanData/course_project
* Download and unzip the Project from git into the new directory
* Download the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to the same diretory and unzip it. 
** There are several data files in the original source set, but you will only be concerned with the following:
 
*** UCI HAR Dataset
**** README.txt
**** activity_labels.txt
**** features.txt
**** features_info.txt
**** test
**** train
*** run_analysis.R


## Dependencies
The script `run_analysis.R` depends on the libraries `dplyr`, if you have not installed them then execute `install.packages(dplyr)` from the `RStudio IDE` or `R Console` prompt.
    
## Running the analysis     
* Load the `run_analysis.R` into the the `RStudio IDE` or `R Console`. 
* Source the script `run_analysis.R` script: `source("run_analysis.R")`
* This will execute the function `CleanAndAggregateStudy` resulting in the creation of the file `StudyAveragesTidy.csv` in the `~/dev/Coursera/datasciencecoursera/GetCleanData/course_project` directory.

## Codebook
Information about the datasets is provided in `CodeBook.md`.     

## Code 
The code contains detailed commments explaining the steps in which the original data was transformed.

=======
# get_clean_data-course_project
Coursera Getting and Cleaning Data => Course Project
>>>>>>> 62f4d2f2fc2d15d37f2fbb64300a992ab4c3766e
