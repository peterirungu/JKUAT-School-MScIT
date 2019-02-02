library(tidyverse)
library(broom)
library(ggfortify)
library(ggplot2)

#Load raw data that is train_revised.csv and test_question.csv
train <- read.csv("train_revised.csv", header = TRUE)
test <- read.csv("test_questions.csv", header = TRUE)
train_aggregate <- read.csv("train_aggregated.csv", header = TRUE)
final <- read.csv("final.csv", header = TRUE)

#Fit linear regression model
#building regression model
model<-lm(town_from~number_of_tickets, data=final)
model

 
model.diag.metrics <- augment(model)
head(model.diag.metrics)
 
 ggplot(model.diag.metrics, aes(town_from, number_of_tickets)) +
   geom_point() +
   stat_smooth(method = lm, se = FALSE) +
   geom_segment(aes(xend = town_from, yend = .fitted), color = "red", size = 0.3)

 #Diagnostic plots
 par(mfrow = c(2, 2))
 plot(model) 

 autoplot(model) 

 
 # Add observations indices and
 # drop some columns (.se.fit, .sigma) for simplification
 model.diag.metrics <- model.diag.metrics %>%
   mutate(index = 1:nrow(model.diag.metrics)) %>%
   select(index, everything(), -.se.fit, -.sigma)
 # Inspect the data
 head(model.diag.metrics, 4)

 #linearity of the data
 plot(model, 1)
 
 #homogenity of the variance
 plot(model, 3)
 