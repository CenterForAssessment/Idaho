#####################################################################################
###                                                                               ###
###           SGP LAGGED projections for skip year SGP analyses for 2021-2022     ###
###                                                                               ###
#####################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)
require(data.table)

###   Load data
load("Data/Idaho_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2022/PART_C/ELA.R")
source("SGP_CONFIG/2022/PART_C/MATHEMATICS.R")

ID_2022.config <- c(ELA_2022.config, MATHEMATICS_2022.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences

###   Add Baseline matrices to SGPstateData and update SGPstateData
SGPstateData <- addBaselineMatrices("ID", "2022")
SGPstateData[["ID"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"

### Run analysis
Idaho_SGP <- abcSGP(
        Idaho_SGP,
        years="2022",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=ID_2022.config,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=TRUE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=FALSE,
        sgp.projections.lagged.baseline=TRUE,
        sgp.target.scale.scores=FALSE,
        parallel.config=parallel.config
)


###  Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
