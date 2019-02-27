library(readr)
library(dplyr)
library(ggplot2)
library(ggmap)

setwd('/Users/sophiawheatley/Downloads')
dno_data <- read.csv('data-rstats.csv')

## Age
dno_clean <- subset(dno_data, select = c(Geburtsdatum...birth.date, Postanschrift...postal.address))
colnames(dno_clean) <- c('birth_date', 'address')

date_format <- '%m/%d/%Y'
dno_clean$birth_date <- as.Date(dno_clean$birth_date, date_format)
dno_clean$age <- round(as.double(Sys.Date() - dno_clean$birth_date)/365.25, digits = 1)
age_mean <- mean(dno_clean$age)
age_std <- sd(dno_clean$age)
dno_clean <- filter(dno_clean, between(dno_clean$age - age_mean, left = -2*age_std, right = 2*age_std ))

hist(dno_clean$age)

## Germany map
dno_clean$address <- gsub('^Berlin$', 10117, dno_clean$address)
dno_clean$address <- gsub("[[:alpha:]]" , "", dno_clean$address)
dno_clean$address <- gsub("[[:punct:]]" , "", dno_clean$address)  


