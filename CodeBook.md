Created variables: url - url of data sourced
activity\_labels - vector of different activity names
features - vector of differnt feature names (X data)
X\_train/X\_test - Imported raw data for training/test sets
subject\_train/
subject\_tests - Imported subjects id for training/test sets
y\_train/y\_test - Imported raw activiies for training/test sets
y\_train\_labelled/
y\_test\_labelled - y values given descriptive labels
training/test - full data set for trainin/test (y, subj, X)
completeData - merged training/test data set
X\_meansd - X data set with only "mean" or "std" features
meansdData - mean of X\_meansd by activity and subject

Downloads libraries used for markdown knitr, tidyr, dplyr

``` r
library(knitr)
library(tidyr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Downloads file from source

``` r
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, temp, method = "curl")
```

Downloads information about features and activity

``` r
con <- unz(temp,"UCI\ HAR\ Dataset/activity_labels.txt")
activity_labels <- read.table(con)
activity_labels <- as.character(activity_labels$V2)

con <- unz(temp,"UCI\ HAR\ Dataset/features.txt")
features <- read.table(con)
features <- as.character(features$V2) 
```

Unzips and reads in training data

``` r
con <- unz(temp,"UCI\ HAR\ Dataset/train/X_train.txt")
X_train <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/train/y_train.txt")
y_train <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/train/subject_train.txt")
subject_train <- read.table(con)
```

Unzips and reads in test data

``` r
con <- unz(temp,"UCI\ HAR\ Dataset/test/X_test.txt")
X_test <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/test/y_test.txt")
y_test <- read.table(con)

con <- unz(temp,"UCI\ HAR\ Dataset/test/subject_test.txt")
subject_test <- read.table(con)

unlink(temp)
```

### 3. Uses descriptive activity names to name the activities in the data set

Renames the y values by the description given in the activity labels

``` r
label_activity <- function(x) activity_labels[x]

y_train_labelled <- sapply(y_train, label_activity)
y_test_labelled <- sapply(y_test, label_activity)

table(y_train_labelled)
```

    ## y_train_labelled
    ##             LAYING            SITTING           STANDING 
    ##               1407               1286               1374 
    ##            WALKING WALKING_DOWNSTAIRS   WALKING_UPSTAIRS 
    ##               1226                986               1073

### 4. Appropriately labels the data set with descriptive variable names.

Makes the training data into a single data frame. Renames the features by the description given in the features labels.

``` r
training <- data.frame(y_train_labelled, subject_train, X_train)
colnames(training) <- c("Activity", "Subject", features)
```

Makes the test data into a single data frame. Renames the features by the description given in the features labels.

``` r
test <- data.frame(y_test_labelled, subject_test, X_test)
colnames(test) <- c("Activity", "Subject", features)
```

### 1. Merges the training and the test sets to create one data set.

Binds test data and training data to get complete data

``` r
completeData <- rbind(training, test)
head(completeData[,1:4])
```

    ##   Activity Subject tBodyAcc-mean()-X tBodyAcc-mean()-Y
    ## 1 STANDING       1         0.2885845       -0.02029417
    ## 2 STANDING       1         0.2784188       -0.01641057
    ## 3 STANDING       1         0.2796531       -0.01946716
    ## 4 STANDING       1         0.2791739       -0.02620065
    ## 5 STANDING       1         0.2766288       -0.01656965
    ## 6 STANDING       1         0.2771988       -0.01009785

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Extracts all the features with either mean or standard deviation included in the discription. This includes mean frequency.

``` r
X_meansd <- completeData[,grepl("mean|std",names(completeData))]
head(X_meansd[,1:4])
```

    ##   tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
    ## 1         0.2885845       -0.02029417        -0.1329051       -0.9952786
    ## 2         0.2784188       -0.01641057        -0.1235202       -0.9982453
    ## 3         0.2796531       -0.01946716        -0.1134617       -0.9953796
    ## 4         0.2791739       -0.02620065        -0.1232826       -0.9960915
    ## 5         0.2766288       -0.01656965        -0.1153619       -0.9981386
    ## 6         0.2771988       -0.01009785        -0.1051373       -0.9973350

### 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Prints out the mean of each variable for each activity (6) and subject (30).

``` r
meansdData <- data.frame(completeData[,1:2], X_meansd) %>%
              tbl_df() %>%
              group_by(Activity, Subject)%>%
              summarize_all(mean) %>%
              print
