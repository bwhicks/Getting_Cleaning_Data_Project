# Week 4 Project: Getting and Cleaning Data

This repo contains files relating to the course project for Getting and Cleaning
Data through Coursera and Johns Hopkins.

The original dataset has also been uploaded to the repo for posterity's sake.
The study examined 30 subjects engaging in various activities and reported 
various derived values  aspects of their physical movement.

## run_analysis.R

This R script performs the following functions:

1. Imports data from the UCI HAR Dataset/training and UCI HAR Dataset/test
for test and training runs.
2. Merges the training and test sets to created a combined dataset with 
human readable activity names rather than codes.
3. Labels the dataset using codes related to UCI for measures.
4. Produces a data set (output in tidy.txt) that provides averages
for each subject per activity ('for each activity and subject').
The output is tab-delimited in a more human friendly wide format.

Note: the current grep() also includes meanFreq() since instructions of
assignment are unclear as whether this is a 'measurement on the mean
and standard deviation'

## codebook.md

This is a codebook that explains variable names along with their
relation to the original dataset.



