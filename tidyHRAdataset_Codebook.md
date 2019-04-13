tidyHRAdataset Codebook
================

tidydataset.csv

subjectID integer range 1:30 - identifies the subject that performed the experiment.

activityLabel 1 of 6 values - 1 WALKING, 2 WALKING\_UPSTAIRS, 3 WALKING\_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING

Next set of 79 columns are the mean and std feature vectors extracted from the original dataset. All features are normalized and bounded within \[-1,1\]

\[1\] "1 tBodyAcc-mean()-X" "2 tBodyAcc-mean()-Y" "3 tBodyAcc-mean()-Z"
\[4\] "4 tBodyAcc-std()-X" "5 tBodyAcc-std()-Y" "6 tBodyAcc-std()-Z"
\[7\] "41 tGravityAcc-mean()-X" "42 tGravityAcc-mean()-Y" "43 tGravityAcc-mean()-Z"
\[10\] "44 tGravityAcc-std()-X" "45 tGravityAcc-std()-Y" "46 tGravityAcc-std()-Z"
\[13\] "81 tBodyAccJerk-mean()-X" "82 tBodyAccJerk-mean()-Y" "83 tBodyAccJerk-mean()-Z"
\[16\] "84 tBodyAccJerk-std()-X" "85 tBodyAccJerk-std()-Y" "86 tBodyAccJerk-std()-Z"
\[19\] "121 tBodyGyro-mean()-X" "122 tBodyGyro-mean()-Y" "123 tBodyGyro-mean()-Z"
\[22\] "124 tBodyGyro-std()-X" "125 tBodyGyro-std()-Y" "126 tBodyGyro-std()-Z"
\[25\] "161 tBodyGyroJerk-mean()-X" "162 tBodyGyroJerk-mean()-Y" "163 tBodyGyroJerk-mean()-Z"
\[28\] "164 tBodyGyroJerk-std()-X" "165 tBodyGyroJerk-std()-Y" "166 tBodyGyroJerk-std()-Z"
\[31\] "201 tBodyAccMag-mean()" "202 tBodyAccMag-std()" "214 tGravityAccMag-mean()"
\[34\] "215 tGravityAccMag-std()" "227 tBodyAccJerkMag-mean()" "228 tBodyAccJerkMag-std()"
\[37\] "240 tBodyGyroMag-mean()" "241 tBodyGyroMag-std()" "253 tBodyGyroJerkMag-mean()"
\[40\] "254 tBodyGyroJerkMag-std()" "266 fBodyAcc-mean()-X" "267 fBodyAcc-mean()-Y"
\[43\] "268 fBodyAcc-mean()-Z" "269 fBodyAcc-std()-X" "270 fBodyAcc-std()-Y"
\[46\] "271 fBodyAcc-std()-Z" "294 fBodyAcc-meanFreq()-X" "295 fBodyAcc-meanFreq()-Y"
\[49\] "296 fBodyAcc-meanFreq()-Z" "345 fBodyAccJerk-mean()-X" "346 fBodyAccJerk-mean()-Y"
\[52\] "347 fBodyAccJerk-mean()-Z" "348 fBodyAccJerk-std()-X" "349 fBodyAccJerk-std()-Y"
\[55\] "350 fBodyAccJerk-std()-Z" "373 fBodyAccJerk-meanFreq()-X" "374 fBodyAccJerk-meanFreq()-Y"
\[58\] "375 fBodyAccJerk-meanFreq()-Z" "424 fBodyGyro-mean()-X" "425 fBodyGyro-mean()-Y"
\[61\] "426 fBodyGyro-mean()-Z" "427 fBodyGyro-std()-X" "428 fBodyGyro-std()-Y"
\[64\] "429 fBodyGyro-std()-Z" "452 fBodyGyro-meanFreq()-X" "453 fBodyGyro-meanFreq()-Y"
\[67\] "454 fBodyGyro-meanFreq()-Z" "503 fBodyAccMag-mean()" "504 fBodyAccMag-std()"
\[70\] "513 fBodyAccMag-meanFreq()" "516 fBodyBodyAccJerkMag-mean()" "517 fBodyBodyAccJerkMag-std()"
\[73\] "526 fBodyBodyAccJerkMag-meanFreq()" "529 fBodyBodyGyroMag-mean()" "530 fBodyBodyGyroMag-std()"
\[76\] "539 fBodyBodyGyroMag-meanFreq()" "542 fBodyBodyGyroJerkMag-mean()" "543 fBodyBodyGyroJerkMag-std()"
\[79\] "552 fBodyBodyGyroJerkMag-meanFreq()"

