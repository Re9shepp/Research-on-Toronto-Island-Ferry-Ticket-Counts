#### Preamble ####
# Purpose: Hourly Simulation Values
# Author: Mingjin Zhan
# Date: 23 September 2024
# Contact: mingjin.zhan@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate data(by chat gpt) ####
set.seed(0405)

# Define the start and end date
start_time <- as.POSIXct("2023-08-01 00:00:00")
end_time <- as.POSIXct("2024-08-01 00:00:00")

# Generates a time series in hours from August 1, 2023 to July 31, 2024
time_series <- seq(start_time, end_time, by = "hour")

# Generate hourly simulation values, higher during the day and lower at night
# (by Chat gpt)
# Generate 24 hours, with values higher during the day (6 AM to 6 PM) and lower at night
hours <- hour(time_series)

# Use a sine wave to model daily cycle, adjust the amplitude and mean value
values1 <- 500 + 450 * sin((pi/12) * (hours - 6)) + rnorm(length(hours), 0, 5)
values2 <- 500 + 450 * sin((pi/10) * (hours - 5)) + rnorm(length(hours), 0, 5)
generate_value1 <- round(values1)
generate_value2 <- round(values2)

simulated_df <- data.frame(Time = time_series, sale_value = generate_value1, 
                           redemption_value = generate_value2)


#### Write_csv
write_csv(simulated_df, file = "data/raw_data/simulated.csv")

