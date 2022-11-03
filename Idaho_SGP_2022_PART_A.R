#################################################################
###                                                           ###
###                Idaho Consecutive-year                     ###
###                SGP analyses for 2021-2022                 ###
###                                                           ###
#################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Idaho_SGP.Rdata")
load("Data/Idaho_Data_LONG_2022.Rdata")

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("ID", "2022")

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2022/PART_A/ELA.R")
source("SGP_CONFIG/2022/PART_A/MATHEMATICS.R")

ID_2022.config <- c(
	ELA.2022.config,
	MATHEMATICS.2022.config
)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

#####
###   Run SGP analysis for consecutive year
###   create new Idaho_SGP object with historical data
#####

Idaho_SGP <- updateSGP(
        what_sgp_object = Idaho_SGP,
        with_sgp_data_LONG = Idaho_Data_LONG_2022,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = ID_2022.config,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Consecutive year SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, # 
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

###   Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