```

    ## Source: local data frame [180 x 81]
    ## Groups: Activity [?]
    ## 
    ##    Activity Subject tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z
    ##      <fctr>   <int>             <dbl>             <dbl>             <dbl>
    ## 1    LAYING       1         0.2215982       -0.04051395        -0.1132036
    ## 2    LAYING       2         0.2813734       -0.01815874        -0.1072456
    ## 3    LAYING       3         0.2755169       -0.01895568        -0.1013005
    ## 4    LAYING       4         0.2635592       -0.01500318        -0.1106882
    ## 5    LAYING       5         0.2783343       -0.01830421        -0.1079376
    ## 6    LAYING       6         0.2486565       -0.01025292        -0.1331196
    ## 7    LAYING       7         0.2501767       -0.02044115        -0.1013610
    ## 8    LAYING       8         0.2612543       -0.02122817        -0.1022454
    ## 9    LAYING       9         0.2591955       -0.02052682        -0.1075497
    ## 10   LAYING      10         0.2802306       -0.02429448        -0.1171686
    ## # ... with 170 more rows, and 76 more variables: tBodyAcc.std...X <dbl>,
    ## #   tBodyAcc.std...Y <dbl>, tBodyAcc.std...Z <dbl>,
    ## #   tGravityAcc.mean...X <dbl>, tGravityAcc.mean...Y <dbl>,
    ## #   tGravityAcc.mean...Z <dbl>, tGravityAcc.std...X <dbl>,
    ## #   tGravityAcc.std...Y <dbl>, tGravityAcc.std...Z <dbl>,
    ## #   tBodyAccJerk.mean...X <dbl>, tBodyAccJerk.mean...Y <dbl>,
    ## #   tBodyAccJerk.mean...Z <dbl>, tBodyAccJerk.std...X <dbl>,
    ## #   tBodyAccJerk.std...Y <dbl>, tBodyAccJerk.std...Z <dbl>,
    ## #   tBodyGyro.mean...X <dbl>, tBodyGyro.mean...Y <dbl>,
    ## #   tBodyGyro.mean...Z <dbl>, tBodyGyro.std...X <dbl>,
    ## #   tBodyGyro.std...Y <dbl>, tBodyGyro.std...Z <dbl>,
    ## #   tBodyGyroJerk.mean...X <dbl>, tBodyGyroJerk.mean...Y <dbl>,
    ## #   tBodyGyroJerk.mean...Z <dbl>, tBodyGyroJerk.std...X <dbl>,
    ## #   tBodyGyroJerk.std...Y <dbl>, tBodyGyroJerk.std...Z <dbl>,
    ## #   tBodyAccMag.mean.. <dbl>, tBodyAccMag.std.. <dbl>,
    ## #   tGravityAccMag.mean.. <dbl>, tGravityAccMag.std.. <dbl>,
    ## #   tBodyAccJerkMag.mean.. <dbl>, tBodyAccJerkMag.std.. <dbl>,
    ## #   tBodyGyroMag.mean.. <dbl>, tBodyGyroMag.std.. <dbl>,
    ## #   tBodyGyroJerkMag.mean.. <dbl>, tBodyGyroJerkMag.std.. <dbl>,
    ## #   fBodyAcc.mean...X <dbl>, fBodyAcc.mean...Y <dbl>,
    ## #   fBodyAcc.mean...Z <dbl>, fBodyAcc.std...X <dbl>,
    ## #   fBodyAcc.std...Y <dbl>, fBodyAcc.std...Z <dbl>,
    ## #   fBodyAcc.meanFreq...X <dbl>, fBodyAcc.meanFreq...Y <dbl>,
    ## #   fBodyAcc.meanFreq...Z <dbl>, fBodyAccJerk.mean...X <dbl>,
    ## #   fBodyAccJerk.mean...Y <dbl>, fBodyAccJerk.mean...Z <dbl>,
    ## #   fBodyAccJerk.std...X <dbl>, fBodyAccJerk.std...Y <dbl>,
    ## #   fBodyAccJerk.std...Z <dbl>, fBodyAccJerk.meanFreq...X <dbl>,
    ## #   fBodyAccJerk.meanFreq...Y <dbl>, fBodyAccJerk.meanFreq...Z <dbl>,
    ## #   fBodyGyro.mean...X <dbl>, fBodyGyro.mean...Y <dbl>,
    ## #   fBodyGyro.mean...Z <dbl>, fBodyGyro.std...X <dbl>,
    ## #   fBodyGyro.std...Y <dbl>, fBodyGyro.std...Z <dbl>,
    ## #   fBodyGyro.meanFreq...X <dbl>, fBodyGyro.meanFreq...Y <dbl>,
    ## #   fBodyGyro.meanFreq...Z <dbl>, fBodyAccMag.mean.. <dbl>,
    ## #   fBodyAccMag.std.. <dbl>, fBodyAccMag.meanFreq.. <dbl>,
    ## #   fBodyBodyAccJerkMag.mean.. <dbl>, fBodyBodyAccJerkMag.std.. <dbl>,
    ## #   fBodyBodyAccJerkMag.meanFreq.. <dbl>, fBodyBodyGyroMag.mean.. <dbl>,
    ## #   fBodyBodyGyroMag.std.. <dbl>, fBodyBodyGyroMag.meanFreq.. <dbl>,
    ## #   fBodyBodyGyroJerkMag.mean.. <dbl>, fBodyBodyGyroJerkMag.std.. <dbl>,
    ## #   fBodyBodyGyroJerkMag.meanFreq.. <dbl>

Details about the session

``` r
sessionInfo()
```

    ## R version 3.3.1 (2016-06-21)
    ## Platform: x86_64-apple-darwin13.4.0 (64-bit)
    ## Running under: OS X 10.10.5 (Yosemite)
    ## 
    ## locale:
    ## [1] en_AU.UTF-8/en_AU.UTF-8/en_AU.UTF-8/C/en_AU.UTF-8/en_AU.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] dplyr_0.5.0 tidyr_0.6.0 knitr_1.14 
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.6     digest_0.6.10   assertthat_0.1  R6_2.1.3       
    ##  [5] DBI_0.5         formatR_1.4     magrittr_1.5    evaluate_0.9   
    ##  [9] stringi_1.1.1   lazyeval_0.2.0  rmarkdown_1.0   tools_3.3.1    
    ## [13] stringr_1.1.0   yaml_2.1.13     htmltools_0.3.5 tibble_1.1
