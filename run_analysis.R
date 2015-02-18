## Create R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Load packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Get and extract data
if(!file.exists("./data")) {dir.create("./data")}
filePath <- function(...) { paste(..., sep = "/") }

downloadData <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  downloadDir <- "data"
  
  zipFile <- filePath(downloadDir, "dataset.zip")
  #zipFile <- filePath("dataset.zip")
  if(!file.exists(zipFile)) { download.file(url, zipFile) }
  
  dataDir <- "UCI HAR Dataset"
  if(!file.exists(dataDir)) { unzip(zipFile, exdir = ".") }
  
  dataDir
}

dataDir <- downloadData()

## Load Activity labels as a dataframe
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Read features and adjust feature names to be more readable using substitutions
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Extract only the mean and standard deviation columns of measurements
mean_std_featurecols <- grep(".*Mean.*|.*Std.*", features[,2])
mean_std_featureset <- features[mean_std_featurecols,]

# Load and process X_test & y_test data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Create X test set to use
X_test_ex = X_test[,mean_std_featurecols]
colnames(X_test_ex) = c(mean_std_featureset$V2)

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
colnames(y_test) = c("Activity_ID", "Activity_Label")
colnames(subject_test) = "subject"

# Bind test data
test_data <- cbind(as.data.table(subject_test), y_test, X_test_ex, filesource = "test")


# Load and process X_train & y_train data.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Create X train test set to use
X_train_ex = X_train[,mean_std_featurecols]
colnames(X_train_ex) = c(mean_std_featureset$V2)

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
colnames(y_train) = c("Activity_ID", "Activity_Label")
colnames(subject_train) = "subject"

# Bind train data
train_data <- cbind(as.data.table(subject_train), y_train, X_train_ex, filesource = "train")

# Merge test and train data
test_train_data = rbind(test_data, train_data)

# Reposition data for calculation
id_labels   = c("subject", "Activity_ID", "Activity_Label","filesource")
data_labels = setdiff(colnames(test_train_data), id_labels)
melt_data = melt(test_train_data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# Write data
write.table(tidy_data, "tidy_data.txt", sep="\t")
