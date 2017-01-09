##Extracts all the features with either mean or 
##standard deviation included in the discription. 
##This includes mean frequency.

X_meansd <- completeData[,grepl("mean|std",names(completeData))]
head(X_meansd[,1:4])

##Prints out the mean of each variable 
##for each activity (6) and subject (30).

meansdData <- data.frame(completeData[,1:2], X_meansd) %>%
    tbl_df() %>%
    group_by(Activity, Subject)%>%
    summarize_all(mean) %>%
    print