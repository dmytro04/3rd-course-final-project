setwd("train")   #to launch the program set working directory "UCI HAR Dataset"
subject_train<-read.table("subject_train.txt")
y_train<-read.table("y_train.txt")              
X_train<-read.table("X_train.txt")
setwd("..")
features<-read.table("features.txt")            #reading files
setwd("test")
subject_test<-read.table("subject_test.txt")
y_test<-read.table("y_test.txt")
X_test<-read.table("X_test.txt")

X_train<-cbind(X_train,y_train=y_train, subject_train=subject_train)   #adding y and subject files to the main table
X_test<-cbind(X_test,y_test=y_test, subject_test=subject_test)

X_train<-setNames(X_train, c(as.vector(features$V2),"y","subject"))  #setting names from the file features
X_test<-setNames(X_test, c(as.vector(features$V2),"y","subject"))    #and then merging test and train tables into one
mergeddata<-rbind(X_test,X_train)

remove(X_test, X_train)      #removing large datasets, which aren't needed anymore

means_and_stds<-grepl("std|mean",colnames(mergeddata))   #taking columns with mean and st
means_and_stds[562:563]<-c(T,T)                 #leaving y and subject columns
mergeddata<-mergeddata[,means_and_stds]

setwd("..")
activity_labels<-read.table("activity_labels.txt")
for(i in 1:nrow(mergeddata)) {       # for-loop over rows
      a<-mergeddata[i,80]
      mergeddata[i,80]<-activity_labels[a,2]          #setting activity names instead of numbers
}


grouped_data<-group_by(mergeddata,y,subject)          #grouping by activity and subject
grouped_data<-summarise(grouped_data,across((1:79),mean))   #taking mean for every pair "activity-subject"


colnames(grouped_data)[which(names(grouped_data) == "y")] <- "activity"
all_names<-list()
for(i in 1:ncol(grouped_data)) {
      name_of_column<-colnames(grouped_data[,i])
      name_of_column<-gsub("_",".",name_of_column)        #setting appropriate names of columns
      name_of_column<-gsub("-",".",name_of_column)
      name_of_column<-tolower(name_of_column)
      all_names[i]<-name_of_column
}
colnames(grouped_data)<- all_names

