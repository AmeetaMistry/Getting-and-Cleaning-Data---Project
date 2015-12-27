##STEP 1
##Read in features (column names for x_train and x_test) and activity_labels (description for activity)
setwd("~/Getting and Cleaning Data/Project")
column_label<-read.table("features.txt")
activity_label<-read.table("activity_labels.txt")


##Read the 3 files associated with training data
setwd("~/Getting and Cleaning Data/Project/train")
y_train<-read.table("y_train.txt")  ##activities file
x_train<-read.table("X_train.txt")  ##readings
subject_train<-read.table("subject_train.txt")  ##subject file


##Read the 3 files associated with test data
setwd("~/Getting and Cleaning Data/Project/test")
y_test<-read.table("y_test.txt")  ##activities file
x_test<-read.table("X_test.txt")  ##readings
subject_test<-read.table("subject_test.txt")  ##subject file


##STEP 2
##Row bind the train and test files for each set 
y_both<-rbind(y_train,y_test)  ##includes both train and test activities
x_both<-rbind(x_train,x_test)  ##includes both train and test measurements
subject_both<-rbind(subject_train,subject_test)  ##includes both train and test subjects


##STEP 3
##Add column names to the x_complete file
colnames(x_both) <- column_label[,2]


##Retain only the columns that have mean or std dev in the column name
logicalvector<- (grepl("-mean()..",column_label[,2]) & !grepl("-meanFreq()..",column_label[,2]) | grepl("-std()..",column_label[,2]) ) 
x_both_retained<-x_both[logicalvector] 


##Replace with column names that are meaningful to the general population
colnames(x_both_retained)<-c("tBodyAcc-mean-X","tBodyAcc-mean-Y","tBodyAcc-mean-Z","tBodyAcc-std-X","tBodyAcc-std-Y","tBodyAcc-std-Z","tGravityAcc-mean-X","tGravityAcc-mean-Y","tGravityAcc-mean-Z",
                            "tGravityAcc-std-X","tGravityAcc-std-Y","tGravityAcc-std-Z","tBodyAccJerk-mean-X","tBodyAccJerk-mean-Y","tBodyAccJerk-mean-Z",                        "tBodyAccJerk-std-X","tBodyAccJerk-std-Y","tBodyAccJerk-std-Z","tBodyGyro-mean-X","tBodyGyro-mean-Y","tBodyGyro-mean-Z","tBodyGyro-std-X",         
                            "tBodyGyro-std-Y","tBodyGyro-std-Z","tBodyGyroJerk-mean-X","tBodyGyroJerk-mean-Y","tBodyGyroJerk-mean-Z","tBodyGyroJerk-std-X","tBodyGyroJerk-std-Y","tBodyGyroJerk-std-Z",      
                            "tBodyAccMag-mean","tBodyAccMag-std","tGravityAccMag-mean","tGravityAccMag-std","tBodyAccJerkMag-mean","tBodyAccJerkMag-std","tBodyGyroMag-mean","tBodyGyroMag-std",         
                            "tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std","fBodyAcc-mean-X","fBodyAcc-mean-Y","fBodyAcc-mean-Z","fBodyAcc-std-X","fBodyAcc-std-Y","fBodyAcc-std-Z",           
                            "fBodyAccJerk-mean-X","fBodyAccJerk-mean-Y","fBodyAccJerk-mean-Z","fBodyAccJerk-std-X","fBodyAccJerk-std-Y","fBodyAccJerk-std-Z","fBodyGyro-mean-X","fBodyGyro-mean-Y",         
                            "fBodyGyro-mean-Z","fBodyGyro-std-X","fBodyGyro-std-Y","fBodyGyro-std-Z","fBodyAccMag-mean","fBodyAccMag-std","fBodyAccJerkMag-mean","fBodyAccJerkMag-std",  
                            "fBodyGyroMag-mean","fBodyGyroMag-std","fBodyGyroJerkMag-mean","fBodyGyroJerkMag-std")
         

##STEP 4         
##Merge the consolidated subjects file, the consolidated activities file and the consolidated readings (limited to 
##mean and standard deviations) file

##First give descriptive column names to both the consolidated subjects
##file and the consolidated activities file
colnames(subject_both)<-"subject"
colnames(y_both)<-"activity"

final_data<-cbind(subject_both,y_both,x_both_retained)

##Replace activity code by activity descripion
colnames(activity_label)<-c("activity","description")

##Add activity description to the final_data
final_data2<-merge(final_data,activity_label,by = "activity", All.final_data = TRUE)
colnames(final_data2)


##STEP 5
##Derive mean for all 66 variables by subject, by activity.  The 66
##variables are in columns 3:68.  Subject is in column 2 and activity 
##description is in column 69
tidyData=aggregate(final_data2[,3:68],by=final_data2[,c(2,69)],mean) 
head(tidyData)


##Create .txt file 
write.table(tidyData,file ="tidyData.txt",row.names=FALSE) 





