#### Preamble ####
# Purpose: Tests simulate values
# Author: Mingjin Zhan
# Date: 23 September 2024
# Contact: mingjin.zhan@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Test data ####
data <- read_csv("data/raw_data/simulated.csv")

# Test for negative numbers
data$sale_value |> min() <= 0
data$redemption_value |> min() <= 0
# Test for integers
all(data$sale_value %% 1 != 0)
all(data$redemption_value %% 1 != 0)
