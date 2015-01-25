**************************************************************************************
CodeBook produced for the Coursera "Getting and Cleaning Data Course Project",Jan 2015.

1.0 Study Design

The reader should refer to the documentation in the source data set to gain an
understanding of that study design and how the data was collected. 

The source data, "Human Activity Recognition Using Smartphones Dataset" was obtained from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Essentially many sensor data variables associated with movement were collected 
(via smartphone accelerometer and gyroscope) across a range of physical activities
carried out by various subjects (trial participants). Some data such as mean and standard 
deviation for each of the sensor measured data was calculated and also associated.
 
In this project the calculated (mean and standard deviation) subset of the data was 
extracted for each activity carried out by a subject. The data was then averaged for reach
subject and activity. 

2.0 Code Book

The variables that are omitted from PerSubjectActivityMeans.txt but are available in the
source data set are fully described within the zip file of that data set. However the 
following variables as used in the generated PerSubjectActivityMeans.txt dataset are 
described below:

Subject :  An identifier of the participant (subject) in the trial (1..30)
Activity:  The type of activity being carried out by the subject 
		   (one of: WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING)

For a complete description of variables, including derivation and units of measurement the
reader should consult features_info.txt from the source data set. The following is an 
extract for convenience:

*******
The features selected for this database come from the accelerometer and gyroscope 3-axial 
raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time)
were captured at a constant rate of 50 Hz. Then they were filtered using a median filter 
and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove 
noise. Similarly, the acceleration signal was then separated into body and gravity 
acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth
filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
Also the magnitude of these three-dimensional signals were calculated using the
Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, 
fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
*******

The mean and std features extracted and used in the product data set are themselves 
averaged for all instances of the specific subject carrying out a specific
activity. It should be noted that the variable names are re-used but their meaning in 
the product data set is changed.	   
		
		
In the product data set the following variables are used:

tBodyAcc-mean()-X  : The mean of the original data "time domain mean of body acceleration
					 readings in the X dimension" for all instances of the specific
					 subject carrying out a specific activity.
					     
Note: following are described similarly by analogy to above (std is standard deviation):
					        
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z
tBodyAcc-std()-X  
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X           
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-mean()-X        
tBodyAccJerk-mean()-Y      
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X          
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-mean()-X           
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X         
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-mean()-X     
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X         
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-mean()        
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()           
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()           
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()    
     
fBodyAcc-mean()-X :  The mean of the original data frequency domain mean of body 
					 acceleration readings in the X dimension" for all instances of
					 the specific subject carrying out a specific activity.
					 
Note: following are described similarly by analogy to above (std is standard deviation):
					 
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z              
fBodyAcc-meanFreq()-X
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z          
fBodyAccJerk-mean()-X 
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z         
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z         
fBodyAccJerk-meanFreq()-X
fBodyAccJerk-meanFreq()-Y   
fBodyAccJerk-meanFreq()-Z     
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z             
fBodyGyro-std()-X     
fBodyGyro-std()-Y 
fBodyGyro-std()-Z            
fBodyGyro-meanFreq()-X  
fBodyGyro-meanFreq()-Y   
fBodyGyro-meanFreq()-Z       
fBodyAccMag-mean()    
fBodyAccMag-std()    
fBodyAccMag-meanFreq()        
fBodyBodyAccJerkMag-mean()    
fBodyBodyAccJerkMag-std()
fBodyBodyAccJerkMag-meanFreq()
fBodyBodyGyroMag-mean()    
fBodyBodyGyroMag-std() 
fBodyBodyGyroMag-meanFreq()   
fBodyBodyGyroJerkMag-mean() 
fBodyBodyGyroJerkMag-std()  
fBodyBodyGyroJerkMag-meanFreq()