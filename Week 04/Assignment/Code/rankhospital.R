rankhospital <- function(state, outcome, rank = "best"){
        
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
        
        # Is 'RANK' numeric, best or worst
        if (is.numeric(rank)) {
                # Rows that match state
                state.rows <- which(data[, "state"] == state)
                # Filter data to state
                data.filtered <- data[state.rows, ]
                # Filter data to outcome
                data.filtered[, eval(outcome)] <- as.numeric(data.filtered[, eval(outcome)])
                data.filtered <- data.filtered[order(data.filtered[, eval(outcome)], data.filtered[, "hospital"]), ]
                output <- data.filtered[, "hospital"][rank]
        } else if (!is.numeric(rank)){
                if (rank == "best") {
                        output <- best(state, outcome)
                } else if (rank == "worst") {
                        # Rows that match state
                        state.rows <- which(data[, "state"] == state)
                        # Filter data to state
                        data.filtered <- data[state.rows, ]    
                        data.filtered[, eval(outcome)] <- as.numeric(data.filtered[, eval(outcome)])
                        data.filtered <- data.filtered[order(data.filtered[, eval(outcome)], data.filtered[, "hospital"], decreasing = TRUE), ]
                        output <- data.filtered[, "hospital"][1]
                } else {
                        stop('invalid rank')
                }
        }
        return(output)
}
