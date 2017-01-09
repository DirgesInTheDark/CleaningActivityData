##Makes the training data into a single data frame. 
##Renames the features by the description given in the features labels.
training <- data.frame(y_train_labelled, subject_train, X_train)
colnames(training) <- c("Activity", "Subject", features)


##Makes the test data into a single data frame. 
##Renames the features by the description given in the features labels.
test <- data.frame(y_test_labelled, subject_test, X_test)
colnames(test) <- c("Activity", "Subject", features)

##Binds test data and training data to get complete data
completeData <- rbind(training, test)
head(completeData[,1:4])