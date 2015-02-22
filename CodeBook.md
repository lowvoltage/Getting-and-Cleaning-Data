Raw Data - Numeric
--------

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

Raw Data - Factors
--------
External to the numeric data, the activity codes and subject ID for each observation are available, in separate files. Activty codes table:
<pre>
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING 
</pre>

Raw Data to Intermediate Format
-------
This is the bulk of the data cleanup and processing. The external activity & subject tables are merged to the test & training set using cbind(). Then the test & training sets are merged using rbind(). The resulting data set has 563 columns (561 measurements + activity + subject)

As a next step, the measurements' columns are filtered and only those that contain "-std()" or "-mean()" are preserved. There are 66 of these columns. Proper names are set to the "Activity" and "Subject" columns.

Then a text-based processing is performed on the column names, to make them tidy. All names are converted to CamelCase, and the following substitutions are executed (regular expression notation is used):

* "^t" --> "Time"
* "^f" --> "Freq"
* "\\-" --> "" (i.e. dashes are removed)

As specified in step 3), the values in the "Activity" column are converted from integers in 1:6 to factors from the table above


Intermediate Format
----
The intermediate data set is a tidy data set with 68 columns:
<pre>
 [1] "TimeBodyAccMeanX"        "TimeBodyAccMeanY"        "TimeBodyAccMeanZ"        "TimeBodyAccStdX"        
 [5] "TimeBodyAccStdY"         "TimeBodyAccStdZ"         "TimeGravityAccMeanX"     "TimeGravityAccMeanY"    
 [9] "TimeGravityAccMeanZ"     "TimeGravityAccStdX"      "TimeGravityAccStdY"      "TimeGravityAccStdZ"     
[13] "TimeBodyAccJerkMeanX"    "TimeBodyAccJerkMeanY"    "TimeBodyAccJerkMeanZ"    "TimeBodyAccJerkStdX"    
[17] "TimeBodyAccJerkStdY"     "TimeBodyAccJerkStdZ"     "TimeBodyGyroMeanX"       "TimeBodyGyroMeanY"      
[21] "TimeBodyGyroMeanZ"       "TimeBodyGyroStdX"        "TimeBodyGyroStdY"        "TimeBodyGyroStdZ"       
[25] "TimeBodyGyroJerkMeanX"   "TimeBodyGyroJerkMeanY"   "TimeBodyGyroJerkMeanZ"   "TimeBodyGyroJerkStdX"   
[29] "TimeBodyGyroJerkStdY"    "TimeBodyGyroJerkStdZ"    "TimeBodyAccMagMean"      "TimeBodyAccMagStd"      
[33] "TimeGravityAccMagMean"   "TimeGravityAccMagStd"    "TimeBodyAccJerkMagMean"  "TimeBodyAccJerkMagStd"  
[37] "TimeBodyGyroMagMean"     "TimeBodyGyroMagStd"      "TimeBodyGyroJerkMagMean" "TimeBodyGyroJerkMagStd" 
[41] "FreqBodyAccMeanX"        "FreqBodyAccMeanY"        "FreqBodyAccMeanZ"        "FreqBodyAccStdX"        
[45] "FreqBodyAccStdY"         "FreqBodyAccStdZ"         "FreqBodyAccJerkMeanX"    "FreqBodyAccJerkMeanY"   
[49] "FreqBodyAccJerkMeanZ"    "FreqBodyAccJerkStdX"     "FreqBodyAccJerkStdY"     "FreqBodyAccJerkStdZ"    
[53] "FreqBodyGyroMeanX"       "FreqBodyGyroMeanY"       "FreqBodyGyroMeanZ"       "FreqBodyGyroStdX"       
[57] "FreqBodyGyroStdY"        "FreqBodyGyroStdZ"        "FreqBodyAccMagMean"      "FreqBodyAccMagStd"      
[61] "FreqBodyAccJerkMagMean"  "FreqBodyAccJerkMagStd"   "FreqBodyGyroMagMean"     "FreqBodyGyroMagStd"     
[65] "FreqBodyGyroJerkMagMean" "FreqBodyGyroJerkMagStd"  "Subject"                 "Activity"          
</pre>
Column #1 ~ #66:

* Column name: Composite, CamelCase
* Description: Contains the measured value, as specified the original code-book
* Data class: Numeric
* Data range: Normalized to [-1.0, 1.0]
* Data unit: None

Column #67:

* Column name: "Subject"
* Description: An identifier of the subject who carried out the experiment
* Data class: Integer
* Data range: 1 to 30
* Data unit: None

Column #68:

* Column name: "Activity"
* Description: The activity label for the observation
* Data class: Factor
* Data range: One of: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
* Data unit: None

Intermediate Format to Output Format
-------
The intermediate data set is melted, based on the "Subject" and "Activity" columns. It is then summarized, to get the average of each measurement

Output Format
-------------
The output data set is a tidy data set with 4 columns:
Column #1:

* Column name: "Subject"
* Description: An identifier of the subject who carried out the experiment
* Data class: Integer
* Data range: 1 to 30
* Data unit: None

Column #2:

* Column name: "Activity"
* Description: The activity label for the observation
* Data class: Factor
* Data range: One of: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
* Data unit: None

Column #3:

* Column name: "Measurement"
* Description: Name of the measurement being observed
* Data class: Factor
* Data range: One of the column names for columns #1 ~ #66 of the intermediate format
* Data unit: None

Column #4:

* Column name: "Average"
* Description: Averaged value of the measurement, for the given subject and activity
* Data class: Numeric
* Data range: [-1.0, 1.0]
* Data unit: None
