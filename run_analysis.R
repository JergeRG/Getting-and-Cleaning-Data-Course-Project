# It verifies whether the  package is or isn't already installed, in the case it
# is not, the package will be installed
if(!"dplyr" %in% rownames(installed.packages()))
    install.packages("dplyr")

# Loads the package
library(dplyr)

filename <- "Dataset.zip"

# It verifies whether the  dataset is or isn't already exits in the working 
# directory, in the case it is not, the dataset will be downloaded
if(!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# It verifies whether the  dataset directory is or isn't already exits in the working 
# directory, in the case it is not, the dataset will be extracted
if(!file.exists("UCI HAR Dataset")){ 
    unzip(filename) 
}

# Extracts data from the files
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("x", "functions"))
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "label")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = (features$functions))
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "label")

# Merge Data 
x_complete <- rbind(x_train, x_test)
y_complete <- rbind(y_train, y_test)
subject_complete <- rbind(subject_train, subject_test)
merged_data <- cbind(subject_complete, y_complete, x_complete)

# Extracts the mean and standard deviation measurements from each measurement

tidy_data <- merged_data  %>% select(subject, label, contains("mean"), contains("std"))
                                     
# Describes activity names to name the activities in the data set
tidy_data$label <- activity_labels[tidy_data$label, 2]

# Describes variable names
names(tidy_data) <- gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("Freq", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gravity", names(tidy_data))
names(tidy_data) <- gsub("std", "STD", names(tidy_data))
names(tidy_data) <- gsub("mean", "Mean", names(tidy_data))
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("\\.", "", names(tidy_data))
names(tidy_data)[2] <- "activity"

# Average of each variable for each activity and each subject
tidy_data_average <- tidy_data %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean))

# Saves data
write.table(tidy_data_average, "tidy_data_average.txt", row.name=FALSE)


