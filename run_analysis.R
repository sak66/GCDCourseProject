#
# Name: run_analysis.R
# Date: 23/01/15
# 
# Purpose:  This was written for the Coursera - Getting and Cleaning Data, Course Project
#
# Function: This script does the following:
#
#           Using the data set obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#           
#           1. Merges the training and the test sets to create one data set.
#           2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#           3. Substitutes (Uses) descriptive activity names to name the activities in the data set
#           4. Substitutes (Appropriately labels) the data set with descriptive variable names.
#
#           5. Using the new data set (as created above) creates an independent tidy data set with
#              the average of each variable for each activity and each subject.
#
#            This data set contains 6 activity rows for every subject  
#            The values in each row are the avarage of theose measured for the subject carying out the activity.  
#     
#
#            **  Saves he resulting data set PerSubjectActivityMeans.txt *
#
# Use: The source Samsung data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
# should be unzipped in your working directory.
#
# Prerequisites:
#                1. Install and unzip https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#                2. Install data.table package for use by R ( install.packages("data.table") )
#                3. Install dplyr package for use by R ( install.packages("dplyr") )
#
#
wd <- getwd()
cat("Current working dir: ", wd)
cat("\nRunning run_analysis.R ...\n")

# *************************
#  Load libraries
# *************************

library(data.table)
library(dplyr)


# ****************************
#  load the global decode data
# ****************************
#
# activity_labels.txt: each row contains an activity code, a space separator and the human readable 
# (decode) string.
#

decode.activity <- fread("./UCI HAR Dataset/activity_labels.txt",sep=' ')
#
# features.txt: each row contains an feature code (alligns with column number in the observation data),
# a space separator and the human readable (decode) string.
#

decode.feature <- fread("./UCI HAR Dataset/features.txt",sep=' ')

# *************************
#  load the data from test
# *************************
#
# test/subject_test.txt': Each row represents the subject who performed the activity for
# each observation in test/X_test.txt. 
#

test.observation.subjects <- fread("./UCI HAR Dataset/test/subject_test.txt")

#
# test/y_test.txt': Each row represents an activity type (label) for each observation in X_test.txt 
#

test.coded.observation.activity <- fread("./UCI HAR Dataset/test/y_test.txt")

#
# test/X_test.txt': Each row represents an activity observation with 561 features
# Note: Unfortunatly fread seems to have an issue with large number of columns
#       therefor as a work around read.table is used and then the data frame is 
#       converted to data table

DF.test.observation.features <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.observation.features <- data.table(DF.test.observation.features)
#free up the memory by destroying the Data Frame which is not needed any more
rm(DF.test.observation.features)


# *************************
#  load the data from train
# *************************
#
# train/subject_test.txt': Each row represents the subject who performed the activity for
# each observation in train/X_train.txt. 
#

train.observation.subjects <- fread("./UCI HAR Dataset/train/subject_train.txt")

#
# train/y_test.txt': Each row represents an activity type (label) for each observation in X_train.txt 
#

train.coded.observation.activity <- fread("./UCI HAR Dataset/train/y_train.txt")

#
# test/X_train.txt': Each row represents an activity observation with 561 features
#

DF.train.observation.features <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.observation.features <- data.table(DF.train.observation.features)
#free up the memory by destroying the Data Frame which is not needed any more
rm(DF.train.observation.features)

#
# *********************************************
# Combine the data sets:
#                       test.observation.subjects with train.observation.subjects
#                       test.coded.observation.activity with train.coded.observation.activity
#                       test.observation.features with train.observation.features
#

observation.subjects <- rbind(test.observation.subjects,train.observation.subjects)
# free up memory
rm(test.observation.subjects,train.observation.subjects)

coded.observation.activity <- rbind(test.coded.observation.activity,train.coded.observation.activity)
# free up memory
rm(test.coded.observation.activity,train.coded.observation.activity)

observation.features <- rbind(test.observation.features,train.observation.features)
# free up memory
rm(test.observation.features,train.observation.features)

#
# ******************************************************************************
# Substitute (Appropriately labels) the data set with descriptive variable names
# ie .. set human readable column names in the observation.features data table.
#
# simpler but slower: colnames(observation.features) <- decode.feature$V2
# ******************************************************************************
#
setnames(observation.features,colnames(observation.features),decode.feature$V2)

# free unneeded data table
rm(decode.feature)

#
# ******************************************************************************
# Add a column to the observation.features data table to map the human
# readable activity (decode) looked up for the activity code of each observation.  
#
# Add a column to the observation.features data table to map the Subject
# id for each observation
#
# ******************************************************************************
#

observation.features[,Activity:=decode.activity[coded.observation.activity$V1]$V2][,Subject:=observation.subjects]


# free unneeded data tables
rm(coded.observation.activity)


#
# ******************************************************************************
# Reorder the column names in the observation.features data table such that 
# Subject is first and Activity is second, all the features follow..
#
#  Note: this data set has 561 features, and we have addes 562 (Activity)
#       and 563 (Subject) above
#        
# *******************************************************************************
#

setcolorder(observation.features, c(563, 562,1:561))

#
# ********************************************************************************
# Leave only t mean or std feature data as well as the Activity and Subject columns
# *********************************************************************************
#

meansAndStd.dataset <- observation.features[, grep("(Activity)|(Subject)|(std)|(mean)", colnames(observation.features)), with=FALSE]

# Throw away the full features data, we're interested in mean ant std values only
rm(observation.features)

# 
# **********************************************************************************
#  Create a data set contains 6 activity rows for every subject  
#  The values in each row are the avarage of theose measured for the subject carying 
#  out the activity.
# **********************************************************************************
#
ActivityMeans.dataset <- data.table()
# For all subjects
for ( currentSubject in unique(observation.subjects$V1) ) {
  #  For all activities
  for ( currentActivity in decode.activity$V2 ) {
       currentSubjectActivity.data <- subset(meansAndStd.dataset, Subject==currentSubject & Activity==currentActivity)
       #  Summarise currentSubjectActivity.data in to a single row with a mean of al the data in each column.
       newRow <- currentSubjectActivity.data %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
       previousRows <- ActivityMeans.dataset
       ActivityMeans.dataset <- rbind(previousRows,newRow)
  }
}
# Clean up
rm(observation.subjects,decode.activity,currentSubjectActivity.data,newRow,previousRows,meansAndStd.dataset,currentActivity,currentSubject)

#
# ********************************************************************************
# Write the result.dataset out as a TXT
# *********************************************************************************
#
write.table(ActivityMeans.dataset, file = "PerSubjectActivityMeans.txt",row.names=FALSE)


