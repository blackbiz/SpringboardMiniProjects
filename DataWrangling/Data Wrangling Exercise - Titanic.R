library(tidyverse)
getwd()
#setwd("C:\Users\craig\Documents\Springboard\SpringboardMiniProjects\DataWrangling\Data")
#getwd()
# 0: Load the data in RStudio
tdf_raw <- read_csv("C:/Users/craig/Documents/Springboard/SpringboardMiniProjects/DataWrangling/Data/titanic_original.csv")
tdf <- tbl_df(tdf_raw)
# Get familiar with the data
str(tdf)
glimpse(tdf)
# 1: Port of embarkation - Find the missing values and replace them with S. 
# Check if there are NA's and view unique values
any(is.na(tdf$embarked))
sum(is.na(tdf$embarked))
which(is.na(tdf$embarked))
unique(tdf$embarked)

# Find - Replace
ind <- which(is.na(tdf$embarked))
tdf$embarked[ind] <- "S"

#Check for NA's
any(is.na(tdf$embarked))
unique(tdf$embarked)

# FAILED NA REPLACE
#tdf$embarked[tdf$embarked == NA] <- "S"
#tdf$embarked[tdf$embarked == ""] <- "S"
#tdf$embarked <- str_replace(tdf$embarked, "", "S")
#idx2 <- which(tdf$embarked == "")
#tdf$embarked[idx2] <- "S"
#replace_na(data, replace = list(), ...)

# 2: Age - Calculate the mean of the Age column and replace missing values
any(is.na(tdf$age))
sum(is.na(tdf$age))
which(is.na(tdf$age))
unique(tdf$age)

avg_age <- mean(tdf$age, na.rm = TRUE)

#replace
ind_age <- which(is.na(tdf$age))
tdf$age[ind_age] <- avg_age

#check
any(is.na(tdf$age))
sum(is.na(tdf$age))

# Age (b) Perhaps use median age.

#3: Lifeboat - Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'
any(is.na(tdf$boat))
sum(is.na(tdf$boat))
which(is.na(tdf$boat))
unique(tdf$boat)

ind_boat <- which(is.na(tdf$boat))
tdf$boat[ind_boat] <- "None"

#check
any(is.na(tdf$boat))
sum(is.na(tdf$boat))

# 4: Cabin -  Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
any(is.na(tdf$cabin))
sum(is.na(tdf$cabin))
which(is.na(tdf$cabin))
unique(tdf$cabin)

#Create dummy variable
tdf <- mutate(tdf,
      has_cabin_number = case_when(
      cabin != NA ~ "0",
      TRUE ~  "1"))

#check dummy variable
unique(tdf$has_cabin_number)
