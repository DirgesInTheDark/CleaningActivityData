
##Downloads file from source
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, temp, method = "curl")

##Downloads information about features and activity
con <- unz(temp,"UCI\ HAR\ Dataset/activity_labels.txt")
activity_labels <- read.table(con)
activity_labels <- as.character(activity_labels$V2)

con <- unz(temp,"UCI\ HAR\ Dataset/features.txt")
features <- read.table(con)
features <- as.character(features$V2) 

##Unzips and reads in training data
con <- unz(temp,"UCI\ HAR\ Dataset/train/X_train.txt")
X_train <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/train/y_train.txt")
y_train <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/train/subject_train.txt")
subject_train <- read.table(con)

##Unzips and reads in test data

con <- unz(temp,"UCI\ HAR\ Dataset/test/X_test.txt")
X_test <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/test/y_test.txt")
y_test <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/test/subject_test.txt")
subject_test <- read.table(con)

unlink(temp)
