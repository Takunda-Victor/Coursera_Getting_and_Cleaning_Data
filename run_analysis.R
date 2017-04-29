#The R script below does the following as per the assignment requirements;
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each #   activity and each subject.

#load the plyr which is used for split-apply-combine procedures and will come in handy in step 5 (the creation of a tidy, independent dataset) 
library(plyr)

#1. Read in and merge the training and test sets to create one data set.

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# combine the 'x' training and test datasets. The 'x'datasets contain the measured observations made.
combinedXdata <- rbind(x_train, x_test)

# combine the 'y' training and test datasets. The 'y'data sets contain labels of anyone of the 6 activities.
combinedYdata <- rbind(y_train, y_test)

# combine the subject training and test datasets.The subject datasets contain codes for the 30 people measured.
combinedSubjectdata <- rbind(subject_train, subject_test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")

# filter observations with mean or std
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# eliminate all columns not including mean or sd from the combinedXdata
combinedXdata <- combinedXdata[, mean_and_std_features]

# create a dataframe of the columns names of mean and sd features
names(combinedXdata) <- features[mean_and_std_features, 2]

# 3. Use descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")

# replace activity value codes with respective and more appropriate activity names
combinedYdata[, 1] <- activities[combinedYdata[, 1], 2]

# Appropriately name the combinedYdata column
names(combinedYdata) <- "activity"

# 4. Appropriately label the data set with descriptive variable names

# Appropriately name the combinedSubjectdata column
names(combinedSubjectdata) <- "subject"

# merge all the data (to get one dataset that has an observation and activity per subject)
all_data <- cbind(combinedXdata, combinedYdata, combinedSubjectdata)

# 5. Create a second, independent tidy data set with the average of each variable
# for each activity and each subject

# here make use of the ddply function to obtain averages of each variable per subject per activity
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)