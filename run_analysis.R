# load the plyr library, needed for ddply
library(plyr)

#If the data files don't already exist, download and unzip them
if(!dir.exists("UCI HAR Dataset")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data.zip")
  unzip("data.zip")
}

# read the data from the downloaded files
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", as.is = TRUE)
featureLabels <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# combine the training and test data sets
dataX <- rbind(trainX, testX)
dataY <- rbind(trainY, testY)
dataSubjects <- rbind(trainSubjects, testSubjects)

# apply names to the columbs of the X, Y, and Subject sets
names(dataX) <- featureLabels[,2]
names(dataY) <- "Activity ID"
names(dataSubjects) <- "Subject"

#extract the "mean" or "std" measures from the X data set then combine Subjects, Y, and X into one set
dataX <- dataX[,grep("mean|std", names(dataX))]
fullData <- cbind(dataSubjects, dataY, dataX)

# remove the unneeded intermediate tables/frames from memory
rm(trainX, trainY, testX, testY, trainSubjects, testSubjects, dataX, dataY, dataSubjects, featureLabels)

# Merge the activity labels, then remove the now-unnecessary data frame
fullData <- merge(activityLabels, fullData, by.x = 1, by.y = "Activity ID")[-1]
names(fullData)[1] <- "Activity"
rm(activityLabels)

# use ddply to split the data across Subject and Activity, then apply "mean()" column-wise
tidyAverages <- ddply(fullData, .(Subject, Activity), numcolwise(mean))

# write the result to output
write.table(tidyAverages, file = "tidy.txt")
