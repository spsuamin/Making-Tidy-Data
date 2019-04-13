# Making-Tidy-Data
Created for submitted programming assignment 3 which is to demonstrate how to transform and clean data. 

This repository contains code and data files submitted for programming assignment #3 as part of the JHU Data Science subcourse Getting and Cleaning Data

There is one R-code file named "Run_Analysis.r".

Uon executing, the file oppens a dialog box asking the user to point to the folder containing the UCI HAR Dataset. A folder of this dataset is also included in this repository but the dataset was originally downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once the directory is selected the code does the following
1. Reads the activity_labels.txt and features.txt files to gather metadata information about the UCI HAR Dataset
2. Reads feature data from the training and test data files 
3. Merges the training and test data together
4. Keeps only the features that are mean or std type calculations
5. Applies metadata information from step 1 to provide descriptive variable names to the data
6. Generates one dataset and writes it locally as "tidyHRAdataset.csv"
7. Groups the dataset by activity and subject and calculates the average for each mean and std feature
8. Writes "tidy2HRAdataset.csv locally. 

Both the "tidyHRAdataset.csv" and "tidy2HRAdatset.cvs are provided in this repository. 