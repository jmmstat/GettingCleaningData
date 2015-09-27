## This is the R-code part of the project submission for the class "Getting and Cleaning Data."
## 
## After the data were downloaded and unzipped, they were read into R as numeric data frames 
## with code supplied by R-Studio's "Import Dataset" feature:
##
X_train <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/train/y_train.txt", quote="\"")
X_test <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_train <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/test/subject_test.txt", quote="\"")
##
## In order to avoid possible confusion from the variables in each file named "V1" we rename:
##
  names(y_train) <-"Y"
  names(subject_train) <-"S"
  names(y_test) <-"Y"
  names(subject_test) <-"S"
##
## Next, we code test ("0") or train ("1") into each subject file as a new variable "T"
##
  subject_train$T <- 1L
  subject_test$T <- 0L
##
## Now we can cbind the three train sets and the three test sets and then rbind those together
## to get the total dataset - a dataframe with 10299 obs. of 564 variables
##
  total <- rbind(cbind(X_train,y_train,subject_train),cbind(X_test,y_test,subject_test))
##
## Secondly, we are asked to "extract means and standard deviations" and create a summary set 
## called "meansd" below. We assume that what is wanted are those variables labelled with "mean"
## or "std" - labels found in a file called "features"
##
  features <- read.table("~/Coursera/DataScientist/Course 3/Project/R/UCI HAR Dataset/features.txt", quote="\"",
                       stringsAsFactors=FALSE)
  features <- features[,2]    # Housekeeping chore
##
## We also want to keep the variable containing the activity being engaged in, the subject number,
## and (humor me) whether the subject was in the "test" group or the "train" group.
##
  names(total) <- c(features, "Activity","Subject","Group")
##
## So, the columns (numbers) containing the mean and std (sd, or standard deviation) data are going 
## into a vector called "goodind."  We use one of the oldest of programming tools "grep" to do this
##
  goodind <- grep("mean|std",features,ignore.case=TRUE)
##
## Then, we add the "address" variables (at the left) and create the "meansd" dataset (10299 by 89)
##
  meansd <- total[,c(564:562,goodind)]
##
## Thirdly, we finish off the naming with some factor level labels
##  
  meansd$Group <- factor(meansd$Group,labels = c("Test","Train"))
  meansd$Activity <- factor(meansd$Activity, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
##
##Fourthly, we want to create a tidy data set with only the means for each subject and each activity:
## In order to take advantage of its convenience, we first load the "dplyr" package
##
  library(dplyr)
##
## The specific command we want is the "summarise_each" - which will pull out the column means 
## - after the file has been sorted ("group-by") by subject (with Group) and Activity
##
  meansd <- meansd %>% group_by(Group,Subject,Activity)  %>% summarise_each("mean")
##
## We use write.table() to create the submission file
##
  write.table(meansd,file = "meansd.txt", row.names = FALSE)
