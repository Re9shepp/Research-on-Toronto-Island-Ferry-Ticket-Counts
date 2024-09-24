#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)

data <- read_csv("data/raw_data/raw_data.csv")

# 转换Timestamp为日期时间格式
data$Timestamp <- as.POSIXct(data$Timestamp, format="%Y-%m-%dT%H:%M:%S")

start_date <- as.POSIXct("2023-08-01 00:00:00")
end_date <- as.POSIXct("2024-08-01 00:00:00")

data <- subset(data, Timestamp >= start_date & Timestamp < end_date)

# 按每小时汇总数据
hourly_data <- data %>%
  mutate(hour = format(data$Timestamp, "%Y-%m-%d %H:00:00")) %>%
  group_by(hour) %>%
  summarise(Redemption_Count = sum(`Redemption Count`),
            Sales_Count = sum(`Sales Count`))

# 将hour转换为日期时间格式
hourly_data$hour <- as.POSIXct(hourly_data$hour)


#### Save data ####
write_csv(hourly_data, "data/analysis_data/analysis_data.csv")

