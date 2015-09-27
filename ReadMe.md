## This is a markdown file.

This folder contains three files:

1. "run_analysis.R" - which contains the R script,
2. "README.md" - this file,
3. "Code Book" - which contains a detailed description of the variables in the dataset analyzed in this study.

The R script has five sections:
1. The data from the web site for the study are assumed to be downloaded and avaiable for reading into R.


 The data are from:
 Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
 A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
 21th European Symposium on Artificial Neural Networks, Computational Intelligence and 
 Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
 
 This dataset specifically is acknowledged as from
 Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
 Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
 Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
 Vitoria-Gasteiz, Spain. Dec 2012

The six data  sets are read into R using read.table (utilizing R-Studio's "Import Dataset" feature).
Next, a dummy variable indicating membership in either the "train" or "test" groups are created (it is assumed to be of importance since that's how the data are filed). And, certain repeated column names are disambiguated (creating variable T, S and Y - later name "Group", "Subject"" and "Activity")

Finally, the data sets for train and test are combined.

2. Next, we find the variables representing means ("mean") and standard deviation ("sd") are located and kept, eliminating all others.

3. We finish off the variable naming.

4. We dreate the tidy data set using the "dplyr" package.

5. We write the finished dataset ("meansd.txt") using the "write.table" function.