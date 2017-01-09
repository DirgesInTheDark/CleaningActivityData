The run\_analysis R file calls the following four in order of:

getData.R
*Downloads file from source
*Downloads information about features and activity
*Unzips and reads in training data
*Unzips and reads in test data

label\_y.R
\*Renames the y values by the description given in the activity labels

makeComplete.R
*Makes the training data into a single data frame.
*Renames the features by the description given in the features labels.
*Makes the test data into a single data frame.
*Renames the features by the description given in the features labels.
\*Binds test data and training data to get complete data

meansdData.R
*Extracts all the features with either mean or standard deviation included in the discription. This includes mean frequency.
*Prints out the mean of each variable for each activity (6) and subject (30).
