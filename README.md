# 3rd-course-final-project
to launch the program set working directory "UCI HAR Dataset"

First I read data
Then added y and subject files to the main table using cbind()
Then I set names from the file features and then merged test and train tables into one using rbind
Then I took columns with mean and std in their names by grepl
Then I used for loop to set activity names instead of numbers
Then I grouped my table by activity and subject and tookmean for every pair "activity-subject" for each variable
Finnaly I set appropriate names of columns(replaced _-with ., made all letters low, didn't touch () so it was clear which function was used to get a value)
