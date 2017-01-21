rankall <- function(outcome, num = "best"){
        
        # Read outcome data
        data <- read.csv("../Data/outcome-of-care-measures.csv", colClasses = "character")
        # Make the data table smaller
        data <- as.data.frame(cbind(data[, 2],   # hospital
                                    data[, 7],   # state
                                    data[, 11],  # heart attack
                                    data[, 17],  # heart failure
                                    data[, 23]), # pneumonia
                              stringsAsFactors = FALSE)
        colnames(data) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        # Check state is valid
        if (!state %in% data$state) {
                stop("invalid state")
        }
        
        # Check if outcome is valid
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop("invalid outcome")
        }
        
        if (is.numeric(num)) {
                by_state <- with(data, split(data, state))
                ordered  <- list()
                for (i in seq_along(by_state)){
                        by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                                             by_state[[i]][, "hospital"]), ]
                        ordered[[i]]  <- c(by_state[[i]][num, "hospital"], by_state[[i]][, "state"][1])
                }
                result <- do.call(rbind, ordered)
                output <- as.data.frame(result, row.names = result[, 2], stringsAsFactors = FALSE)
                names(output) <- c("hospital", "state")
        } else if (!is.numeric(num)) {
                if (num == "best") {
                        by_state <- with(data, split(data, state))
                        ordered  <- list()
                        for (i in seq_along(by_state)){
                                by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                                                     by_state[[i]][, "hospital"]), ]
                                ordered[[i]]  <- c(by_state[[i]][1, c("hospital", "state")])
                        }
                        result <- do.call(rbind, ordered)
                        output <- as.data.frame(result, stringsAsFactors = FALSE)
                        rownames(output) <- output[, 2]
                } else if (num == "worst") {
                        by_state <- with(data, split(data, state))
                        ordered  <- list()
                        for (i in seq_along(by_state)){
                                by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                                                     by_state[[i]][, "hospital"], 
                                                                     decreasing = TRUE), ]
                                ordered[[i]]  <- c(by_state[[i]][1, c("hospital", "state")])
                        }
                        result <- do.call(rbind, ordered)
                        output <- as.data.frame(result, stringsAsFactors = FALSE)
                        rownames(output) <- output[, 2]
                } else {
                        stop('invalid num')
                }
        }
        return(output)
}