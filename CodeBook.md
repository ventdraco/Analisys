
1. DOWNLOAD AND OPEN FILES FROM ZIP FOR ANALYSIS

filename <- "20Dataset.zip" Contain all the information from the URL "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 which was opened on the file called "UCI HAR Dataset"
 

2. READ DATA,  ANALYSE DATA AND ASSIGN EACH TABLE TO VARIABLES

2.1 LABELS
activity = activity_labels.txt 'data.frame': 6 obs. of 2 variables: list of variables for each vector
features = features.txt 'data.frame': 561 obs. of  2 variables: name for each columns on the info table for test and train.

2.2 SUBJECTS TOTAL OF 30 
subtest = subject_test.txt 'data.frame': 2947 obs. of 1 variable:
subtrain = subject_train.txt 'data.frame': 7352 obs. of 1 variable:

2.3 INFORMATION FOR EACH SUBJECT 
xtest = x_test.txt 'data.frame': 2947 obs. of 561 variables:
xtrain = x_train.txt 'data.frame': 7352 obs. of 561 variables:

2.4 ACTIVITIES ID PER SUBJECT
ytest = y_test.txt 'data.frame': 2947 obs. of 1 variable:
ytrain = y_train.txt 'data.frame': 7352 obs. of 1 variables:


3. ADDING COLUMNS NAMES TO EACH VARIABLE

library(data.table) 
Uses descriptive activity names to name the activities in the data set
SETNAME()

4. MERGE DATA 

X 'data.frame':	10299 obs. of 561 variables = xtrain and xtest
Y 'data.frame':	10299 obs. of 1 variable = ytrain and ytest
S 'data.frame':	10299 obs. of 1 variable = subtrain and subtest
mdata 'data.frame': 10299 obs. of 563 variables = S,Y and X

5. LABEL ACTIVITY NAME 
mdata$activityId chr [1:10299] = table activity second column when it match with by column activityId

6. Getting mean, std for subject ID and Activity
TD 'data.frame': 10299 obs. of 88 variables = Columns in mdata table called SubId, activityId all columns which contains either Mean or STD

7. USING APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
USED library 'mgsub'

Modify all names in TD when
"BodyBody" = "Body"
"-mean()" = "Mean"
"-std()" = "STD"
"-freq()" = "Frequency"
"\\()" = ""

8. CREATE SECONDARY TIDY DATA SET

secTD 'data.frame': 180 obs. of 88 variables = Average of all columns with out SubId and activityId excluding all "NA" and ordered by SubId and activityId
