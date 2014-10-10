rankall<- function(outcome, num = "best"){
  #Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #Check that state and outcome are valid
  
  if ( outcome != "heart attack" & outcome != "heart failure" & outcome != "pneumonia"){
    stop("invalid outcome")
  }
  final_data = data.frame()
  v<-c()
  # For each state, find the hospital of the given rank
  for (i in state.abb){
    data <- subset(df, df$State == i)
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
       x <- c(i,ordered_data$Hospital.Name[1])
    } 
    if (num =="worst"){
      #print(nrow(ordered_data))
      #new_data <- ordered_data[, c(2,11, 17, 23)]
      #print(new_data)
      x<-c(i, ordered_data$Hospital.Name[nrow(ordered_data)])
    }
    if (typeof(num)== "double"){
      #print("Yes, a number!")
      x <- c(i, ordered_data$Hospital.Name[num])
    }
    v <- rbind(v,x)
    
  }
  print(v)
  
  #return a data frame with the hospital names and the abbreviated
  #state name
  
  
  
  
  
}