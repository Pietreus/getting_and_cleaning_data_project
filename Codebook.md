# This Codebook contains informations about the Dataset created by "run_analysis.R"  
### Additional information about the the source dataset for this analysis can be in "UCI HAR Dataset/README.txt"  

## The Source Dataset

The "UCI Human Activity Recognition Using Smartphones Dataset" contains smartphone measurements  
of people performing various tasks. Each record provides a vector of features/measurements, the activity label and a subject ID  

## The Analysis

The data from training and test sets of the dataset was combined and the the features  
containing means or standard deviations of measurements were extracted.  
For each subject and each activity, the mean of all records was taken to  
provide one row per subject/activity combination.  

## Objects created by "run_analysis.R"

the script reads the various parts of the dataset into R variables  
the following objects contain unchanged data of one/multiple files of the dataset.  

* traindata:	feature values of the training set  
* testdata:	feature values of the test set  
* fulldata:	combined feature values, first train-, then testdata  

* traindAct:	activity values of the training set  
* testAct:	activity values of the test set
* activities:	combined values, first train-, then testactivities

* activitylabels:	the labels for each of the activity values

* actLabeled:	the activities of the datasets (in order) with the numeric value replaced for the label

* trainSub:	subject id of the training set
* testSub:	subject id of the test set
* subjects:	combined subject ids, first train-, then test-ids

* impNames:	important variable names of the feature vector
		only features describing mean or std measurements were needed for this assignment  
		the names for the features were read from "features.txt"  
		and the required names were selected via regEx (grep function)  

* dataTbl	a dplyr table with the in impNames contained variables of fulldata
		additionally the activity is provided in this table
		the variable names have been manipulated to extract special characters

* transformedTbl	a dpylr table containing the means for all variables in dataTbl for each  
			combination of subject and activity

## The variables in the transformedTbl Object

Column| Name|			Datatype|	Range|									Desciption  
---|---|---|---|---
1|	subjectid|		*int*|		[1,30]|									the identifier for each subject  
2|	activity|		*fct*|		LAYING,<br>SITTING,<br>STANDING,<br>WALKING,<br>WALKING_DOWNSTAIRS,<br>WALKING_UPSTAIRS|	the label of the performed activity  
3-68|	*eg:* fbodyaccstdz|	*dbl*|		[-1,1]|									the means of the original records for each subject/activity combination<br>names starting with "t" are time domain and "f" are frequency domain variables<br>x,y,z at the end of the name describes the gyrocopic axis<br>mean,std define if the variable contains the mean or standard deviation of the measurement<br>additional parts like acc/gyro explain the nature of the measurement itself<br>
														
