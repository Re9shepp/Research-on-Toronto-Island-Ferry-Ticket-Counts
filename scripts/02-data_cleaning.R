#### Preamble ####
# Purpose: Cleans the raw data
# Author: Mingjin Zhan
# Date: 23 September 2024
# Contact: mingjin.zhan@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(dplyr)

data <- read_csv("data/raw_data/raw_data.csv")

# change format of Timestame
data$Timestamp <- as.POSIXct(data$Timestamp, format="%Y-%m-%dT%H:%M:%S")

start_date <- as.POSIXct("2023-08-01 00:00:00")
end_date <- as.POSIXct("2024-08-01 00:00:00")

data <- subset(data, Timestamp >= start_date & Timestamp < end_date)

# data group by hour
hourly_data <- data %>%
  mutate(hour = format(data$Timestamp, "%Y-%m-%d %H:00:00")) %>%
  group_by(hour) %>%
  summarise(Redemption_Count = sum(`Redemption Count`),
            Sales_Count = sum(`Sales Count`))


# change format of hour
hourly_data$hour <- as.POSIXct(hourly_data$hour)

hourly_data$Date <- format(hourly_data$hour, "%Y-%m-%d")
hourly_data$Hour <- format(hourly_data$hour, "%H-%M-%S")

hourly_data <- hourly_data %>% select(-hour)
hourly_data <- hourly_data %>% select(Date, Hour, everything())

#### Save data ####
write_csv(hourly_data, "data/analysis_data/analysis_data.csv")

