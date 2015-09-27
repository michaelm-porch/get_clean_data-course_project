Getting & Cleaning Data - Course Project
========================================

Course project deliverables for the Coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata)

## Installation
* Create a new directory named *./GetCleanData/course_project*: (assuming linux style directory structure)
	* **cd &lt;your basedir&gt;**
	* **mkdir ./GetCleanData/course_project**	
* Download and unzip the Project from git into the new directory [Getting and Cleaning Data - Course Project](https://github.com/michaelm-porch/get_clean_data-course_project)
* Download the raw data from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to the same diretory and unzip it.

There are several data files in the original source set, but you will only be concerned with the following:
 
	UCI HAR Dataset
		README.txt
		activity_labels.txt
		features.txt
		features_info.txt
		test/
			X_test.txt
			y_test.txt
			subject_test.txt
		train/
			X_test.txt
			y_test.txt
			subject_test.txt


## Dependencies
The script `run_analysis.R` depends on the libraries `dplyr`, if you have not installed them then execute `install.packages(dplyr)` from the `RStudio IDE` or `R Console` prompt.
    
## Running the analysis     
* Load the `run_analysis.R` into the the `RStudio IDE` or `R Console`. 
* Source the script `run_analysis.R` script: `source("run_analysis.R")`
	* This will execute the function `CleanAndAggregateStudy` resulting in the creation of the file `StudyAveragesTidy.csv` in the `./GetCleanData/course_project` directory.

Function `CleanAndAggregateStudy` takes a single parameter `calculateAverages` - a boolean defaulted to TRUE - which indicates whether the resultant tidy data should be aggregated by Test Subject and Activity. Setting this value to FALSE will produce non-aggregated unsorted tidy data - these data are useful for validation purposes.

## Codebook
Information about the datasets is provided in `CodeBook.md`.     

## Code 
The code contains detailed commments explaining the steps in which the original data was transformed.

