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
Transfors original data to a "tidy data set"

###Highlights of script
* Extract dataset
* Merge


merge the test and training sets together. Prerequisites for this script:

the UCI HAR Dataset must be extracted and..
the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"
After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

## Code Book
CodeBook.md file explains the transformations performed and data variables.
