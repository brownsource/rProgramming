best <- function(state, outcome) {
  
  d.State <- state
  d.Outcome <- outcome
  
  # Read outcome data
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check that state and outcome are valid
  valid.Outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if (d.State %in% outcome$State == FALSE) {
    stop("Invalid state")
  }
  if (d.Outcome %in% valid.Outcomes == FALSE) {
    stop("Invalid outcome")
  }
  
  # Return hospital name in that state with lowest 30-day death rate
  # Relevant columns
  # [11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"                            
  # [17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"                           
  # [23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  
  # Create a smaller table based on the state
  d.Outcome <- subset(d.Outcome, d.Outcome$State == d.State)
  
  if (d.Outcome == "heart attack") {
    hospitals <- outcome$Hospital.Name[outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == 
                                        min(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)]
  }
  if (d.Outcome == "heart failure") {
    hospitals <- outcome$Hospital.Name[outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == 
                                        min(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)]
  }
  if (d.Outcome == "pneumonia") {
    hospitals <- outcome$Hospital.Name[outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == 
                                        min(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)]
  }
  
  
  print(sort(hospitals[1]))
}