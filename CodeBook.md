# Code Book

This code book describes the data and variables created for the
Getting and Cleaning Data course project.

## Data Source

The data come from the Human Activity Recognition Using Smartphones Dataset.
The original data were collected from accelerometers and gyroscopes
from a Samsung Galaxy S smartphone.

## Tidy Data Set

The tidy data set contains the average of each selected measurement
for each subject and each activity.

Each row represents:
- One subject
- One activity

Each column represents:
- The average of a measurement variable

## Variables

- subject  
  Identifier of the subject who performed the activity (1–30)

- activity  
  Descriptive activity name:
  WALKING  
  WALKING_UPSTAIRS  
  WALKING_DOWNSTAIRS  
  SITTING  
  STANDING  
  LAYING  

- Measurement variables  
  All remaining columns are averages of measurements that contain
  either mean or standard deviation in their original name.
  Examples include:
  - Time_BodyAccel_meanX
  - Time_BodyAccel_stdX
  - Time_GravityAccel_meanY

All values are numeric and represent averaged sensor signals.

## Data Transformations

The following steps were performed to clean the data:

1. Merged the training and test data sets
2. Extracted only mean and standard deviation measurements
3. Replaced activity IDs with descriptive activity names
4. Labeled variables with descriptive names
5. Created a tidy data set with the average of each variable
   for each activity and each subject
