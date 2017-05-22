# Getting_and_cleaning_data_project
Course project for coursera getting and cleaning data course

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

Reads all datasets into the working directory
Reads activities and label files\
Sets the column names in labels/features files then renames columns in datasets to properly identify activities and subjects
Merges all files together and properly names columns
Selects only the mean and standard deviation variables for each domaine measured
Cleans up variable names in resulting dataset
creates a new tidy dataset that contains the average of each variable for each subject and activity
The end result is shown in the file new_tidy_mean.txt.
