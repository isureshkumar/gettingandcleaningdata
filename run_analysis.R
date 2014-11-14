######Start of Part 1
#Merge the training and the test sets to create one data set.
#reading all the necessary files:
library(plyr)
library(reshape)
#training data
x.train.data <- read.table("train/X_train.txt",header = FALSE)
#test data
x.test.data <- read.table("test/X_test.txt",header = FALSE)
feature.variables <- read.table("features.txt")
activity.label <- read.table("activity_labels.txt")


#If the dataframes I merge contains lists inside them, 
#then I get the duplicate rowname error. 
#so few tables need to be unlist after reading them. 

train.activity.labels <- unlist(read.table("train/y_train.txt"))
test.activity.labels <- unlist(read.table("test/y_test.txt"))
train.subject.labels <- unlist(read.table("train/subject_train.txt"))
test.subject.labels <- unlist(read.table("test/subject_test.txt"))

#merge train and test data
#adding a new column'acitivity.ID', 'subject.ID' to 
#track acitivity label in the merged dataset
colnames(x.test.data) = as.character(feature.variables[,2])
x.test.data$activity.ID <- test.activity.labels
x.test.data$subject.ID <- test.subject.labels

colnames(x.train.data) = as.character(feature.variables[,2])
x.train.data$activity.ID <- train.activity.labels
x.train.data$subject.ID <- train.subject.labels

#part#1 one data set merged with both training and test dataset
merged.dataset <- rbind(x.test.data,x.train.data)

#####End of Part 1

#####Start of Part 2

#Extract measurements on the mean and standard deviation for each measurement

#put Subject ID and Acitivy ID at the front
merged.dataset = merged.dataset[,c((ncol(merged.dataset)-1),
                                   ncol(merged.dataset),
                                   1:(ncol(merged.dataset)-2))]

#grepl on column names to extract mean and std on each measurement : 

mean.std.col.index <- sort(c(which(grepl(pattern = "mean()",fixed = TRUE,
                                        x = colnames(merged.dataset))),
                            which(grepl(pattern = "std()",fixed = TRUE,
                                        colnames(merged.dataset)))))

merged.dataset.mean.std <- merged.dataset[,c(1,2,mean.std.col.index)]
#####End of Part 2

#####Start of Part 3
# descriptive activity names to name the activities in the data set
merged.dataset.mean.std$activity.name <- activity.label[merged.dataset.mean.std$activity.ID,2]

#put activity description at the front
merged.dataset.mean.std <- merged.dataset.mean.std[,c(ncol(merged.dataset.mean.std),
                                                     1:(ncol(merged.dataset.mean.std)-1))]
#sorting by activity ID
merged.dataset.mean.std <- merged.dataset.mean.std[order(merged.dataset.mean.std$activity.ID),]

#####End of Part 3


#####Start of Part 4
##Appropriately labels the data set with descriptive variable names.

#In line 25, I have already assigned column names to the variables based on features
#because of special character a call to :merged.dataset.mean.std$tBodyAcc-mean()-X
#in console with show error.
#Therefore, I prefer to replace () with "" and "-" with "_"

colnames(merged.dataset.mean.std) <- gsub(pattern = "-",replacement = "_",
                                         colnames(merged.dataset.mean.std),
                                         fixed = TRUE)

colnames(merged.dataset.mean.std) <- gsub(pattern = "()",replacement = "",
                                         colnames(merged.dataset.mean.std),
                                         fixed = TRUE)


colnames(merged.dataset.mean.std) <- gsub(pattern = "BodyBody",replacement = "Body",
                                         colnames(merged.dataset.mean.std),
                                         fixed = TRUE)
##### End of Part 4

#### Start of Part 5
#creating a tidy data set with the average of each variable for each activity and each subject.
#there are 30 subjects and 6 activities, a correct 'tidy data' should have 180 rows
data.set.melted <- melt(merged.dataset.mean.std,
                              id.vars = c("activity.name", "activity.ID","subject.ID"))

tidy.dataset <- dcast(data.set.melted, activity.name + activity.ID+subject.ID ~ variable,fun = mean)
tidy.dataset <- tidy.dataset[order(tidy.dataset$activity.ID),]
tidy.dataset <- tidy.dataset[,-2]

write.table(x = tidy.dataset,file = "tidydata.txt",row.names = FALSE)
#tidydata = read.table(file = "tidydata.txt",header = T)
#another way 
# tidy.dataset <- aggregate(x = merged.dataset.mean.std,
#           by = list(merged.dataset.mean.std$activity.name,
#                     merged.dataset.mean.std$subject.ID),
#           FUN = mean,simplify = TRUE)
#####End of Part 5
