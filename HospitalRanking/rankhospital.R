rankhospital <- function(state, outcome, num ="best"){
  # Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  #Check that state and outcome are valid
  if ( !(state  %in% state.abb) ) {
    stop("invalid state")
  }
  if ( outcome != "heart attack" & outcome != "heart failure" & outcome != "pneumonia"){
    stop("invalid outcome")
  }
  
  
  #Return hospital name in that state with the given rank
  #of 30-day death rate.
  data <- subset(df, df$State == state)
  if (outcome == "heart attack"){
    data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack<-suppressWarnings(as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    ordered_data =  data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, data$Hospital.Name),]
    ordered_data <- subset(ordered_data, ordered_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack != "Not Available")
  }
  if (outcome == "heart failure") {
    data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure<-suppressWarnings(as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    ordered_data =  data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, data$Hospital.Name),]
    ordered_data <- subset(ordered_data, ordered_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure != "Not Available")
  }
  if (outcome == "pneumonia"){
    data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia<-suppressWarnings(as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    ordered_data =  data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, data$Hospital.Name),]
    ordered_data <- subset(ordered_data, ordered_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia != "Not Available")
  }
   if (num == "best"){
    return(ordered_data$Hospital.Name[1])
  } 
  if (num =="worst"){
    #print(nrow(ordered_data))
    #new_data <- ordered_data[, c(2,11, 17, 23)]
    #print(new_data)
    return(ordered_data$Hospital.Name[nrow(ordered_data)])
  }
  if (typeof(num)== "double"){
    #print("Yes, a number!")
    return(ordered_data$Hospital.Name[num])
  }
  
}