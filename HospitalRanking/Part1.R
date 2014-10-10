setwd("~/R/rprog-data-ProgAssignment3-data")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)
outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
hist(outcome[,11])
head(outcome$Hospital.Name)
head(outcome$State)
state.name
state.abb
!("Oregon"  %in% state.abb)
data <- subset(outcome, outcome$State == "OR")
head(data)
m <- which.max(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
data$Hospital.Name[m]
