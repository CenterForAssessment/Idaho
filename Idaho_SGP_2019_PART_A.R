#########################################################################
###                                                                   ###
###       Idaho Learning Loss Analyses -- Create Baseline Matrices    ###
###                                                                   ###
#########################################################################

### Load necessary packages
require(SGP)

### Load Data
load("Data/Idaho_SGP.Rdata")
load("Data/Idaho_Data_LONG_2019.Rdata")

###   Create a smaller subset of the LONG data to work with.
Idaho_SGP_LONG_Data <- updateSGP(Idaho_SGP, Idaho_Data_LONG_2019, steps="prepareSGP")@Data
Idaho_Baseline_Data <- data.table::data.table(Idaho_SGP_LONG_Data[, c("ID", "CONTENT_AREA", "YEAR", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "VALID_CASE"),])

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2019/Matrices/ELA.R")
source("SGP_CONFIG/2019/Matrices/MATHEMATICS.R")


Idaho_BASELINE_CONFIG <- c(ELA_BASELINE.config, MATHEMATICS_BASELINE.config)

###   Create Baseline Matrices

Idaho_SGP <- prepareSGP(Idaho_Baseline_Data, create.additional.variables=FALSE)

Idaho_Baseline_Matrices <- baselineSGP(
				Idaho_SGP,
				sgp.baseline.config=Idaho_BASELINE_CONFIG,
				return.matrices.only=TRUE,
				calculate.baseline.sgps=FALSE,
				goodness.of.fit.print=FALSE,
				parallel.config = list(
					BACKEND="PARALLEL", WORKERS=list(TAUS=4))
)

###   Save results
save(Idaho_Baseline_Matrices, file="Data/Idaho_Baseline_Matrices.Rdata")
