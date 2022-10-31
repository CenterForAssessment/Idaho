###########################################################################
###
### Data prep file for 2017 to 2022 data
###
###########################################################################

### Load packages
require(data.table)
require(openxlsx)

### Load Data
Idaho_Data_LONG_2017 <- as.data.table(read.xlsx("Data/Base_Files/Deidentified ISAT 2017.xlsx", na.strings =c("N/A", "NULL", "NA")))
Idaho_Data_LONG_2018_2019 <- as.data.table(read.xlsx("Data/Base_Files/Deidentified ISAT 2018-2019.xlsx", na.strings =c("N/A", "NULL", "NA")))
Idaho_Data_LONG_2021_2022 <- as.data.table(read.xlsx("Data/Base_Files/Deidentified ISAT 2021-2022.xlsx", na.strings =c("N/A", "NULL", "NA")))

### Stack data.tables
Idaho_Data_LONG <- rbindlist(list(Idaho_Data_LONG_2017, Idaho_Data_LONG_2018_2019, Idaho_Data_LONG_2021_2022))

### Tidy up data
setnames(Idaho_Data_LONG, c("YEAR", "SCHOOL_NUMBER", "ID", "CONTINUOUS_ENROLLMENT_STATUS", "GRADE", "GENDER", "ETHNICITY", "SES_STATUS", "SPECIAL_EDUCATION_STATUS", "LEP_STATUS", "MIGRANT_STATUS", "HOMELESS_STATUS", "FOSTER_STATUS", "MILITARY_CONNECTED_STATUS", "CONTENT_AREA", "TEST_TYPE", "PARTICIPATION_STATUS", "PROFICIENCY_STATUS", "ACHIEVEMENT_LEVEL", "SCALE_SCORE", "ASSESSMENT_DATE", "MAKING_PROGRESS_TARGET", "IS_MAKING_PROGRESS", "ACCOMMODATION", "PERCENTILE_RANK"))

Idaho_Data_LONG[,YEAR:=as.character(YEAR)]
Idaho_Data_LONG[,ID:=as.character(ID)]
Idaho_Data_LONG[,GRADE:=as.character(GRADE)]
Idaho_Data_LONG[CONTENT_AREA=="MATH", CONTENT_AREA:="MATHEMATICS"]
Idaho_Data_LONG[,ACHIEVEMENT_LEVEL:=as.character(ACHIEVEMENT_LEVEL)]

### Invalidate Certain Cases 
Idaho_Data_LONG[, VALID_CASE:="VALID_CASE"]
Idaho_Data_LONG[TEST_TYPE=="ALT", VALID_CASE:="INVALID_CASE"]
Idaho_Data_LONG[PARTICIPATION_STATUS=="N", VALID_CASE:="INVALID_CASE"]
Idaho_Data_LONG[is.na(SCALE_SCORE), VALID_CASE:="INVALID_CASE"]
Idaho_Data_LONG[CONTENT_AREA=="SCIENCE", VALID_CASE:="INVALID_CASE"]

### Check for duplicates (no duplicates amongst VALID_CASEs 10/26/22)
setkey(Idaho_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID, SCALE_SCORE)
setkey(Idaho_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
Idaho_Data_LONG[which(duplicated(Idaho_Data_LONG, by=key(Idaho_Data_LONG)))-1, VALID_CASE := "INVALID_CASE"]
setkey(Idaho_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)

### Reorder columns
setcolorder(Idaho_Data_LONG, c(26, 15, 1, 5, 3, 20, 19, 18, 4, 2, 6:14, 16, 17, 21:25))

### Save Results as separate files based upon years
Idaho_Data_LONG_2019 <- Idaho_Data_LONG[YEAR=="2019"]
Idaho_Data_LONG_2021 <- Idaho_Data_LONG[YEAR=="2021"]
Idaho_Data_LONG_2022 <- Idaho_Data_LONG[YEAR=="2022"]
Idaho_Data_LONG <- Idaho_Data_LONG[YEAR < "2019"]

save(Idaho_Data_LONG, file="Data/Idaho_Data_LONG.Rdata")
save(Idaho_Data_LONG_2019, file="Data/Idaho_Data_LONG_2019.Rdata")
save(Idaho_Data_LONG_2021, file="Data/Idaho_Data_LONG_2021.Rdata")
save(Idaho_Data_LONG_2022, file="Data/Idaho_Data_LONG_2022.Rdata")