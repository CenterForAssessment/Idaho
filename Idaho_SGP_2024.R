#################################################################
###                                                           ###
###                Idaho IRI Fall-Spring 2024                 ###
###                SGP analyses                               ###
###                                                           ###
#################################################################

###   Load packages
require(SGP)

###   Load data
load("Data/Idaho_SGP.Rdata")
load("Data/Idaho_IRI_Data_LONG_2023_2024.Rdata")

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2024/READING.R")

ID_2024.config <- c(
	READING.2024.config
)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

#####
###   Run SGP analysis for consecutive year
###   create new Idaho_SGP object with historical data
#####

Idaho_SGP <- updateSGP(
        what_sgp_object = Idaho_SGP,
        with_sgp_data_LONG = Idaho_IRI_Data_LONG_2023_2024,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = ID_2024.config,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = FALSE, # 
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        SGPt=TRUE,
        parallel.config = parallel.config
)

###   Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
