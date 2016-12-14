# Getting and Cleaning Data: Course Project
This repository contains the course project for the "Getting and Cleaning Data" module of the Coursera Data Science Specialization.  

## Contents
This repository contains the following files:  

* `readme.md` - This file; describes the contents of the repository and decisions made during the project
* `codebook.md` - Codebook for the project; defines the variables used in `tidy.txt`
* `tidy.txt` - The final, tidied version of the input data
* `run_analysis.R` - The R language script file. Sourcing this will reproduce the tidying process.  


## Background
The dataset used for this project is from UCI's Machine Learning Repository: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Description of the Script
The `run_analysis.R` script, when sourced, will download the initial data set to the working directory and unzip it.  It will then complete the 5 steps outlined in the project description, as detailed below:  

1. Merges the training and test sets to create one set.  

	`rbind()` is used to merge the test and train data sets of each type (X, Y, and subject).  These three sets are later combined using `cbind()` to produce on data frame containing all the data.
2. Extracts only the measurements on the mean and standard deviation for each measurement.  

	`grep()` is used to select the data containing the characters "mean" or "std".  This includes measurements from the original data set that end with the "mean()" or "std()" function.  It also includes the "meanFreq()" measurements, which are specified in the data description to be the calculated mean of the frequency components.  It omits the "angle()" values (e.g. angle(X,gravityMean), as these are vector angle measurements and not calculated mean values. 
3. Uses descriptive activity names to name the activities in the data set.  
	
	The activity names from `activity_labels.txt` are combined with the complete data set using `merge()`, replacing the numerical activity id with a descriptive terms such as "WALKING".
4. Appropriately labels the data set with descriptive variable names.  
	
	The labels given in `features.txt` are applied to the columns of the measurement data.  These labels are short but sufficiently descriptive to inform about their source.  Further information on the labels can also be found in the information accompanying the original data and in the `codebook.md` file in this repository.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
	
	FIX ME!