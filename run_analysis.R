#run_analysis.R
#this script loads the data from the "UCI HAR Dataset" and does the following
#   1)Merges the training and the test sets to create one data set.
#   2)Extracts only the measurements on the mean and standard deviation
#       for each measurement.
#   3)Creates a seperate, tidy dataset with the average of each variable
#       for each activity and each subject.

#Note: "UCI HAR Dataset" has to be in working dir
require(dplyr)

#reading data from various files
traindata <- read.table(file.path("UCI HAR Dataset","train","X_train.txt"))
trainAct <- read.table(file.path("UCI HAR Dataset","train","y_train.txt"))
trainSub <- read.table(file.path("UCI HAR Dataset","train","subject_train.txt"))

testdata <- read.table(file.path("UCI HAR Dataset","test","X_test.txt"))
testAct <- read.table(file.path("UCI HAR Dataset","test","y_test.txt"))
testSub <- read.table(file.path("UCI HAR Dataset","test","subject_test.txt"))

fulldata <- rbind(traindata,testdata)
activities <- rbind(trainAct, testAct)
activitylabels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt"))

#joining activities and labels without messing with the row-order of activities
actLabeled <- left_join(activities, activitylabels, by = "V1")[,2]
subjects <- rbind(trainSub, testSub)
#reading the original variable names
names(fulldata) <- read.table(file.path("UCI HAR Dataset","features.txt"))[,2]

#extracting only mean() and std() variables and adapting variable names

impNames <- grep("-mean\\(\\)|-std\\(\\)", names(fulldata))
dataTbl <- tbl_df(fulldata[,impNames])
#manipulating the names 
names(dataTbl) <- tolower(gsub("\\(\\)|-","",names(dataTbl)))

#the Table required in Step 4 of the assignment
fullTbl <- mutate(dataTbl, Activity = actLabeled)


#adding the subject column, grouping by subject/activity
#and take the mean for each column per group
#the tidy dataset, as requested in the assignment
transformedTbl <- fullTbl %>% mutate( subjectID = subjects[,1]) %>%
                              group_by(subjectID, Activity) %>%
                              summarise_all(list(mean)) %>%
                              ungroup()


