################################################################################
###                                                                          ###
###          SGP STRAIGHT projections for skip year SGP analyses for 2021    ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Idaho_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2021/PART_B/ELA.R")
source("SGP_CONFIG/2021/PART_B/MATHEMATICS.R")

ID_CONFIG <- c(ELA_2021.config, MATHEMATICS_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("ID", "2021")
SGPstateData[["ID"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- NULL

###   Run analysis

Idaho_SGP <- abcSGP(
        Idaho_SGP,
        years = "2021", # need to add years now (after adding 2019 baseline projections).  Why?
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=ID_CONFIG,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=TRUE,
        sgp.projections.lagged.baseline=FALSE,
        sgp.target.scale.scores=TRUE,
        outputSGP.directory=output.directory,
        parallel.config=parallel.config
)

###   Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
