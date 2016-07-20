How the data was transformed and cleaned

The original dataset was obtained found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following files were read into R using read.table():

1. features.txt - this has the names of all features 
2. y_train.txt - this has the coded activities for the training set
3. subject_train.txt - this has the subject ID's for the training set
4. X_train.txt - this is the data for the training set
5. X_test.txt - this is the data for the test set
6. subject_test.txt - this has the subject ID's for the test set
7. y_test.txt - this has the coded activities for the test set

After reading in the tables the features were assigned to a variable and then added
to both the X_train dataset and the X_test dataset as column names

The activity and subject datasets for both the test and trainging data were then 
given variable names, Activity and Subject_ID respectively.

Next, all columns for both the training and test set were removed except for those 
that were either measuring mean() or std()

The columns for activity and subject_id were added to the test and training data

Then, the test and training datsets were merged to create one dataset.

Next, the activity column was recoded to have more descriptive names.

Finally, the full dataset was grouped by subject and activity and the average of 
each column was found. This gives us the average value for each subject broken
down by activity. 

The two cleaned datasets are then saved as csv files. 


Description of Variables

The first two variables are:

Subject_ID - This is a categorical variable that lists the subjects by ID number ranging from 1-30               

Activity - This is a categorical variable that states the activity that the subjects performed. 
           It is broken down into 6 self explanatory levels.
	        1. Laying
		2. Sitting
		3. Standing
		4. Walking
		5. WalkingDownstairs
		6. WalkingUpstairs


Given the complexity of the variable titles obtained from the frequency file, they were left as is. Further justification for 
this decision is given at the end of the variable description. 

They are coded as follows: 

1. Each variable starts with a t or an f.
    t denotes time
    f denotes frequency domain signals

2. There are 9 different measurements that are a combination of the following. 
   Acc - results obtained from the accelerometer. 
   Gyro - results obtained from the gyroscope.
   Body - measures the body acceleration
   Gravity - measures the gravity acceleration
   Jerk - the linear acceleration and angular velocity 
   Mag - the magnitude of the jerk signals using the Euclidian norm
   
   These are combined to create the following variables
               
    1. BodyAcc
    2. GravityAcc     
    3. BodyAccJerk
    4. BodyGyro      
    5. BodyGyroJerk  
    6. BodyAccMag     
    7. BodyAccJerkMag
    8. BodyGyroMag     
    9. BodyGyroJerkMag  

3. The calculation done to the measurement		
    mean() - the average of the variable
    std() - the standard deviation of the variable

4. XYZ denotes the three axial signals in either direction X, Y, or Z

An example of one of the variables
tBodyAcc-mean()-Z

The t tells us we are looking at measurements of time
BodyAcc tells us we are measuring the time it takes the body to accelerate in the performed activity
mean() tells us this is the average of the body acceleration for the exercise
Z tells us we are seeing the axial signal in the Z direction

To recode each measurement based on the above parameters would complicate things tremendously and introduce many NA's to an otherwise clean dataset.
