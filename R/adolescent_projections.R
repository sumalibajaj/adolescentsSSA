library(dplyr)

# From here: https://population.un.org/dataportal/data/indicators/46/locations/947/start/2023/end/2030/table/pivotbylocation
# Some rows are repeated, so make sure to extract distinct rows only
dat_read <- read.csv("data/unpopulation_dataportal_20230817144903.csv")

# Keeping data for adolescents
dat <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  filter(Age %in% c("10-14", "15-19")) %>%
  distinct() 

dat_30 <- dat %>%
  filter(Time == 2030)
sum(dat_30$Value)


# Checking if our estimate is reliable by comparing an estimate to published work
# https://esaro.unfpa.org/sites/default/files/pub-pdf/Status%20Report%20Adolescents%20and%20Young%20People%20in%20Sub-Saharan%20Africa.pdf
# Keeping data for young people (10-24 years) in 2025
dat_check <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  filter(Age %in% c("10-14", "15-19", "20-24")) %>%
  distinct() 

dat_check_25 <- dat_check %>%
  filter(Time == 2025)
sum(dat_check_25$Value)

# We get 407 million and they report 436 million


