#This script assumes you have UCR HAR Dataset/ in the working directory.



#Function to pull in a subset of mean() and std() observations
import_subset <- function (obsfile) {
  #Slurp in observation names
  obnames.df <- data.frame(read.table('UCI HAR Dataset/features.txt'))
  index.wanted <- grep('mean|std',obnames.df[,2])
  names.wanted <- grep('mean|std',obnames.df[,2], value=TRUE)
  
  #Grab in the observation data frame
  df <- data.frame(read.table(obsfile))
  
  # Subset with the index
  df.meanstd <- df[,index.wanted]
  colnames(df.meanstd) <- names.wanted
  
  
  return(df.meanstd)
}

# Function to append tasks and people, make tasks human readable
append_taskspeople <- function (obsdf, yfile, subject_file) {
  df <- data.frame(read.table(subject_file), read.table(yfile))
  colnames(df) <- c('Subject', 'Task')
  

  
  df$Task <- sapply(df$Task,switch,
             'Walking',
             'Walking Upstairs',
             'Walking Downstairs',
             'Sitting',
             'Standing',
             'Laying')
    
                      
  as.data.frame(obsdf)
  
  # Uncomment to generate codes.txt file used in codebook.md
  # write.table(colnames(cbind(df,obsdf)),'codes.txt',sep='\t',quote=FALSE)
              
  return(cbind(df, obsdf))
  
} 

#Set working dir as appropriate, assuming internal layout of zip
#File currently assumes the file is invoked in a project directory
#Containing the dataset as presented


#Get the two datasets
X.meanstd_train <- import_subset('UCI HAR Dataset/train/X_train.txt')
X_train <- append_taskspeople(X.meanstd_train, 'UCI HAR Dataset/train/y_train.txt',
                             'UCI HAR Dataset/train/subject_train.txt')

X.meanstd_test <- import_subset('UCI HAR Dataset/test/X_test.txt')
X_test <- append_taskspeople(X.meanstd_test, 'UCI HAR Dataset/test/y_test.txt',
                            'UCI HAR Dataset/test/subject_test.txt')

# Merge datasets and sort by Subject observations
fulldf <- rbind(X_train,X_test)
fulldf <- fulldf[order(fulldf$Subject),]

#Grab column names for future use
names <- colnames(fulldf)

#Aggregate all the observations with same subject, same activity, take the mean
tidy <- aggregate(fulldf[,-c(1:2)], by = list(fulldf$Subject, fulldf$Task), mean)
colnames(tidy) <- names



#Output as a tab-delimited table, in wide format
write.table(tidy, 'tidy.txt', sep='\t', quote=FALSE, row.name=FALSE)
