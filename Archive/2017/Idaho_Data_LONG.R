###########################################################################
###
### Syntax for construction of Idaho LONG data file
###
###########################################################################

### Load data.table package

require(SGP)
require(data.table)


### Load data

Idaho_Data_LONG <- fread("Data/Base_Files/Student_Level_File_3_to_10.csv")


### Tidy up data

setnames(Idaho_Data_LONG, c("ID", "SCHOOL_NUMBER", "CONTENT_AREA", "YEAR", "GRADE", "SCALE_SCORE", "SCALE_SCORE_STANDARDIZED",
							"ACHIEVEMENT_LEVEL_ORIGINAL", "ECONOMICALLY_DISADVANTAGED_STATUS", "SPECIAL_EDUCATION_STATUS", "ELL_STATUS", "MINORITY_STATUS"))

Idaho_Data_LONG[,ID:=paste0("000000", ID)]
Idaho_Data_LONG[,ID:=strtail(ID, 6)]

Idaho_Data_LONG[CONTENT_AREA=="Math", CONTENT_AREA:="MATHEMATICS"]
Idaho_Data_LONG[CONTENT_AREA=="ELA", CONTENT_AREA:="READING"]

Idaho_Data_LONG[,YEAR:=as.character(YEAR)]

Idaho_Data_LONG[,GRADE:=as.character(GRADE)]

Idaho_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

Idaho_Data_LONG[,SCALE_SCORE_STANDARDIZED:=NULL]

Idaho_Data_LONG[ECONOMICALLY_DISADVANTAGED_STATUS=="N", ECONOMICALLY_DISADVANTAGED_STATUS:="Economically Disadvantaged: No"]
Idaho_Data_LONG[ECONOMICALLY_DISADVANTAGED_STATUS=="Y", ECONOMICALLY_DISADVANTAGED_STATUS:="Economically Disadvantaged: Yes"]

Idaho_Data_LONG[SPECIAL_EDUCATION_STATUS=="N", SPECIAL_EDUCATION_STATUS:="Special Education: No"]
Idaho_Data_LONG[SPECIAL_EDUCATION_STATUS=="Y", SPECIAL_EDUCATION_STATUS:="Special Education: Yes"]

Idaho_Data_LONG[ELL_STATUS=="N", ELL_STATUS:="ELL: No"]
Idaho_Data_LONG[ELL_STATUS=="Y", ELL_STATUS:="ELL: Yes"]

Idaho_Data_LONG[MINORITY_STATUS=="N", MINORITY_STATUS:="Minority: No"]
Idaho_Data_LONG[MINORITY_STATUS=="Y", MINORITY_STATUS:="Minority: Yes"]

Idaho_Data_LONG[,VALID_CASE:="VALID_CASE"]
Idaho_Data_LONG[!is.na(SCALE_SCORE), SCALE_SCORE_CSEM:=25]


### Create ACHIEVEMENT_LEVEL variable

tmp <- prepareSGP(Idaho_Data_LONG)
Idaho_Data_LONG <- tmp@Data


### Set key

setkey(Idaho_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)


### Save results

save(Idaho_Data_LONG, file="Data/Idaho_Data_LONG.Rdata")
