## If the data files don't already exist, download and unzip them
if(!dir.exists("UCI HAR Dataset")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data.zip")
  unzip("data.zip")
}

## read the data from the downloaded files
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", as.is = TRUE)
featureLabels <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

## combine the training and test data sets
## then remove the individual sets from memory
dataX <- rbind(trainX, testX)
dataY <- rbind(trainY, testY)
dataSubjects <- rbind(trainSubjects, testSubjects)
rm(trainX, trainY, testX, testY, trainSubjects, testSubjects)

