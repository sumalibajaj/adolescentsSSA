library(dplyr)

# From here: https://population.un.org/dataportal/data/indicators/74/locations/947/start/2019/end/2023/table/pivotbylocation
# Idea is that we add the following to obtain number of adolescent mothers in 2023:
# We assume that number of births = number of mothers in a given year (overestimation because twins etc)
# We also assume that a woman who became a mother between 2019 and 2023 is still a mother (still an adolescent in 2023)
# (no death rates of children included), and is added to the data
# 1. recent adolescent (15-19) mothers in 2023
# 2. 15-18 year old mothers from 2022 (who are still mothers in 2023)
# 3. 15-17 year old mothers from 2021 (who are still mothers in 2023)
# 4. 15-16 year old mothers from 2020 (who are still mothers in 2023)
# 5. 15 year old mothers from 2019 (who are still mothers in 2023)

dat_read <- read.csv("data/unpopulation_dataportal_20230817160939.csv")

# Keeping data for adolescent mothers in 2023
# adding a column with value 1 if it satisfies the conditions mentioned in 1 to 5
dat <- dat_read %>%
  select(Location, Time, Age, Value) %>%
  mutate(mother_in_2023 = case_when(Time == 2019 & Age %in% c(15) ~ 1,
                                    Time == 2020 & Age %in% c(15, 16) ~ 1,
                                    Time == 2021 & Age %in% c(15, 16, 17) ~ 1,
                                    Time == 2022 & Age %in% c(15, 16, 17, 18) ~ 1,
                                    Time == 2023 & Age %in% c(15, 16, 17, 18, 19) ~ 1))
dat_mother_in_2023 <- dat %>% filter(mother_in_2023 == 1)
sum(dat_mother_in_2023$Value)


# Adolescent women population 
# https://population.un.org/dataportal/data/indicators/46/locations/947/start/2019/end/2023/table/pivotbysex
dat_pop <- read.csv("data/unpopulation_dataportal_20230817164255.csv")

# Keep population for 2023 only
dat_pop <- dat_pop %>%
  select(Location, Time, Age, Value)
dat_pop %>% filter(Time == 2023) %>% pull(Value)

# Proportion of adolescent women that are mothers in 2023
sum(dat_mother_in_2023$Value)/dat_pop %>% filter(Time == 2023) %>% pull(Value)

