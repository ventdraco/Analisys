library(dplyr)
filename <- "20Dataset.zip"
##checking if the file already exists, if it doesn't it will download it
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
} 
##unzip the file, if it doesn't exists on the path.
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}
##checking files UCI HAR Dataset
list.files("UCI HAR Dataset", recursive=TRUE)

## reading data
##list of activities 
activity <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE) 
## list of variables for each vector
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE) 
##features_info contain info about features table, not necessary for this assignment
## reading test data
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
lapply(subtest,unique) ## identified unique codes for subject_test table "2"  "4"  "9"  "10" "12" "13" "18" "20" "24"
xtest <- read.table("UCI HAR Dataset/test/x_test.txt", header = FALSE) ## info
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)  ## activity id
lapply(ytest, unique) ##checking unique codes for y_test list was 5 4 6 1 3 2
##reading train data
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
lapply(subtrain,unique) ## identified unique codes for subject_train table 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt", header = FALSE) ## info
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)  ## activity id
lapply(ytrain, unique) ##checking unique codes for y_test list was 5 4 6 1 3 2

library(data.table) ##to use setnames fuction
##Uses descriptive activity names to name the activities in the data set
xtrain <- setnames(xtrain, features[,2])
ytrain <- setnames(ytrain, "activityId")
subtrain <- setnames(subtrain, "SubId")
xtest <- setnames(xtest, features[,2])
ytest <- setnames(ytest, "activityId")
subtest <- setnames(subtest, "SubId")
activity <- setnames(activity, old = c('V1','V2'), new = c('activityId','actName'))

#mergin tables
X <- rbind(xtrain, xtest)
Y <- rbind(ytrain, ytest)
S <- rbind(subtrain, subtest)
mdata <- cbind(S,Y,X)
##replacing the activity ID for the activity Name
mdata$activityId <- activity[mdata$activityId, 2]

##getting mean, std which are required to this assignment
TD <- mdata %>% select(SubId, activityId, contains("Mean"), contains("STD"))

##Using appropriately labels the data set with descriptive variable names
library(mgsub)
names(TD) <- mgsub(names(TD), c("BodyBody", "-mean()", "-std()", "-freq()", "\\()"), c("Body", "Mean","STD","Frequency",""))

## sec tidy data set with the average of each variable for each activity
##In general, the tilde (‘~’) separates the left side of a formula with the right side of the formula.
secTD <- aggregate(. ~ SubId + activityId, TD, mean, na.action=na.pass) 
secTD <- secTD[order(secTD$SubId, secTD$activityId),]
##Generating the txt with the secondary Tidydata
write.table(secTD, "Analysis.txt", row.name=FALSE)
##you can use this to view the table on R
##View(secTD)