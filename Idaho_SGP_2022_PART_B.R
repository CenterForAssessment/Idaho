###########################################################################
###                                                                     ###
###     SGP STRAIGHT projections for skip year SGP analyses for 2022    ###
###                                                                     ###
###########################################################################

###   Load packages
require(SGP)
require(SGPmatrices)
require(data.table)

###   Load data
load("Data/Idaho_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2022/PART_B/ELA.R")
source("SGP_CONFIG/2022/PART_B/MATHEMATICS.R")

ID_2022.config <- c(ELA_2022.config, MATHEMATICS_2022.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("ID", "2021")
SGPstateData[["ID"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- NULL ### WAIT UNTIL AFTER PART C TO MERGE

###   Run analysis
Idaho_SGP <- abcSGP(
        Idaho_SGP,
        years = "2022",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=ID_2022.config,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=TRUE,
        sgp.projections.lagged.baseline=FALSE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)

###   Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
