setwd("~/R")
sf<- read.csv("seaflow_21min.csv")

seaflow <- subset(sf, file_id != 208)
head(seaflow)
summary(seaflow)
library(caret)
library(ggplot2)
library(rpart)
library(randomForest)
library(e1071)
x <- split(seaflow, seaflow$pop)
training_index <- createDataPartition(seaflow$pop, p = 0.5, list = FALSE)

training_set <- seaflow[training_index,]

test_set <- seaflow[-training_index,]
head(training_set)
mean(training_set$time)
ggplot(data = training_set, aes(x = pe , y = chl_small ,colour = pop)) + geom_line()
#fol <- formula(training_set$pop ~ training_set$fsc_small + training_set$fsc_perp + training_set$fsc_big + training_set$pe + training_set$chl_big + training_set$chl_small)
fol <- formula (pop ~ fsc_small + fsc_perp + chl_small + pe + chl_big + chl_small)
model <- rpart(fol, method="class", data=training_set)
print(model)
prediction <- predict(model, newdata = test_set, type ="class")
head(prediction)
correct <- sum(prediction == test_set$pop)
correct_percentage = correct/nrow(test_set)
correct_percentage
model2 <- randomForest(fol, data = training_set)
prediction2 <- predict(model2, newdata = test_set, type ="class")
correct2 <- sum(prediction2 == test_set$pop)
correct_percentage2 = correct2/nrow(test_set)
correct_percentage2
importance(model2)
model3 <- svm(fol, data=training_set)
prediction3 <- predict(model3, newdata = test_set, type ="class")
correct3 <- sum(prediction3 == test_set$pop)
correct_percentage3 = correct3/nrow(test_set)
correct_percentage3
correct3
confusionMatrix1 <- table(pred = prediction, true = test_set$pop)
confusionMatrix2 <- table(pred = prediction2, true = test_set$pop)
confusionMatrix3 <- table(pred = prediction3, true = test_set$pop)
confusionMatrix1
confusionMatrix2
confusionMatrix3
ggplot(data = test_set, aes(x = id , y = fsc_small)) + geom_line()
ggplot(data = test_set, aes(x = id , y = fsc_perp)) + geom_line()
ggplot(data = test_set, aes(x = id , y = fsc_big)) + geom_line()
ggplot(data = test_set, aes(x = id , y = pe)) + geom_line()
ggplot(data = test_set, aes(x = id , y = chl_small)) + geom_line()
ggplot(data = test_set, aes(x = id , y = chl_big)) + geom_line()
ggplot(data = test_set, aes(x = id , y = fsc_big, colour = pop)) + geom_line()
