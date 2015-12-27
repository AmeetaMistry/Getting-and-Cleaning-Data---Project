# Getting-and-Cleaning-Data---Project

##STEP 1
This step consists of downloading and reading into R the features.txt and activity_labels.txt files from where the column headings and activity descriptions will be derived.  It also includes downloading the 3 train files and 3 test files consisting of subject, activity and readings each.

##STEP 2
In this step the train and test files are merged to create a single set for each of the 3 files.

##STEP 3
Column operations: In this step the 561 column names are derived from the features.txt file and only columns pertaining to mean and standard deviation measurements are retained.  The column names are also changed for easier understanding.

##STEP 4
The 3 consolidated files are merged.  Code for activity is replaced with description.

##STEP 5
tidyData is generated and written.
