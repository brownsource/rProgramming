# Initialise by reading in data
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
# View the data
head(outcome)
summary(outcome)
str(outcome)

# histogram of the 30-day death rates from heart attack
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


# testing the best.R function
source("best.R")
best("TX", "heart attack")
# [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
best("TX", "heart failure")
# [1] "FORT DUNCAN MEDICAL CENTER"
best("MD", "heart attack")
# [1] "JOHNS HOPKINS HOSPITAL, THE"
best("MD", "pneumonia")
# [1] "GREATER BALTIMORE MEDICAL CENTER"
best("BB", "heart attack")
# Error in best("BB", "heart attack") : invalid state
best("NY", "hert attack")
# Error in best("NY", "hert attack") : invalid outcome

Test answers:
best("SC", "heart attack")
                        
