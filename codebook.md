# Code Book

This document describes the variables, data, transformations performaned and other functioning of
run_analysis.R


run_analysis.R consumes data from the UCIHAR Dataset[1] and processes it (details below). For the purpose of this exercise, the input file has been downloaded, unzipped and is read locally. The R programm  can be run as long as the downloaded and unzipped data is in your working directory. 


##Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

###Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


   
   
   
## Library dependencies : plyr, reshape2 
###Start of Part 1 :Merge the training and the test sets to create one data set.

####Reading all the necessary files using read.table,
- as training/test data have no header files, we make  header = FALSE
- neccesary column header for test/train data is in features.txt
- activity type used for labelling data is in activity_labels.txt
- we read activity labels for training data and test data
- information about 30 volunteer is read for both training and test data from subject_train.txt
and subject_test.txt

write.table may generate list objects which gives duplicate rowname error. 
so tables need to be unlist() after reading them.

#### merge data sets
- merge train and test data
- adding a new column'acitivity.ID','subject.ID' in training and test datasets to  track activity,subject label.
- assigned column names to the train/test data set based on featured variables
- I use rbind to merge training and test dataset into one data set


<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Sep 21 07:42:08 2014 -->
<TABLE border=1>
<CAPTION ALIGN="bottom"> merged sample </CAPTION>
<TR> <TH>  </TH> <TH> tBodyAcc.mean...X </TH> <TH> tBodyAcc.mean...Y </TH> <TH> tBodyAcc.mean...Z </TH> <TH> tBodyAcc.std...X </TH> <TH> tBodyAcc.std...Y </TH> <TH> activity.ID </TH> <TH> subject.ID </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD align="right"> 0.26 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.01 </TD> <TD align="right"> -0.94 </TD> <TD align="right"> -0.92 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right"> 0.29 </TD> <TD align="right"> -0.01 </TD> <TD align="right"> -0.12 </TD> <TD align="right"> -0.98 </TD> <TD align="right"> -0.97 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.03 </TD> <TD align="right"> -0.12 </TD> <TD align="right"> -0.99 </TD> <TD align="right"> -0.97 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right"> 0.27 </TD> <TD align="right"> -0.03 </TD> <TD align="right"> -0.12 </TD> <TD align="right"> -0.99 </TD> <TD align="right"> -0.97 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD align="right"> 0.27 </TD> <TD align="right"> -0.03 </TD> <TD align="right"> -0.13 </TD> <TD align="right"> -0.99 </TD> <TD align="right"> -0.97 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> <TD align="right"> -0.99 </TD> <TD align="right"> -0.97 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> </TR>
   </TABLE>


#### Extract measurements on the mean and standard deviation for each measurement
- grepl on column names to extract mean and std on each measurement 
- grepl is used with fixed = TRUE so that R compiler knows  pattern is a string to be matched as is
- I also add activity ID and subject ID as the first two columns of the dataframe.    




<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Sep 21 07:42:08 2014 -->
<TABLE border=1>
<CAPTION ALIGN="bottom"> merged sample mean and std </CAPTION>
<TR> <TH>  </TH> <TH> activity.ID </TH> <TH> subject.ID </TH> <TH> tBodyAcc.mean...X </TH> <TH> tBodyAcc.mean...Y </TH> <TH> tBodyAcc.mean...Z </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.26 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.01 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.29 </TD> <TD align="right"> -0.01 </TD> <TD align="right"> -0.12 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.03 </TD> <TD align="right"> -0.12 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.27 </TD> <TD align="right"> -0.03 </TD> <TD align="right"> -0.12 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.27 </TD> <TD align="right"> -0.03 </TD> <TD align="right"> -0.13 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD align="right">   5 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> </TR>
   </TABLE>

#### descriptive activity names to name the activities in the data set
- I combine actictiy lavel as a factor to the dataset of part 2
- reorder the columns only to make sure that activity label, activity ID and subject ID are the three columns of the dataframe.    
- sort dataset by activity ID



