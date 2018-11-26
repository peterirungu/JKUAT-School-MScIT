
#Load raw data that is train_revised.csv and test_question.csv
train <- read.csv("train_revised.csv", header = TRUE)
test <- read.csv("test_questions.csv", header = TRUE)

#check the datatypes for the train data
str(train)

# add a column on train dataset to count number of tickets per ride(no_of_tickets)
train_tickets <- data.frame(no_of_tickets = rep(0, nrow(train)),train[,])

#count aggregate for all ride id


table(train$ride_id)
