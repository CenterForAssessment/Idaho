#########################################
# Data preparation for Idaho IRI Data
#########################################

### Load necessary libraries
require(data.table)

### Utility functions
getPercentile <- function(x) {
  tmp <- findInterval(x, quantile(x, probs = seq(0.005, by=0.01, length= 100), na.rm = TRUE), rightmost.closed = TRUE)
  return(pmax(pmin(tmp, 99), 1))
}

### Load data
#Idaho_IRI_Data_LONG <- fread("Data/Base_Files/IRI Scores SY 2023-2024.csv")
#Idaho_IRI_Data_LONG <- fread("Data/Base_Files/IRI Scores SY 2023-2024 022625.csv")
Idaho_IRI_Data_LONG <- fread("Data/Base_Files/IRI Scores SY 2023-2024 030425.csv")

### Tidy up the data
setnames(Idaho_IRI_Data_LONG, c("YEAR", "ID", "CONTINUOUS_ENROLLMENT_STATUS", "GRADE", "TEST_TYPE", "DATE", "SCALE_SCORE", "INSTRUCTOR_ID", "SMART_CLASSROOM", "TEACHER_YEAR_IN_PROGRAM", "SCHOOL_NUMBER"))
Idaho_IRI_Data_LONG[, YEAR := as.character(YEAR)]
Idaho_IRI_Data_LONG[, ID := as.character(ID)]
Idaho_IRI_Data_LONG[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

Idaho_IRI_Data_LONG[YEAR == "2023" & TEST_TYPE=="Fall ISIP", YEAR:="2022_2023.1"]
Idaho_IRI_Data_LONG[YEAR == "2023" & TEST_TYPE=="Spring ISIP", YEAR:="2022_2023.3"]
Idaho_IRI_Data_LONG[YEAR == "2024" & TEST_TYPE=="Fall ISIP", YEAR:="2023_2024.1"]
Idaho_IRI_Data_LONG[YEAR == "2024" & TEST_TYPE=="Spring ISIP", YEAR:="2023_2024.3"]

Idaho_IRI_Data_LONG[TEST_TYPE == "Fall ISIP", GRADE := paste0(GRADE, ".1")]
Idaho_IRI_Data_LONG[TEST_TYPE == "Spring ISIP", GRADE := paste0(GRADE, ".3")]

Idaho_IRI_Data_LONG[, VALID_CASE := "VALID_CASE"]
Idaho_IRI_Data_LONG[, TEST_TYPE := NULL]
Idaho_IRI_Data_LONG[, CONTENT_AREA := "READING"]
Idaho_IRI_Data_LONG[, SCALE_SCORE_CSEM := 6.593] ### From technical manual (page 81).

Idaho_IRI_Data_LONG[, SMART_CLASSROOM_YES_NO := ifelse(SMART_CLASSROOM == 0, "No", "Yes")]

Idaho_IRI_Data_LONG[, SCALE_SCORE_PERCENTILE := getPercentile(SCALE_SCORE), by = c("CONTENT_AREA", "GRADE", "YEAR")]
Idaho_IRI_Data_LONG[SCALE_SCORE_PERCENTILE <= 20, SCALE_SCORE_QUINTILE := 1]
Idaho_IRI_Data_LONG[SCALE_SCORE_PERCENTILE > 20 & SCALE_SCORE_PERCENTILE <= 40, SCALE_SCORE_QUINTILE := 2]
Idaho_IRI_Data_LONG[SCALE_SCORE_PERCENTILE > 40 & SCALE_SCORE_PERCENTILE <= 60, SCALE_SCORE_QUINTILE := 3]
Idaho_IRI_Data_LONG[SCALE_SCORE_PERCENTILE > 60 & SCALE_SCORE_PERCENTILE <= 80, SCALE_SCORE_QUINTILE := 4]
Idaho_IRI_Data_LONG[SCALE_SCORE_PERCENTILE > 80, SCALE_SCORE_QUINTILE := 5]

tmp.2022_2023.ids <- Idaho_IRI_Data_LONG[YEAR %in% c("2022_2023.1", "2022_2023.3") & SMART_CLASSROOM_YES_NO == "Yes", ID]
Idaho_IRI_Data_LONG[YEAR %in% c("2022_2023.1", "2022_2023.3") & ID %in% tmp.2022_2023.ids, SMART_CLASSROOM_YEARS:="2022_2023"]
Idaho_IRI_Data_LONG[YEAR %in% c("2022_2023.1", "2022_2023.3") & !ID %in% tmp.2022_2023.ids, SMART_CLASSROOM_YEARS:=NA]
Idaho_IRI_Data_LONG[YEAR %in% c("2023_2024.1", "2023_2024.3") & ID %in% tmp.2022_2023.ids & SMART_CLASSROOM_YES_NO == "Yes", SMART_CLASSROOM_YEARS:=paste("2022_2023", "2023_2024", sep=",")]
Idaho_IRI_Data_LONG[YEAR %in% c("2023_2024.1", "2023_2024.3") & !ID %in% tmp.2022_2023.ids & SMART_CLASSROOM_YES_NO == "Yes", SMART_CLASSROOM_YEARS:="2023_2024"]
Idaho_IRI_Data_LONG[YEAR %in% c("2023_2024.1", "2023_2024.3") & ID %in% tmp.2022_2023.ids & SMART_CLASSROOM_YES_NO == "No", SMART_CLASSROOM_YEARS:="2022_2023"]

setcolorder(Idaho_IRI_Data_LONG, c("VALID_CASE", "CONTENT_AREA", "GRADE", "YEAR", "DATE", "ID", "SCALE_SCORE", "SCALE_SCORE_CSEM", "SCALE_SCORE_PERCENTILE", "SCALE_SCORE_QUINTILE", "CONTINUOUS_ENROLLMENT_STATUS", "INSTRUCTOR_ID", "SMART_CLASSROOM", "SMART_CLASSROOM_YES_NO", "TEACHER_YEAR_IN_PROGRAM", "SMART_CLASSROOM_YEARS", "SCHOOL_NUMBER"))

### Create knots/boundaries 
#ID_IRI_Knots_Boundaries <- SGP::createKnotsBoundaries(Idaho_IRI_Data_LONG)
#save(ID_IRI_Knots_Boundaries, file = "/Users/conet/GitHub/DBetebenner/SGPstateData/master/Knots_Boundaries/ID_IRI_Knots_Boundaries.Rdata")

### Remove duplicates 
# ### Resolve duplicates
setkey(Idaho_IRI_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID, GRADE, SCALE_SCORE)
setkey(Idaho_IRI_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)
dups <- Idaho_IRI_Data_LONG[VALID_CASE=="VALID_CASE"][c(which(duplicated(Idaho_IRI_Data_LONG[VALID_CASE=="VALID_CASE"], by=key(Idaho_IRI_Data_LONG)))-1, which(duplicated(Idaho_IRI_Data_LONG[VALID_CASE=="VALID_CASE"], by=key(Idaho_IRI_Data_LONG)))),]
setkeyv(dups, key(Idaho_IRI_Data_LONG)) ### 112 dups 2023, 36 2024 due to multiple-school membership 
Idaho_IRI_Data_LONG[which(duplicated(Idaho_IRI_Data_LONG, by=key(Idaho_IRI_Data_LONG)))-1, VALID_CASE:="INVALID_CASE"]

### Save the data
Idaho_IRI_Data_LONG_2022_2023 <- Idaho_IRI_Data_LONG[YEAR %in% c("2022_2023.1", "2022_2023.3")]
save(Idaho_IRI_Data_LONG_2022_2023, file = "Data/Idaho_IRI_Data_LONG_2022_2023.Rdata")

Idaho_IRI_Data_LONG_2023_2024 <- Idaho_IRI_Data_LONG[YEAR %in% c("2023_2024.1", "2023_2024.3")]
save(Idaho_IRI_Data_LONG_2023_2024, file = "Data/Idaho_IRI_Data_LONG_2023_2024.Rdata")