Transformations
---------------

Read the activity labels and feature labels from the corresponding supporting files

``` r
#Read metadata
activity_labels <- read.delim(file = "activity_labels.txt",header = FALSE) #Reads the activity labels
feature_labels <- read.delim(file = "features.txt",header = FALSE) #Reads the measurement feature labels
```

Identifies features that are mean or std calculations only

``` r
#Find the features that are mean or std calculations on the measurements.
filter<-grep("-(mean|std)",feature_labels$V1)  
#grep("-(mean|std)",feature_labels$V1,value=TRUE) #Uncomment this line to inspect which features are mean or std. 
```

Reads the feature data and activity from the training and test files

``` r
#Read the training dataset
setwd("./train")
train_subject_data <- read.delim(file = "subject_train.txt",header=FALSE,col.names = "subjectID") #Subject Identifier
train_x_data<-read.delim(file = "X_train.txt",header=FALSE,sep="") #Feature Vector Data 
train_y_data<-read.delim(file = "y_train.txt",header=FALSE,col.names = "activityLabel") #Activity Identifier
setwd("..")

#Read the test dataset
setwd("./test")
test_subject_data <- read.delim(file = "subject_test.txt",header=FALSE,col.names = "subjectID") #subject identifier
test_x_data<-read.delim(file = "X_test.txt",header = FALSE,sep = "") #feature vector data
test_y_data<-read.delim(file = "y_test.txt",header=FALSE,col.names = "activityLabel") # activity identifier
```

Combines the training and test data for the subjects, feature data, and activity

``` r
#Merge the traing and test datasets
combine_subject <-rbind(train_subject_data,test_subject_data) #merge the subject identifer data
combine_y_data <-rbind(train_y_data,test_y_data) #merge the activity identifier data
activityLabel <-factor(combine_y_data$activityLabel) 
levels(activityLabel) <- activity_labels$V1 #replace activity values with descriptive activity labels
combine_y_data3 <-as.data.frame(activityLabel) 
combine_x_data <-rbind(train_x_data,test_x_data) #merge the feature vector data
```

Keep only the mean and stdev features in the dataset

``` r
#Extract the mean and standard deviation for each measurement.
combine_x_data <-combine_x_data[,filter]
names(combine_x_data)<-grep("-(mean|std)",feature_labels$V1,value=TRUE) #apply the feature names as column labels
```

Applying descriptive names to the columns of the dataset

``` r
#renaming variables with descriptive names
test_subjects <-combine_subject
test_subjects$Obs <- seq.int(nrow(test_subjects))
test_activity <-combine_y_data3
test_activity$Obs <-seq.int(nrow(test_activity))
test_featuredata <- combine_x_data
test_featuredata$Obs <- seq.int(nrow(test_featuredata))
```

Combine the individual dataframes into one dataset

``` r
#Combine the variables into one dataframe
library(plyr)
dfList=list(test_subjects,test_activity,test_featuredata)
dataset<-join_all(dfList)
dataset$Obs <- NULL
head(dataset) #display the first five rows of the dataset
tail(dataset) #display the last five rows of the dataset
```

Writes the tidydataset as a csv file

``` r
setwd(filepath)
write.csv(dataset, file = "tidyHRAdataset.csv")
```

Additional processing to calculate the average of each mean, std feature across combination of activity and subject

``` r
#Calculate a dataset of average of each feature vector grouped by activity and subject
library(dplyr)
dataset2 <- dataset %>% 
        group_by(activityLabel,subjectID) %>%
        summarise_all(mean)

setwd(filepath)
write.csv(dataset2, file = "tidy2HRAdataset.csv")
```
