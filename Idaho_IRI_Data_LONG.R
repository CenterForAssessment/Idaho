#########################################
# Data preparation for Idaho IRI Data
#########################################

### Load necessary libraries
require(data.table)

### Load data
Idaho_IRI_Data_LONG <- fread("Data/Base_Files/IRI Scores SY 2023-2024.csv")

### Tidy up the data
setnames(Idaho_IRI_Data_LONG, c("YEAR", "ID", "TEST_TYPE", "GRADE", "SCALE_SCORE"))
Idaho_IRI_Data_LONG[, YEAR := as.character(YEAR)]
Idaho_IRI_Data_LONG[, ID := as.character(ID)]
Idaho_IRI_Data_LONG[, GRADE := as.character(GRADE)]
Idaho_IRI_Data_LONG[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

Idaho_IRI_Data_LONG[YEAR == "2023" & TEST_TYPE=="Fall ISIP", YEAR:="2022_2023.1"]
Idaho_IRI_Data_LONG[YEAR == "2023" & TEST_TYPE=="Spring ISIP", YEAR:="2022_2023.3"]
Idaho_IRI_Data_LONG[YEAR == "2024" & TEST_TYPE=="Fall ISIP", YEAR:="2023_2024.1"]
Idaho_IRI_Data_LONG[YEAR == "2024" & TEST_TYPE=="Spring ISIP", YEAR:="2023_2024.3"]

Idaho_IRI_Data_LONG[TEST_TYPE == "Fall ISIP", GRADE := paste0(GRADE, ".1")]
Idaho_IRI_Data_LONG[TEST_TYPE == "Spring ISIP", GRADE := paste0(GRADE, ".3")]

Idaho_IRI_Data_LONG[, VALID_CASE := "VALID_CASE"]
Idaho_IRI_Data_LONG[, TEST_TYPE := NULL]
Idaho_IRI_Data_LONG[, VALID_CASE := "VALID_CASE"]
Idaho_IRI_Data_LONG[, CONTENT_AREA := "READING"]

setcolorder(Idaho_IRI_Data_LONG, c("VALID_CASE", "CONTENT_AREA", "GRADE", "YEAR", "ID", "SCALE_SCORE"))

### Create knots/boundaries 
ID_IRI_Knots_Boundaries <- SGP::createKnotsBoundaries(Idaho_IRI_Data_LONG)
#save(ID_IRI_Knots_Boundaries, file = "/Users/conet/GitHub/DBetebenner/SGPstateData/master/Knots_Boundaries/ID_IRI_Knots_Boundaries.Rdata")

### Save the data
Idaho_IRI_Data_LONG_2022_2023 <- Idaho_IRI_Data_LONG[YEAR %in% c("2022_2023.1", "2022_2023.3")]
save(Idaho_IRI_Data_LONG_2022_2023, file = "Data/Idaho_IRI_Data_LONG_2022_2023.Rdata")

Idaho_IRI_Data_LONG_2023_2024 <- Idaho_IRI_Data_LONG[YEAR %in% c("2023_2024.1", "2023_2024.3")]
save(Idaho_IRI_Data_LONG_2023_2024, file = "Data/Idaho_IRI_Data_LONG_2023_2024.Rdata")