<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Sep 21 07:42:08 2014 -->
<TABLE border=1>
<CAPTION ALIGN="bottom"> merged sample mean, std with actitivy labels </CAPTION>
<TR> <TH>  </TH> <TH> activity.name </TH> <TH> activity.ID </TH> <TH> subject.ID </TH> <TH> tBodyAcc.mean...X </TH> <TH> tBodyAcc.mean...Y </TH>  </TR>
  <TR> <TD align="right"> 80 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.20 </TD> <TD align="right"> -0.03 </TD> </TR>
  <TR> <TD align="right"> 81 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.25 </TD> <TD align="right"> -0.00 </TD> </TR>
  <TR> <TD align="right"> 82 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.33 </TD> <TD align="right"> -0.03 </TD> </TR>
  <TR> <TD align="right"> 83 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.31 </TD> <TD align="right"> -0.02 </TD> </TR>
  <TR> <TD align="right"> 84 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.27 </TD> <TD align="right"> -0.02 </TD> </TR>
  <TR> <TD align="right"> 85 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.19 </TD> <TD align="right"> -0.01 </TD> </TR>
   </TABLE>
####Appropriately labels the data set with descriptive variable names
- I already assigned column names to the variables based on features in part I
- because of special character a call to a particular column:merged.dataset.mean.std$tBodyAcc-mean()-X
in console with show error.
- Therefore, I prefer to replace () with "" and "-" with "_"
- I also clean up other variable definition, such as BodyBody to Body






<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Sep 21 07:42:08 2014 -->
<TABLE border=1>
<CAPTION ALIGN="bottom"> merged sample mean, std with actitivy labels and features variable </CAPTION>
<TR> <TH>  </TH> <TH> activity.name </TH> <TH> activity.ID </TH> <TH> subject.ID </TH> <TH> tBodyAcc_mean_X </TH> <TH> tBodyAcc_mean_Y </TH>  </TR>
  <TR> <TD align="right"> 80 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.20 </TD> <TD align="right"> -0.03 </TD> </TR>
  <TR> <TD align="right"> 81 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.25 </TD> <TD align="right"> -0.00 </TD> </TR>
  <TR> <TD align="right"> 82 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.33 </TD> <TD align="right"> -0.03 </TD> </TR>
  <TR> <TD align="right"> 83 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.31 </TD> <TD align="right"> -0.02 </TD> </TR>
  <TR> <TD align="right"> 84 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.27 </TD> <TD align="right"> -0.02 </TD> </TR>
  <TR> <TD align="right"> 85 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right">   2 </TD> <TD align="right"> 0.19 </TD> <TD align="right"> -0.01 </TD> </TR>
   </TABLE>
####creating a tidy data set with the average of each variable for each activity and each subject.
- there are 30 subjects and 6 activities, a correct 'tidy data' should have 180 rows
- first I melt the dataframe by idvars activity IDs, activity name and subject IDs 
- Then use dcast to convert this moltebn dataframe into a dataframe with mean values
- I also take out acitivity ID and I keep activity name and subject ID in the tidydata




<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Sep 21 07:42:11 2014 -->
<TABLE border=1>
<CAPTION ALIGN="bottom"> tidy dataset </CAPTION>
<TR> <TH>  </TH> <TH> activity.name </TH> <TH> subject.ID </TH> <TH> tBodyAcc_mean_X </TH> <TH> tBodyAcc_mean_Y </TH> <TH> tBodyAcc_mean_Z </TH>  </TR>
  <TR> <TD align="right"> 91 </TD> <TD> WALKING </TD> <TD align="right">   1 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> </TR>
  <TR> <TD align="right"> 92 </TD> <TD> WALKING </TD> <TD align="right">   2 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> </TR>
  <TR> <TD align="right"> 93 </TD> <TD> WALKING </TD> <TD align="right">   3 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> </TR>
  <TR> <TD align="right"> 94 </TD> <TD> WALKING </TD> <TD align="right">   4 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.01 </TD> <TD align="right"> -0.11 </TD> </TR>
  <TR> <TD align="right"> 95 </TD> <TD> WALKING </TD> <TD align="right">   5 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> </TR>
  <TR> <TD align="right"> 96 </TD> <TD> WALKING </TD> <TD align="right">   6 </TD> <TD align="right"> 0.28 </TD> <TD align="right"> -0.02 </TD> <TD align="right"> -0.11 </TD> </TR>
   </TABLE>

  
  [1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
