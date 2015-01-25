# GCDCourseProject
*********************************************************************
The artefacts in this repository were created for
the Coursera "Getting and Cleaning Data Course Project",Jan 2015.

The purpose is to clean and summarise the source 
"Human Activity Recognition Using Smartphones Dataset" obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The reader should refer to the documentation in the source data set to gain an
understanding of that study design and how the data was collected. In order to process the
source data set and to produce the summary dataset the following was done:

1. Download the "Human Activity Recognition Using Smartphones Dataset" obtained from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unzip this in the R working directory.

3. Run the R script run_analysis.R
   NOTE: "data.table and "dplyr' R packages are required.

4. The result data set is written to the working directory as PerSubjectActivityMeans.txt


The repo contains the following files:


Readme.md: 
==========

this file.

CodeBook.md:
============

Modifies and updates the codebooks available with the 
"Human Activity Recognition Using Smartphones Dataset" data to indicate all the variables 
and summaries calculated, along with units, and other relevant information.

run_analysis.R:
===============

Some background:

In the original data set many sensor data variables associated with movement were collected 
(via smartphone accelerometer and gyroscope) across a range of physical activities
carried out by various subjects (trial participants). Some data such as mean and standard 
deviation for each of the sensor measured data was calculated and also associated.
 
In this project the calculated (mean and standard deviation) subset of the data was 
extracted for each activity carried out by a subject. The data was then averaged for reach
subject and activity. 

This R script functions as follows:

 1. Merges the original training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Substitute the activity codes with descriptive activity names.
 4. Substitute the coded variable names in the data set with descriptive variable names.
 5. Using the data (as processed above) creates an independent tidy data set with
    the average of each extracted variable (original mean and std values) for each activity and each subject.
    (Please see CodeBook.md for more information)
   
