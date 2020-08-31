# CodeBook - Getting and Cleaning Data Course Project

In this file is description the process of cleaning data for the steps required for the course project's.

The steps are the following:

1. **Load the library dplyr** \
The script verifies whether the  package is or isn't already installed, in the case it is not, the package will be installed. This dplyr package is necessary to clean and organize dataset.

2. **Download and extract the data set** \
The data set use for the project is a data collected from the accelerometers from the Samsung Galaxy S smartphone. The data set is extract in the folder `UCI HAR Dataset`. The data set  was obtained from the link: 
    + https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

3. **Extract data**\
    * The features data is extracting from the file `features.txt`, this data is storing in the
variable `features.txt`.
    * The content of the file `activity_labels.txt` is storing in the variable `activity_labels`
    * The content of the file `subject_train.txt` is storig in the variable `subject_train`
    * The content of the file `x_train.txt` is storing in the variable `x_train`
    * The content of the file `y_train.txt` is storing in the variable `y_train`
    * The content of the file `subject_test.txt` is storing in the variable `subject_test`
    * The content of the file `x_test.txt` is storing in the variable `x_test`
    * The content of the file `y_test.txt` is storing in the variable `y_test`
    
    Here is a description of the variables:
    
    |     Varible     |        Dimension        | Description                                                                       |
    | :-------------: | :---------------------: | --------------------------------------------------------------------------------- |
    | features        | 561 rows, 2 columns     | The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. |
    | activity_labels | 6 rows, 2 columns       | Activities performed when measurements were taken with its corresponding ID. |
    | subject_train   | 2947 rows, 1 column     | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. |
    | x_train         | 7342 rows, 561 columns  | Training data of the  recorded features. |
    | y_train         | 7352 rows, 1 column     | Labels of the train data. |
    | subject_test    | 2947 rows, 1 column     | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. |
    | x_test          | 2947 rows, 561 columns  | Test data of the  recorded features. |
    | y_test          | 2947 rows, 1 column     | Labels of the test data. |
    
4. **Merges the training and the test sets to create one data set**\
    * The `rbind()` function is using for merging `x_train` and `x_test` and its result is storing in `x_complete`
    * The `rbind()` function is using for merging `y_train` and `y_test` and its result is storing in `y_complete`
    * The `rbind()` function is using for merging `subject_train` and `subject_test` and its result is storing in `subject_complete`
    * The `cbind()` function is using for merging `subject_complete`, `y_complete` and `x_complete` and its result is storing in `merged_data`
    
    Here is a description of the variables:
    
    |     Varible      |        Dimension        | Description                                                                 |
    | :--------------: | :---------------------: | --------------------------------------------------------------------------- |
    | x_complete       | 10299 rows, 561 columns | Training data and test data of the recorded features.                       |
    | y_complete       | 10299 rows, 1 column    | Labels of the train data and the test data.                                 |
    | subject_complete | 10299 rows, 1 column    | Identifies the subject who performed the activity for each window sample.   |
    | merged_data      | 10299 rows, 563 columns | Collection of training and test data.                                       |
    
5. **Extracts only the measurements on the mean and standard deviation for each measurement**\
The statement `merged_data  %>% select(subject, label, contains("mean"), contains("std"))` selects the columns that corresponding at the measurements on the mean and standard deviation for each measurement. The statement result is storing in `tidy_data`.

    |     Varible      |        Dimension        | Description                                                                 |
    | :--------------: | :---------------------: | --------------------------------------------------------------------------- |
    | tidy_data        | 10299 rows, 88 columns  | Collection of training and test data at the measurements on the mean and standard deviation  for each measurement. |

6. **Uses descriptive activity names to name the activities in the data set**\
All numbers of the second column of `tidy_data` are replacing by their corresponding activity taken from the second column of  `activity_labels `.

7. **Rename the columns to make them representative** \
Some characters from the `names()` of the `tidy_data` are replaced using grep function and regular expressions: 
    * Each `-mean()` in columns' name is replaced by `Mean`.
    * Each `-std()` in columns' name is replaced by `STD`.
    * Each `-freq()` in columns' name is replaced by `Frequency`.
    * Each `Freq` in columns' name is replaced by `Frequency`.
    * Each `Mag` in columns' name is replaced by `Magnitude`.
    * Each `Acc` in columns' name is replaced by `Accelerometer`.
    * Each `Gyro` in columns' name is replaced by `Gyroscope`.
    * Each `BodyBody` in columns' name is replaced by `Body`.
    * Each `angle` in columns' name is replaced by `Angle`.
    * Each `gravity` in columns' name is replaced by `Gravity`.
    * Each `std` in columns' name is replaced by `STD`.
    * Each `mean` in columns' name is replaced by `Mean`.
    * Each `t` at the start in columns' name is replaced by `Time`.
    * Each `f` in columns' name is replaced by `Frequency`.
    * Each `.` in columns' name is removed.
    * The `label` column is renamed to `activities`.

8. **Create a data set with the average of each variable for each activity and each subject**\
The statement `tidy_data_average <- tidy_data %>% group_by(subject, activity) %>% summarise_all(list(mean))` group the data by the subject and the activity and it calculate the average of each variable. The result of the statement is storing in `tidy_data_average`.
    
9. **Save a file with the data final**\
`tidy_data_average` is storing in the `tidy_data_average.txt` file.
 \
 \
 \
    

    
