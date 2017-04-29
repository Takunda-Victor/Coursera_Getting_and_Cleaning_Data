---
title: "CodeBook"
author: "Takunda"
date: "29 April 2017"
output: html_document
---
Data
Altogether 10 datasets have been made use of as obtained from the zipped folder whose link is available together with the assignment intsructions. The data has been split into 2, a training set and a testing set. The X data is for actual observations made, the Y data for the activity which was being carried out when measurement was made and the subject data contains the persons on whom the observations were made.

Variables
The variables in this dataset are as below;
x_train, x_set, y_train and y_test - these are variables containing data read in from the respective datasets.The variables combinedXdata, combinedYdata and combinedSubjectdata are the result of combining the training and testing datasets for each of 'x', 'y' and 'subject'.

Data Transformations
1. combining of training and testing datasets.
2. Extraction of data involving observations with means and standard deviations.
3. Provide understandable and descriptive names for columns of resulting dataset.
4. Creation of a single dataset with averages of observations per subject per activity.