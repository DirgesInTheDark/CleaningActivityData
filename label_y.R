##Renames the y values by the description given in the activity labels

label_activity <- function(x) activity_labels[x]

y_train_labelled <- sapply(y_train, label_activity)
y_test_labelled <- sapply(y_test, label_activity)

table(y_train_labelled)