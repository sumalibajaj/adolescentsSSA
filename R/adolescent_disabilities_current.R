library(dplyr)

# Using 2022 disability prevalence estimates for 5-17 yr olds in SSA from here:
# Table 2: https://www.frontiersin.org/articles/10.3389/fpubh.2022.977453/full

est_5.17 <- 59300000
est_prop_5.17 <- 15.9/100
est_pop_5.17 <- est_5.17/est_prop_5.17

# Compare est_pop_5.17 to data on no.of children by age from:
# https://population.un.org/dataportal/data/indicators/46/locations/947/start/2022/end/2022/table/pivotbylocation

dat_read <- read.csv("data/unpopulation_dataportal_20231005120015.csv")
dat_5.17 <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  filter(Age %in% c("5","6","7","8","9","10","11","12","13","14","15","16","17")) %>%
  distinct()
pop_5.17 <- sum(dat_5.17$Value)

# how different are the pop estimates for 5-17 yr olds from disability estimates and UN
# This can be correction factor
adj <- est_pop_5.17/(pop_5.17)

# Take the disability proportion of 5-17 yr olds and multiply by no.of 10-17 yr olds
# to get number estimate
dat_10.17 <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  filter(Age %in% c("10","11","12","13","14","15","16","17")) %>%
  distinct()
pop_10.17 <- sum(dat_10.17$Value)
pop_10.17_adj <- pop_10.17 * adj # adjusting the population by correction factor adj

est_10.17 <- est_prop_5.17*pop_10.17
est_10.17
est_10.17_adj <- est_prop_5.17*pop_10.17_adj # disability estimate using adjusted population estimate
est_10.17_adj 


