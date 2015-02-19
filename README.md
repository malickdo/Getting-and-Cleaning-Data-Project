# Getting-and-Cleaning-Data-Project

##Intro
This repository contains my work for the course project for the Coursera course "Getting and Cleaning data"

##Course Project
Purpose is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  The data used for this project is collected from the accelerometers of the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test subjects are in the subject_test.txt file.  Similar description for the training set.

## Script (run_analysis.R)
Transforms original data to a "tidy data set"

###Highlights of script
* Load R Packages
* Extract dataset
* Manipulate and Merge Data 
  * Merges the training and the test sets to create one data set.
  * Extracts only the measurements on the mean and standard deviation for each measurement.
  * Uses descriptive activity names to name the activities in the data set
  * Appropriately labels the data set with descriptive variable names.
* Output "tidy data" 
  * Average of each variable for each activity and each subject.

## Code Book
CodeBook.md file explains the transformations performed and data variables.
