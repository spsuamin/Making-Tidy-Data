#Ask user to select the directory containing the UCH HAR Dataset
filepath <- if (interactive())
        choose.dir(getwd(),"Select the root UCI HAR Dataset Folder")

setwd(filepath)

#Read metadata
activity_labels <- read.delim(file = "activity_labels.txt",header = FALSE) #Reads the activity labels
feature_labels <- read.delim(file = "features.txt",header = FALSE) #Reads the measurement feature labels

#Find the features that are mean or std calculations on the measurements.
filter<-grep("-(mean|std)",feature_labels$V1)  
#grep("-(mean|std)",feature_labels$V1,value=TRUE) #Uncomment this line to inspect which features are mean or std. 

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

#Merge the traing and test datasets
combine_subject <-rbind(train_subject_data,test_subject_data) #merge the subject identifer data
combine_y_data <-rbind(train_y_data,test_y_data) #merge the activity identifier data
activityLabel <-factor(combine_y_data$activityLabel) 
levels(activityLabel) <- activity_labels$V1 #replace activity values with descriptive activity labels
combine_y_data3 <-as.data.frame(activityLabel) 
combine_x_data <-rbind(train_x_data,test_x_data) #merge the feature vector data
 
#Extract the mean and standard deviation for each measurement.
combine_x_data <-combine_x_data[,filter]
names(combine_x_data)<-grep("-(mean|std)",feature_labels$V1,value=TRUE) #apply the feature names as column labels

#renaming variables with descriptive names
test_subjects <-combine_subject
test_subjects$Obs <- seq.int(nrow(test_subjects))
test_activity <-combine_y_data3
test_activity$Obs <-seq.int(nrow(test_activity))
test_featuredata <- combine_x_data
test_featuredata$Obs <- seq.int(nrow(test_featuredata))

#Combine the variables into one dataframe
library(plyr)
dfList=list(test_subjects,test_activity,test_featuredata)
dataset<-join_all(dfList)
dataset$Obs <- NULL
head(dataset) #display the first five rows of the dataset
tail(dataset) #display the last five rows of the dataset


setwd(filepath)
write.csv(dataset, file = "tidyHRAdataset.csv")


#Calculate a dataset of average of each feature vector grouped by activity and subject
library(dplyr)
dataset2 <- dataset %>% 
        group_by(activityLabel,subjectID) %>%
        summarise_all(mean)

setwd(filepath)
write.csv(dataset2, file = "tidy2HRAdataset.csv")