library(tidyverse)
getwd()
#setwd("C:\Users\craig\Documents\Springboard\SpringboardMiniProjects\DataWrangling\Data")
#getwd()
# 0: Load the data in RStudio
df_raw <- read_csv("C:/Users/craig/Documents/Springboard/SpringboardMiniProjects/DataWrangling/Data/refine_original.csv")
df <- df_raw
# Get familiar with the data
str(df)
glimpse(df)
# 1: Clean up brand names
unique(df$company)
df$company <- tolower(df$company)
# Another method is the function str_to_lower(dog) {From the Strinr package} 
# Another method is the function gsub("unilver", "unilever", df$company)
df$company

# Fix "Phillips" variable
idx <- which(df$company == "phillips")
df$company[idx] <- "philips"
idx <- which(df$company == "phllips")
df$company[idx] <- "philips"
idx <- which(df$company == "phillps")
df$company[idx] <- "philips"
idx <- which(df$company == "phlips")
df$company[idx] <- "philips"
idx <- which(df$company == "fillips")
df$company[idx] <- "philips"

# Fix "akzo" variable
idx <- which(df$company == "akz0")
df$company[idx] <- "akzo"
idx <- which(df$company == "ak zo")
df$company[idx] <- "akzo"

# Fix "unilever" variable
idx <- which(df$company == "unilver")
df$company[idx] <- "unilever"

# 2: Separate product code and number
names(df)
df <- separate(df, `Product code / number`, into = c("Product", "Code"), sep = "-")

# 3: Create Lookup table
lut <- c("p" = "Smartphone", "v" = "TV", "x" = "Laptop", "q" = "Tablet")
df$Category <- lut[df$Product]

# 4: Add full address for geocoding
df <- unite(df, "full_address", c(address, city, country), sep = ",")

# 5: Create dummy variables for company and product category (mutate with case_when)
df <- df %>%
  mutate(
    company_philips = case_when(
      company =="philips" ~ "1",
      TRUE ~  "0"),
    company_akzo = case_when(
      company =="akzo" ~ "1",
      TRUE ~  "0"),
    company_van_houten = case_when(
      company =="van houten" ~ "1",
      TRUE ~  "0"),
    company_unilever = case_when(
      company =="unilever" ~ "1",
      TRUE ~  "0")
  )
# Next convert to markdown document and universal reference for inful file.