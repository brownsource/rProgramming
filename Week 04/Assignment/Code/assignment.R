# Set the working directory
setwd("Week 04/Assignment/Code")

# Clear the environment
rm(list=ls())

# ---------------------------------------------------------------------------------
## ASSIGNMENT 01

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

# ---------------------------------------------------------------------------------
## ASSIGNMENT 02

source("rankhospital.R")

rankhospital("TX", "heart failure", 4)
# [1] "DETAR HOSPITAL NAVARRO"

rankhospital("MD", "heart attack", "worst")
# [1] "HARFORD MEMORIAL HOSPITAL"

rankhospital("MN", "heart attack", 5000)
# [1] NA

# ---------------------------------------------------------------------------------
## ASSIGNMENT 03

source("rankall.R")
head(rankall("heart attack", 20), 10)

tail(rankall("pneumonia", "worst"), 3)

tail(rankall("heart failure"), 10)

# ---------------------------------------------------------------------------------
## QUIZ
best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

         