# Load in the dplyr library
library(dplyr)

# Read in the 4 tables we will be working with for the training set
# First tables are the feature names 
features <- read.table("features.txt")

# The activity codes for the training data
activity_train <- read.table("y_train.txt")

# Subject ID for the training data
subject_train <- read.table("subject_train.txt")

# Last, the training dataset itself
x_train <- read.table("X_train.txt")

# Extracting the names from the features dataset
names <- features[,2]

# adding the features as column names for the training dataset
colnames(x_train) <- names

# adding variable names to the activity and subject data frames
colnames(activity_train) <- c("Activity")
colnames(subject_train) <- c("Subject_ID")

# removing all variables except those for mean and std_dev
x_train <- x_train[,grepl("mean()|std()", colnames(x_train))]

# This still leaves us with the variable "mean freq", so let's remove that next
x_train <- select(x_train, 1:46, 50:55, 59:64, 68:69, 71:72, 74:75, 77:78)

# Now, let's add the subject and activity columns leaving us with a clean set of training data
x_train <- bind_cols(activity_train, x_train)
clean_train <- bind_cols(subject_train, x_train)

# Let's now move on to the test set by loading it in
x_test <- read.table("X_test.txt")

# Next the user ID's and activity labels for the test set
subject_test <- read.table("subject_test.txt")
activity_test <- read.table("y_test.txt")

# We will add the same labels to these
colnames(activity_test) <- c("Activity")
colnames(subject_test) <- c("Subject_ID")

# Now lets add the variable names to the test data
colnames(x_test) <- names

# Let's remove everything except mean() and std_dev()
x_test <- x_test[,grepl("mean()|std()", colnames(x_test))]
x_test <- select(x_test, 1:46, 50:55, 59:64, 68:69, 71:72, 74:75, 77:78)

# Let's attach our user ID and activity columns
x_test <- bind_cols(activity_test, x_test)
clean_test <- bind_cols(subject_test, x_test)

# Now we can combine the test and training data together
full <- bind_rows(clean_train, clean_test)

# Next, let's change the activity labels to actual activity names
full <- full %>%
  mutate(Activity = ifelse(Activity == 1, "Walking",
                           ifelse(Activity == 2, "WalkingUpstairs",
                                  ifelse(Activity == 3, "WalkingDownstairs",
                                         ifelse(Activity == 4, "Sitting",
                                                ifelse(Activity == 5, "Standing", "Laying"))))))

# Grouped by subject and activity
sub_act <- full %>%
  group_by(Subject_ID, Activity) %>%
  summarise_each(funs(mean))

# Finally, the two cleaned datasets are saved as csv files and written to the working directory. I commented these out to meet 
# the requirements of the assignment, which creates a .txt file instead

# write.csv(full, "mean_and_std.csv")
# write.csv(sub_act, "activity_and_subject.csv")
write.table(sub_act, "activity_and_subject.txt", row.names = FALSE)





  
