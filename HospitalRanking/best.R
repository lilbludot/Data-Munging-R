
best <- function(state, outcome){
  #Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #Check that state and outcome are valid
  if ( !(state  %in% state.abb) ) {
    stop("invalid state")
  }
  if ( outcome != "heart attack" & outcome != "heart failure" & outcome != "pneumonia"){
    stop("invalid outcome")
  }
  
  # Return hospital name in the state with lowest 30-day death rate. 
  data <- subset(df, df$State == state)
  if (outcome == "heart attack"){
    x<-suppressWarnings(as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    m <- which.min(x)  
  }
  if (outcome == "heart failure") {
    x<-suppressWarnings(as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    m <- which.min(x) 
  
  }
  if (outcome == "pneumonia"){
    x<-suppressWarnings(as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    m <- which.min(x)
  }
  
  return(data$Hospital.Name[m])
}
