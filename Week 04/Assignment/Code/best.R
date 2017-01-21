best <- function(state, outcome) {
        
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
        
        ## Check that state and outcome are valid
        
        # Check state is valid
        if (!state %in% data$state) {
                stop("invalid state")
        }
        
        # Check if outcome is valid
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop("invalid outcome")
        }
        
        # Rows that match state
        state.rows <- which(data[, "state"] == state)
        # Filter data to state
        data.filtered <- data[state.rows, ]
        # Convert field to numeric
        performance <- as.numeric(data.filtered[, eval(outcome)])
        # Determnime the best (minimum) performing value
        min.performance <- min(performance, na.rm = TRUE)
        # Filter the data to the min.performance
        result  <- data.filtered[, "hospital"][which(performance == min.performance)]
        # Set the value to the list of hospitals
        output  <- result[order(result)]

        return(output)
}