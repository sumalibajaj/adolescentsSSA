library(dplyr)

# From here: https://population.un.org/dataportal/data/indicators/46/locations/903/start/2023/end/2050/table/pivotbylocation
# Some rows are repeated, so make sure to extract distinct rows only
dat_read <- read.csv("data/africa/unpopulation_dataportal_20231016105945.csv")

# Keeping data for children aged 0-19
dat <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  filter(Age %in% c("0-4", "5-9", "10-14", "15-19")) %>%
  distinct() 

# Children as of 2023
dat_23 <- dat %>%
  filter(Time == 2023)
sum(dat_23$Value)

dat_year <- dat %>%
  group_by(Time) %>%
  summarise(pop = sum(Value))

write.csv(dat_year, file = "data/processed/africa_0to19.csv")