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
unique(subtest, incomparables = FALSE) ## identified unique codes for subject_test table [1] "2"  "4"  "9"  "10" "12" "13" "18" "20" "24"


