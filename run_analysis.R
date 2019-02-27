#run_analysis.R
#this script loads the data from the "UCI HAR Dataset" and does the following
#   1)Merges the training and the test sets to create one data set.
#   2)Extracts only the measurements on the mean and standard deviation
#       for each measurement.
#   3)Creates a seperate, tidy dataset with the average of each variable
#       for each activity and each subject.

#Note: "UCI HAR Dataset" has to be in working dir

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
names(fulldata) <- features

#extracting only mean() and std() variables

impNames <- grep("-mean\\(\\)|-std\\(\\)",features)

fulldata <- fulldata[,impNames]

names(fulldata)


#TODO
#rbind subjects and activities then cbind them to the dataset
#replace the activity numbers with the names

# create the transformed dataset with the mean for each sub/act/var
