setwd("~/Desktop/R Files/UCI")
names <- read.csv("features.txt", sep = " ", header=FALSE)
cols <- names$V2


setwd("~/Desktop/R Files/UCI/test")
testx <- read.table("X_test.txt")
testy <- read.table("y_test.txt")
testsub <- read.table("subject_test.txt")
## train 
setwd("~/Desktop/R Files/UCI/train")
 trainx <- read.table("X_train.txt")
 trainy <- read.table("y_train.txt")
 trainsub <- read.table("subject_train.txt")
## set col names
colnames(testx) <- cols
colnames(trainx) <- cols
colnames(testsub) <- "subject"
colnames(trainsub) <- "subject"
colnames(testy) <- "activity"
colnames(trainy) <- "activity"

#Combine columns
ys <- rbind(testy, trainy)
xs <- rbind(testx, trainx)
subs <- rbind(testsub, trainsub)
##Combine tables
total <- cbind(xs, ys, subs)

## select variables of only mean and stdv
avg <- total[,grep("mean", colnames(total))]
std <- total[,grep("std", colnames(total))]
##merge together
astot <- cbind(avg, std, subs, ys)

##rename activity
astot$activity <-gsub("1", "walking", astot$activity)
astot$activity <-gsub("2", "walking_upstairs", astot$activity)
astot$activity <-gsub("3", "walking_downstairs", astot$activity)
astot$activity <-gsub("4", "sitting", astot$activity)
astot$activity <-gsub("5", "standing", astot$activity)
astot$activity <-gsub("6", "laying", astot$activity)

## arrange and average
data <- group_by(astot, subject, activity)
newdata <- summarise_each(data, funs(mean))


