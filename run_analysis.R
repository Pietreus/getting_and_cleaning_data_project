#run_analysis.R
#this script loads the data from the "UCI HAR Dataset" and does the following
#   1)Merges the training and the test sets to create one data set.
#   2)Extracts only the measurements on the mean and standard deviation
#       for each measurement.
#   3)Creates a seperate, tidy dataset with the average of each variable
#       for each activity and each subject.

#Note: "UCI HAR Dataset" has to be in working dir
library(dplyr)


#TODO filepath variables are useless, combine statements
trainPath <- file.path("UCI HAR Dataset","train","X_train.txt")
trainAct <- file.path("UCI HAR Dataset","train","y_train.txt")
trainSub <- file.path("UCI HAR Dataset","train","subject_train.txt")

testPath <- file.path("UCI HAR Dataset","test","X_test.txt")
testAct <- file.path("UCI HAR Dataset","test","y_test.txt")
testSub <- file.path("UCI HAR Dataset","test","subject_test.txt")

featurePath <- file.path("UCI HAR Dataset","features.txt")


traindata <- read.table(trainPath)
testdata <- read.table(testPath)
features <- read.table(featurePath)[,2]

fulldata <- rbind(traindata,testdata)
activities <- rbind(read.table(trainAct),read.table(testAct))
activitylabels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt"))
actLabeled <- merge(activities,activitylabels)[,2]
subjects <- rbind(read.table(trainSub),read.table(testSub))
names(fulldata) <- features

#extracting only mean() and std() variables

impNames <- grep("-mean\\(\\)|-std\\(\\)",features)

dataTbl <- tbl_df(fulldata[,impNames])
#Table required in Step 4 of the assignment
fullTbl <- mutate(dataTbl, Activity = actLabeled)


#TODO
#Variable names may be too ambiguous -- fix with regex
#create the transformed dataset with the mean for each sub/act/var
#for loops for subjects and activities -> calc mean for each variable
#better: group and take mean per group

transformedTbl <- fullTbl %>% mutate( subjectID = subjects[,1]) %>%
                              group_by(subjectID, Activity) %>%
                              summarise_all(list(mean)) %>%
                              ungroup()


