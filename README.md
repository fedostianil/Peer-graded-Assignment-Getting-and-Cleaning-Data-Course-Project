# Getting and Cleaning Data Course Project

This repository contains my work for the Coursera
Getting and Cleaning Data course project.

## Files in this repository

- run_analysis.R  
  This script downloads the data, merges the training and test sets,
  extracts the mean and standard deviation variables, uses descriptive
  activity names, and creates a tidy data set.

- tidy_data  
  This is the final tidy data set with the average of each variable
  for each activity and each subject.

- CodeBook.md  
  Describes the variables in the tidy data set and the steps used
  to clean the data.

- UCI HAR Dataset  
  Contains the original data files from the Human Activity Recognition study.

## How the script works

1. Reads training and test data
2. Merges them into one data set
3. Keeps only mean and standard deviation measurements
4. Replaces activity IDs with activity names
5. Labels the variables with descriptive names
6. Creates a second tidy data set with averages
