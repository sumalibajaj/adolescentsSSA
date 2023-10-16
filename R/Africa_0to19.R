library(dplyr)

# From here: https://population.un.org/dataportal/data/indicators/46/locations/903/start/2023/end/2050/table/pivotbylocation
# Some rows are repeated, so make sure to extract distinct rows only
dat_read <- read.csv("data/africa/unpopulation_dataportal_20231016133702.csv")

# Keeping data for children aged 0-19
dat_0to19 <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  filter(Age %in% c("0-4", "5-9", "10-14", "15-19")) %>%
  distinct() 

dat_0to19 <- dat_0to19 %>%
  group_by(Time) %>%
  summarise(pop = sum(Value))

# Total population by year
dat_all <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  distinct() %>%
  group_by(Time) %>%
  summarise(pop_all = sum(Value))

dat_final <- left_join(dat_0to19, dat_all, by = "Time") %>%
  mutate(percent = (pop/pop_all)*100)

write.csv(dat_final, file = "data/processed/africa_0to19.csv")
