################################################################################
###                                                                          ###
###                Idaho COVID Skip-year SGP analyses for 2021             ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Idaho_SGP.Rdata")
load("Data/Idaho_Data_LONG_2021.Rdata")

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("ID", "2021")

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2021/PART_A/ELA.R")
source("SGP_CONFIG/2021/PART_A/MATHEMATICS.R")
source("SGP_CONFIG/2021/PART_A/ELA_BASELINE.R")
source("SGP_CONFIG/2021/PART_A/MATHEMATICS_BASELINE.R")

ID_CONFIG <- c(ELA_2021.config, MATHEMATICS_2021.config)
ID_CONFIG_BASELINE <- c(ELA_BASELINE_2021.config, MATHEMATICS_BASELINE_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

#####
###   Run updateSGP analysis and create cohort referenced SGPs
#####

Idaho_SGP <- updateSGP(
        what_sgp_object = Idaho_SGP,
        with_sgp_data_LONG = Idaho_Data_LONG_2021,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = ID_CONFIG,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)


#####
###   Run abcSGP analysis and create baseline referenced SGPs
#####

Idaho_SGP <- abcSGP(
        sgp_object = Idaho_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = ID_CONFIG_BASELINE,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

###   Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
