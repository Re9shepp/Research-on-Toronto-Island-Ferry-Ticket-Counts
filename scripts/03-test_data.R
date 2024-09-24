#### Preamble ####
# Purpose: Tests simulate values
# Author: Mingjin Zhan
# Date: 23 September 2024
# Contact: mingjin.zhan@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)


#### Test data ####
data <- read_csv("data/raw_data/simulated.csv")

# Test for negative numbers
data$Value |> min() <= 0

# Test for integers
all(data$Value %%1 != 0)
